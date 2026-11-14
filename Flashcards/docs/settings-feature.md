# Settings feature — scope (student wants all of it) and open details

Status 14 Nov 2026: BUILT (compiles, lint clean), NOT yet tested on a device. See "Settled decisions". The student also wants "follow the device" as an option for theme and language.

## Scope
1. **Theme:** System (follow device) / Light / Dark.
2. **Language:** System (follow device) / English / ไทย.
3. **Default review Mode:** which Mode a Review session starts in.
4. **Study reminder:** a notification at a time the user chooses, saying how many Cards are Due.
5. **Reset progress:** set every Card back to "new" without deleting Cards.
6. **Daily new-card limit:** cap how many never-reviewed Cards a day's Review sessions introduce.

Entry point: a "Settings" button on the deck list (the theme is `NoActionBar`, so there is no app-bar menu; decide with the student between a text button, an icon button in the header, or adding a Toolbar). New `SettingsActivity`, stored in SharedPreferences (course pattern; existing file `flashcards`, key `mode` is already used by Review).

## Mechanisms (what Claude believes about the APIs; verify against current docs before building)
- **Theme** [fact, AppCompat]: `AppCompatDelegate.setDefaultNightMode(MODE_NIGHT_FOLLOW_SYSTEM | MODE_NIGHT_NO | MODE_NIGHT_YES)` recreates open activities, but the choice is not persisted by itself: save it in SharedPreferences and re-apply it at process start (a small `Application` subclass declared in the manifest via `android:name`, or at the start of every Activity's `onCreate`).
- **Language** [fact, AppCompat 1.6+; this project has 1.8.0]: `AppCompatDelegate.setApplicationLocales(LocaleListCompat.forLanguageTags("th"))`; the empty list `LocaleListCompat.getEmptyLocaleList()` means follow the device. On API 33+ the platform stores it; below 33 AppCompat persists it only if the manifest declares the `AppLocalesMetadataHolderService` with metadata `autoStoreLocales=true` [inference: minSdk is 29, so this declaration is needed]. Optional: `res/xml/locales_config.xml` plus `android:localeConfig` so the per-app language appears in system settings on 13+.
- **Rubric link** [inference]: criteria 3.3 and 3.4 say "switching language/theme changes the screens"; an in-app switch makes that easy to demonstrate with screenshots, and "System" keeps the current device-following behaviour.
- **Reminder** [fact: Week 11 pattern in `Docs/Week11/TaskReminderSQLite`]: persist the intention in SharedPreferences, schedule with AlarmManager through a `PendingIntent` (one fixed request code), a `BroadcastReceiver` shows the notification, a boot receiver re-arms after reboot; a daily reminder re-arms itself in the receiver; `POST_NOTIFICATIONS` needs a runtime request on Android 13+; notification channel on 8+. [inference] An inexact alarm (`setAndAllowWhileIdle`) avoids the `SCHEDULE_EXACT_ALARM` special permission and is enough for a study reminder; the course sample uses exact alarms. The receiver reads the Due count from SQLite at fire time (not a stored number).
- **Reset progress:** `UPDATE cards SET ease_factor=2.5, interval_days=0, repetitions=0, due_day=<today>`; must ask for confirmation (rubric 4.3 style), and cancel must change nothing.
- **Daily new-card limit** [inference]: affects `DbHelper.getDueCardIds` and the Due counts shown on the Deck list and Deck screen. Counting "new Cards already introduced today" needs state: either a column (for example `first_review_day`) or a per-day counter in SharedPreferences. A schema change must migrate with `ALTER TABLE` (see design-decisions.md, pitfalls).

## Settled decisions (14 Nov 2026, student chose every recommendation)
1. Reminder: one global daily time (default 20:00, off by default), skipped when nothing is Due; inexact alarm (may arrive a few minutes late).
2. Reset progress: per Deck (Deck screen top-bar menu) and all Decks (Settings); both confirm. Reset also clears `first_review_day`, so a reset Deck may start new Cards again the same day.
3. New-card limit: one value in Settings, applied per Deck, per local day, 0 = unlimited (default). Stored as `cards.first_review_day` (DB_VERSION 2, `ALTER TABLE` migration).
4. Default Mode: Last used (default) / Original / Multiple Choice; key `default_mode`.
5. Entry point: gear icon in the deck-list MaterialToolbar.
6. Settings rows open AlertDialog single-choice lists; limit = number dialog; time = TimePickerDialog.

Known limit: below Android 13 the notification text uses the device language, not the in-app language.

## Open decisions (historical: the questions asked before building)
1. Reminder: one global daily time, or per Deck? [one global daily time]
2. Reminder: skip the notification when nothing is Due? [yes, skip]
3. Reset progress: all Decks or one Deck? [per Deck from the Deck screen, plus an all-Decks option in Settings if wanted]
4. New-card limit: per Deck or global; counted per local calendar day; what does 0 mean? [global, 0 = unlimited so the current behaviour stays the default]. Note this reverses the earlier decision "no daily cap".
5. Default Mode: three choices "Original", "Multiple Choice", "Remember last used"? [three choices, default Remember last used = today's behaviour]
6. Where does the Settings button go (see Entry point above)? [header button on the deck list]
7. English strings and `values-th` strings for every new label (rule in CLAUDE.md).

## Verify on a device when built (feeds the report)
Language switch updates open screens and dialogs; theme switch recolours; "System" follows the device again; reminder fires at the chosen time and after a reboot; the notification opens the app; reset asks to confirm; the limit changes the Due count and the session length; settings survive an app restart.
