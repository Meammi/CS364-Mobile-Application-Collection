package com.example.flashcards;

import android.app.Application;

/** Re-applies the saved theme each time the app process starts. */
public class FlashcardsApp extends Application {
    @Override
    public void onCreate() {
        super.onCreate();
        Prefs.applyTheme(Prefs.theme(this));
    }
}
