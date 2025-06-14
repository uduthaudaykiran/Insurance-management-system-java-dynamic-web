<%-- complaintAck.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complaint Acknowledgement</title>
    <style>
        /* Base Styles */
        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #166088;
            --accent-color: #4fc3f7;
            --success-color: #4caf50;
            --warning-color: #ff9800;
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
            position: relative;
            padding: 20px;
        }

        /* Header Styles */
        .customer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: rgba(18, 18, 18, 0.8);
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .welcome-text {
            font-size: 16px;
            color: var(--accent-color);
        }

        .logout-link {
            color: var(--danger-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            margin-left: 15px;
        }

        .logout-link:hover {
            text-decoration: underline;
        }

        /* Acknowledgement Container */
        .ack-container {
            max-width: 600px;
            margin: 0 auto;
            background: rgba(18, 18, 18, 0.8);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .ack-title {
            color: var(--success-color);
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: 600;
        }

        .ack-message {
            margin-bottom: 20px;
            line-height: 1.6;
            font-size: 18px;
        }

        .complaint-id {
            color: var(--accent-color);
            font-size: 24px;
            font-weight: 600;
            margin: 10px 0;
            display: inline-block;
            padding: 8px 15px;
            background: rgba(79, 195, 247, 0.1);
            border-radius: 8px;
        }

        .home-link {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 25px;
            background: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .home-link:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        /* Theme Toggle */
        .theme-toggle {
            position: fixed;
            top: 20px;
            left: 200px;
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

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .customer-header,
        body.light-theme .ack-container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .welcome-text {
            color: var(--secondary-color);
        }

        body.light-theme .logout-link {
            color: var(--danger-color);
        }

        body.light-theme .ack-title {
            color: var(--success-color);
        }

        body.light-theme .complaint-id {
            color: var(--secondary-color);
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme .home-link {
            background: var(--secondary-color);
        }

        body.light-theme .home-link:hover {
            background: var(--primary-color);
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .ack-container {
            animation: fadeIn 0.6s ease-out forwards;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .customer-header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }

            .ack-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body class="dark-theme">
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

    <div class="customer-header">
        <span class="welcome-text">Welcome ${customer.customerName}</span>
        <a href="LogoutServlet" class="logout-link">Logout</a>
    </div>
    
    <div class="ack-container">
        <h2 class="ack-title">Complaint Registered Successfully</h2>
        <p class="ack-message">Your complaint has been registered with ID:</p>
        <div class="complaint-id">${complaintId}</div>
        <p class="ack-message">You can check the status of your complaint using this ID.</p>
        
        <a href="HomeServlet" class="home-link">Back to Home</a>
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

        // Add animation on load
        document.addEventListener('DOMContentLoaded', () => {
            const ackContainer = document.querySelector('.ack-container');
            ackContainer.style.opacity = '0';
            setTimeout(() => {
                ackContainer.style.animation = 'fadeIn 0.6s ease-out forwards';
            }, 100);
        });
    </script>
</body>
</html>