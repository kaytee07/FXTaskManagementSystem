package org.novatech.utils;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnect {
    private static final String URL = "jdbc:mysql://localhost:3306/taskdatabase";
    private static  final String USER = "root";
    private static  final String PASSWORD = "Hhdh573)&@/dg";

    public static Connection getConnection() throws SQLException{
        return  DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
