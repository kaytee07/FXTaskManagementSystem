<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novatech - ${empty task ? 'Create' : 'Edit'} Task</title>
    <style>
        :root {
            --novatech-blue: #0066cc;
            --novatech-dark: #003366;
            --novatech-light: #e6f2ff;
            --novatech-accent: #ff6600;
            --error-color: #e74c3c;
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

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .form-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            padding: 30px;
        }

        .form-header {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .form-header h2 {
            color: var(--novatech-dark);
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--novatech-dark);
            font-weight: 500;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--novatech-blue);
            box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
            outline: none;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--novatech-blue);
            color: white;
        }

        .btn-primary:hover {
            background: var(--novatech-dark);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .error-message {
            color: var(--error-color);
            font-size: 0.9rem;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                padding: 15px;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
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
            <a href="/FXTaskManagementSystem/tasks">Back to Tasks</a>
            <a href="/FXTaskManagementSystem/logout">Logout</a>
        </div>
    </header>

    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h2>${empty task ? 'Create New' : 'Edit'} Task</h2>
            </div>

            <form action="/FXTaskManagementSystem/tasks${not empty task ? '/' : ''}${not empty task ? task.task_id : ''}" method="POST">
                <div class="form-group">
                    <label for="title">Title</label>
                    <input type="text" id="title" name="title" required
                           value="${not empty task ? task.title : ''}">
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description">${not empty task ? task.description : ''}</textarea>
                </div>

                <div class="form-group">
                    <label for="due_date">Due Date</label>
                    <input type="date" id="due_date" name="due_date" required
                           value="${not empty task ? task.due_date : ''}">
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" required>
                        <option value="pending" ${not empty task && task.status == 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="completed" ${not empty task && task.status == 'completed' ? 'selected' : ''}>Completed</option>
                        <option value="overdue" ${not empty task && task.status == 'overdue' ? 'selected' : ''}>Overdue</option>
                    </select>
                </div>

                <div class="form-actions">
                    <a href="/FXTaskManagementSystem/tasks" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">${empty task ? 'Create' : 'Update'} Task</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>