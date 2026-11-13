package com.example.stepbystep;

public class ActivityItem {
    public final long id;
    public final long startedAt;
    public final long durationMs;
    public final int steps;
    public final int shakes;

    public ActivityItem(long id, long startedAt, long durationMs, int steps, int shakes) {
        this.id = id;
        this.startedAt = startedAt;
        this.durationMs = durationMs;
        this.steps = steps;
        this.shakes = shakes;
    }
}
