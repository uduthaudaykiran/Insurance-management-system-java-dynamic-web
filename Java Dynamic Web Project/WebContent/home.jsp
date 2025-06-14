<%@ page import="model.Bill" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Complaint, model.Bill" %>
<html>
<head>
    <title>Home</title>
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

        h2 {
            color: var(--accent-color);
            margin: 20px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--primary-color);
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

        /* No Data Message */
        .no-data {
            padding: 20px;
            background: rgba(40, 40, 40, 0.6);
            border-radius: 8px;
            text-align: center;
            color: var(--warning-color);
            margin: 20px 0;
        }

        /* Error Message */
        .error-message {
            color: var(--danger-color);
            padding: 15px;
            margin: 20px 0;
            background: rgba(244, 67, 54, 0.1);
            border-radius: 8px;
            border-left: 4px solid var(--danger-color);
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

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .container,
        body.light-theme .user-header,
        body.light-theme .nav-menu {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .bg-circle {
            background: radial-gradient(circle, rgba(74, 111, 165, 0.1) 0%, rgba(74, 111, 165, 0) 70%);
        }

        body.light-theme .nav-menu a {
            color: var(--text-dark);
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
        Welcome <%= ((model.Customer)session.getAttribute("customer")).getCustomerName() %> | 
        <a href="LogoutServlet">Logout</a>
    </div>
    
    <div class="nav-menu">
        <a href="HomeServlet">Home</a>
        <a href="PaymentServlet">Pay Bill</a>
        <a href="registerComplaint.jsp">Register Complaint</a>
        <a href="ComplaintStatusServlet">Complaint Status</a>
    </div>
    
    <div class="container">
        <h2>Recent Bills</h2>
        <% List<Bill> recentBills = (List<Bill>) request.getAttribute("recentBills"); %>
        <table>
            <tr>
                <th>Bill Number</th>
                <th>Due Amount</th>
                <th>Payable Amount</th>
                <th>Status</th>
            </tr>
            <% if (recentBills != null && !recentBills.isEmpty()) { %>
                <% for (Bill bill : recentBills) { %>
                    <tr>
                        <td><%= bill.getBillNumber() %></td>
                        <td><%= bill.getDueAmount() %></td>
                        <td><%= bill.getPayableAmount() %></td>
                        <td><%= bill.getStatus() %></td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="4" class="no-data">No bills found</td>
                </tr>
            <% } %>
        </table>
        
        <h2>Recent Complaints</h2>
        <% List<Complaint> recentComplaints = (List<Complaint>) request.getAttribute("recentComplaints"); %>
        <% if (recentComplaints != null && !recentComplaints.isEmpty()) { %>
            <table>
                <tr>
                    <th>Complaint ID</th>
                    <th>Type</th>
                    <th>Problem</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <% for (Complaint complaint : recentComplaints) { %>
                    <tr>
                        <td><%= complaint.getComplaintId() %></td>
                        <td><%= complaint.getComplaintType() %></td>
                        <td><%= complaint.getProblem() %></td>
                        <td><%= complaint.getStatus() %></td>
                        <td>
                            <a href="complaintStatus.jsp?searchParam=<%= complaint.getComplaintId() %>" class="action-link">View Details</a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <div class="no-data">
                <p>No recent complaints found.</p>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message"><%= request.getAttribute("error") %></div>
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