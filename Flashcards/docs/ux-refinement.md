# UX/UI refinement — status

Student feedback (14 Nov 2026): the main use case works on their device; the UX/UI design still needs refinement. They have not said what feels wrong. Ask which screens and what bothers them before redesigning. Constraints: stay with Views/XML and Material3 (Java, no Compose); every rubric behaviour in rubric-and-report-plan.md must keep working; light and dark must both stay readable; every string in English and Thai.

## Rough spots Claude knows about (inference from writing the screens; none is tested on a device)
- All buttons are plain Material buttons; no colour semantics in Multiple Choice (correct/wrong feedback is text only: "Correct!" / "Wrong", then the full Back).
- Each list row has a visible Delete text button: heavy on small screens; alternatives to discuss: swipe or long-press (each delete must still confirm).
- The New deck dialog ignores an empty name silently (no error message).
- No app bar, so no natural place for Settings or overflow actions.
- The card Back is shown as plain text; line breaks are kept, but there is no emphasis on the Gist line.
- Empty states are single lines of text.
- Review progress is text only ("Card i of n"); no progress bar.
- Grade buttons all look the same; Again/Hard/Good/Easy have no visual hierarchy.
- Edge-to-edge insets are padded on the root of every screen; check with gesture navigation and 3-button navigation.

## Rules while refining
- Do not change behaviour while changing looks (schedule, grading, Option rules are in design-decisions.md).
- Test each visual change in portrait and landscape, light and dark, English and Thai (Thai strings are often longer or break differently).

## Round 1 (14 Nov 2026, Claude Code) — built, compiles, NOT yet tested on a device
Student: "almost all" rough spots above are real; timer was not noticed.
- MaterialToolbar on every screen (theme stays NoActionBar); back arrow goes through the back dispatcher, so Review still asks "End session?". Settings icon goes in the deck-list toolbar later.
- Row delete = trash icon button (still confirms). New deck dialog: empty name shows "Required" and stays open.
- Empty states: icon + larger muted text.
- Review: timer is a chip with a clock icon in the toolbar (same pause/resume); progress bar; "Card i of n" and the Mode button share one row; deck name as title.
- Grades: Again = outlined error colour, Hard/Easy = tonal, Good = filled. Gist line bold in the Back.
- Multiple Choice after answering: right Option = primary stroke + check, wrong pick = error stroke + cross, others dimmed; buttons stay enabled (clicks ignored) so colours are not greyed. Theme colours only, no green.

## Round 2 (14 Nov 2026)
- Deck-list rows: one kebab (⋮) button with a PopupMenu (Statistics, Delete; Delete still confirms). A stats icon next to the trash icon was tried and rejected as crowded. Card rows keep the trash icon.
- Deck screen: Statistics is a chart icon in the toolbar; Rename and Reset progress stay in ⋮.
