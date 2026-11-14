package com.example.flashcards;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.WindowCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.appbar.MaterialToolbar;

import java.util.ArrayList;
import java.util.List;

/** Screen 2: one Deck — its Cards, Study button, Add card button. */
public class DeckActivity extends AppCompatActivity {
    public static final String EXTRA_DECK_ID = "deckId";

    private DbHelper db;
    private long deckId;
    private Deck deck;
    private MaterialToolbar toolbar;
    private TextView summaryText;
    private TextView emptyText;
    private CardAdapter adapter;
    private AlertDialog dialog;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_deck);
        Ui.applyInsets(findViewById(R.id.main));

        db = new DbHelper(this);
        deckId = getIntent().getLongExtra(EXTRA_DECK_ID, -1);

        toolbar = findViewById(R.id.toolbar);
        toolbar.setNavigationOnClickListener(v -> getOnBackPressedDispatcher().onBackPressed());
        toolbar.inflateMenu(R.menu.menu_deck);
        toolbar.setOnMenuItemClickListener(item -> {
            if (item.getItemId() == R.id.action_deck_stats) {
                Intent i = new Intent(this, StatsActivity.class);
                i.putExtra(StatsActivity.EXTRA_DECK_ID, deckId);
                startActivity(i);
                return true;
            }
            if (deck != null && item.getItemId() == R.id.action_rename) {
                dialog = DeckDialogs.name(this, db, deck, this::reload);
                return true;
            }
            if (deck != null && item.getItemId() == R.id.action_reset) {
                dialog = DeckDialogs.reset(this, db, deck, this::reload);
                return true;
            }
            return false;
        });
        summaryText = findViewById(R.id.summaryText);
        emptyText = findViewById(R.id.emptyText);

        RecyclerView list = findViewById(R.id.cardList);
        list.setLayoutManager(new LinearLayoutManager(this));
        adapter = new CardAdapter();
        list.setAdapter(adapter);

        findViewById(R.id.studyButton).setOnClickListener(v -> onStudy());
        findViewById(R.id.addCardButton).setOnClickListener(v -> {
            Intent i = new Intent(this, AddEditCardActivity.class);
            i.putExtra(AddEditCardActivity.EXTRA_DECK_ID, deckId);
            startActivity(i);
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        reload();
    }

    private void reload() {
        deck = db.getDeck(deckId);
        if (deck == null) {   // the Deck no longer exists
            finish();
            return;
        }
        toolbar.setTitle(deck.name);
        summaryText.setText(getString(R.string.deck_counts, deck.dueCount, deck.cardCount));
        List<Card> cards = db.getCards(deckId);
        adapter.setItems(cards);
        emptyText.setVisibility(cards.isEmpty() ? View.VISIBLE : View.GONE);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (dialog != null) dialog.dismiss();
        db.close();
    }

    private void onStudy() {
        if (deck == null || deck.cardCount == 0) {
            Toast.makeText(this, R.string.add_cards_first, Toast.LENGTH_SHORT).show();
        } else if (deck.dueCount > 0) {
            startReview(false);
        } else {
            dialog = new AlertDialog.Builder(this)
                    .setTitle(R.string.nothing_due_title)
                    .setMessage(R.string.nothing_due_message)
                    .setPositiveButton(R.string.study_anyway, (d, w) -> startReview(true))
                    .setNegativeButton(android.R.string.cancel, null)
                    .show();
        }
    }

    private void startReview(boolean practice) {
        Intent i = new Intent(this, ReviewActivity.class);
        i.putExtra(ReviewActivity.EXTRA_DECK_ID, deckId);
        i.putExtra(ReviewActivity.EXTRA_PRACTICE, practice);
        startActivity(i);
    }

    private void confirmDelete(Card card) {
        dialog = new AlertDialog.Builder(this)
                .setTitle(R.string.delete_card_title)
                .setMessage(getString(R.string.delete_card_message, card.front))
                .setPositiveButton(R.string.delete, (d, w) -> {
                    db.deleteCard(card.id);
                    reload();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }

    private class CardAdapter extends RecyclerView.Adapter<CardAdapter.VH> {
        private List<Card> items = new ArrayList<>();

        void setItems(List<Card> cards) {
            items = cards;
            notifyDataSetChanged();
        }

        class VH extends RecyclerView.ViewHolder {
            final TextView front;
            final TextView gist;
            final Button delete;

            VH(View v) {
                super(v);
                front = v.findViewById(R.id.cardFront);
                gist = v.findViewById(R.id.cardGist);
                delete = v.findViewById(R.id.deleteButton);
            }
        }

        @Override
        public VH onCreateViewHolder(ViewGroup parent, int viewType) {
            return new VH(getLayoutInflater().inflate(R.layout.item_card, parent, false));
        }

        @Override
        public void onBindViewHolder(VH h, int position) {
            Card c = items.get(position);
            h.front.setText(c.front);
            h.gist.setText(Card.gistOf(c.back));
            h.itemView.setOnClickListener(v -> {
                Intent i = new Intent(DeckActivity.this, AddEditCardActivity.class);
                i.putExtra(AddEditCardActivity.EXTRA_DECK_ID, deckId);
                i.putExtra(AddEditCardActivity.EXTRA_CARD_ID, c.id);
                startActivity(i);
            });
            h.delete.setOnClickListener(v -> confirmDelete(c));
        }

        @Override
        public int getItemCount() {
            return items.size();
        }
    }
}
