package org.novatech.servlets;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.novatech.dao.TaskDao;
import org.novatech.models.Task;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/tasks/*")
public class TaskServlet extends HttpServlet {
    private TaskDao taskDAO = new TaskDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/FXTaskManagementSystem/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            String status = request.getParameter("status");
            String sort = request.getParameter("sort");
            try {
                List<Task> tasks = taskDAO.getTasksByUserId(userId, status, sort);
                for(Task task: tasks){
                    System.out.println(task.getTitle());
                }
                request.setAttribute("tasks", tasks);
                request.getRequestDispatcher("/tasks.jsp").forward(request, response);
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else if (path.equals("/new")) {
            request.setAttribute("action", "create");
            request.getRequestDispatcher("/task_form.jsp").forward(request, response);
        } else if (path.endsWith("/edit")) {
            int id = Integer.parseInt(path.substring(1, path.length() - 5));
            try {
                Task task = taskDAO.getTaskById(id);
                System.out.println(task);
                if (task.getUser_id() != userId) {
                    response.sendError(403);
                    return;
                }
                request.setAttribute("task", task);
                request.setAttribute("action", "update");
                request.getRequestDispatcher("/task_form.jsp").forward(request, response);
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else {
            response.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("/FXTaskManagementSystem/login");
            return;
        }
        int userId = (int) session.getAttribute("userId");
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            Task task = new Task();
            task.setUser_id(userId);
            task.setTitle(request.getParameter("title"));
            task.setDescription(request.getParameter("description"));
            task.setDue_date(Date.valueOf(request.getParameter("due_date")));
            task.setStatus(request.getParameter("status"));
            try {
                taskDAO.createTask(task);
                response.sendRedirect("/FXTaskManagementSystem/tasks");
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else if (path.startsWith("/") && !path.endsWith("/delete")) {
            String idStr = path.substring(1);
            if (!idStr.matches("\\d+")) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid task ID in path.");
                return;
            }

            int id = Integer.parseInt(idStr);

            try {
                Task task = taskDAO.getTaskById(id);
                if (task.getUser_id() != userId) {
                    response.sendError(403);
                    return;
                }
                task.setTitle(request.getParameter("title"));
                task.setDescription(request.getParameter("description"));
                task.setDue_date(Date.valueOf(request.getParameter("due_date")));
                task.setStatus(request.getParameter("status"));
                taskDAO.updateTask(task);

                response.sendRedirect("/FXTaskManagementSystem/tasks");
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else if (path.endsWith("/delete")) {
            int id = Integer.parseInt(path.substring(1, path.length() - 7));
            try {
                Task task = taskDAO.getTaskById(id);
                if (task.getUser_id() != userId) {
                    response.sendError(403);
                    return;
                }
                taskDAO.deleteTask(id);
                response.sendRedirect("/FXTaskManagementSystem/tasks");
            } catch (SQLException e) {
                throw new ServletException("Database error", e);
            }
        } else {
            response.sendError(404);
        }
    }
}
