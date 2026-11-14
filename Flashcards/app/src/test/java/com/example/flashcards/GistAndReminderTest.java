package com.example.flashcards;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import java.util.Calendar;

public class GistAndReminderTest {
    @Test
    public void gistIsFirstNonBlankLineUnchanged() {
        assertEquals("Frequency: Common", Card.gistOf("\n  \r\nFrequency: Common\r\nMeaning: x"));
        assertEquals("  indented ", Card.gistOf("  indented \nsecond"));
        assertEquals("", Card.gistOf(" \n\n "));
        assertEquals("", Card.gistOf(null));
    }

    private static long at(int dayOffset, int hour, int minute) {
        Calendar c = Calendar.getInstance();
        c.set(2026, Calendar.NOVEMBER, 14, hour, minute, 0);
        c.set(Calendar.MILLISECOND, 0);
        c.add(Calendar.DAY_OF_YEAR, dayOffset);
        return c.getTimeInMillis();
    }

    @Test
    public void reminderLaterTodayStaysToday() {
        assertEquals(at(0, 20, 0), ReminderScheduler.nextTime(20, 0, at(0, 10, 0)));
    }

    @Test
    public void reminderAlreadyPassedMovesToTomorrow() {
        assertEquals(at(1, 8, 30), ReminderScheduler.nextTime(8, 30, at(0, 10, 0)));
    }

    @Test
    public void reminderExactlyNowMovesToTomorrow() {   // the receiver re-arms at fire time
        assertEquals(at(1, 20, 0), ReminderScheduler.nextTime(20, 0, at(0, 20, 0)));
    }
}
