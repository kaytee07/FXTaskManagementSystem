<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novatech - Task Manager</title>
    <style>
        :root {
            --novatech-blue: #0066cc;
            --novatech-dark: #003366;
            --novatech-light: #e6f2ff;
            --novatech-accent: #ff6600;
            --pending-color: #f39c12;
            --completed-color: #2ecc71;
            --overdue-color: #e74c3c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            min-height: 100vh;
        }

        .header {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .novatech-logo {
            display: flex;
            align-items: center;
        }

        .novatech-logo h1 {
            color: var(--novatech-blue);
            font-size: 1.8rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .novatech-logo span {
            color: var(--novatech-accent);
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-menu a {
            color: var(--novatech-dark);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .user-menu a:hover {
            color: var(--novatech-blue);
        }

        .logout-btn {
            background: var(--novatech-light);
            padding: 8px 15px;
            border-radius: 5px;
            color: var(--novatech-blue);
        }

        .logout-btn:hover {
            background: var(--novatech-blue);
            color: white;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .page-title {
            font-size: 1.8rem;
            color: var(--novatech-dark);
        }

        .btn {
            padding: 10px 20px;
            background: var(--novatech-blue);
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            background: var(--novatech-dark);
            transform: translateY(-2px);
        }

        .btn-accent {
            background: var(--novatech-accent);
        }

        .btn-accent:hover {
            background: #e65c00;
        }

        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filter-label {
            font-weight: 500;
            color: var(--novatech-dark);
        }

        .filter-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: white;
        }

        .task-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .task-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            padding: 20px;
            transition: transform 0.3s, box-shadow 0.3s;
            border-top: 4px solid var(--novatech-blue);
            position: relative;
        }

        .task-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .task-status {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.7rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-pending {
            background-color: #fef5e7;
            color: var(--pending-color);
        }

        .status-completed {
            background-color: #e8f8f0;
            color: var(--completed-color);
        }

        .status-overdue {
            background-color: #fdedec;
            color: var(--overdue-color);
        }

        .task-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--novatech-dark);
            margin-bottom: 10px;
            padding-right: 30px;
        }

        .task-description {
            color: #666;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .task-due {
            display: flex;
            align-items: center;
            gap: 5px;
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }

        .task-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.8rem;
            text-decoration: none;
            transition: all 0.2s;
        }

        .edit-btn {
            background: var(--novatech-light);
            color: var(--novatech-blue);
        }

        .edit-btn:hover {
            background: var(--novatech-blue);
            color: white;
        }

        .delete-btn {
            background: #fdedec;
            color: var(--overdue-color);
        }

        .delete-btn:hover {
            background: var(--overdue-color);
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: #666;
        }

        .empty-state p {
            margin-top: 10px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                padding: 15px;
            }

            .filters {
                flex-direction: column;
            }

            .task-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="novatech-logo">
            <h1>Nova<span>tech</span></h1>
        </div>
        <div class="user-menu">
            <span>Welcome, ${sessionScope.username}</span>
            <a href="/FXTaskManagementSystem/tasks/new" class="btn btn-accent">+ New Task</a>
            <a href="/FXTaskManagementSystem/logout" class="logout-btn">Logout</a>
        </div>
    </header>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">My Tasks</h1>
            <div class="filters">
                <div class="filter-group">
                    <span class="filter-label">Status:</span>
                    <select class="filter-select" onchange="filterTasks()" id="statusFilter">
                        <option value="">All</option>
                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="completed" ${param.status == 'completed' ? 'selected' : ''}>Completed</option>
                        <option value="overdue" ${param.status == 'overdue' ? 'selected' : ''}>Overdue</option>
                    </select>
                </div>
                <div class="filter-group">
                    <span class="filter-label">Sort by:</span>
                    <select class="filter-select" onchange="filterTasks()" id="sortFilter">
                        <option value="">Default</option>
                        <option value="due_asc" ${param.sort == 'due_asc' ? 'selected' : ''}>Due Date (Asc)</option>
                        <option value="due_desc" ${param.sort == 'due_desc' ? 'selected' : ''}>Due Date (Desc)</option>
                        <option value="title_asc" ${param.sort == 'title_asc' ? 'selected' : ''}>Title (A-Z)</option>
                        <option value="title_desc" ${param.sort == 'title_desc' ? 'selected' : ''}>Title (Z-A)</option>
                    </select>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty tasks}">
                <div class="task-grid">
                    <c:forEach items="${tasks}" var="task">
                        <div class="task-card">
                            <span class="task-status status-${task.status}">${task.status}</span>
                            <h3 class="task-title">${task.title}</h3>
                            <p class="task-description">${task.description}</p>
                            <div class="task-due">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z"></path>
                                </svg>
                                Due: ${task.due_date}
                            </div>
                            <div class="task-actions">
                                <a href="/FXTaskManagementSystem/tasks/${task.task_id}/edit" class="action-btn edit-btn">Edit</a>
                                <a href="#" class="action-btn delete-btn"
                                   onclick="if(confirm('Are you sure you want to delete this task?')) {
                                       fetch('/FXTaskManagementSystem/tasks/${task.task_id}/delete', {
                                           method: 'POST'
                                       }).then(() => window.location.reload());
                                   }; return false;">Delete</a>

                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="1.5">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                        <polyline points="10 9 9 9 8 9"></polyline>
                    </svg>
                    <h3>No tasks found</h3>
                    <p>You don't have any tasks yet. Create your first task to get started!</p>
                    <a href="/FXTaskManagementSystem/tasks/new" class="btn">Create Task</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        function filterTasks() {
            const status = document.getElementById('statusFilter').value;
            const sort = document.getElementById('sortFilter').value;

            let url = '/FXTaskManagementSystem/tasks';
            const params = new URLSearchParams();

            if (status) params.append('status', status);
            if (sort) params.append('sort', sort);

            if (params.toString()) {
                url += '?' + params.toString();
            }

            window.location.href = url;
        }
    </script>
</body>
</html>