package com.example.flashcards;

import android.app.Activity;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;

import com.google.android.material.textfield.TextInputLayout;

/** Deck dialogs shared by the deck list and the Deck screen. Callers dismiss them in onDestroy. */
final class DeckDialogs {
    private DeckDialogs() {}

    /** New deck (deck == null) or rename. Empty or duplicate names keep the dialog open. */
    static AlertDialog name(Activity a, DbHelper db, Deck deck, Runnable done) {
        View view = a.getLayoutInflater().inflate(R.layout.dialog_deck_name, null);
        TextInputLayout layout = view.findViewById(R.id.deckNameLayout);
        EditText input = view.findViewById(R.id.deckNameInput);
        if (deck != null) {
            input.setText(deck.name);
            input.setSelectAllOnFocus(true);
        }
        AlertDialog dialog = new AlertDialog.Builder(a)
                .setTitle(deck == null ? R.string.new_deck : R.string.rename_deck)
                .setView(view)
                .setPositiveButton(deck == null ? R.string.create : R.string.rename, null)
                .setNegativeButton(android.R.string.cancel, null)
                .show();
        // own click handler so an invalid name keeps the dialog open
        dialog.getButton(AlertDialog.BUTTON_POSITIVE).setOnClickListener(v -> {
            String name = input.getText().toString().trim();
            if (name.isEmpty()) {
                layout.setError(a.getString(R.string.required));
            } else if (db.deckNameExists(name, deck == null ? -1 : deck.id)) {
                layout.setError(a.getString(R.string.deck_name_exists));
            } else {
                if (deck == null) db.addDeck(name);
                else db.renameDeck(deck.id, name);
                done.run();
                dialog.dismiss();
            }
        });
        return dialog;
    }

    /** Reset progress of one Deck after confirmation; Cards are kept. */
    static AlertDialog reset(Activity a, DbHelper db, Deck deck, Runnable done) {
        return new AlertDialog.Builder(a)
                .setTitle(R.string.reset_deck_title)
                .setMessage(a.getString(R.string.reset_deck_message, deck.name))
                .setPositiveButton(R.string.reset_confirm, (d, w) -> {
                    db.resetProgress(deck.id);
                    done.run();
                    Toast.makeText(a, R.string.progress_reset, Toast.LENGTH_SHORT).show();
                })
                .setNegativeButton(android.R.string.cancel, null)
                .show();
    }
}
