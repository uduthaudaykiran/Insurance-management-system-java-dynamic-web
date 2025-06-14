<%@ page import="java.util.List, model.Bill, java.text.NumberFormat" %>
<%
    List<Bill> pendingBills = (List<Bill>) request.getAttribute("pendingBills");
    List<Bill> billHistory = (List<Bill>) request.getAttribute("billHistory");
    String error = (String) request.getAttribute("error");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Bill Payment</title>
    <meta charset="UTF-8">
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
            --table-header-bg: #1e1e1e;
            --table-row-even: #1a1a1a;
            --table-row-odd: #222;
            --table-border: #333;
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

        /* Navigation and User Info */
        .user-info {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 10px 15px;
            background: rgba(30, 30, 30, 0.8);
            border-radius: 8px;
            font-size: 14px;
        }

        .user-info a {
            color: var(--accent-color);
            margin-left: 10px;
            text-decoration: none;
        }

        .user-info a:hover {
            text-decoration: underline;
        }

        .main-nav {
            display: flex;
            justify-content: center;
            background: rgba(30, 30, 30, 0.8);
            padding: 15px;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--input-border-dark);
        }

        .main-nav a {
            color: var(--text-light);
            text-decoration: none;
            margin: 0 15px;
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s;
        }

        .main-nav a:hover {
            background: var(--primary-color);
            color: white;
        }

        /* Container Styles */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        h2, h3 {
            color: var(--accent-color);
            margin-bottom: 20px;
            text-align: center;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 30px;
        }

        h3 {
            font-size: 22px;
            margin: 25px 0 15px;
        }

        /* Section Styles */
        .section {
            background: rgba(18, 18, 18, 0.8);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border);
        }

        th {
            background-color: var(--table-header-bg);
            color: var(--accent-color);
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: var(--table-row-even);
        }

        tr:nth-child(odd) {
            background-color: var(--table-row-odd);
        }

        tr:hover {
            background-color: rgba(79, 195, 247, 0.1);
        }

        /* Button Styles */
        button {
            padding: 12px 25px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            margin: 20px auto 0;
        }

        button:hover {
            background: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        button:active {
            transform: translateY(0);
        }

        /* Checkbox Styles */
        input[type="checkbox"] {
            width: auto;
            transform: scale(1.3);
            accent-color: var(--accent-color);
        }

        /* Error Message */
        .error {
            color: var(--danger-color);
            padding: 15px;
            margin: 20px 0;
            background: rgba(244, 67, 54, 0.1);
            border-radius: 8px;
            border-left: 4px solid var(--danger-color);
            text-align: center;
        }

        /* No Data Message */
        p {
            text-align: center;
            color: var(--text-light);
            opacity: 0.8;
            margin: 20px 0;
        }

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .section,
        body.light-theme .user-info,
        body.light-theme .main-nav {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme th {
            background-color: #f1f1f1;
        }

        body.light-theme tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        body.light-theme tr:nth-child(odd) {
            background-color: white;
        }

        body.light-theme .bg-circle {
            background: radial-gradient(circle, rgba(74, 111, 165, 0.1) 0%, rgba(74, 111, 165, 0) 70%);
        }

        body.light-theme .main-nav a {
            color: var(--text-dark);
        }

        body.light-theme p {
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

    <div class="user-info">
        Welcome <%= ((model.Customer)session.getAttribute("customer")).getCustomerName() %>
        <a href="LogoutServlet">Logout</a>
    </div>

    <div class="main-nav">
        <a href="HomeServlet">Home</a>
        <a href="PaymentServlet">Pay Bill</a>
        <a href="registerComplaint.jsp">Register Complaint</a>
        <a href="ComplaintStatusServlet">Complaint Status</a>
    </div>

    <div class="container">
        <h2>Bill Payment</h2>
        
        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <!-- Pending Bills -->
        <div class="section">
            <h3>Pending Bills</h3>
            <% if (pendingBills != null && !pendingBills.isEmpty()) { %>
                <form action="PaymentServlet" method="post">
                    <table>
                        <thead>
                            <tr>
                                <th>Select</th>
                                <th>Bill Number</th>
                                <th>Due Amount</th>
                                <th>Payable Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Bill bill : pendingBills) { %>
                                <tr>
                                    <td><input type="checkbox" name="selectedBills" value="<%= bill.getBillId() %>"></td>
                                    <td><%= bill.getBillNumber() %></td>
                                    <td><%= currencyFormat.format(bill.getDueAmount()) %></td>
                                    <td><%= currencyFormat.format(bill.getPayableAmount()) %></td>
                                    <td><%= bill.getStatus() %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                    <button type="submit">Pay Selected Bills</button>
                </form>
            <% } else { %>
                <p>No pending bills found</p>
            <% } %>
        </div>

        <!-- Bill History -->
        <div class="section">
            <h3>Bill History</h3>
            <% if (billHistory != null && !billHistory.isEmpty()) { %>
                <table>
                    <thead>
                        <tr>
                            <th>Bill Number</th>
                            <th>Due Amount</th>
                            <th>Payable Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Bill bill : billHistory) { %>
                            <tr>
                                <td><%= bill.getBillNumber() %></td>
                                <td><%= currencyFormat.format(bill.getDueAmount()) %></td>
                                <td><%= currencyFormat.format(bill.getPayableAmount()) %></td>
                                <td><%= bill.getStatus() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <p>No bill history found</p>
            <% } %>
        </div>
    </div>

    <script>
        // Animation for sections
        document.addEventListener('DOMContentLoaded', () => {
            const sections = document.querySelectorAll('.section');
            sections.forEach((section, index) => {
                section.style.opacity = '0';
                section.style.transform = 'translateY(20px)';
                section.style.transition = `all 0.5s ease ${index * 0.1}s`;
                
                setTimeout(() => {
                    section.style.opacity = '1';
                    section.style.transform = 'translateY(0)';
                }, 100);
            });
        });
    </script>
</body>
</html>