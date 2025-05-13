<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Novatech - Create Account</title>
    <style>
        :root {
            --novatech-blue: #0066cc;
            --novatech-dark: #003366;
            --novatech-light: #e6f2ff;
            --novatech-accent: #ff6600;
            --error-color: #e74c3c;
            --success-color: #2ecc71;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, var(--novatech-light) 0%, #ffffff 100%);
        }

        .novatech-logo {
            text-align: center;
            margin-bottom: 20px;
        }

        .novatech-logo h1 {
            color: var(--novatech-blue);
            font-size: 2.5rem;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .novatech-logo span {
            color: var(--novatech-accent);
        }

        .container {
            width: 100%;
            max-width: 450px;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--novatech-blue) 0%, var(--novatech-accent) 100%);
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            color: var(--novatech-dark);
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .form-header p {
            color: #666;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--novatech-dark);
            font-weight: 500;
            font-size: 0.9rem;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: var(--novatech-blue);
            box-shadow: 0 0 0 3px rgba(0, 102, 204, 0.1);
            outline: none;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: var(--novatech-blue);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }

        .btn:hover {
            background: var(--novatech-dark);
            transform: translateY(-2px);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 0.9rem;
            color: #666;
        }

        .login-link a {
            color: var(--novatech-blue);
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .alert-error {
            background-color: #fde8e8;
            color: var(--error-color);
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background-color: #e8fdf1;
            color: var(--success-color);
            border: 1px solid #c3e6cb;
        }

        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
                margin: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="novatech-logo">
            <h1>Nova<span>tech</span></h1>
        </div>

        <div class="form-header">
            <h2>Create Your Account</h2>
            <p>Join Novatech's growing community of technology enthusiasts</p>
        </div>

        <%-- Display error message if present --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <%-- Display success message if present --%>
        <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
        <% } %>

        <form id="registrationForm" action="signup" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required
                       placeholder="Enter your username"
                       value="<%= request.getParameter("username") != null ?
                              request.getParameter("username") : "" %>">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required
                       placeholder="Create a password (min 8 characters)">
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required
                       placeholder="Confirm your password">
            </div>

            <button type="submit" class="btn">Create Account</button>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Sign in</a>
            </div>
        </form>
    </div>

    <script>
        document.getElementById('registrationForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            // Client-side validation
            if (password.length < 8) {
                alert('Password must be at least 8 characters long');
                e.preventDefault();
                return;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>