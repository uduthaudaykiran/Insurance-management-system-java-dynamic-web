package web;

import dao.BillDAO;
import dao.ComplaintDAO;
import model.Bill;
import model.Complaint;
import model.Customer;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        BillDAO billDAO = new BillDAO();
        ComplaintDAO complaintDAO = new ComplaintDAO();
        
        try {
            // Get recent bills (last 5)
            List<Bill> recentBills = billDAO.getBillsByConsumerId(customer.getConsumerId());
            request.setAttribute("recentBills", recentBills);
            
            // Get recent complaints for the customer
            List<Complaint> recentComplaints = complaintDAO.getComplaintsByConsumerId(customer.getConsumerId());
            request.setAttribute("recentComplaints", recentComplaints);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading home page");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}