package com.example.flashcards;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DbHelper extends SQLiteOpenHelper {
    private static final String DB_NAME = "flashcards.db";
    private static final int DB_VERSION = 3;   // 2: cards.first_review_day, 3: sessions (study log)

    private static final String CARD_COLS =
            "_id, deck_id, front, back, ease_factor, interval_days, repetitions, due_day";

    private final Context appContext;

    public DbHelper(Context context) {
        super(context, DB_NAME, null, DB_VERSION);
        appContext = context.getApplicationContext();
    }

    /** Due is a local calendar day, stored as an epoch day. */
    public static long today() {
        return LocalDate.now().toEpochDay();
    }

    @Override
    public void onConfigure(SQLiteDatabase db) {
        super.onConfigure(db);
        db.setForeignKeyConstraintsEnabled(true);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE decks ("
                + "_id INTEGER PRIMARY KEY AUTOINCREMENT, "
                + "name TEXT NOT NULL, "
                + "created_at INTEGER NOT NULL)");
        db.execSQL("CREATE TABLE cards ("
                + "_id INTEGER PRIMARY KEY AUTOINCREMENT, "
                + "deck_id INTEGER NOT NULL REFERENCES decks(_id) ON DELETE CASCADE, "
                + "front TEXT NOT NULL, "
                + "back TEXT NOT NULL, "
                + "created_at INTEGER NOT NULL, "
                + "ease_factor REAL NOT NULL DEFAULT 2.5, "
                + "interval_days INTEGER NOT NULL DEFAULT 0, "
                + "repetitions INTEGER NOT NULL DEFAULT 0, "
                + "due_day INTEGER NOT NULL, "
                + "first_review_day INTEGER)");   // day a new Card was first graded; null = not yet
        db.execSQL("CREATE INDEX idx_cards_deck_due ON cards(deck_id, due_day)");
        createSessions(db);
    }

    /** Study log: one row per Review or Practice session. */
    private static void createSessions(SQLiteDatabase db) {
        db.execSQL("CREATE TABLE sessions ("
                + "_id INTEGER PRIMARY KEY AUTOINCREMENT, "
                + "deck_id INTEGER NOT NULL REFERENCES decks(_id) ON DELETE CASCADE, "
                + "day INTEGER NOT NULL, "            // epoch day the session started
                + "started_at INTEGER NOT NULL, "     // millis
                + "cards INTEGER NOT NULL DEFAULT 0, "
                + "again INTEGER NOT NULL DEFAULT 0, "
                + "seconds INTEGER NOT NULL DEFAULT 0, "
                + "practice INTEGER NOT NULL DEFAULT 0)");
        db.execSQL("CREATE INDEX idx_sessions_deck_day ON sessions(deck_id, day)");
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // migrate, never drop: the user's Cards must survive
        if (oldVersion < 2) {
            db.execSQL("ALTER TABLE cards ADD COLUMN first_review_day INTEGER");
        }
        if (oldVersion < 3) {
            createSessions(db);
        }
    }

    // ---- decks ----

    public long addDeck(String name) {
        ContentValues v = new ContentValues();
        v.put("name", name);
        v.put("created_at", System.currentTimeMillis());
        return getWritableDatabase().insert("decks", null, v);
    }

    /** Same name ignoring case; excludeId = the Deck being renamed (-1 when creating). */
    public boolean deckNameExists(String name, long excludeId) {
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT 1 FROM decks WHERE TRIM(name) = ? COLLATE NOCASE AND _id <> ? LIMIT 1",
                new String[]{name.trim(), String.valueOf(excludeId)})) {
            return c.moveToFirst();
        }
    }

    /** Same Front in the same Deck, ignoring case; excludeCardId = the Card being edited (-1 when adding). */
    public boolean frontExists(long deckId, String front, long excludeCardId) {
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT 1 FROM cards WHERE deck_id = ? AND TRIM(front) = ? COLLATE NOCASE"
                        + " AND _id <> ? LIMIT 1",
                new String[]{String.valueOf(deckId), front.trim(), String.valueOf(excludeCardId)})) {
            return c.moveToFirst();
        }
    }

    public void renameDeck(long id, String name) {
        ContentValues v = new ContentValues();
        v.put("name", name);
        getWritableDatabase().update("decks", v, "_id = ?", new String[]{String.valueOf(id)});
    }

    public void deleteDeck(long id) {
        getWritableDatabase().delete("decks", "_id = ?", new String[]{String.valueOf(id)});
    }

    // columns: id, name, all Cards, Due reviewed Cards, Due new Cards, new Cards started today
    private String deckQuery(String tail) {
        long t = today();
        return "SELECT d._id, d.name, "
                + "(SELECT COUNT(*) FROM cards c WHERE c.deck_id = d._id), "
                + "(SELECT COUNT(*) FROM cards c WHERE c.deck_id = d._id AND c.interval_days > 0 AND c.due_day <= " + t + "), "
                + "(SELECT COUNT(*) FROM cards c WHERE c.deck_id = d._id AND c.interval_days = 0 AND c.due_day <= " + t + "), "
                + "(SELECT COUNT(*) FROM cards c WHERE c.deck_id = d._id AND c.first_review_day = " + t + ") "
                + "FROM decks d " + tail;
    }

    /** How many more new Cards this Deck may start today; -1 = unlimited. */
    private int newLeftToday(int startedToday) {
        int limit = Prefs.newLimit(appContext);
        return limit <= 0 ? -1 : Math.max(0, limit - startedToday);
    }

    private Deck readDeck(Cursor c) {
        Deck d = new Deck();
        d.id = c.getLong(0);
        d.name = c.getString(1);
        d.cardCount = c.getInt(2);
        int newDue = c.getInt(4);
        int left = newLeftToday(c.getInt(5));
        d.dueCount = c.getInt(3) + (left < 0 ? newDue : Math.min(newDue, left));
        return d;
    }

    public List<Deck> getDecks() {
        List<Deck> list = new ArrayList<>();
        try (Cursor c = getReadableDatabase().rawQuery(
                deckQuery("ORDER BY d.name COLLATE NOCASE"), null)) {
            while (c.moveToNext()) list.add(readDeck(c));
        }
        return list;
    }

    public Deck getDeck(long id) {
        try (Cursor c = getReadableDatabase().rawQuery(
                deckQuery("WHERE d._id = ?"), new String[]{String.valueOf(id)})) {
            return c.moveToFirst() ? readDeck(c) : null;
        }
    }

    /** Due Cards over all Decks (new-card limit applied), for the reminder. */
    public int getTotalDueCount() {
        int total = 0;
        for (Deck d : getDecks()) total += d.dueCount;
        return total;
    }

    // ---- cards ----

    public long addCard(long deckId, String front, String back) {
        ContentValues v = new ContentValues();
        v.put("deck_id", deckId);
        v.put("front", front);
        v.put("back", back);
        v.put("created_at", System.currentTimeMillis());
        v.put("ease_factor", 2.5);
        v.put("interval_days", 0);
        v.put("repetitions", 0);
        v.put("due_day", today());   // a new Card is Due on the day it is created
        return getWritableDatabase().insert("cards", null, v);
    }

    public void updateCard(long id, String front, String back) {
        ContentValues v = new ContentValues();
        v.put("front", front);
        v.put("back", back);
        getWritableDatabase().update("cards", v, "_id = ?", new String[]{String.valueOf(id)});
    }

    public void deleteCard(long id) {
        getWritableDatabase().delete("cards", "_id = ?", new String[]{String.valueOf(id)});
    }

    /** wasNew = first grade of a new Card: counts toward today's new-card limit. */
    public void saveSchedule(long id, double ease, int interval, int repetitions, long dueDay,
                             boolean wasNew) {
        ContentValues v = new ContentValues();
        v.put("ease_factor", ease);
        v.put("interval_days", interval);
        v.put("repetitions", repetitions);
        v.put("due_day", dueDay);
        if (wasNew) v.put("first_review_day", today());
        getWritableDatabase().update("cards", v, "_id = ?", new String[]{String.valueOf(id)});
    }

    /** Make Cards new again (Cards are kept). deckId = -1: every Deck. */
    public void resetProgress(long deckId) {
        ContentValues v = new ContentValues();
        v.put("ease_factor", 2.5);
        v.put("interval_days", 0);
        v.put("repetitions", 0);
        v.put("due_day", today());
        v.putNull("first_review_day");
        if (deckId == -1) {
            getWritableDatabase().update("cards", v, null, null);
        } else {
            getWritableDatabase().update("cards", v, "deck_id = ?",
                    new String[]{String.valueOf(deckId)});
        }
    }

    private static Card readCard(Cursor c) {
        Card card = new Card();
        card.id = c.getLong(0);
        card.deckId = c.getLong(1);
        card.front = c.getString(2);
        card.back = c.getString(3);
        card.ease = c.getDouble(4);
        card.intervalDays = c.getInt(5);
        card.repetitions = c.getInt(6);
        card.dueDay = c.getLong(7);
        return card;
    }

    public Card getCard(long id) {
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT " + CARD_COLS + " FROM cards WHERE _id = ?",
                new String[]{String.valueOf(id)})) {
            return c.moveToFirst() ? readCard(c) : null;
        }
    }

    public List<Card> getCards(long deckId) {
        List<Card> list = new ArrayList<>();
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT " + CARD_COLS + " FROM cards WHERE deck_id = ? ORDER BY _id DESC",
                new String[]{String.valueOf(deckId)})) {
            while (c.moveToNext()) list.add(readCard(c));
        }
        return list;
    }

    private static long[] readIds(Cursor c) {
        long[] ids = new long[c.getCount()];
        int i = 0;
        while (c.moveToNext()) ids[i++] = c.getLong(0);
        return ids;
    }

    /**
     * Due Cards: reviewed (overdue) Cards first by due day, then new Cards (never graded),
     * new Cards capped by the daily new-card limit.
     */
    public long[] getDueCardIds(long deckId) {
        String deck = String.valueOf(deckId);
        long t = today();
        long[] reviewed;
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT _id FROM cards WHERE deck_id = ? AND interval_days > 0 AND due_day <= " + t
                        + " ORDER BY due_day, _id", new String[]{deck})) {
            reviewed = readIds(c);
        }
        int startedToday;
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT COUNT(*) FROM cards WHERE deck_id = ? AND first_review_day = " + t,
                new String[]{deck})) {
            startedToday = c.moveToFirst() ? c.getInt(0) : 0;
        }
        int left = newLeftToday(startedToday);
        long[] fresh;
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT _id FROM cards WHERE deck_id = ? AND interval_days = 0 AND due_day <= " + t
                        + " ORDER BY due_day, _id" + (left < 0 ? "" : " LIMIT " + left),
                new String[]{deck})) {
            fresh = readIds(c);
        }
        long[] all = new long[reviewed.length + fresh.length];
        System.arraycopy(reviewed, 0, all, 0, reviewed.length);
        System.arraycopy(fresh, 0, all, reviewed.length, fresh.length);
        return all;
    }

    // ---- study log and statistics ----

    public long startSession(long deckId, boolean practice) {
        ContentValues v = new ContentValues();
        v.put("deck_id", deckId);
        v.put("day", today());
        v.put("started_at", System.currentTimeMillis());
        v.put("practice", practice ? 1 : 0);
        return getWritableDatabase().insert("sessions", null, v);
    }

    public void updateSession(long id, int cards, int again, long seconds) {
        ContentValues v = new ContentValues();
        v.put("cards", cards);
        v.put("again", again);
        v.put("seconds", seconds);
        getWritableDatabase().update("sessions", v, "_id = ?", new String[]{String.valueOf(id)});
    }

    // deckId = -1: all Decks (ids are longs, safe to put in the SQL)
    private static String deckFilter(String word, long deckId) {
        return deckId == -1 ? "" : " " + word + " deck_id = " + deckId;
    }

    public Stats getStats(long deckId) {
        Stats s = new Stats();
        SQLiteDatabase db = getReadableDatabase();
        long t = today();

        try (Cursor c = db.rawQuery("SELECT day, SUM(cards), SUM(seconds) FROM sessions"
                + " WHERE day >= " + (t - 6) + deckFilter("AND", deckId) + " GROUP BY day", null)) {
            while (c.moveToNext()) {
                int i = (int) (c.getLong(0) - (t - 6));   // 0 = six days ago, 6 = today
                if (i >= 0 && i < 7) {
                    s.weekCards[i] = c.getInt(1);
                    s.weekSeconds[i] = c.getLong(2);
                }
            }
        }

        try (Cursor c = db.rawQuery("SELECT COALESCE(SUM(cards), 0), COALESCE(SUM(seconds), 0), "
                + "COALESCE(SUM(CASE WHEN practice = 0 THEN cards ELSE 0 END), 0), "
                + "COALESCE(SUM(CASE WHEN practice = 0 THEN again ELSE 0 END), 0) "
                + "FROM sessions" + deckFilter("WHERE", deckId), null)) {
            if (c.moveToFirst()) {
                s.totalCards = c.getInt(0);
                s.totalSeconds = c.getLong(1);
                s.gradedCards = c.getInt(2);   // Practice sessions not counted in Again %
                s.againCards = c.getInt(3);
            }
        }

        // streak: days in a row with a session, ending today (or yesterday if not studied yet today)
        try (Cursor c = db.rawQuery("SELECT DISTINCT day FROM sessions WHERE cards > 0"
                + deckFilter("AND", deckId) + " ORDER BY day DESC", null)) {
            long expect = t;
            while (c.moveToNext()) {
                long day = c.getLong(0);
                if (s.streak == 0 && day == t - 1) expect = t - 1;
                if (day != expect) break;
                s.streak++;
                expect--;
            }
        }

        try (Cursor c = db.rawQuery("SELECT COALESCE(SUM(interval_days = 0), 0), "
                + "COALESCE(SUM(interval_days BETWEEN 1 AND 20), 0), "
                + "COALESCE(SUM(interval_days >= 21), 0) FROM cards"
                + deckFilter("WHERE", deckId), null)) {
            if (c.moveToFirst()) {
                s.newCount = c.getInt(0);
                s.learningCount = c.getInt(1);
                s.matureCount = c.getInt(2);
            }
        }
        return s;
    }

    /** Latest sessions first, for the study log list. */
    public List<Session> getSessions(long deckId, int limit) {
        List<Session> list = new ArrayList<>();
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT s._id, d.name, s.started_at, s.cards, s.again, s.seconds, s.practice "
                        + "FROM sessions s JOIN decks d ON d._id = s.deck_id WHERE s.cards > 0"
                        + (deckId == -1 ? "" : " AND s.deck_id = " + deckId)
                        + " ORDER BY s.started_at DESC LIMIT " + limit, null)) {
            while (c.moveToNext()) {
                Session s = new Session();
                s.id = c.getLong(0);
                s.deckName = c.getString(1);
                s.startedAt = c.getLong(2);
                s.cards = c.getInt(3);
                s.again = c.getInt(4);
                s.seconds = c.getLong(5);
                s.practice = c.getInt(6) == 1;
                list.add(s);
            }
        }
        return list;
    }

    /** Every Card of the Deck, for a Practice session. */
    public long[] getAllCardIds(long deckId) {
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT _id FROM cards WHERE deck_id = ? ORDER BY _id",
                new String[]{String.valueOf(deckId)})) {
            return readIds(c);
        }
    }

    /** Gist lines of the other Cards in the Deck (candidate Distractors). */
    public List<String> getOtherGists(long deckId, long excludeCardId) {
        List<String> list = new ArrayList<>();
        try (Cursor c = getReadableDatabase().rawQuery(
                "SELECT back FROM cards WHERE deck_id = ? AND _id <> ?",
                new String[]{String.valueOf(deckId), String.valueOf(excludeCardId)})) {
            while (c.moveToNext()) list.add(Card.gistOf(c.getString(0)));
        }
        return list;
    }
}
