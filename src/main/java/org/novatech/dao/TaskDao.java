package org.novatech.dao;

import org.novatech.models.Task;
import org.novatech.utils.DatabaseConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TaskDao {
    public List<Task> getTasksByUserId(int userId, String status, String sort) throws SQLException {
        String sql = "SELECT * FROM task WHERE user_id = ?";
        if (status != null && !status.isEmpty()) {
            sql += " AND status = ?";
        }
        if (sort != null && sort.equals("due_date")) {
            sql += " ORDER BY due_date";
        }
        try (Connection conn = DatabaseConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            if (status != null && !status.isEmpty()) {
                stmt.setString(2, status);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                List<Task> tasks = new ArrayList<>();
                while (rs.next()) {
                    Task task = new Task();
                    task.setTask_id(rs.getInt("task_id"));
                    task.setUser_id(rs.getInt("user_id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDue_date(rs.getDate("due_date"));
                    task.setStatus(rs.getString("status"));
                    tasks.add(task);
                }
                return tasks;
            }
        }
    }

    public Task getTaskById(int Id) throws SQLException {
        String sql = "SELECT * FROM task WHERE task_id = ?";
        try (Connection conn = DatabaseConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, Id);
            try(ResultSet rs = stmt.executeQuery()){
                if(rs.next()){
                    Task task = new Task();
                    task.setTask_id(rs.getInt("task_id"));
                    task.setUser_id(rs.getInt("user_id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDue_date(rs.getDate("due_date"));
                    task.setStatus(rs.getString("status"));
                    return task;
                }
            }
        }
        return null;
    }

    public void createTask(Task task) throws  SQLException {
        String sql = "INSERT INTO task (user_id, title, description, due_date, status) VALUES (?, ?, ?, ?, ?)";
        try(Connection conn = DatabaseConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, task.getUser_id());
            stmt.setString(2, task.getTitle());
            stmt.setString(3, task.getDescription());
            stmt.setDate(4, task.getDue_date());
            stmt.setString(5, task.getStatus());
            stmt.executeUpdate();
        }
    }

    public void updateTask(Task task) throws SQLException {
        String sql = "UPDATE task SET title = ?, description = ?, due_date = ?, status = ? WHERE task_id = ?";
        try(Connection conn = DatabaseConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setDate(3, task.getDue_date());
            stmt.setString(4, task.getStatus());
            stmt.setInt(5, task.getTask_id());
            stmt.executeUpdate();
        }
    }

    public void deleteTask (int Id) throws SQLException {
        String sql = "DELETE FROM task WHERE task_id = ?";
        try (Connection conn = DatabaseConnect.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, Id);
            stmt.executeUpdate();
        }
    }


}
