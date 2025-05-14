package org.novatech.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.novatech.dao.UserDao;
import org.novatech.models.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            User user = userDao.getUserByUsername(username);
            if(user != null && userDao.checkPasswd(password, user.getPasswordHash())){
                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getUser_id());
                response.sendRedirect("/FXTaskManagementSystem/tasks");
            } else {
                request.setAttribute("error", "Invalid username and password");
                request.getRequestDispatcher("/login.jsp").forward(request,response);
            }
        } catch (SQLException e){
            throw new ServletException("DB error", e);
        }
    }
}
