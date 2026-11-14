package com.example.flashcards;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import java.util.Calendar;

/** One daily study reminder (Week 11 pattern). Inexact alarm: no exact-alarm permission needed. */
final class ReminderScheduler {
    private ReminderScheduler() {}

    private static final int REQUEST_CODE = 1;

    private static PendingIntent pendingIntent(Context c) {
        Intent i = new Intent(c, ReminderReceiver.class);
        return PendingIntent.getBroadcast(c, REQUEST_CODE, i,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
    }

    /** Arms the next reminder if it is on, otherwise cancels it. */
    static void update(Context c) {
        AlarmManager am = c.getSystemService(AlarmManager.class);
        if (am == null) return;
        PendingIntent pi = pendingIntent(c);
        am.cancel(pi);
        if (Prefs.reminderOn(c)) {
            long at = nextTime(Prefs.reminderHour(c), Prefs.reminderMinute(c),
                    System.currentTimeMillis());
            am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, at, pi);
        }
    }

    /** Next occurrence of hour:minute in local time. */
    static long nextTime(int hour, int minute, long now) {
        Calendar next = Calendar.getInstance();
        next.setTimeInMillis(now);
        next.set(Calendar.HOUR_OF_DAY, hour);
        next.set(Calendar.MINUTE, minute);
        next.set(Calendar.SECOND, 0);
        next.set(Calendar.MILLISECOND, 0);
        if (next.getTimeInMillis() <= now) next.add(Calendar.DAY_OF_YEAR, 1);
        return next.getTimeInMillis();
    }
}
