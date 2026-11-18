package com.example.flashcards;

import android.content.SharedPreferences;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.os.SystemClock;
import android.text.SpannableString;
import android.text.style.StyleSpan;
import android.view.View;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.TextView;

import androidx.activity.OnBackPressedCallback;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.WindowCompat;

import com.google.android.material.appbar.MaterialToolbar;
import com.google.android.material.button.MaterialButton;
import com.google.android.material.color.MaterialColors;
import com.google.android.material.progressindicator.LinearProgressIndicator;

import java.util.List;
import java.util.Locale;
import java.util.Random;

/**
 * Screen 4: a Review session (or a Practice session). Two Modes: Original and Multiple Choice.
 * Every grade is written to the database as soon as it is given. All session state is kept in
 * fields and saved in onSaveInstanceState so rotation never loses progress.
 */
public class ReviewActivity extends AppCompatActivity {
    public static final String EXTRA_DECK_ID = "deckId";
    public static final String EXTRA_PRACTICE = "practice";

    private static final int MODE_ORIGINAL = 0;
    private static final int MODE_CHOICE = 1;
    private static final String PREFS = "flashcards";
    private static final String KEY_MODE = "mode";

    private static final String S_QUEUE = "queue";
    private static final String S_INDEX = "index";
    private static final String S_MODE = "mode";
    private static final String S_OPTIONS = "options";
    private static final String S_CHOSEN = "chosen";
    private static final String S_REVEALED = "revealed";
    private static final String S_FALLBACK = "fallback";
    private static final String S_REVIEWED = "reviewed";
    private static final String S_AGAIN = "again";
    private static final String S_ELAPSED = "elapsed";
    private static final String S_SESSION = "session";

    private DbHelper db;
    private SharedPreferences prefs;
    private long deckId;
    private boolean practice;

    // ---- session state (all saved in onSaveInstanceState) ----
    private long[] queue = new long[0];   // Card ids of this session
    private int index;                    // position in queue; index == queue.length means finished
    private int mode;
    private String[] options;             // Multiple Choice Options in their saved order; null = none
    private int chosen = -1;              // chosen Option, -1 = not answered yet
    private boolean revealed;             // Original mode: Back is showing
    private boolean fallback;             // Multiple Choice requested but too few Options
    private int reviewed;
    private int again;
    private long elapsedMs;
    private long sessionId = -1;          // study log row; created on the first grade

    private Card card;
    private boolean timerRunning;
    private AlertDialog dialog;

    private TextView progressText;
    private TextView practiceBadge;
    private TextView noticeText;
    private TextView frontText;
    private TextView backText;
    private View answerDivider;
    private View flashCard;
    private TextView resultText;
    private Chronometer timer;
    private Button modeButton;
    private Button showAnswerButton;
    private Button nextButton;
    private View optionsLayout;
    private View gradeLayout;
    private LinearProgressIndicator progressBar;
    private final MaterialButton[] optionButtons = new MaterialButton[4];

