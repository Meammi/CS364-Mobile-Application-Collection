package com.example.flashcards;

import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.view.WindowCompat;

import com.google.android.material.appbar.MaterialToolbar;
import com.google.android.material.textfield.TextInputEditText;
import com.google.android.material.textfield.TextInputLayout;

/** Screen 3: create or edit a Card. Front and Back are both required. */
public class AddEditCardActivity extends AppCompatActivity {
    public static final String EXTRA_DECK_ID = "deckId";
    public static final String EXTRA_CARD_ID = "cardId";

    private DbHelper db;
    private long deckId;
    private long cardId;
    private TextInputLayout frontLayout;
    private TextInputLayout backLayout;
    private TextInputEditText frontInput;
    private TextInputEditText backInput;
    private View previewCard;
    private TextView previewFront;
    private TextView previewGist;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        WindowCompat.enableEdgeToEdge(getWindow());
        setContentView(R.layout.activity_add_edit_card);
        Ui.applyInsets(findViewById(R.id.main));

        db = new DbHelper(this);
        deckId = getIntent().getLongExtra(EXTRA_DECK_ID, -1);
        cardId = getIntent().getLongExtra(EXTRA_CARD_ID, -1);

        frontLayout = findViewById(R.id.frontLayout);
        backLayout = findViewById(R.id.backLayout);
        frontInput = findViewById(R.id.frontInput);
        backInput = findViewById(R.id.backInput);
        MaterialToolbar header = findViewById(R.id.toolbar);
        header.setNavigationOnClickListener(v -> getOnBackPressedDispatcher().onBackPressed());
        Button saveAnother = findViewById(R.id.saveAnotherButton);

        if (cardId != -1) {
            header.setTitle(R.string.edit_card_title);
            saveAnother.setVisibility(View.GONE);
            if (savedInstanceState == null) {   // after rotation the EditTexts restore themselves
                Card c = db.getCard(cardId);
                if (c != null) {
                    frontInput.setText(c.front);
                    backInput.setText(c.back);
                }
            }
        } else {
            header.setTitle(R.string.add_card_title);
        }
        Deck deck = db.getDeck(deckId);
        if (deck != null) header.setSubtitle(deck.name);

        previewCard = findViewById(R.id.previewCard);
        previewFront = findViewById(R.id.previewFront);
        previewGist = findViewById(R.id.previewGist);
        TextWatcher watcher = new TextWatcher() {
            @Override public void beforeTextChanged(CharSequence s, int a, int b, int c) {}
            @Override public void onTextChanged(CharSequence s, int a, int b, int c) {}
            @Override public void afterTextChanged(Editable s) { updatePreview(); }
        };
        frontInput.addTextChangedListener(watcher);
        backInput.addTextChangedListener(watcher);
        updatePreview();

        findViewById(R.id.saveButton).setOnClickListener(v -> {
            if (save()) finish();
        });
        saveAnother.setOnClickListener(v -> {
            if (save()) {
                frontInput.setText("");
                backInput.setText("");
                frontInput.requestFocus();
                Toast.makeText(this, R.string.saved, Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        db.close();
    }

    /** Front + Gist line, as lists and Multiple Choice will show them. */
    private void updatePreview() {
        String front = textOf(frontInput).trim();
        String gist = Card.gistOf(textOf(backInput));
        previewCard.setVisibility(front.isEmpty() && gist.trim().isEmpty() ? View.GONE : View.VISIBLE);
        previewFront.setText(front);
        previewGist.setText(gist);
    }

    private static String textOf(TextInputEditText e) {
        return e.getText() == null ? "" : e.getText().toString();
    }

    private boolean save() {
        String front = textOf(frontInput).trim();
        String back = textOf(backInput);   // kept as typed: the Gist line is used unchanged
        frontLayout.setError(front.isEmpty() ? getString(R.string.required) : null);
        backLayout.setError(back.trim().isEmpty() ? getString(R.string.required) : null);
        if (front.isEmpty() || back.trim().isEmpty()) return false;
        if (db.frontExists(deckId, front, cardId)) {   // no duplicate Front in this Deck
            frontLayout.setError(getString(R.string.card_front_exists));
            return false;
        }

        if (cardId == -1) {
            db.addCard(deckId, front, back);
        } else {
            db.updateCard(cardId, front, back);
        }
        return true;
    }
}
