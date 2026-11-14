package com.example.flashcards;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class Sm2Test {
    private static final double EPS = 1e-9;

    /** The worked example in docs/design-decisions.md ("Carefree"). */
    @Test
    public void workedExample() {
        Sm2.Result r = Sm2.next(2.5, 0, 0, Sm2.GOOD);   // 14 Nov
        assertEquals(2.5, r.ease, EPS);
        assertEquals(1, r.interval);
        assertEquals(1, r.repetitions);

        r = Sm2.next(r.ease, r.interval, r.repetitions, Sm2.HARD);   // 15 Nov
        assertEquals(2.36, r.ease, EPS);
        assertEquals(6, r.interval);
        assertEquals(2, r.repetitions);

        r = Sm2.next(r.ease, r.interval, r.repetitions, Sm2.GOOD);   // 21 Nov: ceil(6 x 2.36)
        assertEquals(2.36, r.ease, EPS);
        assertEquals(15, r.interval);
        assertEquals(3, r.repetitions);

        r = Sm2.next(r.ease, r.interval, r.repetitions, Sm2.AGAIN);   // 6 Dec, missed
        assertEquals(2.36, r.ease, EPS);   // failure keeps the ease
        assertEquals(1, r.interval);
        assertEquals(0, r.repetitions);
    }

    @Test
    public void easyRaisesEase() {
        assertEquals(2.6, Sm2.next(2.5, 0, 0, Sm2.EASY).ease, EPS);
    }

    @Test
    public void easeNeverBelowFloor() {
        assertEquals(1.3, Sm2.next(1.3, 6, 2, Sm2.HARD).ease, EPS);
    }

    @Test
    public void exactProductIsNotRoundedUp() {
        // 10 x 2.5 = 25 exactly; floating-point noise must not make it 26
        assertEquals(25, Sm2.next(2.5, 10, 3, Sm2.GOOD).interval);
    }
}
