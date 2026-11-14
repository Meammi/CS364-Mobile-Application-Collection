package com.example.flashcards;

/** One row of the study log. */
public class Session {
    public long id;
    public String deckName;
    public long startedAt;
    public int cards;
    public int again;
    public long seconds;
    public boolean practice;
}
