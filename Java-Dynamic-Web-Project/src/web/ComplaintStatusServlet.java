// ComplaintStatusServlet.java
// ComplaintStatusServlet.java
package web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ComplaintDAO;
import model.Complaint;
import model.Customer;

@WebServlet("/ComplaintStatusServlet")
public class ComplaintStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        // Redirect to login if not authenticated
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Check if admin
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            
            if (isAdmin != null && isAdmin) {
                // Admin view - show all complaints
                List<Complaint> complaints = complaintDAO.getAllComplaints();
                request.setAttribute("complaints", complaints);
                request.getRequestDispatcher("adminComplaintStatus.jsp").forward(request, response);
            } else {
                // Customer view - show only their complaints
                List<Complaint> complaints = complaintDAO.getComplaintsByConsumerId(customer.getConsumerId());
                request.setAttribute("complaints", complaints);
                request.getRequestDispatcher("complaintStatus.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching complaints: " + e.getMessage());
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String complaintIdStr = request.getParameter("complaintId");
        String consumerIdStr = request.getParameter("consumerId");
        String status = request.getParameter("status");
        String remarks = request.getParameter("remarks");
        
        try {
            // Check if this is a status update request (from admin)
            if (status != null) {
                Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
                if (isAdmin == null || !isAdmin) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
                    return;
                }
                
                int complaintId = Integer.parseInt(complaintIdStr);
                boolean updated = complaintDAO.updateComplaintStatus(complaintId, status);
                
                if (updated) {
                    request.setAttribute("message", "Status updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update status");
                }
                
                // Return to admin view
                List<Complaint> complaints = complaintDAO.getAllComplaints();
                request.setAttribute("complaints", complaints);
                request.getRequestDispatcher("adminComplaintStatus.jsp").forward(request, response);
                return;
            }
            
            // Regular search functionality
            Complaint complaint = null;
            if (complaintIdStr != null && !complaintIdStr.isEmpty()) {
                int complaintId = Integer.parseInt(complaintIdStr);
                complaint = complaintDAO.getComplaintById(complaintId, null);
            } else if (consumerIdStr != null && !consumerIdStr.isEmpty()) {
                long consumerId = Long.parseLong(consumerIdStr);
                complaint = complaintDAO.getLatestComplaintByConsumerId(consumerId);
            }
            
            if (complaint != null) {
                request.setAttribute("complaint", complaint);
            } else {
                request.setAttribute("error", "No complaint found with the given details");
            }
            
            // Forward to appropriate view based on user role
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            if (isAdmin != null && isAdmin) {
                List<Complaint> complaints = complaintDAO.getAllComplaints();
                request.setAttribute("complaints", complaints);
                request.getRequestDispatcher("adminComplaintStatus.jsp").forward(request, response);
            } else {
                Customer customer = (Customer) session.getAttribute("customer");
                if (customer != null) {
                    List<Complaint> complaints = complaintDAO.getComplaintsByConsumerId(customer.getConsumerId());
                    request.setAttribute("complaints", complaints);
                }
                request.getRequestDispatcher("complaintStatus.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid complaint/consumer ID format");
            request.getRequestDispatcher("complaintStatus.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("complaintStatus.jsp").forward(request, response);
        }
    }
}