package web;

import dao.BillDAO;
import model.Bill;
import model.Customer;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet("/PaymentConfirmationServlet")
public class PaymentConfirmationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] selectedBills = request.getParameterValues("selectedBills");
        String paymentMode = request.getParameter("paymentMode");
        String cardNumber = request.getParameter("cardNumber");
        String cardHolder = request.getParameter("cardHolder");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");

        // Basic validation
        if (selectedBills == null || selectedBills.length == 0) {
            request.setAttribute("error", "No bills selected for payment");
            request.getRequestDispatcher("payment.jsp").forward(request, response);
            return;
        }

        BillDAO billDAO = new BillDAO();
        List<Bill> paidBills = new ArrayList<>();
        double totalAmount = 0;
        String transactionId = generateTransactionId();
        String transactionDate = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());

        try {
            // Begin transaction
            billDAO.beginTransaction();

            // Process each selected bill
            for (String billIdStr : selectedBills) {
                int billId = Integer.parseInt(billIdStr);
                Bill bill = billDAO.getBillById(billId);

                // Validate bill
                if (bill == null || !"PENDING".equalsIgnoreCase(bill.getStatus())) {
                    billDAO.rollbackTransaction();
                    request.setAttribute("error", "One or more bills cannot be paid (already paid or invalid)");
                    request.getRequestDispatcher("payment.jsp").forward(request, response);
                    return;
                }

                // Update bill status in database
                billDAO.updateBillStatus(billId, "PAID");
                
                // Update the local bill object's status to ensure confirmation page shows correct status
                bill.setStatus("PAID");
                
                totalAmount += bill.getPayableAmount();
                paidBills.add(bill);
            }

            // Commit transaction if all updates succeeded
            billDAO.commitTransaction();

            // Set attributes for confirmation page
            request.setAttribute("paidBills", paidBills);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("transactionId", transactionId);
            request.setAttribute("transactionDate", transactionDate);
            request.setAttribute("paymentMode", paymentMode);
            request.setAttribute("cardLastFour", cardNumber.substring(cardNumber.length() - 4));

            // Forward to confirmation page
            request.getRequestDispatcher("paymentConfirmation.jsp").forward(request, response);

        } catch (SQLException | NumberFormatException e) {
            try {
                billDAO.rollbackTransaction();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            request.setAttribute("error", "Error processing payment: " + e.getMessage());
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        }
    }

    private String generateTransactionId() {
        return "TXN" + System.currentTimeMillis();
    }
}