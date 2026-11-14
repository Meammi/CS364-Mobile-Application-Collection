package com.example.flashcards;

/**
 * SM-2 scheduling (P. A. Wozniak, SuperMemo 2). Written for this project from the
 * published description; see the report (criterion 5.2) for the credit.
 *
 * Grades map to SM-2 quality q: Again = 1, Hard = 3, Good = 4, Easy = 5.
 * q < 3 restarts the repetitions and leaves the ease factor unchanged.
 */
public final class Sm2 {
    public static final int AGAIN = 1;
    public static final int HARD = 3;
    public static final int GOOD = 4;
    public static final int EASY = 5;

    private static final double MIN_EASE = 1.3;

    public static final class Result {
        public double ease;
        public int interval;     // days until the next review
        public int repetitions;  // successful reviews in a row
    }

    private Sm2() {}

    public static Result next(double ease, int interval, int repetitions, int q) {
        Result r = new Result();
        if (q < 3) {
            r.ease = ease;
            r.interval = 1;
            r.repetitions = 0;
            return r;
        }
        r.repetitions = repetitions + 1;
        if (r.repetitions == 1) {
            r.interval = 1;
        } else if (r.repetitions == 2) {
            r.interval = 6;
        } else {
            r.interval = (int) Math.ceil(interval * ease - 1e-9);
        }
        double e = ease + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02));
        r.ease = Math.max(MIN_EASE, e);
        return r;
    }
}
