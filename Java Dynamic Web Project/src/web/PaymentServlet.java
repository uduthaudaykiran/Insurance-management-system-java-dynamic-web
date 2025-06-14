package web;

import dao.BillDAO;
import model.Bill;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            BillDAO billDAO = new BillDAO();
            
            // Get all bills for the customer
            List<Bill> allBills = billDAO.getBillsByConsumerId(customer.getConsumerId());
            
            // Separate into pending bills and history
            List<Bill> pendingBills = new ArrayList<>();
            List<Bill> billHistory = new ArrayList<>();
            
            for (Bill bill : allBills) {
                if ("PENDING".equalsIgnoreCase(bill.getStatus())) {
                    pendingBills.add(bill);
                } else {
                    billHistory.add(bill);
                }
            }
            
            // Debug output
            System.out.println("Customer ID: " + customer.getConsumerId());
            System.out.println("Total bills found: " + allBills.size());
            System.out.println("Pending bills: " + pendingBills.size());
            System.out.println("Bill history: " + billHistory.size());
            
            request.setAttribute("pendingBills", pendingBills);
            request.setAttribute("billHistory", billHistory);
            request.getRequestDispatcher("payBill.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving bills: " + e.getMessage());
            request.getRequestDispatcher("payBill.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String[] selectedBills = request.getParameterValues("selectedBills");
        if (selectedBills == null || selectedBills.length == 0) {
            request.setAttribute("error", "Please select at least one bill to pay");
            doGet(request, response);
            return;
        }

        BillDAO billDAO = new BillDAO();
        double totalAmount = 0;
        List<Bill> selectedBillObjects = new ArrayList<>(); // NEW: Store full bill objects
        
        try {
            // Calculate total amount and validate bills
            for (String billId : selectedBills) {
                Bill bill = billDAO.getBillById(Integer.parseInt(billId));
                if (bill == null || !"PENDING".equalsIgnoreCase(bill.getStatus())) {
                    request.setAttribute("error", "One or more selected bills are not valid for payment");
                    doGet(request, response);
                    return;
                }
                selectedBillObjects.add(bill); // NEW: Add full bill object
                totalAmount += bill.getPayableAmount();
            }
            
            // Add PG charges (2% of total amount)
            double pgCharges = totalAmount * 0.02;
            double totalPayable = totalAmount + pgCharges;
            
            request.setAttribute("selectedBills", selectedBills);
            request.setAttribute("selectedBillObjects", selectedBillObjects); // NEW: Pass full bill objects
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("pgCharges", pgCharges);
            request.setAttribute("totalPayable", totalPayable);
            
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing payment: " + e.getMessage());
            doGet(request, response);
        }
    }
}