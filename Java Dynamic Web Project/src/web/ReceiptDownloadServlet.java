// ReceiptDownloadServlet.java
package web;

import dao.BillDAO;
import model.Bill;
import model.Customer;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/ReceiptDownloadServlet")
public class ReceiptDownloadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String billId = request.getParameter("billId");
        if (billId == null || billId.isEmpty()) {
            response.sendRedirect("home.jsp");
            return;
        }

        BillDAO billDAO = new BillDAO();
        try {
            Bill bill = billDAO.getBillById(Integer.parseInt(billId));
            if (bill == null || !"PAID".equalsIgnoreCase(bill.getStatus())) {
                response.sendRedirect("home.jsp");
                return;
            }

            // Set response content type
            response.setContentType("text/plain");
            response.setHeader("Content-Disposition", "attachment;filename=receipt_"+billId+".txt");

            // Write receipt content
            PrintWriter out = response.getWriter();
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            
            out.println("ELECTRICITY BILL PAYMENT RECEIPT");
            out.println("--------------------------------");
            out.println("Receipt Date: " + sdf.format(new Date()));
            out.println("Consumer ID: " + customer.getConsumerId());
            out.println("Customer Name: " + customer.getCustomerName());
            out.println("Bill Number: " + bill.getBillNumber());
            out.println("Amount Paid: " + bill.getPayableAmount());
            out.println("Payment Status: " + bill.getStatus());
            out.println("--------------------------------");
            out.println("Thank you for your payment!");
            
            out.close();
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("home.jsp");
        }
    }
}