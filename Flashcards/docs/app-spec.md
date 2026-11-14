# App spec — the student's original description (14 Nov 2026, verbatim in substance)

**Anki-style flashcards with a Multiple Choice mode.**

- **Core concept:** a flashcard app similar to Anki, to learn and retain vocabulary, especially English words met while gaming or consuming media.
- **Persona:** a Thai user who plays video games in English to practise. When they meet a hard word they translate it (with AI, outside the app) and format it into a rich, structured card.
- **Preferred card layout (the user's own text, not enforced by the app):**
  - Word (POS): `[Word + part of speech]`
  - Frequency: `[Commonness] — [Typical context]`
  - Meaning: `[Simple English definition] | [Thai translation]`
  - Feeling: `[Emotional tone or impression] — [Thai explanation]`
  - Example: `[One natural English sentence]`
- **Problem:** plain Anki can make users "draw a blank".
- **Solution:** a Multiple Choice mode next to the Original flashcard mode; the user can toggle between them while reviewing a deck.
- **Choices:** the first line of the Back (for example the Frequency/context line) of the target card, plus the first lines of the Backs of other cards in the deck as distractors.
- **Example cards (Front -> first Back line):**
  - `(Adj): Carefree` -> `Frequency: Common — Describing someone without worries or stress.`
  - `(Adj): Desperate` -> `Frequency: Common — When someone urgently needs something or feels they have no other choice.`
  - `(Adj): Intrigued` -> `Frequency: Common — Used when something makes you curious or interested.`
  - `(Adj): Lush` -> `Frequency: Common — Describing rich green nature, luxurious places, or rich flavors.`
  - Quiz for "Carefree": prompt `(Adj): Carefree`; four choices a–d, where a (its own first line) is correct and b–d are the other cards' first lines.
- **Philosophy:** frictionless, completely freeform card creation. The user types Front and Back however they like; no rigid fields.
- **Original timeline:** about 4 days (the student later said they would finish the project the same day, 14 Nov, and set the real deadline themselves).

## What the session decided about the spec
- "AI-Powered" in the original title means the user uses AI outside the app to write card text. The app itself contains no AI and no network access; the student wants it minimal.
- "First line" became the **Gist line** (first non-blank line of the Back, used unchanged, not required to follow any format).
- Spaced repetition (SM-2, as in Anki) was added to scope by the student's choice.
