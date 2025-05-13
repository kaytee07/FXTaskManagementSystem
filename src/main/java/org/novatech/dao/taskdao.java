package org.novatech.dao;

import org.novatech.models.Task;
import org.novatech.utils.DatabaseConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class taskdao {


    public Task getTaskById(int Id) throws SQLException {
        String sql = "SELECT * FROM task WHERE title = ?";

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


}
