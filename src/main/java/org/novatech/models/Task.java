package org.novatech.models;

import java.sql.Date;

public class Task {
    private int task_id;
    private int user_id;
    private String title;
    private String description;
    private Date due_date;
    private String status;

    private void validateTitle(String title){
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be null or empty");
        }
    }

    private void validateDescription(String description){
        if (description == null || description.trim().isEmpty()) {
            throw new IllegalArgumentException("Description cannot be null or empty");
        }
    }

    private void validateDate(Date due_date){
        if (due_date == null) {
            throw new IllegalArgumentException("Due date cannot be null or empty");
        }
    }

    private void validateStatus(String status){
        if (status == null || status.trim().isEmpty()) {
            throw new IllegalArgumentException("Status cannot be null or empty");
        }
        if (!status.matches("(?i)pending|completed")) {
            throw new IllegalArgumentException("Status must be 'pending', 'in progress', or 'completed'");
        }
    }


    public void setTask_id(int task_id) {
        this.task_id = task_id;
    }

    public int getTask_id() {
        return task_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setTitle(String title){
        validateTitle(title);
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setDescription(String description) {
        validateDescription(description);
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDue_date(Date due_date) {
        validateDate(due_date);
        this.due_date = due_date;
    }

    public Date getDue_date() {
        return due_date;
    }

    public void setStatus(String status) {
        validateStatus(status);
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
