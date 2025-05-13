package org.novatech.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.novatech.dao.UserDao;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/signup")
public class  SignupServlet extends HttpServlet {
    UserDao userDao = new UserDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    protected  void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        if(!password.equals(confirmPassword)){
            System.out.println(password + " " + confirmPassword);
            request.setAttribute("error", "Passwords do not much");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }

        try{
            userDao.createUser(username, password);
            request.setAttribute("Success", "registration successful!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("DB error", e);
        }

    }
}
