// ComplaintServlet.java
package web;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.ComplaintDAO;
import model.Complaint;
import model.Customer;

@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String complaintType = request.getParameter("complaintType");
        String category = request.getParameter("category");
        String contactPerson = request.getParameter("contactPerson");
        String landMark = request.getParameter("landMark");
        String problem = request.getParameter("problem");
        String mobileNumber = request.getParameter("mobileNumber");
        String address = request.getParameter("address");

        // Validation
        if (complaintType == null || complaintType.isEmpty() ||
            category == null || category.isEmpty() ||
            contactPerson == null || contactPerson.isEmpty() ||
            landMark == null || landMark.isEmpty() ||
            problem == null || problem.isEmpty() ||
            mobileNumber == null || !mobileNumber.matches("\\d{10}") ||
            address == null || address.isEmpty()) {
            
            request.setAttribute("error", "Please fill all fields correctly");
            request.getRequestDispatcher("registerComplaint.jsp").forward(request, response);
            return;
        }

        Complaint complaint = new Complaint();
        complaint.setConsumerId(customer.getConsumerId());
        complaint.setComplaintType(complaintType);
        complaint.setCategory(category);
        complaint.setCustomerName(contactPerson);
        complaint.setLandMark(landMark);
        complaint.setProblem(problem);
        complaint.setMobileNumber(mobileNumber);
        complaint.setAddress(address);
        complaint.setStatus("OPEN");

        try {
            int complaintId = complaintDAO.registerComplaint(complaint);
            complaint.setComplaintId(complaintId); // Set the generated ID
            
            request.setAttribute("complaintId", complaintId);
            request.getRequestDispatcher("complaintAck.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error registering complaint");
            request.getRequestDispatcher("registerComplaint.jsp").forward(request, response);
        }
    }
}