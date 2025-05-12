package org.novatech.dao;

import org.novatech.models.User;
import org.novatech.utils.DatabaseConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class UserDao {
    public User getUserByUsername(String username) throws SQLException{
        String sql = "SELECT * FROM users WHERE username = ?";
        try(Connection conn = DatabaseConnect.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()){
                if(rs.next()){
                    User user = new User();
                    user.setUser_id(rs.getInt("user_id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    return  user;
                }
            }
        }
        return  null;
    }

    public boolean checkPasswd(String password, String hash){
        return  BCrypt.checkpw(password, hash);
    }
}
