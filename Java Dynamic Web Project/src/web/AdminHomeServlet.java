//AdminHomeServlet.java
package web;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.ComplaintDAO;

@WebServlet("/AdminHomeServlet")
public class AdminHomeServlet extends HttpServlet {
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int openCount = complaintDAO.getComplaintCountByStatus("OPEN");
            int inProgressCount = complaintDAO.getComplaintCountByStatus("IN_PROGRESS");
            int resolvedCount = complaintDAO.getComplaintCountByStatus("RESOLVED");
            
            request.setAttribute("openCount", openCount);
            request.setAttribute("inProgressCount", inProgressCount);
            request.setAttribute("resolvedCount", resolvedCount);
            
            request.getRequestDispatcher("adminHome.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}