//CustomerRegistrationServlet.java
package web;

import dao.CustomerDAO;
import model.Customer;
import exceptions.EmailAlreadyExistException;
import java.io.IOException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class CustomerRegistrationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Generate 13-digit consumer ID
            long consumerId = new Random().nextLong() % 10000000000000L;
            if (consumerId < 0) consumerId = -consumerId;
            
            // Get parameters from request
            int billNumber = Integer.parseInt(request.getParameter("billNumber"));
            String title = request.getParameter("title");
            String customerName = request.getParameter("customerName");
            String email = request.getParameter("email");
            String mobileNumber = request.getParameter("countryCode") + "-" + request.getParameter("mobileNumber");
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Create customer object
            Customer customer = new Customer(consumerId, billNumber, title, customerName, 
                                           email, mobileNumber, userId, password, confirmPassword);
            
            // Register customer
            CustomerDAO customerDAO = new CustomerDAO();
            customerDAO.registerCustomer(customer);
            
            // Set attributes for acknowledgment page
            request.setAttribute("consumerId", consumerId);
            request.setAttribute("customerName", customerName);
            request.setAttribute("email", email);
            
            // Forward to acknowledgment page
            request.getRequestDispatcher("/registrationAck.jsp").forward(request, response);
            
        } catch (EmailAlreadyExistException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }
}
