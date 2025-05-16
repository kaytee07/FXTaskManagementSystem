package org.novatech.utils;


import org.novatech.models.Task;

import java.util.Comparator;

public class TaskComparator {
    /**
     * Returns a Comparator for sorting Tasks by due_date in ascending order (earliest first).
     * Null dates are considered later than non-null dates.
     */
    public static Comparator<Task> dueDateAscending() {
        return Comparator.comparing(Task::getDue_date, Comparator.nullsLast(Comparator.naturalOrder()));
    }

    /**
     * Returns a Comparator for sorting Tasks by due_date in descending order (latest first).
     * Null dates are considered earlier than non-null dates.
     */
    public static Comparator<Task> dueDateDescending() {
        return Comparator.comparing(Task::getDue_date, Comparator.nullsFirst(Comparator.reverseOrder()));
    }

    /**
     * Returns a Comparator for sorting Tasks by title in ascending order (A-Z).
     * Null titles are considered later than non-null titles.
     */
    public static Comparator<Task> titleAscending() {
        return Comparator.comparing(Task::getTitle, Comparator.nullsLast(Comparator.naturalOrder()));
    }

    /**
     * Returns a Comparator for sorting Tasks by title in descending order (Z-A).
     * Null titles are considered earlier than non-null titles.
     */
    public static Comparator<Task> titleDescending() {
        return Comparator.comparing(Task::getTitle, Comparator.nullsFirst(Comparator.reverseOrder()));
    }

    /**
     * Returns a Comparator based on the sort parameter.
     * @param sort The sort order: due_asc, due_desc, title_asc, title_desc.
     * @return A Comparator for the specified sort order, or null if sort is invalid.
     */
    public static Comparator<Task> getComparator(String sort) {
        if (sort == null) return null;
        switch (sort.toLowerCase()) {
            case "due_asc":
                return dueDateAscending();
            case "due_desc":
                return dueDateDescending();
            case "title_asc":
                return titleAscending();
            case "title_desc":
                return titleDescending();
            default:
                return null;
        }
    }
}
