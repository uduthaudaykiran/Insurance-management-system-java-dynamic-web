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

import javax.servlet.annotation.WebServlet;

@WebServlet("/AdminFeedbackServlet")
public class AdminFeedbackServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Check admin authentication
        if (session.getAttribute("isAdmin") == null || !(Boolean)session.getAttribute("isAdmin")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        request.getRequestDispatcher("adminFeedback.jsp").forward(request, response);
    }
}