//BillHistoryServlet.java
package web;

import dao.BillDAO;
import model.Bill;
import model.Customer;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/BillHistoryServlet")
public class BillHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        BillDAO billDAO = new BillDAO();
        try {
            // Get all bills (including paid ones) for history
            List<Bill> allBills = billDAO.getBillsByConsumerId(customer.getConsumerId());
            request.setAttribute("billHistory", allBills);
            
            // Get only pending bills for payment page
            List<Bill> pendingBills = billDAO.getBillsByConsumerId(customer.getConsumerId());
            request.setAttribute("pendingBills", pendingBills);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("billHistory.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving bill history");
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }
}