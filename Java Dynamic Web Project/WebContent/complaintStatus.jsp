<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" import="java.util.List, model.Complaint, model.Customer"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complaint Status</title>
    <style>
        /* Base Styles */
        :root {
            --primary-color: #4a6fa5;
            --secondary-color: #166088;
            --accent-color: #4fc3f7;
            --success-color: #4caf50;
            --danger-color: #f44336;
            --warning-color: #ff9800;
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
            overflow-x: hidden;
            position: relative;
            padding: 20px;
        }

        /* Background Animation */
        .bg-animation {
            position: fixed;
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

        /* Header Styles */
        .user-header {
            float: right;
            padding: 10px 20px;
            background: rgba(30, 30, 30, 0.8);
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .user-header a {
            color: var(--accent-color);
            text-decoration: none;
            margin-left: 10px;
        }

        .user-header a:hover {
            text-decoration: underline;
        }

        /* Navigation */
        .nav-menu {
            clear: both;
            display: flex;
            gap: 20px;
            padding: 15px 20px;
            background: rgba(30, 30, 30, 0.8);
            border-radius: 8px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .nav-menu a {
            color: var(--text-light);
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .nav-menu a:hover {
            background: var(--primary-color);
            color: white;
        }

        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background: rgba(30, 30, 30, 0.8);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        h2, h3 {
            color: var(--accent-color);
            margin-bottom: 20px;
        }

        /* Form Styles */
        .search-form {
            margin-bottom: 30px;
            padding: 20px;
            background: rgba(40, 40, 40, 0.6);
            border-radius: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: inline-block;
            width: 200px;
            color: var(--accent-color);
            font-weight: 500;
        }

        input[type="text"] {
            padding: 10px 15px;
            background: var(--input-bg-dark);
            border: 1px solid var(--input-border-dark);
            border-radius: 8px;
            color: var(--text-light);
            width: 300px;
            max-width: 100%;
        }

        input[type="text"]:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(79, 195, 247, 0.2);
        }

        input[readonly] {
            background: rgba(30, 30, 30, 0.5);
            color: #888;
        }

        /* Button Styles */
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 10px;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-secondary {
            background: var(--secondary-color);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* Message Styles */
        .error {
            color: var(--danger-color);
            padding: 15px;
            margin: 20px 0;
            background: rgba(244, 67, 54, 0.1);
            border-radius: 8px;
            border-left: 4px solid var(--danger-color);
        }

        .message {
            color: var(--success-color);
            padding: 15px;
            margin: 20px 0;
            background: rgba(76, 175, 80, 0.1);
            border-radius: 8px;
            border-left: 4px solid var(--success-color);
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: var(--table-bg-dark);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border-dark);
        }

        th {
            background: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background: rgba(79, 195, 247, 0.1);
        }

        .action-link {
            color: var(--accent-color);
            text-decoration: none;
        }

        .action-link:hover {
            text-decoration: underline;
        }

        /* No Complaints Message */
        .no-complaints {
            padding: 20px;
            background: rgba(40, 40, 40, 0.6);
            border-radius: 8px;
            text-align: center;
            color: var(--warning-color);
            margin: 20px 0;
        }

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .container,
        body.light-theme .user-header,
        body.light-theme .nav-menu,
        body.light-theme .search-form {
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

        body.light-theme table {
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        body.light-theme th, 
        body.light-theme td {
            border-bottom: 1px solid #eee;
        }

        body.light-theme th {
            background: var(--secondary-color);
        }

        body.light-theme .nav-menu a {
            color: var(--text-dark);
        }

        /* Theme Toggle Switch */
        .theme-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
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

        body.light-theme .toggle-text {
            color: var(--text-dark);
        }
    </style>
</head>
<body class="dark-theme">
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

    <div class="user-header">
        Welcome <%= ((Customer) session.getAttribute("customer")).getCustomerName() %> | 
        <a href="LogoutServlet">Logout</a>
    </div>
    
    <div class="nav-menu">
        <a href="HomeServlet">Home</a>
        <a href="PaymentServlet">Payments</a>
        <a href="registerComplaint.jsp">Register Complaint</a>
        <a href="ComplaintStatusServlet">Complaint Status</a>
    </div>
    
    <div class="container">
        <h2>Complaint Status</h2>
        
        <%-- Display messages or errors --%>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>
        
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
            <div class="message"><%= message %></div>
        <% } %>
        
        <div class="search-form">
            <form action="ComplaintStatusServlet" method="post">
                <div class="form-group">
                    <label for="complaintId">Search by Complaint ID: </label>
                    <input type="text" id="complaintId" name="complaintId">
                </div>
                <div class="form-group">
                    <label for="consumerId">OR by Consumer ID: </label>
                    <input type="text" id="consumerId" name="consumerId" 
                           value="<%= ((Customer) session.getAttribute("customer")).getConsumerId() %>" 
                           readonly>
                </div>
                <button type="submit" class="btn btn-primary">Search</button>
                <button type="reset" class="btn btn-secondary">Clear</button>
            </form>
        </div>
        
        <%-- Display single complaint details if available --%>
        <% Complaint complaint = (Complaint) request.getAttribute("complaint"); %>
        <% if (complaint != null) { %>
            <h3>Complaint Details</h3>
            <table>
                <tr>
                    <th>Complaint ID</th>
                    <td><%= complaint.getComplaintId() %></td>
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
                    <td><%= complaint.getStatus() %></td>
                </tr>
                <tr>
                    <th>Problem Description</th>
                    <td><%= complaint.getProblem() %></td>
                </tr>
            </table>
        <% } %>
        
        <%-- Display all complaints for the customer --%>
        <% List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints"); %>
        <% if (complaints != null && !complaints.isEmpty()) { %>
            <h3>Your Recent Complaints</h3>
            <table>
                <tr>
                    <th>Complaint ID</th>
                    <th>Type</th>
                    <th>Category</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <% for (Complaint comp : complaints) { %>
                    <tr>
                        <td><%= comp.getComplaintId() %></td>
                        <td><%= comp.getComplaintType() %></td>
                        <td><%= comp.getCategory() %></td>
                        <td><%= comp.getStatus() %></td>
                        <td>
                            <a href="ComplaintStatusServlet?complaintId=<%= comp.getComplaintId() %>" class="action-link">
                                View Details
                            </a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else if (complaints != null) { %>
            <div class="no-complaints">
                <p>No complaints found for your account.</p>
            </div>
        <% } %>
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

        // Add animation to container on load
        document.addEventListener('DOMContentLoaded', () => {
            const container = document.querySelector('.container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(20px)';
            container.style.transition = 'all 0.5s ease';
            
            setTimeout(() => {
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>