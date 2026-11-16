# Lilearn docs — index

Written 14 Nov 2026 from the design session between the student and Claude (claude.ai Project "CS364 Mobile"). Read this file first, then only what the task needs.

| File | Read it when |
|---|---|
| [app-spec.md](app-spec.md) | You need the student's original intent: card layout, Multiple Choice idea, example cards |
| [design-decisions.md](design-decisions.md) | You are about to change behaviour: every settled decision, why, and what was rejected |
| [settings-feature.md](settings-feature.md) | Building the Settings feature (scope is set; some details are open) |
| [ux-refinement.md](ux-refinement.md) | Working on UX/UI |
| [rubric-and-report-plan.md](rubric-and-report-plan.md) | Touching anything the grade depends on; writing the report |
| `../CONTEXT.md` | Vocabulary (use these terms exactly) |

## Course-level material (outside this project) — explore it when needed
Relative to this `docs/` folder, the course folder `CS364 Mobile` is `../../../` (absolute on the student's PC: `D:\Document\University\Year3-S1\CS364 Mobile`). Claude Code only sees it if you start with `claude --add-dir ../..` from the `Flashcards` folder (or run `/add-dir ../..` in a session). `--add-dir` gives file access only; it does not load that folder's CLAUDE.md files. Spending tokens there is allowed when it helps.

Read in this order:
1. `../../../INDEX.md` — map of the whole course folder. Read first. Never read `build/`, `.gradle/`, `.idea/`, generated files.
2. `../../../CLAUDE_INSTRUCTIONS.md` — the student's working rules for the course (written for claude.ai: its line "I cannot build or run Android here" does NOT apply in Claude Code; the rest does).
3. `../../../Docs/_digest/CS364_digest_Weeks3-10.md` — per-week concepts and code patterns, Weeks 3–12 (includes Week 11 Scheduler = the reminder pattern, and the rubric). Cheaper than the lecture PDFs.
4. `../../../Docs/_extracted/*.txt` — plain text of every lecture PDF (MA01–MA13), syllabus, TQF3, the sample reports. Slides are in Thai.
5. `../../../Docs/Week12/CS364_TermProject_Rubric1-69.xlsx` — the grading rubric (Thai); `CS364_Ex1–Ex3.pdf` — past reports (structure only, not code to copy).
6. Reference apps = the style the course expects: `../../StepByStep`, `../../BMI`, `../../WeekendPlaner` (the student's repo) and the per-week apps under `../../../Docs/Week*/`. For reminders: `../../../Docs/Week11/TaskReminderSQLite/app/src/main/java/` (ReminderScheduler, ReminderReceiver, NotificationHelper, BootReceiver).

The same session also produced a Project doc in claude.ai (`claude/cs364-final-project-plan.md`); its content is mirrored in these files, so Claude Code does not need it.
