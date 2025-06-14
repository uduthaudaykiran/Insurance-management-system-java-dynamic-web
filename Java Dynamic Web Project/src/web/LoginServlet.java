// LoginServlet.java
package web;

import dao.CustomerDAO;
import model.Customer;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        
        // Check for admin login
        if ("admin".equals(userId) && "123".equals(password)) {
            HttpSession session = request.getSession();
            // Set both customer and adminUsername attributes
            Customer adminUser = new Customer();
            adminUser.setCustomerName("Admin");
            adminUser.setUserId("admin");
            session.setAttribute("customer", adminUser);
            session.setAttribute("adminUsername", "Admin"); // Add this line
            session.setAttribute("isAdmin", true);
            response.sendRedirect("AdminHomeServlet"); // Redirect to servlet, not JSP
            return;
        }
        
        try {
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getUserId(userId);
            
            if (customer != null && customer.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("customer", customer);
                session.setAttribute("isAdmin", false);
                response.sendRedirect("HomeServlet");
            } else {
                request.setAttribute("errorMessage", "Invalid User ID or Password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed. Please try again.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}