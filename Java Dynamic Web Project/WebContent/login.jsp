<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        /* Base Styles */
        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #166088;
            --accent-color: #4fc3f7;
            --success-color: #4caf50;
            --danger-color: #f44336;
            --text-light: #f8f9fa;
            --text-dark: #212529;
            --bg-dark: #121212;
            --bg-darker: #0a0a0a;
            --input-bg-dark: #1e1e1e;
            --input-border-dark: #333;
            --toggle-bg: #333;
            --toggle-fg: #f8f9fa;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            background: var(--bg-dark);
            color: var(--text-light);
            overflow: hidden;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Background Animation */
        .bg-animation {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            overflow: hidden;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(74, 111, 165, 0.2) 0%, rgba(74, 111, 165, 0) 70%);
            animation: float 15s infinite linear;
        }

        @keyframes float {
            0% {
                transform: translateY(0) translateX(0) rotate(0deg);
                opacity: 0.3;
            }
            50% {
                opacity: 0.6;
            }
            100% {
                transform: translateY(-100vh) translateX(100px) rotate(360deg);
                opacity: 0.3;
            }
        }

        /* Toggle Switch */
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 100;
        }

        .toggle-container {
            display: flex;
            align-items: center;
        }

        .toggle-text {
            margin-right: 10px;
            font-size: 14px;
            color: var(--text-light);
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: var(--toggle-bg);
            transition: .4s;
            border-radius: 34px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 4px;
            bottom: 4px;
            background-color: var(--toggle-fg);
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: var(--accent-color);
        }

        input:checked + .slider:before {
            transform: translateX(30px);
        }

        /* Content Styles */
        .form-container {
            width: 100%;
            max-width: 450px;
            padding: 40px;
            background: rgba(18, 18, 18, 0.8);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }

        h2 {
            color: var(--accent-color);
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--accent-color);
        }

        input {
            width: 100%;
            padding: 12px 15px;
            background: var(--input-bg-dark);
            border: 1px solid var(--input-border-dark);
            border-radius: 8px;
            color: var(--text-light);
            font-size: 16px;
            transition: all 0.3s;
        }

        input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(79, 195, 247, 0.2);
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-success {
            background: var(--success-color);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .error {
            color: var(--danger-color);
            padding: 10px;
            margin-top: 20px;
            background: rgba(244, 67, 54, 0.1);
            border-radius: 8px;
            border-left: 4px solid var(--danger-color);
            text-align: center;
        }

        .forgot-password {
            text-align: right;
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .forgot-password a {
            color: var(--accent-color);
            text-decoration: none;
            font-size: 14px;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .form-container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        body.light-theme input {
            background: white;
            border-color: #ddd;
            color: var(--text-dark);
        }

        body.light-theme .bg-circle {
            background: radial-gradient(circle, rgba(74, 111, 165, 0.1) 0%, rgba(74, 111, 165, 0) 70%);
        }

        body.light-theme label {
            color: var(--secondary-color);
        }

        body.light-theme .forgot-password a {
            color: var(--secondary-color);
        }
    </style>
</head>
<body class="login-page dark-theme">
    <!-- Background Animation Elements -->
    <div class="bg-animation">
        <div class="bg-circle" style="width: 300px; height: 300px; top: 10%; left: 5%; animation-delay: 0s;"></div>
        <div class="bg-circle" style="width: 200px; height: 200px; top: 60%; left: 20%; animation-delay: 3s;"></div>
        <div class="bg-circle" style="width: 250px; height: 250px; top: 30%; left: 70%; animation-delay: 6s;"></div>
        <div class="bg-circle" style="width: 150px; height: 150px; top: 70%; left: 80%; animation-delay: 9s;"></div>
        <div class="bg-circle" style="width: 180px; height: 180px; top: 20%; left: 40%; animation-delay: 12s;"></div>
    </div>

    <!-- Theme Toggle Switch -->
    <div class="theme-toggle">
        <div class="toggle-container">
            <span class="toggle-text">Dark Mode</span>
            <label class="toggle-switch">
                <input type="checkbox" id="theme-toggle">
                <span class="slider"></span>
            </label>
        </div>
    </div>

    <div class="form-container">
        <h2>Login</h2>
        <form action="login" method="post">
            <div class="form-group">
                <label for="userId">User ID:</label>
                <input type="text" id="userId" name="userId" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="forgot-password">
                <a href="forgot-password.jsp">Forgot Password?</a>
            </div>
            <div class="button-group">
                <button type="submit" class="btn btn-primary">Login</button>
                <button type="button" class="btn btn-success" onclick="window.location.href='register.jsp'">Register</button>
            </div>
            <div class="error">
                <% if(request.getAttribute("errorMessage") != null) { %>
                    <%= request.getAttribute("errorMessage") %>
                <% } %>
            </div>
        </form>
    </div>

    <script>
        // Theme Toggle Functionality
        const toggleSwitch = document.getElementById('theme-toggle');
        const currentTheme = localStorage.getItem('theme');

        if (currentTheme) {
            document.body.classList.add(currentTheme);
            if (currentTheme === 'light-theme') {
                toggleSwitch.checked = true;
                document.querySelector('.toggle-text').textContent = 'Light Mode';
            }
        }

        function switchTheme(e) {
            if (e.target.checked) {
                document.body.classList.replace('dark-theme', 'light-theme');
                localStorage.setItem('theme', 'light-theme');
                document.querySelector('.toggle-text').textContent = 'Light Mode';
            } else {
                document.body.classList.replace('light-theme', 'dark-theme');
                localStorage.setItem('theme', 'dark-theme');
                document.querySelector('.toggle-text').textContent = 'Dark Mode';
            }
        }

        toggleSwitch.addEventListener('change', switchTheme, false);

        // Add focus effect when clicking on input fields
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('label').style.color = 'var(--accent-color)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.querySelector('label').style.color = '';
            });
        });

        // Simple animation on form load
        document.addEventListener('DOMContentLoaded', () => {
            const form = document.querySelector('.form-container');
            form.style.opacity = '0';
            form.style.transform = 'translateY(20px)';
            form.style.transition = 'all 0.5s ease';
            
            setTimeout(() => {
                form.style.opacity = '1';
                form.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>