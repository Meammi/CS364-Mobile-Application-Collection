package com.example.stepbystep;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ActivityAdapter extends RecyclerView.Adapter<ActivityAdapter.Holder> {

    public interface Listener {
        void onItemClick(ActivityItem item);
        void onItemLongClick(ActivityItem item);
    }

    private final List<ActivityItem> items = new ArrayList<>();
    private final Listener listener;

    public ActivityAdapter(Listener listener) {
        this.listener = listener;
    }

    public void setItems(List<ActivityItem> newItems) {
        items.clear();
        items.addAll(newItems);
        notifyDataSetChanged();
    }

    @NonNull
    @Override
    public Holder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_activity, parent, false);
        return new Holder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull Holder h, int position) {
        ActivityItem item = items.get(position);
        Context c = h.itemView.getContext();

        h.tvDate.setText(formatStart(item.startedAt));
        h.tvSteps.setText(c.getResources().getQuantityString(R.plurals.item_steps, item.steps, item.steps));
        h.tvShakes.setText(c.getResources().getQuantityString(R.plurals.item_shakes, item.shakes, item.shakes));
        h.tvDuration.setText(formatDuration(c, item.durationMs));

        h.itemView.setOnClickListener(v -> listener.onItemClick(item));
        h.itemView.setOnLongClickListener(v -> {
            listener.onItemLongClick(item);
            return true;
        });
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    static String formatDuration(Context c, long ms) {
        long sec = ms / 1000;
        return c.getString(R.string.duration_m_s, sec / 60, sec % 60);
    }

    static String formatStart(long wallMs) {
        return DateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.SHORT).format(new Date(wallMs));
    }

    static class Holder extends RecyclerView.ViewHolder {
        final TextView tvDate;
        final TextView tvSteps;
        final TextView tvShakes;
        final TextView tvDuration;

        Holder(@NonNull View v) {
            super(v);
            tvDate = v.findViewById(R.id.tvItemDate);
            tvSteps = v.findViewById(R.id.tvItemSteps);
            tvShakes = v.findViewById(R.id.tvItemShakes);
            tvDuration = v.findViewById(R.id.tvItemDuration);
        }
    }
}
