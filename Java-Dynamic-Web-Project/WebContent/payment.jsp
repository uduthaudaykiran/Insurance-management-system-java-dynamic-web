<%@ page import="java.util.List, model.Bill, java.text.NumberFormat" %>
<%
    String[] selectedBills = (String[]) request.getAttribute("selectedBills");
    List<Bill> selectedBillObjects = (List<Bill>) request.getAttribute("selectedBillObjects");
    Double totalAmount = (Double) request.getAttribute("totalAmount");
    Double pgCharges = (Double) request.getAttribute("pgCharges");
    Double totalPayable = (Double) request.getAttribute("totalPayable");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
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

        /* Form Styles */
        form {
            margin-top: 30px;
        }

        .form-row {
            display: flex;
            margin-bottom: 15px;
            align-items: center;
        }

        .form-row label {
            width: 200px;
            font-weight: 500;
            color: var(--accent-color);
        }

        .form-row input, 
        .form-row select {
            flex: 1;
            padding: 10px 15px;
            background: var(--input-bg-dark);
            border: 1px solid var(--input-border-dark);
            border-radius: 8px;
            color: var(--text-light);
            font-size: 16px;
        }

        .form-row input:focus,
        .form-row select:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 2px rgba(79, 195, 247, 0.2);
        }

        /* Button Styles */
        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
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

        body.light-theme .form-row input,
        body.light-theme .form-row select {
            background: white;
            border-color: #ddd;
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
        <h2>Payment Details</h2>
        
        <div class="section">
            <h3>Selected Bills</h3>
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
                    <% for (Bill bill : selectedBillObjects) { %>
                        <tr>
                            <td><%= bill.getBillNumber() %></td>
                            <td><%= currencyFormat.format(bill.getDueAmount()) %></td>
                            <td><%= currencyFormat.format(bill.getPayableAmount()) %></td>
                            <td><%= bill.getStatus() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="section">
            <form action="PaymentConfirmationServlet" method="post">
                <!-- Pass all selected bill IDs as hidden fields -->
                <% for (String billId : selectedBills) { %>
                    <input type="hidden" name="selectedBills" value="<%= billId %>">
                <% } %>
                
                <h3>Payment Summary</h3>
                <div class="form-row">
                    <label>Total Bill Amount:</label>
                    <span><%= currencyFormat.format(totalAmount) %></span>
                </div>
                <div class="form-row">
                    <label>PG Charges (2%):</label>
                    <span><%= currencyFormat.format(pgCharges) %></span>
                </div>
                <div class="form-row">
                    <label>Total Payable Amount:</label>
                    <span style="font-weight: bold; color: var(--accent-color);">
                        <%= currencyFormat.format(totalPayable) %>
                    </span>
                </div>
                
                <h3>Payment Method</h3>
                <div class="form-row">
                    <label for="paymentMode">Mode of Payment:</label>
                    <select name="paymentMode" id="paymentMode" required>
                        <option value="CREDIT">Credit Card</option>
                        <option value="DEBIT">Debit Card</option>
                    </select>
                </div>
                
                <h3>Card Details</h3>
                <div class="form-row">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" name="cardNumber" id="cardNumber" 
                           pattern="[0-9]{16}" title="16 digit card number" required>
                </div>
                <div class="form-row">
                    <label for="cardHolder">Card Holder Name:</label>
                    <input type="text" name="cardHolder" id="cardHolder" 
                           minlength="10" required>
                </div>
                <div class="form-row">
                    <label for="expiryDate">Expiry Date (MM/YY):</label>
                    <input type="text" name="expiryDate" id="expiryDate" 
                           pattern="(0[1-9]|1[0-2])/[0-9]{2}" title="MM/YY format" required>
                </div>
                <div class="form-row">
                    <label for="cvv">CVV:</label>
                    <input type="text" name="cvv" id="cvv" 
                           pattern="[0-9]{3}" title="3 digit CVV" required>
                </div>
                
                <div class="button-group">
                    <a href="PaymentServlet" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Pay Now</button>
                </div>
            </form>
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