    // Option look after answering
    private static final int OPT_NORMAL = 0;
    private static final int OPT_RIGHT = 1;
    private static final int OPT_WRONG = 2;
    private static final int OPT_DIM = 3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_review);
        Ui.applyInsets(findViewById(R.id.main));

        db = new DbHelper(this);
        prefs = getSharedPreferences(PREFS, MODE_PRIVATE);
        deckId = getIntent().getLongExtra(EXTRA_DECK_ID, -1);
        practice = getIntent().getBooleanExtra(EXTRA_PRACTICE, false);

        progressText = findViewById(R.id.progressText);
        practiceBadge = findViewById(R.id.practiceBadge);
        noticeText = findViewById(R.id.noticeText);
        frontText = findViewById(R.id.frontText);
        backText = findViewById(R.id.backText);
        answerDivider = findViewById(R.id.answerDivider);
        flashCard = findViewById(R.id.flashCard);
        resultText = findViewById(R.id.resultText);
        timer = findViewById(R.id.timer);
        modeButton = findViewById(R.id.modeButton);
        showAnswerButton = findViewById(R.id.showAnswerButton);
        nextButton = findViewById(R.id.nextButton);
        optionsLayout = findViewById(R.id.optionsLayout);
        gradeLayout = findViewById(R.id.gradeLayout);
        progressBar = findViewById(R.id.progressBar);
        MaterialToolbar toolbar = findViewById(R.id.toolbar);
        toolbar.setNavigationOnClickListener(v -> getOnBackPressedDispatcher().onBackPressed());
        Deck deck = db.getDeck(deckId);
        if (deck != null) toolbar.setTitle(deck.name);
        optionButtons[0] = findViewById(R.id.option0);
        optionButtons[1] = findViewById(R.id.option1);
        optionButtons[2] = findViewById(R.id.option2);
        optionButtons[3] = findViewById(R.id.option3);

        modeButton.setOnClickListener(v -> toggleMode());
        showAnswerButton.setOnClickListener(v -> {
            revealed = true;
            render();
        });
        nextButton.setOnClickListener(v -> advance());
        findViewById(R.id.gradeAgain).setOnClickListener(v -> grade(Sm2.AGAIN));
        findViewById(R.id.gradeHard).setOnClickListener(v -> grade(Sm2.HARD));
        findViewById(R.id.gradeGood).setOnClickListener(v -> grade(Sm2.GOOD));
        findViewById(R.id.gradeEasy).setOnClickListener(v -> grade(Sm2.EASY));
        for (int i = 0; i < optionButtons.length; i++) {
            final int n = i;
            optionButtons[i].setOnClickListener(v -> onOption(n));
        }

        if (savedInstanceState != null) {
            long[] q = savedInstanceState.getLongArray(S_QUEUE);
            queue = q == null ? new long[0] : q;
            index = savedInstanceState.getInt(S_INDEX);
            mode = savedInstanceState.getInt(S_MODE);
            options = savedInstanceState.getStringArray(S_OPTIONS);
            chosen = savedInstanceState.getInt(S_CHOSEN, -1);
            revealed = savedInstanceState.getBoolean(S_REVEALED);
            fallback = savedInstanceState.getBoolean(S_FALLBACK);
            reviewed = savedInstanceState.getInt(S_REVIEWED);
            again = savedInstanceState.getInt(S_AGAIN);
            elapsedMs = savedInstanceState.getLong(S_ELAPSED);
            sessionId = savedInstanceState.getLong(S_SESSION, -1);
        } else {
            int start = Prefs.defaultMode(this);   // Settings: last used / Original / Multiple Choice
            mode = start == Prefs.START_ORIGINAL ? MODE_ORIGINAL
                    : start == Prefs.START_CHOICE ? MODE_CHOICE
                    : prefs.getInt(KEY_MODE, MODE_ORIGINAL);
            queue = practice ? db.getAllCardIds(deckId) : db.getDueCardIds(deckId);
        }

        getOnBackPressedDispatcher().addCallback(this, new OnBackPressedCallback(true) {
            @Override
            public void handleOnBackPressed() {
                if (index >= queue.length) {
                    finish();
                } else {
                    confirmEnd();
                }
            }
        });

        showCard(savedInstanceState != null);
    }

    // ---- timer: runs only while the screen is in the foreground ----

    @Override
    protected void onResume() {
        super.onResume();
        timer.setBase(SystemClock.elapsedRealtime() - elapsedMs);
        if (index < queue.length) {
            timer.start();
            timerRunning = true;
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        stopTimer();
        saveLog();   // keeps the logged time right even if the app is killed
    }

    private long elapsedNow() {
        return timerRunning ? SystemClock.elapsedRealtime() - timer.getBase() : elapsedMs;
    }

    private void saveLog() {
        if (sessionId != -1) db.updateSession(sessionId, reviewed, again, elapsedNow() / 1000);
    }

    private void stopTimer() {
        if (timerRunning) {
            elapsedMs = SystemClock.elapsedRealtime() - timer.getBase();
            timer.stop();
            timerRunning = false;
        }
    }

    @Override
    protected void onSaveInstanceState(Bundle out) {
        super.onSaveInstanceState(out);
        out.putLongArray(S_QUEUE, queue);
        out.putInt(S_INDEX, index);
        out.putInt(S_MODE, mode);
        out.putStringArray(S_OPTIONS, options);
        out.putInt(S_CHOSEN, chosen);
        out.putBoolean(S_REVEALED, revealed);
        out.putBoolean(S_FALLBACK, fallback);
        out.putInt(S_REVIEWED, reviewed);
        out.putInt(S_AGAIN, again);
        out.putLong(S_ELAPSED, elapsedNow());
        out.putLong(S_SESSION, sessionId);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (dialog != null) dialog.dismiss();
        db.close();
    }

    // ---- flow ----

    /** keepState = true after rotation: reuse the saved Options / revealed flag. */
    private void showCard(boolean keepState) {
        if (index >= queue.length) {
            showSummary();
            return;
        }
        card = db.getCard(queue[index]);
        if (card == null) {   // Card vanished: skip it
            index++;
            showCard(false);
            return;
        }
        if (!keepState) {
            chosen = -1;
            revealed = false;
            fallback = false;
            options = null;
            if (mode == MODE_CHOICE) prepareChoice();
        }
        render();
    }

    private void prepareChoice() {
        String gist = Card.gistOf(card.back);
        List<String> opts = McOptions.build(gist, db.getOtherGists(deckId, card.id), new Random());
        if (gist.trim().isEmpty() || opts.size() < 2) {
            fallback = true;   // too few Options: this Card is shown in Original mode
            options = null;
        } else {
            options = opts.toArray(new String[0]);
        }
    }

    private void render() {
        boolean choiceStyle = mode == MODE_CHOICE && options != null;
        boolean answered = choiceStyle ? chosen >= 0 : revealed;

        progressText.setText(getString(R.string.review_progress, index + 1, queue.length));
        progressBar.setMax(Math.max(1, queue.length));
        progressBar.setProgressCompat(index, false);
        practiceBadge.setVisibility(practice ? View.VISIBLE : View.GONE);
        modeButton.setText(mode == MODE_CHOICE ? R.string.mode_choice : R.string.mode_original);
        modeButton.setEnabled(!answered);   // switch only before answering this Card
        noticeText.setVisibility(mode == MODE_CHOICE && fallback ? View.VISIBLE : View.GONE);

        frontText.setVisibility(View.VISIBLE);
        frontText.setText(card.front);
        String gist = Card.gistOf(card.back);
        SpannableString back = new SpannableString(card.back);
        int start = card.back.indexOf(gist);
        if (!gist.isEmpty() && start >= 0) {   // Gist line in bold
            back.setSpan(new StyleSpan(Typeface.BOLD), start, start + gist.length(), 0);
        }
        backText.setText(back);
        backText.setVisibility(answered ? View.VISIBLE : View.GONE);
        answerDivider.setVisibility(backText.getVisibility());

        optionsLayout.setVisibility(choiceStyle ? View.VISIBLE : View.GONE);
        for (int i = 0; i < optionButtons.length; i++) {
            MaterialButton b = optionButtons[i];
            if (choiceStyle && i < options.length) {
                b.setVisibility(View.VISIBLE);
                b.setText(options[i]);
                b.setClickable(chosen < 0);   // stays enabled so the colours are not greyed out
                if (chosen < 0) styleOption(b, OPT_NORMAL);
                else if (options[i].equals(gist)) styleOption(b, OPT_RIGHT);
                else if (i == chosen) styleOption(b, OPT_WRONG);
                else styleOption(b, OPT_DIM);
            } else {
                b.setVisibility(View.GONE);
            }
        }

        if (choiceStyle && chosen >= 0) {
            boolean ok = options[chosen].equals(gist);
            resultText.setText(ok ? R.string.correct : R.string.wrong);
            resultText.setTextColor(MaterialColors.getColor(resultText,
                    ok ? R.attr.colorSuccess : androidx.appcompat.R.attr.colorError));
            resultText.setVisibility(View.VISIBLE);
        } else {
            resultText.setVisibility(View.GONE);
        }

        showAnswerButton.setVisibility(!choiceStyle && !revealed ? View.VISIBLE : View.GONE);
        gradeLayout.setVisibility(!choiceStyle && revealed ? View.VISIBLE : View.GONE);
        nextButton.setVisibility(choiceStyle && chosen >= 0 ? View.VISIBLE : View.GONE);
    }

    /** Theme colours only: right = green fill + check, wrong = red fill + cross, others muted. */
    private void styleOption(MaterialButton b, int look) {
        int stroke, fill, text;
        if (look == OPT_RIGHT) {
            stroke = R.attr.colorSuccess;
            fill = R.attr.colorSuccessContainer;
            text = R.attr.colorOnSuccessContainer;
        } else if (look == OPT_WRONG) {
            stroke = androidx.appcompat.R.attr.colorError;
            fill = com.google.android.material.R.attr.colorErrorContainer;
            text = com.google.android.material.R.attr.colorOnErrorContainer;
        } else {
            stroke = com.google.android.material.R.attr.colorOutlineVariant;
            fill = 0;   // transparent
            text = look == OPT_DIM ? com.google.android.material.R.attr.colorOnSurfaceVariant
                    : com.google.android.material.R.attr.colorOnSurface;
        }
        float dp = getResources().getDisplayMetrics().density;
        b.setStrokeColor(ColorStateList.valueOf(MaterialColors.getColor(b, stroke)));
        b.setStrokeWidth((int) ((look == OPT_RIGHT || look == OPT_WRONG ? 2 : 1) * dp));
        b.setBackgroundTintList(ColorStateList.valueOf(
                fill == 0 ? Color.TRANSPARENT : MaterialColors.getColor(b, fill)));
        ColorStateList textColor = ColorStateList.valueOf(MaterialColors.getColor(b, text));
        b.setTextColor(textColor);
        b.setIconTint(textColor);
        if (look == OPT_RIGHT) b.setIconResource(R.drawable.ic_check);
        else if (look == OPT_WRONG) b.setIconResource(R.drawable.ic_close);
        else b.setIcon(null);
    }

    private void toggleMode() {
        mode = mode == MODE_ORIGINAL ? MODE_CHOICE : MODE_ORIGINAL;
        prefs.edit().putInt(KEY_MODE, mode).apply();
        showCard(false);   // rebuild the current (still unanswered) Card for the new Mode
    }

    private void onOption(int n) {
        if (chosen >= 0 || options == null) return;
        chosen = n;
        boolean ok = options[n].equals(Card.gistOf(card.back));
        applyGrade(ok ? Sm2.HARD : Sm2.AGAIN);   // wrong = Again, correct = Hard
        render();
    }

    private void grade(int q) {
        applyGrade(q);
        advance();
    }

    private void advance() {
        index++;
        showCard(false);
    }

    private void applyGrade(int q) {
        reviewed++;
        if (q == Sm2.AGAIN) again++;
        if (sessionId == -1) sessionId = db.startSession(deckId, practice);
        saveLog();
        if (!practice) {   // Practice sessions never change a schedule
            Sm2.Result r = Sm2.next(card.ease, card.intervalDays, card.repetitions, q);
            db.saveSchedule(card.id, r.ease, r.interval, r.repetitions,
                    DbHelper.today() + r.interval, card.intervalDays == 0);
        }
    }

    // ---- dialogs ----

    private void confirmEnd() {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.end_title)
                .setMessage(R.string.end_message)
                .setPositiveButton(R.string.end_yes, (d, w) -> finish())
                .setNegativeButton(R.string.keep_studying, null)
                .show();
    }

    private void showSummary() {
        stopTimer();
        saveLog();
        for (View v : new View[]{flashCard, optionsLayout,
                gradeLayout, showAnswerButton, nextButton}) {
            v.setVisibility(View.GONE);
        }
        modeButton.setEnabled(false);
        progressText.setText(R.string.session_complete);
        progressBar.setMax(1);
        progressBar.setProgressCompat(1, false);
        long s = elapsedMs / 1000;
        String time = String.format(Locale.getDefault(), "%d:%02d", s / 60, s % 60);
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.summary_title)
                .setMessage(getString(R.string.summary_message, reviewed, again, time))
                .setCancelable(false)
                .setPositiveButton(android.R.string.ok, (d, w) -> finish())
                .show();
    }
}
