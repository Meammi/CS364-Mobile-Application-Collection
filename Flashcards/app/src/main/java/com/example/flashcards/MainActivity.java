package com.example.flashcards;

import android.content.Intent;
import android.os.Bundle;
import android.os.SystemClock;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.OnBackPressedCallback;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.PopupMenu;
import androidx.core.view.WindowCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.appbar.MaterialToolbar;

import java.util.ArrayList;
import java.util.List;

/** Screen 1: the list of Decks. Double-back exits the app. */
public class MainActivity extends AppCompatActivity {

    private DbHelper db;
    private DeckAdapter adapter;
    private TextView emptyText;
    private AlertDialog dialog;
    private long lastBackPress = -2000;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_main);
        Ui.applyInsets(findViewById(R.id.main));

        db = new DbHelper(this);
        emptyText = findViewById(R.id.emptyText);

        RecyclerView list = findViewById(R.id.deckList);
        list.setLayoutManager(new LinearLayoutManager(this));
        adapter = new DeckAdapter();
        list.setAdapter(adapter);

        findViewById(R.id.newDeckButton).setOnClickListener(v -> showNewDeckDialog());

        MaterialToolbar toolbar = findViewById(R.id.toolbar);
        toolbar.inflateMenu(R.menu.menu_main);
        toolbar.setOnMenuItemClickListener(item -> {
            if (item.getItemId() == R.id.action_stats) {
                startActivity(new Intent(this, StatsActivity.class));
                return true;
            }
            if (item.getItemId() == R.id.action_settings) {
                startActivity(new Intent(this, SettingsActivity.class));
                return true;
            }
            return false;
        });

        getOnBackPressedDispatcher().addCallback(this, new OnBackPressedCallback(true) {
            @Override
            public void handleOnBackPressed() {
                long now = SystemClock.elapsedRealtime();
                if (now - lastBackPress < 2000) {
                    finish();
                } else {
                    lastBackPress = now;
                    Toast.makeText(MainActivity.this, R.string.press_back_again,
                            Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        reload();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (dialog != null) dialog.dismiss();
        db.close();
    }

    private void reload() {
        List<Deck> decks = db.getDecks();
        adapter.setItems(decks);
        emptyText.setVisibility(decks.isEmpty() ? View.VISIBLE : View.GONE);
    }

    private void showNewDeckDialog() {
        dialog = DeckDialogs.name(this, db, null, this::reload);
    }

    private void confirmDelete(Deck deck) {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.delete_deck_title)
                .setMessage(getString(R.string.delete_deck_message, deck.name, deck.cardCount))
                .setPositiveButton(R.string.delete, (d, w) -> {
                    db.deleteDeck(deck.id);
                    reload();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private class DeckAdapter extends RecyclerView.Adapter<DeckAdapter.VH> {
        private List<Deck> items = new ArrayList<>();

        void setItems(List<Deck> decks) {
            items = decks;
            notifyDataSetChanged();
        }

        class VH extends RecyclerView.ViewHolder {
            final TextView name;
            final TextView counts;
            final Button more;

            VH(View v) {
                super(v);
                name = v.findViewById(R.id.deckName);
                counts = v.findViewById(R.id.deckCounts);
                more = v.findViewById(R.id.moreButton);
            }
        }

        @Override
        public VH onCreateViewHolder(ViewGroup parent, int viewType) {
            return new VH(getLayoutInflater().inflate(R.layout.item_deck, parent, false));
        }

        @Override
        public void onBindViewHolder(VH h, int position) {
            Deck d = items.get(position);
            h.name.setText(d.name);
            h.counts.setText(getString(R.string.deck_counts, d.dueCount, d.cardCount));
            h.itemView.setOnClickListener(v -> {
                Intent i = new Intent(MainActivity.this, DeckActivity.class);
                i.putExtra(DeckActivity.EXTRA_DECK_ID, d.id);
                startActivity(i);
            });
            h.more.setOnClickListener(v -> {   // kebab menu: Statistics, Rename, Reset progress, Delete
                PopupMenu popup = new PopupMenu(MainActivity.this, v);
                popup.inflate(R.menu.menu_deck_row);
                popup.setOnMenuItemClickListener(item -> {
                    if (item.getItemId() == R.id.action_row_stats) {
                        Intent i = new Intent(MainActivity.this, StatsActivity.class);
                        i.putExtra(StatsActivity.EXTRA_DECK_ID, d.id);
                        startActivity(i);
                        return true;
                    }
                    if (item.getItemId() == R.id.action_row_rename) {
                        dialog = DeckDialogs.name(MainActivity.this, db, d, MainActivity.this::reload);
                        return true;
                    }
                    if (item.getItemId() == R.id.action_row_reset) {
                        dialog = DeckDialogs.reset(MainActivity.this, db, d, MainActivity.this::reload);
                        return true;
                    }
                    if (item.getItemId() == R.id.action_row_delete) {
                        confirmDelete(d);
                        return true;
                    }
                    return false;
                });
                popup.show();
            });
        }

        @Override
        public int getItemCount() {
            return items.size();
        }
    }
}
