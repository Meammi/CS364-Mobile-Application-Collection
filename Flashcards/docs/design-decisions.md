 # Design decisions (settled with the student on 14 Nov 2026)

Labels: [decision] = the student chose or approved it; [assumption] = Claude's reading, stated to the student, not objected to; [fact] = verified (code, test, source). Vocabulary: see ../CONTEXT.md.

## First principles
1. A Card is two opaque strings. Structure lives in the user's text, never in the schema; this keeps creation frictionless. Anything the app needs (the Gist line) is derived when needed, never stored.
2. SQLite is the source of truth, screens only show it (Week 8b pattern). Each grade is written immediately. Temporary UI state is saved in the Bundle (Week 6/8a).
3. Scheduling is a pure function (ease, interval, repetitions, grade) -> new values, so it is testable without Android.
4. Every behaviour the rubric checks (criteria 3 and 4) is built in, not added at the end.

## Decisions
| Topic | Decision | Notes |
|---|---|---|
| Persistence | SQLiteOpenHelper | Course pattern; rejected: Room, JSON file |
| Schedule storage | four columns on `cards`: `ease_factor`, `interval_days`, `repetitions`, `due_day` | rejected: separate schedule table (joins). A per-grade reviews log was rejected; statistics (added 14 Nov 2026) use a per-session `sessions` table instead, which covers cards, Again, time and streak |
| Algorithm | SM-2 in our own `Sm2` class (~25 lines) from Wozniak's published description | Credit in report criterion 5.2. No suitable Android library (the Java one found is GPLv3; the other is FSRS). The student said they do not need to explain the algorithm |
| Grades | Again=1, Hard=3, Good=4, Easy=5 | Four buttons in Original mode |
| Failure (q<3) | repetitions reset, ease unchanged [assumption: official SM-2], due tomorrow, no re-queue inside the session | |
| Ease | ease' = max(1.3, ease + 0.1 - (5-q)(0.08 + (5-q)0.02)); start 2.5 | |
| Intervals | 1, 6, then ceil(previous interval x ease) using the ease before the update | [fact] Sm2 matches the worked example below (JUnit-free javac test passed) |
| Due | local calendar day (epoch day); new Cards Due on the day created; daily new-card limit per Deck from Settings (0 = unlimited, default); order: reviewed overdue Cards by due day, then new Cards (`interval_days = 0`) | |
| Practice session | "Study anyway" when nothing is Due; grades are not applied | |
| Multiple Choice | up to 4 Options = Gist line of target + up to 3 Distractors (Gist lines of other Cards of the same Deck); blank Backs and duplicates skipped | |
| Too few Options | fewer than 2 -> that Card is shown in Original mode with a notice | |
| MC grading | wrong = Again, correct = Hard | student's option (c); alternatives considered: correct = Good, or ask the user to grade after answering |
| Option order | saved in the Bundle so rotation does not reshuffle | |
| Mode | switchable only before answering the current Card; the last used Mode is remembered app-wide (SharedPreferences `flashcards`/`mode`) | Settings "Starting mode": Last used (default) / Original / Multiple Choice |
| Gist line | first non-blank line of the Back, used unchanged, never stored | |
| Validation | Front and Back both required (non-blank); no duplicate Front in the same Deck, no duplicate deck name (ignoring case and surrounding spaces; checked on add, edit, create, rename; blocked with an error under the field; existing duplicates are left alone) | |
| Session | grades written immediately, so quitting loses nothing; Back asks "End session?"; ending shows a summary dialog (cards reviewed, Again count, time) | |
| Timer | `Chronometer`, stops in `onPause`, resumes in `onResume`; evidence for rubric 4.4 | |
| Language / theme | currently follow the device (values-th, Material3 DayNight) | settings-feature.md adds System/Light/Dark and System/English/ไทย |
| Orientation | both; `layout-land/activity_review.xml` | |
| Cut | search, import (added back 14 Nov 2026: deck rename in the Deck screen menu; statistics screen from the deck list) | |
| Statistics | all Decks with a Deck filter; also per Deck from the Deck screen menu (same screen, filter hidden); Practice sessions logged and tagged, counted in time/streak, not in Again %; bars from plain Views (no chart library); Learning < 21 days <= Mature | student chose every recommendation |
| Kept | edit Card, end-of-session summary, "Save & add another" | |
| Project | app name Lilearn (Lily + Learn; project folder and package still Flashcards), package com.example.flashcards, Empty Views Activity, Java, minSdk 29, targetSdk 37, Kotlin DSL | |

## Worked SM-2 example (also a test case)
Card "Carefree", created 14 Nov, ease 2.5.
| Event | Grade | Ease | Gap (days) | In a row | Due |
|---|---|---|---|---|---|
| created | — | 2.5 | 0 | 0 | 14 Nov |
| 14 Nov | Good | 2.5 | 1 | 1 | 15 Nov |
| 15 Nov | Hard | 2.36 | 6 | 2 | 21 Nov |
| 21 Nov | Good | 2.36 | 15 | 3 | 6 Dec |
| 6 Dec (missed) | Again | 2.36 | 1 | 0 | 7 Dec |

## Pitfalls to remember
- `DbHelper.onUpgrade` migrates (v1->v2: `ALTER TABLE cards ADD COLUMN first_review_day`); it no longer drops tables. Any further schema change must migrate with `ALTER TABLE ... ADD COLUMN` and bump `DB_VERSION`, or data is lost.
- Deleting a deck relies on `PRAGMA foreign_keys` being on (`setForeignKeyConstraintsEnabled(true)` in `onConfigure`); do not remove it.
- `layout-land/activity_review.xml` must keep exactly the same view ids as the portrait file; the Java code binds both.
- Targeting API 37 forces edge-to-edge: every screen's root has id `main` and `Ui.applyInsets` pads it by the system bars and keyboard.
- Dialogs are dismissed in `onDestroy` to avoid window leaks; Review derives the summary dialog from saved state so it survives rotation.
