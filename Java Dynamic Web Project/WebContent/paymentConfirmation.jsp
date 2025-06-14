<%@ page import="model.Bill" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Confirmation</title>
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
            max-width: 800px;
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
            text-align: left;
            border-bottom: 1px solid var(--accent-color);
            padding-bottom: 8px;
        }

        /* Success Message */
        .success-message {
            background: rgba(76, 175, 80, 0.2);
            color: var(--success-color);
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid var(--success-color);
            margin: 20px 0;
            text-align: center;
            font-weight: 600;
        }

        /* Summary Table */
        .summary-table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
        }

        .summary-table td {
            padding: 12px 15px;
            border-bottom: 1px solid var(--table-border);
        }

        .summary-table tr:last-child td {
            border-bottom: none;
        }

        .summary-table td:first-child {
            font-weight: 600;
            color: var(--accent-color);
            width: 40%;
        }

        /* Bill Details Table */
        .bill-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
        }

        .bill-table th, 
        .bill-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid var(--table-border);
        }

        .bill-table th {
            background-color: var(--table-header-bg);
            color: var(--accent-color);
            font-weight: 600;
        }

        .bill-table tr:nth-child(even) {
            background-color: var(--table-row-even);
        }

        .bill-table tr:nth-child(odd) {
            background-color: var(--table-row-odd);
        }

        .bill-table tr:hover {
            background-color: rgba(79, 195, 247, 0.1);
        }

        .status-paid {
            color: var(--success-color);
            font-weight: 600;
        }

        /* Button Styles */
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* Thank You Message */
        .thank-you {
            text-align: center;
            margin: 30px 0;
            font-size: 18px;
            opacity: 0.9;
        }

        /* Link Styles */
        a.download-link {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
        }

        a.download-link:hover {
            text-decoration: underline;
        }

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .user-info,
        body.light-theme .main-nav {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .bill-table th {
            background-color: #f1f1f1;
        }

        body.light-theme .bill-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        body.light-theme .bill-table tr:nth-child(odd) {
            background-color: white;
        }

        body.light-theme .bg-circle {
            background: radial-gradient(circle, rgba(74, 111, 165, 0.1) 0%, rgba(74, 111, 165, 0) 70%);
        }

        body.light-theme .main-nav a {
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
        <h2>Payment Confirmation</h2>
        
        <div class="success-message">
            Your payment has been processed successfully!
        </div>
        
        <h3>Transaction Summary</h3>
        <table class="summary-table">
            <tr>
                <td><strong>Transaction ID:</strong></td>
                <td><%= request.getAttribute("transactionId") %></td>
            </tr>
            <tr>
                <td><strong>Date & Time:</strong></td>
                <td><%= request.getAttribute("transactionDate") %></td>
            </tr>
            <tr>
                <td><strong>Payment Mode:</strong></td>
                <td><%= request.getAttribute("paymentMode") %> Card (**** **** **** <%= request.getAttribute("cardLastFour") %>)</td>
            </tr>
            <tr>
                <td><strong>Total Amount Paid:</strong></td>
                <td>₹<%= request.getAttribute("totalAmount") %></td>
            </tr>
        </table>
        
        <% List<Bill> paidBills = (List<Bill>) request.getAttribute("paidBills"); %>
        <% if (paidBills != null && !paidBills.isEmpty()) { %>
            <h3>Bill Details</h3>
            <table class="bill-table">
                <tr>
                    <th>Bill Number</th>
                    <th>Amount Paid</th>
                    <th>Status</th>
                    <th>Receipt</th>
                </tr>
                <% for (Bill bill : paidBills) { %>
                    <tr>
                        <td><%= bill.getBillNumber() %></td>
                        <td>₹<%= bill.getPayableAmount() %></td>
                        <td class="status-paid"><%= bill.getStatus() %></td>
                        <td><a href="ReceiptDownloadServlet?billId=<%= bill.getBillId() %>" class="download-link">Download</a></td>
                    </tr>
                <% } %>
            </table>
        <% } %>
        
        <p class="thank-you">Thank you for your payment. A confirmation has been sent to your registered email.</p>
        
        <div style="text-align: center;">
            <a href="HomeServlet" class="btn btn-primary">Back to Home</a>
        </div>
    </div>

    <script>
        // Animation for page elements
        document.addEventListener('DOMContentLoaded', () => {
            const elements = document.querySelectorAll('.success-message, .summary-table, .bill-table, .thank-you');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                element.style.transition = `all 0.5s ease ${index * 0.1}s`;
                
                setTimeout(() => {
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, 100);
            });
        });
    </script>
</body>
</html>