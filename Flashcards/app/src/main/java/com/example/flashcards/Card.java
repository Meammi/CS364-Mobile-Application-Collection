package com.example.flashcards;

public class Card {
    public long id;
    public long deckId;
    public String front;
    public String back;
    public double ease;
    public int intervalDays;
    public int repetitions;
    public long dueDay;

    /** Gist line: the first non-blank line of a Back, used unchanged. Never stored. */
    public static String gistOf(String back) {
        if (back == null) return "";
        for (String line : back.split("\\r?\\n")) {
            if (!line.trim().isEmpty()) return line;
        }
        return "";
    }
}
