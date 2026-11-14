package com.example.flashcards;

import android.Manifest;
import android.app.TimePickerDialog;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.text.InputType;
import android.text.format.DateFormat;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.app.AppCompatDelegate;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.core.os.LocaleListCompat;
import androidx.core.view.WindowCompat;

import com.google.android.material.appbar.MaterialToolbar;
import com.google.android.material.materialswitch.MaterialSwitch;
import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;

import java.util.Calendar;

/** Screen 5: Settings, stored in SharedPreferences (see Prefs). */
public class SettingsActivity extends AppCompatActivity {
    private static final int REQUEST_NOTIFICATIONS = 1;
    private static final String[] LANGUAGE_TAGS = {"", "en", "th"};   // "" = follow the device

    private View rowTheme, rowLanguage, rowMode, rowNewLimit, rowReminderTime, rowReset;
    private MaterialSwitch reminderSwitch;
    private AlertDialog dialog;
    private TimePickerDialog timeDialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_settings);
        Ui.applyInsets(findViewById(R.id.main));

        MaterialToolbar toolbar = findViewById(R.id.toolbar);
        toolbar.setNavigationOnClickListener(v -> getOnBackPressedDispatcher().onBackPressed());

        rowTheme = row(R.id.rowTheme, R.string.setting_theme);
        rowLanguage = row(R.id.rowLanguage, R.string.setting_language);
        rowMode = row(R.id.rowMode, R.string.setting_default_mode);
        rowNewLimit = row(R.id.rowNewLimit, R.string.setting_new_limit);
        rowReminderTime = row(R.id.rowReminderTime, R.string.setting_reminder_time);
        rowReset = row(R.id.rowReset, R.string.reset_all);
        reminderSwitch = findViewById(R.id.reminderSwitch);

        rowTheme.setOnClickListener(v -> chooseTheme());
        rowLanguage.setOnClickListener(v -> chooseLanguage());
        rowMode.setOnClickListener(v -> chooseMode());
        rowNewLimit.setOnClickListener(v -> editNewLimit());
        findViewById(R.id.rowReminder).setOnClickListener(v -> toggleReminder());
        rowReminderTime.setOnClickListener(v -> chooseTime());
        rowReset.setOnClickListener(v -> confirmResetAll());

        render();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (dialog != null) dialog.dismiss();
        if (timeDialog != null) timeDialog.dismiss();
    }

    private View row(int id, int title) {
        View row = findViewById(id);
        ((TextView) row.findViewById(R.id.settingTitle)).setText(title);
        return row;
    }

    private static void setValue(View row, String value) {
        ((TextView) row.findViewById(R.id.settingValue)).setText(value);
    }

    private String[] labels(int... ids) {
        String[] s = new String[ids.length];
        for (int i = 0; i < ids.length; i++) s[i] = getString(ids[i]);
        return s;
    }

    private String[] themeLabels() {
        return labels(R.string.theme_system, R.string.theme_light, R.string.theme_dark);
    }

    private String[] languageLabels() {
        return labels(R.string.language_system, R.string.language_english, R.string.language_thai);
    }

    private String[] modeLabels() {
        return labels(R.string.default_mode_last, R.string.default_mode_original,
                R.string.default_mode_choice);
    }

    private int languageIndex() {
        String tags = AppCompatDelegate.getApplicationLocales().toLanguageTags();
        if (tags.startsWith("th")) return 2;
        if (tags.startsWith("en")) return 1;
        return 0;
    }

    private String timeText() {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.HOUR_OF_DAY, Prefs.reminderHour(this));
        c.set(Calendar.MINUTE, Prefs.reminderMinute(this));
        return DateFormat.getTimeFormat(this).format(c.getTime());
    }

    private void render() {
        setValue(rowTheme, themeLabels()[Prefs.theme(this)]);
        setValue(rowLanguage, languageLabels()[languageIndex()]);
        setValue(rowMode, modeLabels()[Prefs.defaultMode(this)]);
        int limit = Prefs.newLimit(this);
        setValue(rowNewLimit, limit <= 0 ? getString(R.string.new_limit_unlimited)
                : getString(R.string.new_limit_value, limit));
        boolean on = Prefs.reminderOn(this);
        reminderSwitch.setChecked(on);
        setValue(rowReminderTime, timeText());
        rowReminderTime.setEnabled(on);
        rowReminderTime.setAlpha(on ? 1f : 0.5f);
        setValue(rowReset, getString(R.string.reset_all_summary));
    }

    // ---- choices ----

    private void chooseTheme() {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.setting_theme)
                .setSingleChoiceItems(themeLabels(), Prefs.theme(this), (d, which) -> {
                    Prefs.get(this).edit().putInt(Prefs.KEY_THEME, which).apply();
                    d.dismiss();
                    Prefs.applyTheme(which);   // recreates open screens if the theme changes
                    render();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void chooseLanguage() {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.setting_language)
                .setSingleChoiceItems(languageLabels(), languageIndex(), (d, which) -> {
                    d.dismiss();
                    // AppCompat stores it and recreates open screens; empty list = follow the device
                    AppCompatDelegate.setApplicationLocales(
                            LocaleListCompat.forLanguageTags(LANGUAGE_TAGS[which]));
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void chooseMode() {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.setting_default_mode)
                .setSingleChoiceItems(modeLabels(), Prefs.defaultMode(this), (d, which) -> {
                    Prefs.get(this).edit().putInt(Prefs.KEY_DEFAULT_MODE, which).apply();
                    d.dismiss();
                    render();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private void editNewLimit() {
        TextInputLayout layout = new TextInputLayout(this);
        layout.setHelperText(getString(R.string.new_limit_hint));
        TextInputEditText input = new TextInputEditText(layout.getContext());
        input.setInputType(InputType.TYPE_CLASS_NUMBER);
        input.setText(String.valueOf(Prefs.newLimit(this)));
        input.setSelectAllOnFocus(true);
        layout.addView(input);
        FrameLayout box = new FrameLayout(this);
        int pad = (int) (24 * getResources().getDisplayMetrics().density);
        box.setPadding(pad, pad / 3, pad, 0);
        box.addView(layout);

        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.setting_new_limit)
                .setView(box)
                .setPositiveButton(R.string.save, (d, w) -> {
                    int n;
                    try {
                        n = Integer.parseInt(String.valueOf(input.getText()).trim());
                    } catch (NumberFormatException e) {
                        n = 0;   // empty or too large = unlimited
                    }
                    Prefs.get(this).edit().putInt(Prefs.KEY_NEW_LIMIT, Math.max(0, n)).apply();
                    render();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    // ---- reminder ----

    private void toggleReminder() {
        if (Prefs.reminderOn(this)) {
            setReminder(false);
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU
                && ContextCompat.checkSelfPermission(this, Manifest.permission.POST_NOTIFICATIONS)
                != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.POST_NOTIFICATIONS}, REQUEST_NOTIFICATIONS);
        } else {
            setReminder(true);
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] results) {
        super.onRequestPermissionsResult(requestCode, permissions, results);
        if (requestCode != REQUEST_NOTIFICATIONS) return;
        if (results.length > 0 && results[0] == PackageManager.PERMISSION_GRANTED) {
            setReminder(true);
        } else {
            Toast.makeText(this, R.string.reminder_permission_denied, Toast.LENGTH_LONG).show();
            render();
        }
    }

    private void setReminder(boolean on) {
        Prefs.get(this).edit().putBoolean(Prefs.KEY_REMINDER_ON, on).apply();
        ReminderScheduler.update(this);
        render();
    }

    private void chooseTime() {
        timeDialog = new TimePickerDialog(this, (picker, hour, minute) -> {
            Prefs.get(this).edit()
                    .putInt(Prefs.KEY_REMINDER_HOUR, hour)
                    .putInt(Prefs.KEY_REMINDER_MINUTE, minute)
                    .apply();
            ReminderScheduler.update(this);
            render();
        }, Prefs.reminderHour(this), Prefs.reminderMinute(this), DateFormat.is24HourFormat(this));
        timeDialog.show();
    }

    // ---- data ----

    private void confirmResetAll() {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.reset_all_title)
                .setMessage(R.string.reset_all_message)
                .setPositiveButton(R.string.reset_confirm, (d, w) -> {
                    DbHelper db = new DbHelper(this);
                    db.resetProgress(-1);
                    db.close();
                    Toast.makeText(this, R.string.progress_reset, Toast.LENGTH_SHORT).show();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }
}
