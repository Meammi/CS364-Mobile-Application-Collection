package com.example.flashcards;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Random;

public class McOptionsTest {
    private static List<String> build(String target, String... others) {
        return McOptions.build(target, Arrays.asList(others), new Random(42));
    }

    @Test
    public void fiveCardsGiveFourDistinctOptionsWithTarget() {
        List<String> o = build("T", "a", "b", "c", "d");
        assertEquals(4, o.size());
        assertTrue(o.contains("T"));
        assertEquals(4, new HashSet<>(o).size());
    }

    @Test
    public void twoCardsGiveTwoOptions() {
        List<String> o = build("T", "a");
        assertEquals(2, o.size());
        assertTrue(o.contains("T"));
    }

    @Test
    public void oneCardGivesOnlyTarget() {   // caller falls back to Original mode
        assertEquals(Collections.singletonList("T"), build("T"));
    }

    @Test
    public void blanksDuplicatesAndTargetCopiesSkipped() {
        List<String> o = build("T", "", "   ", "a", "a", "T");
        assertEquals(2, o.size());
        assertTrue(o.contains("T"));
        assertTrue(o.contains("a"));
    }
}
