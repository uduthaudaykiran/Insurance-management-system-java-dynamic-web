<%@ page import="model.Complaint" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Complaint Status</title>
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

        /* Form Container */
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(18, 18, 18, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* Details Table */
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        .details-table th,
        .details-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border-dark);
        }

        .details-table th {
            background: var(--primary-color);
            color: white;
            font-weight: 500;
            width: 30%;
        }

        .details-table tr:nth-child(even) {
            background: rgba(30, 30, 30, 0.5);
        }

        /* Form Elements */
        select, textarea {
            width: 100%;
            padding: 12px 15px;
            background: var(--input-bg-dark);
            border: 1px solid var(--input-border-dark);
            border-radius: 8px;
            color: var(--text-light);
            font-size: 16px;
            transition: all 0.3s;
        }

        select:focus,
        textarea:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(79, 195, 247, 0.2);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .submit-btn {
            display: block;
            width: 100%;
            max-width: 200px;
            margin: 25px auto 0;
            padding: 12px 25px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        /* Status Options */
        option[value="OPEN"] {
            color: var(--warning-color);
        }

        option[value="IN_PROGRESS"] {
            color: var(--accent-color);
        }

        option[value="RESOLVED"] {
            color: var(--success-color);
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
        body.light-theme .form-container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .details-table th {
            background: var(--secondary-color);
        }

        body.light-theme .details-table tr:nth-child(even) {
            background: rgba(245, 245, 245, 0.8);
        }

        body.light-theme .nav-link {
            color: var(--secondary-color);
        }

        body.light-theme .nav-link:hover {
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme select,
        body.light-theme textarea {
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

            .form-container {
                padding: 20px;
            }

            .details-table th,
            .details-table td {
                display: block;
                width: 100%;
            }

            .details-table th {
                background: var(--primary-color);
                margin-top: 10px;
            }

            .details-table tr {
                margin-bottom: 15px;
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
        <h1>Update Complaint Status</h1>
        <div class="admin-nav">
            <a href="AdminHomeServlet" class="nav-link">Home</a>
            <a href="AdminComplaintServlet" class="nav-link">Complaint Status</a>
        </div>
    </div>
    
    <% Complaint complaint = (Complaint) request.getAttribute("complaint"); %>
    <div class="form-container">
        <form action="AdminComplaintStatusServlet" method="post">
            <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">
            
            <table class="details-table">
                <tr>
                    <th>Complaint ID</th>
                    <td><%= complaint.getComplaintId() %></td>
                </tr>
                <tr>
                    <th>Consumer ID</th>
                    <td><%= complaint.getConsumerId() %></td>
                </tr>
                <tr>
                    <th>Type</th>
                    <td><%= complaint.getComplaintType() %></td>
                </tr>
                <tr>
                    <th>Category</th>
                    <td><%= complaint.getCategory() %></td>
                </tr>
                <tr>
                    <th>Status</th>
                    <td>
                        <select name="status">
                            <option value="OPEN" <%= "OPEN".equals(complaint.getStatus()) ? "selected" : "" %>>OPEN</option>
                            <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>IN PROGRESS</option>
                            <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>RESOLVED</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>Remarks</th>
                    <td><textarea name="remarks" placeholder="Enter any additional remarks..."></textarea></td>
                </tr>
            </table>
            
            <button type="submit" class="submit-btn">Update Status</button>
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

        // Add focus styles for form elements
        document.querySelectorAll('select, textarea').forEach(el => {
            el.addEventListener('focus', function() {
                this.style.borderColor = 'var(--accent-color)';
                this.style.boxShadow = '0 0 0 2px rgba(79, 195, 247, 0.2)';
            });
            
            el.addEventListener('blur', function() {
                this.style.borderColor = 'var(--input-border-dark)';
                this.style.boxShadow = 'none';
            });
        });
    </script>
</body>
</html>