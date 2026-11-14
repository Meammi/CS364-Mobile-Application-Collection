package com.example.flashcards;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Random;

/** Builds the Options for Multiple Choice mode: the target's Gist line plus up to 3 Distractors. */
public final class McOptions {
    public static final int MAX_OPTIONS = 4;

    private McOptions() {}

    /** Returns shuffled Options. The caller treats a result with fewer than 2 entries as "not enough". */
    public static List<String> build(String targetGist, List<String> otherGists, Random rnd) {
        LinkedHashSet<String> pool = new LinkedHashSet<>();
        for (String g : otherGists) {
            if (!g.trim().isEmpty() && !g.equals(targetGist)) pool.add(g);
        }
        List<String> distractors = new ArrayList<>(pool);
        Collections.shuffle(distractors, rnd);
        List<String> options = new ArrayList<>(
                distractors.subList(0, Math.min(MAX_OPTIONS - 1, distractors.size())));
        options.add(targetGist);
        Collections.shuffle(options, rnd);
        return options;
    }
}
