package com.example.flashcards;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import androidx.core.app.NotificationCompat;

/** Fires at the reminder time: re-arms for tomorrow, notifies only if Cards are Due. */
public class ReminderReceiver extends BroadcastReceiver {
    private static final String CHANNEL = "study_reminder";
    private static final int NOTIFICATION_ID = 1;

    @Override
    public void onReceive(Context context, Intent intent) {
        if (!Prefs.reminderOn(context)) return;
        ReminderScheduler.update(context);   // daily: arm the next one

        int due;
        DbHelper db = new DbHelper(context);
        try {
            due = db.getTotalDueCount();   // read now, not stored
        } finally {
            db.close();
        }
        if (due > 0) show(context, due);
    }

    private static void show(Context c, int due) {
        NotificationManager nm = c.getSystemService(NotificationManager.class);
        if (nm == null || !nm.areNotificationsEnabled()) return;
        nm.createNotificationChannel(new NotificationChannel(CHANNEL,
                c.getString(R.string.reminder_channel), NotificationManager.IMPORTANCE_DEFAULT));

        Intent open = new Intent(c, MainActivity.class);
        PendingIntent pi = PendingIntent.getActivity(c, 0, open,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        nm.notify(NOTIFICATION_ID, new NotificationCompat.Builder(c, CHANNEL)
                .setSmallIcon(R.drawable.ic_notification)
                .setContentTitle(c.getString(R.string.app_name))
                .setContentText(c.getString(R.string.reminder_text, due))
                .setContentIntent(pi)
                .setAutoCancel(true)
                .build());
    }
}
