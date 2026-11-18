package com.example.flashcards;

import android.view.View;

import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

final class Ui {
    private Ui() {}

    /** Edge-to-edge: pad the root by the system bars (and the keyboard).
     *  The toolbar takes the top inset so its band reaches under the status bar. */
    static void applyInsets(View root) {
        View bar = root.findViewById(R.id.toolbar);
        int barHeight = bar != null ? bar.getLayoutParams().height : 0;
        ViewCompat.setOnApplyWindowInsetsListener(root, (v, insets) -> {
            Insets bars = insets.getInsets(
                    WindowInsetsCompat.Type.systemBars() | WindowInsetsCompat.Type.ime());
            if (bar != null && barHeight > 0) {
                v.setPadding(bars.left, 0, bars.right, bars.bottom);
                bar.setPadding(bar.getPaddingLeft(), bars.top, bar.getPaddingRight(), bar.getPaddingBottom());
                bar.getLayoutParams().height = barHeight + bars.top;
                bar.requestLayout();
            } else {
                v.setPadding(bars.left, bars.top, bars.right, bars.bottom);
            }
            return insets;
        });
    }
}
