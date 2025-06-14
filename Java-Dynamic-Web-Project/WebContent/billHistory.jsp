<%@ page import="model.Bill" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bill History</title>
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

        /* Bill History Container */
        .bill-container {
            max-width: 1000px;
            margin: 0 auto;
            background: rgba(18, 18, 18, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .section-title {
            color: var(--accent-color);
            margin-bottom: 20px;
            font-size: 22px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--table-border-dark);
        }

        /* Bill History Table */
        .bill-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .bill-table th,
        .bill-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border-dark);
        }

        .bill-table th {
            background: var(--primary-color);
            color: white;
            font-weight: 500;
        }

        .bill-table tr:nth-child(even) {
            background: rgba(30, 30, 30, 0.5);
        }

        .bill-table tr:hover {
            background: rgba(79, 195, 247, 0.1);
        }

        /* Status Badges */
        .status-paid {
            color: var(--success-color);
            font-weight: 500;
        }

        .status-pending {
            color: var(--warning-color);
            font-weight: 500;
        }

        .status-overdue {
            color: var(--danger-color);
            font-weight: 500;
        }

        /* Download Link */
        .download-link {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            background: rgba(79, 195, 247, 0.1);
        }

        .download-link:hover {
            background: rgba(79, 195, 247, 0.2);
            text-decoration: underline;
        }

        /* No Data Message */
        .no-data {
            text-align: center;
            padding: 20px;
            color: var(--warning-color);
            font-style: italic;
        }

        /* Theme Toggle */
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

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .admin-header,
        body.light-theme .bill-container {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .bill-table th {
            background: var(--secondary-color);
        }

        body.light-theme .bill-table tr:nth-child(even) {
            background: rgba(245, 245, 245, 0.8);
        }

        body.light-theme .nav-link {
            color: var(--secondary-color);
        }

        body.light-theme .nav-link:hover {
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme .section-title {
            color: var(--secondary-color);
            border-bottom-color: #ddd;
        }

        body.light-theme .download-link {
            color: var(--secondary-color);
            background: rgba(22, 96, 136, 0.1);
        }

        body.light-theme .download-link:hover {
            background: rgba(22, 96, 136, 0.2);
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

            .bill-container {
                padding: 20px;
            }

            .bill-table {
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
        <h1>Billing Management</h1>
        <div class="admin-nav">
            <a href="AdminHomeServlet" class="nav-link">Home</a>
            <a href="AdminComplaintServlet" class="nav-link">Complaint Status</a>
        </div>
    </div>
    
    <div class="bill-container">
        <h2 class="section-title">Bill History</h2>
        
        <% List<Bill> billHistory = (List<Bill>) request.getAttribute("billHistory"); %>
        <table class="bill-table">
            <tr>
                <th>Bill Number</th>
                <th>Due Amount</th>
                <th>Payable Amount</th>
                <th>Status</th>
                <% if (billHistory != null && !billHistory.isEmpty() && "PAID".equalsIgnoreCase(billHistory.get(0).getStatus())) { %>
                    <th>Receipt</th>
                <% } %>
            </tr>
            <% if (billHistory != null && !billHistory.isEmpty()) { %>
                <% for (Bill bill : billHistory) { %>
                    <tr>
                        <td><%= bill.getBillNumber() %></td>
                        <td>₹<%= String.format("%.2f", bill.getDueAmount()) %></td>
                        <td>₹<%= String.format("%.2f", bill.getPayableAmount()) %></td>
                        <td class="status-<%= bill.getStatus().toLowerCase() %>"><%= bill.getStatus() %></td>
                        <% if ("PAID".equalsIgnoreCase(bill.getStatus())) { %>
                            <td><a href="ReceiptDownloadServlet?billId=<%= bill.getBillId() %>" class="download-link">Download</a></td>
                        <% } else { %>
                            <td>-</td>
                        <% } %>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="5" class="no-data">No bill history found</td>
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

        // Add status classes to all status cells
        document.addEventListener('DOMContentLoaded', function() {
            const statusCells = document.querySelectorAll('.bill-table td:nth-child(4)');
            statusCells.forEach(cell => {
                const status = cell.textContent.trim().toLowerCase();
                if (status.includes('paid')) {
                    cell.classList.add('status-paid');
                } else if (status.includes('pending')) {
                    cell.classList.add('status-pending');
                } else if (status.includes('overdue')) {
                    cell.classList.add('status-overdue');
                }
            });
        });
    </script>
</body>
</html>