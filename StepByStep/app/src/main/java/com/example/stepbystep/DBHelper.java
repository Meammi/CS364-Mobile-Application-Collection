package com.example.stepbystep;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.List;

public class DBHelper extends SQLiteOpenHelper {

    private static final String DB_NAME = "stepbystep.db";
    private static final int DB_VERSION = 1;

    private static final String TABLE = "sessions";
    private static final String COL_ID = "_id";
    private static final String COL_STARTED_AT = "started_at";
    private static final String COL_DURATION = "duration_ms";
    private static final String COL_STEPS = "steps";
    private static final String COL_SHAKES = "shakes";

    public DBHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE " + TABLE + " ("
                + COL_ID + " INTEGER PRIMARY KEY AUTOINCREMENT, "
                + COL_STARTED_AT + " INTEGER NOT NULL, "
                + COL_DURATION + " INTEGER NOT NULL, "
                + COL_STEPS + " INTEGER NOT NULL, "
                + COL_SHAKES + " INTEGER NOT NULL)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE);
        onCreate(db);
    }

    public long insert(ActivityItem item) {
        ContentValues cv = new ContentValues();
        cv.put(COL_STARTED_AT, item.startedAt);
        cv.put(COL_DURATION, item.durationMs);
        cv.put(COL_STEPS, item.steps);
        cv.put(COL_SHAKES, item.shakes);
        return getWritableDatabase().insert(TABLE, null, cv);
    }

    public List<ActivityItem> getAll() {
        List<ActivityItem> list = new ArrayList<>();
        try (Cursor c = getReadableDatabase().query(TABLE, null, null, null, null, null,
                COL_STARTED_AT + " DESC")) {
            int iId = c.getColumnIndexOrThrow(COL_ID);
            int iStarted = c.getColumnIndexOrThrow(COL_STARTED_AT);
            int iDuration = c.getColumnIndexOrThrow(COL_DURATION);
            int iSteps = c.getColumnIndexOrThrow(COL_STEPS);
            int iShakes = c.getColumnIndexOrThrow(COL_SHAKES);
            while (c.moveToNext()) {
                list.add(new ActivityItem(c.getLong(iId), c.getLong(iStarted), c.getLong(iDuration),
                        c.getInt(iSteps), c.getInt(iShakes)));
            }
        }
        return list;
    }

    public int delete(long id) {
        return getWritableDatabase().delete(TABLE, COL_ID + "=?", new String[]{String.valueOf(id)});
    }

    // [0] = steps, [1] = shakes
    public long[] totals() {
        return stepsAndShakes("SUM");
    }

    public long[] best() {
        return stepsAndShakes("MAX");
    }

    private long[] stepsAndShakes(String fn) {
        String sql = "SELECT IFNULL(" + fn + "(" + COL_STEPS + "), 0), IFNULL(" + fn + "(" + COL_SHAKES + "), 0) FROM " + TABLE;
        try (Cursor c = getReadableDatabase().rawQuery(sql, null)) {
            if (c.moveToFirst()) return new long[]{c.getLong(0), c.getLong(1)};
            return new long[]{0, 0};
        }
    }
}
