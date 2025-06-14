<%@ page import="model.Complaint, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Complaint Status</title>
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

        /* Search Form */
        .search-form {
            background: rgba(18, 18, 18, 0.8);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .search-form input[type="text"] {
            padding: 10px 15px;
            background: var(--input-bg-dark);
            border: 1px solid var(--input-border-dark);
            border-radius: 8px;
            color: var(--text-light);
            font-size: 16px;
            margin-right: 10px;
            width: 250px;
            transition: all 0.3s;
        }

        .search-form input[type="text"]:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(79, 195, 247, 0.2);
        }

        .search-form input[type="submit"],
        .search-form input[type="button"] {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-form input[type="submit"] {
            background: var(--primary-color);
            color: white;
        }

        .search-form input[type="button"] {
            background: var(--warning-color);
            color: white;
        }

        .search-form input[type="submit"]:hover,
        .search-form input[type="button"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        /* Complaints Table */
        .complaints-container {
            background: rgba(18, 18, 18, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            overflow-x: auto;
        }

        .complaints-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .complaints-table th,
        .complaints-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border-dark);
        }

        .complaints-table th {
            background: var(--primary-color);
            color: white;
            font-weight: 500;
        }

        .complaints-table tr:nth-child(even) {
            background: rgba(30, 30, 30, 0.5);
        }

        .complaints-table tr:hover {
            background: rgba(79, 195, 247, 0.1);
        }

        .action-link {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .action-link:hover {
            text-decoration: underline;
        }

        /* Status Badges */
        .status-pending {
            color: var(--warning-color);
            font-weight: 500;
        }

        .status-resolved {
            color: var(--success-color);
            font-weight: 500;
        }

        .status-in-progress {
            color: var(--accent-color);
            font-weight: 500;
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
        body.light-theme .search-form,
        body.light-theme .complaints-container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .complaints-table th {
            background: var(--secondary-color);
        }

        body.light-theme .complaints-table tr:nth-child(even) {
            background: rgba(245, 245, 245, 0.8);
        }

        body.light-theme .complaints-table tr:hover {
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme .nav-link,
        body.light-theme .action-link {
            color: var(--secondary-color);
        }

        body.light-theme .nav-link:hover {
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme .search-form input[type="text"] {
            background: white;
            border-color: #ddd;
            color: var(--text-dark);
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

            .search-form input[type="text"] {
                width: 100%;
                margin-bottom: 10px;
                margin-right: 0;
            }

            .complaints-table {
                display: block;
                overflow-x: auto;
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
        <h1>Complaint Status</h1>
        <div class="admin-nav">
            <a href="AdminHomeServlet" class="nav-link">Home</a>
            <a href="AdminComplaintServlet" class="nav-link">Complaint Status</a>
        </div>
    </div>
    
    <form class="search-form" action="AdminComplaintServlet" method="get">
        Search by Consumer ID: <input type="text" name="consumerId">
        <input type="submit" value="Search">
        <input type="button" value="Clear" onclick="window.location='AdminComplaintServlet'">
    </form>
    
    <div class="complaints-container">
        <h2>Complaints</h2>
        <table class="complaints-table">
            <tr>
                <th>Complaint ID</th>
                <th>Consumer ID</th>
                <th>Type</th>
                <th>Category</th>
                <th>Contact Person</th>
                <th>Mobile</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <% for (Complaint complaint : (List<Complaint>) request.getAttribute("complaints")) { %>
            <tr>
                <td><%= complaint.getComplaintId() %></td>
                <td><%= complaint.getConsumerId() %></td>
                <td><%= complaint.getComplaintType() %></td>
                <td><%= complaint.getCategory() %></td>
                <td><%= complaint.getCustomerName() %></td>
                <td><%= complaint.getMobileNumber() %></td>
                <td class="status-<%= complaint.getStatus().toLowerCase().replace(" ", "-") %>">
                    <%= complaint.getStatus() %>
                </td>
                <td><a href="AdminComplaintStatusServlet?complaintId=<%= complaint.getComplaintId() %>" class="action-link">Update Status</a></td>
            </tr>
            <% } %>
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

        // Add status classes based on complaint status
        document.addEventListener('DOMContentLoaded', function() {
            const statusCells = document.querySelectorAll('.complaints-table td:nth-child(7)');
            statusCells.forEach(cell => {
                const status = cell.textContent.trim().toLowerCase();
                if (status.includes('pending')) {
                    cell.classList.add('status-pending');
                } else if (status.includes('resolved')) {
                    cell.classList.add('status-resolved');
                } else if (status.includes('progress')) {
                    cell.classList.add('status-in-progress');
                }
            });
        });
    </script>
</body>
</html>