package com.example.flashcards;

import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.WindowCompat;

import com.google.android.material.appbar.MaterialToolbar;

import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

/** Screen 6: Statistics and the study log, for all Decks or one Deck. */
public class StatsActivity extends AppCompatActivity {
    /** Optional: open for one Deck only (no deck filter). */
    public static final String EXTRA_DECK_ID = "deckId";
    private static final int LOG_LIMIT = 50;

    private DbHelper db;
    private final List<Long> deckIds = new ArrayList<>();   // parallel to the filter items; -1 = all

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_stats);
        Ui.applyInsets(findViewById(R.id.main));

        db = new DbHelper(this);
        MaterialToolbar toolbar = findViewById(R.id.toolbar);
        toolbar.setNavigationOnClickListener(v -> getOnBackPressedDispatcher().onBackPressed());

        title(R.id.rowToday, R.string.stats_today);
        title(R.id.rowAllTime, R.string.stats_all_time);
        title(R.id.rowStreak, R.string.stats_streak);
        title(R.id.rowAgain, R.string.stats_again_rate);
        title(R.id.rowNew, R.string.state_new);
        title(R.id.rowLearning, R.string.state_learning);
        title(R.id.rowMature, R.string.state_mature);

        long oneDeck = getIntent().getLongExtra(EXTRA_DECK_ID, -1);
        if (oneDeck != -1) {   // opened from a Deck screen: that Deck only
            Deck deck = db.getDeck(oneDeck);
            if (deck != null) toolbar.setTitle(deck.name);
            findViewById(R.id.deckFilter).setVisibility(View.GONE);
            show(oneDeck);
            return;
        }

        // deck filter: "All decks" + every Deck (Spinner keeps its selection on rotation)
        List<String> names = new ArrayList<>();
        names.add(getString(R.string.stats_all_decks));
        deckIds.add(-1L);
        for (Deck d : db.getDecks()) {
            names.add(d.name);
            deckIds.add(d.id);
        }
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this,
                android.R.layout.simple_spinner_item, names);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        Spinner filter = findViewById(R.id.deckFilter);
        filter.setAdapter(adapter);
        filter.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
                show(deckIds.get(pos));
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        db.close();
    }

    private void title(int rowId, int text) {
        ((TextView) findViewById(rowId).findViewById(R.id.settingTitle)).setText(text);
    }

    private void value(int rowId, String text) {
        ((TextView) findViewById(rowId).findViewById(R.id.settingValue)).setText(text);
    }

    private static String duration(long seconds) {
        long h = seconds / 3600, m = seconds % 3600 / 60, s = seconds % 60;
        return h > 0 ? String.format(Locale.getDefault(), "%d:%02d:%02d", h, m, s)
                : String.format(Locale.getDefault(), "%d:%02d", m, s);
    }

    private void show(long deckId) {
        Stats s = db.getStats(deckId);

        value(R.id.rowToday, getString(R.string.stats_cards_time,
                s.weekCards[6], duration(s.weekSeconds[6])));
        value(R.id.rowAllTime, getString(R.string.stats_cards_time,
                s.totalCards, duration(s.totalSeconds)));
        value(R.id.rowStreak, String.valueOf(s.streak));
        value(R.id.rowAgain, s.gradedCards == 0 ? getString(R.string.stats_no_value)
                : getString(R.string.stats_percent, Math.round(100f * s.againCards / s.gradedCards)));

        int[] minutes = new int[7];
        for (int i = 0; i < 7; i++) minutes[i] = (int) ((s.weekSeconds[i] + 59) / 60);   // round up
        buildChart(findViewById(R.id.chartCards), s.weekCards);
        buildChart(findViewById(R.id.chartMinutes), minutes);

        value(R.id.rowNew, String.valueOf(s.newCount));
        value(R.id.rowLearning, String.valueOf(s.learningCount));
        value(R.id.rowMature, String.valueOf(s.matureCount));

        showLog(deckId);
    }

    /** Simple 7-day bar chart from plain Views; bar height relative to the largest day. */
    private void buildChart(LinearLayout chart, int[] values) {
        chart.removeAllViews();
        int max = 1;
        for (int v : values) max = Math.max(max, v);
        float dp = getResources().getDisplayMetrics().density;
        int tallest = (int) (90 * dp);
        Locale locale = getResources().getConfiguration().getLocales().get(0);
        long today = DbHelper.today();

        for (int i = 0; i < 7; i++) {
            View col = getLayoutInflater().inflate(R.layout.item_chart_bar, chart, false);
            ((TextView) col.findViewById(R.id.barValue)).setText(String.valueOf(values[i]));
            ((TextView) col.findViewById(R.id.barLabel)).setText(LocalDate.ofEpochDay(today - 6 + i)
                    .getDayOfWeek().getDisplayName(TextStyle.SHORT, locale));
            View bar = col.findViewById(R.id.bar);
            ViewGroup.LayoutParams lp = bar.getLayoutParams();
            lp.height = Math.max((int) (2 * dp), values[i] * tallest / max);
            bar.setLayoutParams(lp);
            chart.addView(col);
        }
    }

    private void showLog(long deckId) {
        LinearLayout list = findViewById(R.id.historyList);
        list.removeAllViews();
        List<Session> sessions = db.getSessions(deckId, LOG_LIMIT);
        findViewById(R.id.historyEmpty).setVisibility(sessions.isEmpty() ? View.VISIBLE : View.GONE);

        java.text.DateFormat date = DateFormat.getMediumDateFormat(this);
        java.text.DateFormat time = DateFormat.getTimeFormat(this);
        for (Session s : sessions) {
            View row = getLayoutInflater().inflate(R.layout.item_session, list, false);
            ((TextView) row.findViewById(R.id.sessionTitle)).setText(s.practice
                    ? getString(R.string.session_practice_title, s.deckName) : s.deckName);
            Date when = new Date(s.startedAt);
            ((TextView) row.findViewById(R.id.sessionDetail)).setText(getString(
                    R.string.session_detail, date.format(when) + " " + time.format(when),
                    s.cards, s.again, duration(s.seconds)));
            list.addView(row);
        }
    }
}
