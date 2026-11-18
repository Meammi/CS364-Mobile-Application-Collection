package com.example.flashcards;

import android.graphics.Typeface;
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
import com.google.android.material.card.MaterialCardView;
import com.google.android.material.color.MaterialColors;

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

        tileText(R.id.tileToday, R.id.statLabel, getString(R.string.stats_today));
        tileText(R.id.tileAllTime, R.id.statLabel, getString(R.string.stats_all_time));
        tileText(R.id.tileStreak, R.id.statLabel, getString(R.string.stats_streak));
        tileText(R.id.tileAgain, R.id.statLabel, getString(R.string.stats_again_short));
        tileText(R.id.tileAgain, R.id.statSub, getString(R.string.stats_reviews_only));
        highlightStreak();
        findViewById(R.id.stateBar).setClipToOutline(true);   // round the ends of the segments

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
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, R.layout.item_filter, names);
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

    private void tileText(int tileId, int textId, String text) {
        ((TextView) findViewById(tileId).findViewById(textId)).setText(text);
    }

    /** Days in a row: the one dark tile, in the header colours; no small line. */
    private void highlightStreak() {
        MaterialCardView tile = findViewById(R.id.tileStreak);
        tile.setCardBackgroundColor(MaterialColors.getColor(tile, R.attr.colorHeader));
        tile.setStrokeWidth(0);
        ((TextView) tile.findViewById(R.id.statLabel)).setTextColor(
                MaterialColors.getColor(tile, R.attr.colorOnHeaderVariant));
        ((TextView) tile.findViewById(R.id.statValue)).setTextColor(
                MaterialColors.getColor(tile, R.attr.colorOnHeader));
        tile.findViewById(R.id.statSub).setVisibility(View.GONE);
    }

    private void segment(int id, int count) {
        View seg = findViewById(id);
        LinearLayout.LayoutParams lp = (LinearLayout.LayoutParams) seg.getLayoutParams();
        lp.weight = count;
        seg.setLayoutParams(lp);
    }

    private static String duration(long seconds) {
        long h = seconds / 3600, m = seconds % 3600 / 60, s = seconds % 60;
        return h > 0 ? String.format(Locale.getDefault(), "%d:%02d:%02d", h, m, s)
                : String.format(Locale.getDefault(), "%d:%02d", m, s);
    }

    private void show(long deckId) {
        Stats s = db.getStats(deckId);

        tileText(R.id.tileToday, R.id.statValue, String.valueOf(s.weekCards[6]));
        tileText(R.id.tileToday, R.id.statSub, getString(R.string.stats_cards_sub, duration(s.weekSeconds[6])));
        tileText(R.id.tileAllTime, R.id.statValue, String.valueOf(s.totalCards));
        tileText(R.id.tileAllTime, R.id.statSub, getString(R.string.stats_cards_sub, duration(s.totalSeconds)));
        tileText(R.id.tileStreak, R.id.statValue, String.valueOf(s.streak));
        tileText(R.id.tileAgain, R.id.statValue, s.gradedCards == 0 ? getString(R.string.stats_no_value)
                : getString(R.string.stats_percent, Math.round(100f * s.againCards / s.gradedCards)));

        int[] minutes = new int[7];
        for (int i = 0; i < 7; i++) minutes[i] = (int) ((s.weekSeconds[i] + 59) / 60);   // round up
        buildChart(findViewById(R.id.chartCards), s.weekCards);
        buildChart(findViewById(R.id.chartMinutes), minutes);

        segment(R.id.stateNewSeg, s.newCount);
        segment(R.id.stateLearningSeg, s.learningCount);
        segment(R.id.stateMatureSeg, s.matureCount);
        ((TextView) findViewById(R.id.stateNewCount)).setText(String.valueOf(s.newCount));
        ((TextView) findViewById(R.id.stateLearningCount)).setText(String.valueOf(s.learningCount));
        ((TextView) findViewById(R.id.stateMatureCount)).setText(String.valueOf(s.matureCount));

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
            TextView label = col.findViewById(R.id.barLabel);
            View bar = col.findViewById(R.id.bar);
            if (i == 6) {   // today: pink bar, "Today" in bold
                label.setText(R.string.stats_today);
                label.setTypeface(label.getTypeface(), Typeface.BOLD);
                bar.setBackgroundResource(R.drawable.bg_bar_today);
            } else {
                label.setText(LocalDate.ofEpochDay(today - 6 + i)
                        .getDayOfWeek().getDisplayName(TextStyle.SHORT, locale));
            }
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
        for (int i = 0; i < sessions.size(); i++) {
            Session s = sessions.get(i);
            View row = getLayoutInflater().inflate(R.layout.item_session, list, false);
            ((TextView) row.findViewById(R.id.sessionTitle)).setText(s.deckName);
            row.findViewById(R.id.sessionTag).setVisibility(s.practice ? View.VISIBLE : View.GONE);
            row.findViewById(R.id.sessionDivider).setVisibility(
                    i == sessions.size() - 1 ? View.GONE : View.VISIBLE);
            Date when = new Date(s.startedAt);
            ((TextView) row.findViewById(R.id.sessionDetail)).setText(getString(
                    R.string.session_detail, date.format(when) + " " + time.format(when),
                    s.cards, s.again, duration(s.seconds)));
            list.addView(row);
        }
    }
}
