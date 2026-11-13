package com.example.stepbystep;

import android.Manifest;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.SystemClock;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;

public class MainActivity extends AppCompatActivity implements SensorEventListener {

    private static final float SHAKE_THRESHOLD = 3.2f;
    private static final long SHAKE_GAP_MS = 700;
    private static final long TICK_MS = 1000;

    private SensorManager sensorManager;
    private Sensor stepSensor;
    private Sensor accelSensor;

    private boolean stepPermissionGranted = false;
    private boolean listening = false;
    private long lastShakeAtMs = 0;

    private boolean running = false;
    private float stepBaseline = -1;   // -1 = not set yet
    private int sessionSteps = 0;
    private int sessionShakes = 0;
    private long sessionStartMs = 0;
    private long sessionStartedAt = 0;   // date time for history
    private long sessionDurationMs = 0;

    private DBHelper db;
    private ActivityAdapter adapter;

    private final Handler ticker = new Handler(Looper.getMainLooper());
    private final Runnable tick = new Runnable() {
        @Override
        public void run() {
            showDurationAndAverages();
            ticker.postDelayed(this, TICK_MS);
        }
    };

    private TextView tvSessionSteps;
    private TextView tvSessionShakes;
    private TextView tvDuration;
    private TextView tvAvgSteps;
    private TextView tvAvgShakes;
    private Button btnStartStop;
    private TextView tvNewRecord;
    private TextView tvTotalSteps;
    private TextView tvTotalShakes;
    private TextView tvBestSteps;
    private TextView tvBestShakes;
    private RecyclerView rvHistory;
    private TextView tvEmpty;

    private final ActivityResultLauncher<String> stepPermissionLauncher =
            registerForActivityResult(new ActivityResultContracts.RequestPermission(), granted -> {
                stepPermissionGranted = granted;
                if (!granted) {
                    tvSessionSteps.setText(R.string.value_unavailable);
                    tvAvgSteps.setText(R.string.value_unavailable);
                    Toast.makeText(this, R.string.msg_step_permission_denied, Toast.LENGTH_LONG).show();
                } else if (listening) {
                    sensorManager.registerListener(this, stepSensor, SensorManager.SENSOR_DELAY_NORMAL);
                }
            });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        tvSessionSteps = findViewById(R.id.tvSessionSteps);
        tvSessionShakes = findViewById(R.id.tvSessionShakes);
        tvDuration = findViewById(R.id.tvDuration);
        tvAvgSteps = findViewById(R.id.tvAvgSteps);
        tvAvgShakes = findViewById(R.id.tvAvgShakes);
        btnStartStop = findViewById(R.id.btnStartStop);
        tvNewRecord = findViewById(R.id.tvNewRecord);
        tvTotalSteps = findViewById(R.id.tvTotalSteps);
        tvTotalShakes = findViewById(R.id.tvTotalShakes);
        tvBestSteps = findViewById(R.id.tvBestSteps);
        tvBestShakes = findViewById(R.id.tvBestShakes);
        rvHistory = findViewById(R.id.rvHistory);
        tvEmpty = findViewById(R.id.tvEmpty);

        adapter = new ActivityAdapter(new ActivityAdapter.Listener() {
            @Override
            public void onItemClick(ActivityItem item) {
                showDetails(item);
            }

            @Override
            public void onItemLongClick(ActivityItem item) {
                confirmDelete(item);
            }
        });
        rvHistory.setLayoutManager(new LinearLayoutManager(this));
        rvHistory.setAdapter(adapter);

        db = new DBHelper(this);
        reload();

        btnStartStop.setOnClickListener(v -> {
            if (running) stopSession();
            else startSession();
        });

        sensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        stepSensor = sensorManager.getDefaultSensor(Sensor.TYPE_STEP_COUNTER);
        accelSensor = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);

        if (accelSensor == null) {
            tvSessionShakes.setText(R.string.value_unavailable);
            tvAvgShakes.setText(R.string.value_unavailable);
            Toast.makeText(this, R.string.msg_no_accelerometer, Toast.LENGTH_LONG).show();
        }
        if (stepSensor == null) {
            tvSessionSteps.setText(R.string.value_unavailable);
            tvAvgSteps.setText(R.string.value_unavailable);
            Toast.makeText(this, R.string.msg_no_step_counter, Toast.LENGTH_LONG).show();
        } else if (ContextCompat.checkSelfPermission(this, Manifest.permission.ACTIVITY_RECOGNITION)
                == PackageManager.PERMISSION_GRANTED) {
            stepPermissionGranted = true;
        } else {
            stepPermissionLauncher.launch(Manifest.permission.ACTIVITY_RECOGNITION);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        startListening();
        if (running) ticker.post(tick);
    }

    @Override
    protected void onPause() {
        super.onPause();
        ticker.removeCallbacks(tick);
        stopListening();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        db.close();
    }

    private void startListening() {
        if (listening) return;
        if (accelSensor != null) {
            sensorManager.registerListener(this, accelSensor, SensorManager.SENSOR_DELAY_GAME);
        }
        if (stepsAvailable()) {
            sensorManager.registerListener(this, stepSensor, SensorManager.SENSOR_DELAY_NORMAL);
        }
        listening = true;
    }

    private void stopListening() {
        if (!listening) return;
        sensorManager.unregisterListener(this);
        listening = false;
    }

    private boolean stepsAvailable() {
        return stepSensor != null && stepPermissionGranted;
    }

    private void startSession() {
        running = true;
        stepBaseline = -1;
        sessionSteps = 0;
        sessionShakes = 0;
        sessionStartMs = SystemClock.elapsedRealtime();
        sessionStartedAt = System.currentTimeMillis();
        sessionDurationMs = 0;

        tvNewRecord.setVisibility(View.GONE);
        if (stepsAvailable()) tvSessionSteps.setText(String.valueOf(sessionSteps));
        if (accelSensor != null) tvSessionShakes.setText(String.valueOf(sessionShakes));
        btnStartStop.setText(R.string.btn_stop);

        ticker.removeCallbacks(tick);
        ticker.post(tick);
    }

    private void stopSession() {
        sessionDurationMs = SystemClock.elapsedRealtime() - sessionStartMs;
        running = false;
        ticker.removeCallbacks(tick);
        showDurationAndAverages();
        btnStartStop.setText(R.string.btn_start);
        saveSession();
    }

    private void saveSession() {
        long[] best = db.best();   // get best before insert
        boolean stepRecord = sessionSteps > 0 && sessionSteps > best[0];
        boolean shakeRecord = sessionShakes > 0 && sessionShakes > best[1];

        db.insert(new ActivityItem(0, sessionStartedAt, sessionDurationMs, sessionSteps, sessionShakes));
        Toast.makeText(this, R.string.msg_saved, Toast.LENGTH_SHORT).show();

        if (stepRecord || shakeRecord) {
            int text = stepRecord && shakeRecord ? R.string.new_record_both
                    : stepRecord ? R.string.new_record_steps : R.string.new_record_shakes;
            tvNewRecord.setText(text);
            tvNewRecord.setVisibility(View.VISIBLE);
        }
        reload();
    }

    private void reload() {
        adapter.setItems(db.getAll());
        boolean empty = adapter.getItemCount() == 0;
        rvHistory.setVisibility(empty ? View.GONE : View.VISIBLE);
        tvEmpty.setVisibility(empty ? View.VISIBLE : View.GONE);

        long[] totals = db.totals();
        long[] best = db.best();
        tvTotalSteps.setText(String.valueOf(totals[0]));
        tvTotalShakes.setText(String.valueOf(totals[1]));
        tvBestSteps.setText(String.valueOf(best[0]));
        tvBestShakes.setText(String.valueOf(best[1]));
    }

    private void showDetails(ActivityItem item) {
        View v = LayoutInflater.from(this).inflate(R.layout.dialog_activity_detail, null);
        ((TextView) v.findViewById(R.id.tvDetailStart)).setText(ActivityAdapter.formatStart(item.startedAt));
        ((TextView) v.findViewById(R.id.tvDetailDuration)).setText(ActivityAdapter.formatDuration(this, item.durationMs));
        ((TextView) v.findViewById(R.id.tvDetailSteps)).setText(String.valueOf(item.steps));
        ((TextView) v.findViewById(R.id.tvDetailShakes)).setText(String.valueOf(item.shakes));
        ((TextView) v.findViewById(R.id.tvDetailAvgSteps))
                .setText(getString(R.string.avg_format, perMinute(item.steps, item.durationMs)));
        ((TextView) v.findViewById(R.id.tvDetailAvgShakes))
                .setText(getString(R.string.avg_format, perMinute(item.shakes, item.durationMs)));

        new MaterialAlertDialogBuilder(this)
                .setTitle(R.string.detail_title)
                .setView(v)
                .setPositiveButton(R.string.btn_close, null)
                .show();
    }

    private void confirmDelete(ActivityItem item) {
        new MaterialAlertDialogBuilder(this)
                .setTitle(R.string.delete_title)
                .setMessage(R.string.delete_message)
                .setNegativeButton(R.string.btn_cancel, null)
                .setPositiveButton(R.string.btn_delete, (d, w) -> {
                    db.delete(item.id);
                    reload();
                    Toast.makeText(this, R.string.msg_deleted, Toast.LENGTH_SHORT).show();
                })
                .show();
    }

    private void showDurationAndAverages() {
        if (running) sessionDurationMs = SystemClock.elapsedRealtime() - sessionStartMs;
        tvDuration.setText(ActivityAdapter.formatDuration(this, sessionDurationMs));
        if (stepsAvailable()) {
            tvAvgSteps.setText(getString(R.string.avg_format, perMinute(sessionSteps, sessionDurationMs)));
        }
        if (accelSensor != null) {
            tvAvgShakes.setText(getString(R.string.avg_format, perMinute(sessionShakes, sessionDurationMs)));
        }
    }

    private double perMinute(int count, long durationMs) {
        if (durationMs <= 0) return 0;
        return count * 60000.0 / durationMs;
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        switch (event.sensor.getType()) {
            case Sensor.TYPE_STEP_COUNTER:
                if (!running) break;
                float total = event.values[0];   // steps since reboot
                if (stepBaseline < 0) stepBaseline = total;
                sessionSteps = (int) (total - stepBaseline);
                tvSessionSteps.setText(String.valueOf(sessionSteps));
                break;
            case Sensor.TYPE_ACCELEROMETER:
                if (running && isShake(event.values)) {
                    sessionShakes++;
                    tvSessionShakes.setText(String.valueOf(sessionShakes));
                }
                break;
            default:
                break;
        }
    }

    private boolean isShake(float[] v) {
        float magnitude = (float) Math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2]);
        if (Math.abs(magnitude - SensorManager.GRAVITY_EARTH) <= SHAKE_THRESHOLD) return false;
        long now = SystemClock.elapsedRealtime();
        if (now - lastShakeAtMs < SHAKE_GAP_MS) return false;
        lastShakeAtMs = now;
        return true;
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
    }
}
