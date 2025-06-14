//AdminComplaintServlet.java
package web;

import dao.ComplaintDAO;
import model.Complaint;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/AdminComplaintServlet")
public class AdminComplaintServlet extends HttpServlet {
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String consumerIdStr = request.getParameter("consumerId");
            List<Complaint> complaints;
            
            if (consumerIdStr != null && !consumerIdStr.isEmpty()) {
                long consumerId = Long.parseLong(consumerIdStr);
                complaints = complaintDAO.getComplaintsByConsumerId(consumerId);
            } else {
                complaints = complaintDAO.getAllComplaints();
            }
            
            request.setAttribute("complaints", complaints);
            request.getRequestDispatcher("adminComplaints.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}