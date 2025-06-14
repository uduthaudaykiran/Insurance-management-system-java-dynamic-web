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

@WebServlet("/AdminComplaintStatusServlet")
public class AdminComplaintStatusServlet extends HttpServlet {
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));
            Complaint complaint = complaintDAO.getComplaintById(complaintId, null);
            
            if (complaint == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Complaint not found");
                return;
            }
            
            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("adminComplaintStatus.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int complaintId = Integer.parseInt(request.getParameter("complaintId"));
            String status = request.getParameter("status");
            String remarks = request.getParameter("remarks");
            
            complaintDAO.updateComplaintStatus(complaintId, status);
            // Here you would typically store the remarks in a separate table or add to complaint
            
            response.sendRedirect("AdminComplaintServlet");
        } catch (SQLException | NumberFormatException e) {
            throw new ServletException(e);
        }
    }
}