<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Complaint</title>
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
            --form-bg: rgba(30, 30, 30, 0.8);
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

        /* Form Styles */
        .complaint-form {
            background: var(--form-bg);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--accent-color);
        }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="tel"],
        .form-group input[type="password"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            background: var(--input-bg-dark);
            border: 1px solid var(--input-border-dark);
            border-radius: 6px;
            color: var(--text-light);
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--accent-color);
            outline: none;
            box-shadow: 0 0 0 2px rgba(79, 195, 247, 0.2);
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        /* Button Styles */
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
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
            display: inline-block;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-secondary {
            background: var(--input-bg-dark);
            color: var(--text-light);
            border: 1px solid var(--input-border-dark);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        /* Error Message */
        .error-message {
            color: var(--danger-color);
            background: rgba(244, 67, 54, 0.1);
            padding: 10px 15px;
            border-radius: 6px;
            margin-top: 20px;
            text-align: center;
            border-left: 4px solid var(--danger-color);
        }

        /* Light Theme */
        body.light-theme {
            background: #f5f7fa;
            color: var(--text-dark);
        }

        body.light-theme .user-info,
        body.light-theme .main-nav,
        body.light-theme .complaint-form {
            background: rgba(255, 255, 255, 0.9);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        body.light-theme .form-group input[type="text"],
        body.light-theme .form-group input[type="email"],
        body.light-theme .form-group input[type="tel"],
        body.light-theme .form-group input[type="password"],
        body.light-theme .form-group select,
        body.light-theme .form-group textarea {
            background: white;
            color: var(--text-dark);
            border: 1px solid #ddd;
        }

        body.light-theme .bg-circle {
            background: radial-gradient(circle, rgba(74, 111, 165, 0.1) 0%, rgba(74, 111, 165, 0) 70%);
        }

        body.light-theme .main-nav a {
            color: var(--text-dark);
        }

        body.light-theme .form-group label {
            color: var(--primary-color);
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
        Welcome <%= ((Customer)session.getAttribute("customer")).getCustomerName() %>
        <a href="LogoutServlet">Logout</a>
    </div>
    
    <div class="main-nav">
        <a href="HomeServlet">Home</a>
        <a href="PaymentServlet">Pay Bill</a>
        <a href="registerComplaint.jsp">Register Complaint</a>
        <a href="ComplaintStatusServlet">Complaint Status</a>
    </div>
    
    <div class="container">
        <h2>Register Complaint/Service</h2>
        
        <form action="ComplaintServlet" method="post" class="complaint-form">
            <div class="form-group">
                <label for="complaintType">Complaint/Service Type:</label>
                <select name="complaintType" id="complaintType" required>
                    <option value="">Select Type</option>
                    <option value="Billing related">Billing related</option>
                    <option value="Voltage related">Voltage related</option>
                    <option value="Frequent disruption">Frequent disruption</option>
                    <option value="Street light related">Street light related</option>
                    <option value="Pole related">Pole related</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <select name="category" id="category" required>
                    <option value="">Select Category</option>
                    <option value="High Bill">High Bill</option>
                    <option value="No Power">No Power</option>
                    <option value="Voltage Fluctuation">Voltage Fluctuation</option>
                    <option value="Street Light Fault">Street Light Fault</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="contactPerson">Contact Person:</label>
                <input type="text" name="contactPerson" id="contactPerson" required>
            </div>
            
            <div class="form-group">
                <label for="landMark">LandMark:</label>
                <input type="text" name="landMark" id="landMark" required>
            </div>
            
            <div class="form-group">
                <label for="consumerNo">Consumer No:</label>
                <input type="text" name="consumerNo" id="consumerNo" value="<%= ((Customer)session.getAttribute("customer")).getConsumerId() %>" readonly>
            </div>
            
            <div class="form-group">
                <label for="problem">Problem description:</label>
                <textarea name="problem" id="problem" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="mobileNumber">Mobile Number:</label>
                <input type="text" name="mobileNumber" id="mobileNumber" pattern="[0-9]{10}" required>
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea name="address" id="address" required></textarea>
            </div>
            
            <div class="btn-container">
                <button type="submit" class="btn btn-primary">Submit Complaint</button>
                <button type="reset" class="btn btn-secondary">Cancel</button>
            </div>
            
            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null && !error.isEmpty()) { %>
                <div class="error-message">
                    <%= error %>
                </div>
            <% } %>
        </form>
    </div>

    <script>
        // Animation for form elements
        document.addEventListener('DOMContentLoaded', () => {
            const formGroups = document.querySelectorAll('.form-group');
            formGroups.forEach((group, index) => {
                group.style.opacity = '0';
                group.style.transform = 'translateY(20px)';
                group.style.transition = `all 0.5s ease ${index * 0.1}s`;
                
                setTimeout(() => {
                    group.style.opacity = '1';
                    group.style.transform = 'translateY(0)';
                }, 100);
            });
        });
    </script>
</body>
</html>