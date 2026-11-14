package com.example.flashcards;

/** Numbers for the Statistics screen (all Decks or one Deck). */
public class Stats {
    public final int[] weekCards = new int[7];     // index 0 = six days ago, 6 = today
    public final long[] weekSeconds = new long[7];
    public int totalCards;
    public long totalSeconds;
    public int gradedCards;   // Review sessions only
    public int againCards;    // Review sessions only
    public int streak;
    public int newCount;
    public int learningCount;  // interval 1-20 days
    public int matureCount;    // interval 21+ days
}
