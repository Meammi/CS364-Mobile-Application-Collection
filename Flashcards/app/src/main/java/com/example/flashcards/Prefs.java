package com.example.flashcards;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.appcompat.app.AppCompatDelegate;

/** App settings in SharedPreferences "flashcards". Language is stored by AppCompat itself. */
final class Prefs {
    private Prefs() {}

    static final String FILE = "flashcards";
    static final String KEY_MODE = "mode";               // last used Mode (Review writes it)
    static final String KEY_THEME = "theme";
    static final String KEY_DEFAULT_MODE = "default_mode";
    static final String KEY_NEW_LIMIT = "new_limit";
    static final String KEY_REMINDER_ON = "reminder_on";
    static final String KEY_REMINDER_HOUR = "reminder_hour";
    static final String KEY_REMINDER_MINUTE = "reminder_minute";

    // theme: index in the Settings dialog
    static final int THEME_SYSTEM = 0;
    static final int THEME_LIGHT = 1;
    static final int THEME_DARK = 2;

    // default Mode: index in the Settings dialog
    static final int START_LAST_USED = 0;
    static final int START_ORIGINAL = 1;
    static final int START_CHOICE = 2;

    static SharedPreferences get(Context c) {
        return c.getSharedPreferences(FILE, Context.MODE_PRIVATE);
    }

    static int theme(Context c) {
        return get(c).getInt(KEY_THEME, THEME_SYSTEM);
    }

    static void applyTheme(int theme) {
        AppCompatDelegate.setDefaultNightMode(
                theme == THEME_LIGHT ? AppCompatDelegate.MODE_NIGHT_NO
                        : theme == THEME_DARK ? AppCompatDelegate.MODE_NIGHT_YES
                        : AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM);
    }

    static int defaultMode(Context c) {
        return get(c).getInt(KEY_DEFAULT_MODE, START_LAST_USED);
    }

    /** Daily limit of new Cards per Deck; 0 = unlimited. */
    static int newLimit(Context c) {
        return get(c).getInt(KEY_NEW_LIMIT, 0);
    }

    static boolean reminderOn(Context c) {
        return get(c).getBoolean(KEY_REMINDER_ON, false);
    }

    static int reminderHour(Context c) {
        return get(c).getInt(KEY_REMINDER_HOUR, 20);
    }

    static int reminderMinute(Context c) {
        return get(c).getInt(KEY_REMINDER_MINUTE, 0);
    }
}
