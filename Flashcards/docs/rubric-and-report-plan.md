# Rubric, evidence plan and report plan

Source: `../../../Docs/Week12/CS364_TermProject_Rubric1-69.xlsx` (Thai). Scoring: 5 criteria x 4 sub-items; each sub-item is present (1) or not (0); the level of a criterion = number of sub-items present. Every claim needs a findable page or screenshot in the report. Deadline and presentation date: the student sets them (the syllabus digest lists week-15 presentations on 17 or 20 Nov). Team size 1.

## Coverage map (20 sub-items)
| Item | What satisfies it | Evidence to capture |
|---|---|---|
| 1.1 | function list F1–F12 (below) with screen + result | table + screenshots |
| 1.2 | test table (method, expected, actual) run on device/emulator | filled table |
| 1.3 | lecture topic -> where used: Activity lifecycle (timer in onPause/onResume), resources (values-th, values-night, layout-land), runtime changes (onSaveInstanceState), input controls, SQLite (DbHelper), RecyclerView, dialogs/Toast, Intents, SharedPreferences (and, when built, Scheduler for the reminder) | table with class/file names |
| 1.4 | other courses the student has actually taken: algorithms (shuffle, sampling, Set de-duplication, SM-2 as a function), databases (schema, foreign key, cascade, indexed query) | short paragraph with file/method references |
| 2.1 | the two main functions as flow diagrams + code: `Sm2.next` and `McOptions.build` | diagram + code excerpt |
| 2.2 | one real problem the student actually hit: what, which function, cause | log it when it happens; do not invent |
| 2.3 | the fix: what changed, why, where | diff / code excerpt |
| 2.4 | before/after screenshot or test | same screen before and after |
| 3.1 | 2 AVDs with different size/resolution | screenshots of Deck list and Review on both |
| 3.2 | rotate Review and Deck screens, state kept | portrait + landscape screenshots |
| 3.3 | Thai and English: buttons, dialogs, Toasts | TH and EN screenshots incl. a dialog |
| 3.4 | day/night readable | day and night screenshots |
| 4.1 | back path diagram: Main -> Deck -> (AddEdit | Review); Back goes to the parent | diagram + test notes |
| 4.2 | deck-list double-back Toast; Review "End session?" with cancel/confirm | screenshots |
| 4.3 | confirm on every delete (deck, Card); cancel keeps data | screenshots before/after |
| 4.4 | timer stops when switching apps and continues; position kept | timer value before/after |
| 5.1 | full path: open app -> add deck -> add Cards -> Study -> switch to Multiple Choice -> answer -> summary | numbered screenshots with the tap between screens |
| 5.2 | source/AI statement: `Sm2` written from Wozniak's published SM-2 description; AndroidX/Material libraries; an honest statement whether AI helped write the code (the app itself contains no AI; AI used outside the app to produce Card text is not part of the app) | one paragraph |
| 5.3 | one challenge from 2.2 as problem -> fix -> result | slide with evidence |
| 5.4 | one storyline in report and talk | outline |

Candidate challenges (use only ones really hit): rotation reshuffles Options or loses the current question (fix: order, index, chosen saved in the Bundle); deleting a deck leaves orphan Cards (fix: foreign keys on); too-small decks or duplicate Gist lines (McOptions rules); timer counting while the app is in the background (stop in onPause).

## Function list (rubric 1.1/1.2) — test each on a device
F1 create deck; F2 delete deck (confirm; cancel keeps; confirm deletes its Cards); F3 add Card (freeform, Thai text and multi-line Back kept as typed; empty Front or Back rejected); F4 edit Card; F5 delete Card (confirm); F6 Original review (Show answer, four grades, schedule changes, summary); F7 Multiple Choice review (Options, correct/wrong feedback, grading rule); F8 switch Mode mid-session; F9 data survives app restart; F10 deck with too few Cards falls back with a notice; F11 nothing Due -> Practice session leaves schedules unchanged; F12 quit mid-session, reopen: graded Cards are no longer Due. When Settings is built add: S1 theme, S2 language, S3 default Mode, S4 reminder, S5 reset progress, S6 daily new-card limit. Also: F13 rename deck; T1 statistics (numbers match sessions done; deck filter; Practice tagged; log survives restart; deleting a deck removes its log rows).

Multiple Choice test cases: 5 distinct Cards (4 Options); 2 Cards (2 Options); 1 Card (fallback + notice); two Cards with the same Gist line (no duplicate Options); Back starting with blank lines; a very long Gist line; wrong answer = Again (due tomorrow); correct = Hard.

## State on 14 Nov 2026
Verified by Claude (static): Sm2, McOptions and Card.gistOf compile with javac and pass 12 checks including the SM-2 worked example; every R.id/R.string/R.layout reference resolves; XML well-formed; portrait and landscape Review layouts share ids; EN and TH strings match key for key.
Verified by the student: the main use case runs on their device.
JUnit (`gradlew test`, 14 Nov 2026): Sm2Test (worked example, Easy, ease floor, exact ceil), McOptionsTest (4 / 2 / 1 Options, blanks + duplicates), GistAndReminderTest (Gist line, reminder next time): 12 tests pass. Not unit-tested: DbHelper queries (new-card limit, streak), they need an emulator test.
Not verified: everything else on a device (Practice session, rotation, timer pause, Thai rendering, night theme, deletes, edit Card, two AVDs). The evidence for the report must come from the student's own runs.

## Report skeleton (headings = the 5 criteria)
Cover and member; app overview with icon and home screen; function list with screens (1.1); test table (1.2); lecture-link table (1.3); other-course paragraph (1.4); main functions with diagrams and code (2.1); technical challenge, fix and after-evidence (2.2–2.4); device diversity (3.1–3.4); navigation, delete, lifecycle (4.1–4.4); main user path screenshots (5.1); sources and AI statement (5.2); bibliography. The three sample reports (`../../../Docs/Week12/CS364_Ex1–Ex3.pdf`) show this layout.
