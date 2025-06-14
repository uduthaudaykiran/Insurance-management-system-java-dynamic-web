// CustomerDAO.java
package dao;

import model.Customer;
import exceptions.EmailAlreadyExistException;
import utils.DatabaseUtility;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {
    public void registerCustomer(Customer customer) throws EmailAlreadyExistException, SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            // Check if email already exists
            PreparedStatement checkStmt = conn.prepareStatement("SELECT email FROM Customer WHERE email = ?");
            checkStmt.setString(1, customer.getEmail());
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                throw new EmailAlreadyExistException("Customer with the mentioned Email already registered.");
            }
            
            // Insert new customer
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO Customer (consumerId, billNumber, title, customerName, email, " +
                "mobileNumber, userId, password, confirmPassword) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            
            stmt.setLong(1, customer.getConsumerId());
            stmt.setInt(2, customer.getBillNumber());
            stmt.setString(3, customer.getTitle());
            stmt.setString(4, customer.getCustomerName());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getMobileNumber());
            stmt.setString(7, customer.getUserId());
            stmt.setString(8, customer.getPassword());
            stmt.setString(9, customer.getConfirmPassword());
            
            stmt.executeUpdate();
            System.out.println("Customer Registration is successful");
        }
    }

    public Customer getCustomerById(long consumerId) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Customer WHERE consumerId = ?");
            stmt.setLong(1, consumerId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Customer(
                    rs.getLong("consumerId"),
                    rs.getInt("billNumber"),
                    rs.getString("title"),
                    rs.getString("customerName"),
                    rs.getString("email"),
                    rs.getString("mobileNumber"),
                    rs.getString("userId"),
                    rs.getString("password"),
                    rs.getString("confirmPassword")
                );
            }
            return null;
        }
    }

    public List<Customer> getCustomersByEmailDomain(String domain) throws SQLException {
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Customer WHERE email LIKE ? ORDER BY consumerId ASC");
            stmt.setString(1, "%@" + domain);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                customers.add(new Customer(
                    rs.getLong("consumerId"),
                    rs.getInt("billNumber"),
                    rs.getString("title"),
                    rs.getString("customerName"),
                    rs.getString("email"),
                    rs.getString("mobileNumber"),
                    rs.getString("userId"),
                    rs.getString("password"),
                    rs.getString("confirmPassword")
                ));
            }
        }
        return customers;
    }
    
    public Customer getUserId(String userId) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Customer WHERE userId = ?");
            stmt.setString(1,userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Customer(
                    rs.getLong("consumerId"),
                    rs.getInt("billNumber"),
                    rs.getString("title"),
                    rs.getString("customerName"),
                    rs.getString("email"),
                    rs.getString("mobileNumber"),
                    rs.getString("userId"),
                    rs.getString("password"),
                    rs.getString("confirmPassword")
                );
            }
            return null;
        }
    }

    
    public Customer getCustomerByEmail(String email) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Customer WHERE email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new Customer(
                    rs.getLong("consumerId"),
                    rs.getInt("billNumber"),
                    rs.getString("title"),
                    rs.getString("customerName"),
                    rs.getString("email"),
                    rs.getString("mobileNumber"),
                    rs.getString("userId"),
                    rs.getString("password"),
                    rs.getString("confirmPassword")
                );
            }
            return null;
        }
    }
}