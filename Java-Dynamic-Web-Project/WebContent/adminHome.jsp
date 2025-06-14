<%@ page import="model.Complaint, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Home</title>
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
            --table-bg-dark: #1e1e1e;
            --table-border-dark: #333;
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
        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background: rgba(18, 18, 18, 0.8);
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .welcome-text {
            font-size: 14px;
            color: var(--accent-color);
        }

        .logout-link {
            color: var(--danger-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .logout-link:hover {
            text-decoration: underline;
        }

        /* Page Title */
        .page-title {
            text-align: center;
            margin: 20px 0 30px;
        }

        .page-title h1 {
            color: var(--accent-color);
            margin-bottom: 15px;
            font-size: 28px;
        }

        /* Navigation */
        .admin-nav {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .nav-link {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .nav-link:hover {
            background: rgba(79, 195, 247, 0.1);
        }

        /* Dashboard Container */
        .dashboard-container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(18, 18, 18, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* Summary Table */
        .summary-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .summary-table th,
        .summary-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border-dark);
        }

        .summary-table th {
            background: var(--primary-color);
            color: white;
            font-weight: 500;
        }

        .summary-table tr:nth-child(even) {
            background: rgba(30, 30, 30, 0.5);
        }

        .summary-table tr:hover {
            background: rgba(79, 195, 247, 0.1);
        }

        /* Status Indicators */
        .status-open {
            color: var(--warning-color);
        }

        .status-in-progress {
            color: var(--accent-color);
        }

        .status-resolved {
            color: var(--success-color);
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: rgba(30, 30, 30, 0.5);
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            transition: all 0.3s;
            border-left: 4px solid var(--primary-color);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            margin: 10px 0;
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

        body.light-theme .admin-header,
        body.light-theme .dashboard-container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .summary-table th {
            background: var(--secondary-color);
        }

        body.light-theme .summary-table tr:nth-child(even) {
            background: rgba(245, 245, 245, 0.8);
        }

        body.light-theme .nav-link {
            color: var(--secondary-color);
        }

        body.light-theme .nav-link:hover {
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme .stat-card {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .logout-link {
            color: var(--danger-color);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .admin-header {
                flex-direction: column;
                gap: 10px;
            }

            .admin-nav {
                flex-direction: column;
                gap: 10px;
            }

            .dashboard-container {
                padding: 20px;
            }

            .stats-container {
                grid-template-columns: 1fr;
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

    <div class="admin-header">
        <span class="welcome-text">Welcome Admin</span>
        <a href="LogoutServlet" class="logout-link">Logout</a>
    </div>
    
    <div class="page-title">
        <h1>Admin Dashboard</h1>
        <div class="admin-nav">
            <a href="AdminHomeServlet" class="nav-link">Home</a>
            <a href="AdminComplaintServlet" class="nav-link">Complaint Status</a>
        </div>
    </div>
    
    <div class="dashboard-container">
        <h2>Complaint Summary</h2>
        
        <!-- Stats Cards -->
        <div class="stats-container">
            <div class="stat-card">
                <div>Open Complaints</div>
                <div class="stat-value status-open">${openCount}</div>
                <div>Require attention</div>
            </div>
            <div class="stat-card">
                <div>In Progress</div>
                <div class="stat-value status-in-progress">${inProgressCount}</div>
                <div>Being resolved</div>
            </div>
            <div class="stat-card">
                <div>Resolved</div>
                <div class="stat-value status-resolved">${resolvedCount}</div>
                <div>Completed cases</div>
            </div>
        </div>
        
        <!-- Summary Table -->
        <table class="summary-table">
            <tr>
                <th>Status</th>
                <th>Count</th>
                <th>Percentage</th>
            </tr>
            <tr>
                <td class="status-open">Open Complaints</td>
                <td>${openCount}</td>
                <td>${(openCount / (openCount + inProgressCount + resolvedCount)) * 100}%</td>
            </tr>
            <tr>
                <td class="status-in-progress">In Progress</td>
                <td>${inProgressCount}</td>
                <td>${(inProgressCount / (openCount + inProgressCount + resolvedCount)) * 100}%</td>
            </tr>
            <tr>
                <td class="status-resolved">Resolved</td>
                <td>${resolvedCount}</td>
                <td>${(resolvedCount / (openCount + inProgressCount + resolvedCount)) * 100}%</td>
            </tr>
        </table>
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

        // Format percentages
        document.addEventListener('DOMContentLoaded', function() {
            const percentageCells = document.querySelectorAll('.summary-table td:nth-child(3)');
            percentageCells.forEach(cell => {
                if (cell.textContent.trim() !== '') {
                    const value = parseFloat(cell.textContent);
                    cell.textContent = value.toFixed(1) + '%';
                }
            });
        });
    </script>
</body>
</html>