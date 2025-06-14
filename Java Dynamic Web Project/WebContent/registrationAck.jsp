<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Successful</title>
    <style>
        /* Base Styles */
        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #166088;
            --accent-color: #4fc3f7;
            --text-light: #f8f9fa;
            --text-dark: #212529;
            --bg-dark: #121212;
            --bg-darker: #0a0a0a;
            --success-color: #4caf50;
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
        .overlay {
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background: rgba(18, 18, 18, 0.8);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
            position: relative;
            z-index: 1;
        }

        .success {
            color: var(--success-color);
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: 600;
        }

        .form-group {
            margin: 25px 0;
            text-align: left;
            padding: 20px;
            background: rgba(10, 10, 10, 0.5);
            border-radius: 10px;
            border-left: 4px solid var(--accent-color);
        }

        .form-group p {
            margin: 15px 0;
            font-size: 16px;
            line-height: 1.6;
        }

        .form-group strong {
            color: var(--accent-color);
            margin-right: 10px;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(74, 111, 165, 0.4);
            margin-top: 10px;
        }

        .btn:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(74, 111, 165, 0.6);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .overlay {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .form-group {
            background: rgba(245, 247, 250, 0.8);
        }

        body.light-theme .bg-circle {
            background: radial-gradient(circle, rgba(74, 111, 165, 0.1) 0%, rgba(74, 111, 165, 0) 70%);
        }
    </style>
</head>
<body class="home-page dark-theme">
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

    <div class="overlay">
        <h1 class="success">Consumer Registration successful.</h1>
        
        <div class="form-group">
            <p><strong>Customer ID:</strong> <%= request.getAttribute("consumerId") %></p>
            <p><strong>Customer Name:</strong> <%= request.getAttribute("customerName") %></p>
            <p><strong>Email:</strong> <%= request.getAttribute("email") %></p>
        </div>
        
        <a href="login.jsp" class="btn">Click here to login</a>
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

        // Dynamic background elements
        function createBubbles() {
            const bgAnimation = document.querySelector('.bg-animation');
            const bubbleCount = 8;
            
            for (let i = 0; i < bubbleCount; i++) {
                const bubble = document.createElement('div');
                bubble.classList.add('bg-circle');
                
                const size = Math.random() * 200 + 100;
                const posX = Math.random() * 100;
                const posY = Math.random() * 100;
                const delay = Math.random() * 15;
                const duration = Math.random() * 15 + 15;
                
                bubble.style.width = `${size}px`;
                bubble.style.height = `${size}px`;
                bubble.style.top = `${posY}%`;
                bubble.style.left = `${posX}%`;
                bubble.style.animationDelay = `${delay}s`;
                bubble.style.animationDuration = `${duration}s`;
                
                bgAnimation.appendChild(bubble);
            }
        }

        // Uncomment to enable dynamic bubble creation
        window.addEventListener('load', createBubbles);
    </script>
</body>
</html>