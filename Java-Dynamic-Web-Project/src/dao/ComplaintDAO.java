// ComplaintDAO.java
package dao;

import model.Complaint;
import utils.DatabaseUtility;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComplaintDAO {
	public int registerComplaint(Complaint complaint) throws SQLException {
	    String sql = "INSERT INTO Complaint (consumerId, complaintType, category, landMark, " +
	                 "customerName, problem, address, mobileNumber, status) " +
	                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    
	    try (Connection conn = DatabaseUtility.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
	        
	        stmt.setLong(1, complaint.getConsumerId());
	        stmt.setString(2, complaint.getComplaintType());
	        stmt.setString(3, complaint.getCategory());
	        stmt.setString(4, complaint.getLandMark());
	        stmt.setString(5, complaint.getCustomerName());
	        stmt.setString(6, complaint.getProblem());
	        stmt.setString(7, complaint.getAddress());
	        stmt.setString(8, complaint.getMobileNumber());
	        stmt.setString(9, complaint.getStatus());
	        
	        int affectedRows = stmt.executeUpdate();
	        
	        if (affectedRows == 0) {
	            throw new SQLException("Creating complaint failed, no rows affected.");
	        }
	        
	        try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                return generatedKeys.getInt(1); // Return the generated ID
	            } else {
	                throw new SQLException("Creating complaint failed, no ID obtained.");
	            }
	        }
	    }
	}

    public Complaint getComplaintById(Integer complaintId, Long consumerId) throws SQLException {
        Complaint complaint = null;
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt;
            if (complaintId != null) {
                stmt = conn.prepareStatement("SELECT * FROM Complaint WHERE complaintId = ?");
                stmt.setInt(1, complaintId);
            } else if (consumerId != null) {
                stmt = conn.prepareStatement("SELECT * FROM Complaint WHERE consumerId = ?");
                stmt.setLong(1, consumerId);
            } else {
                throw new IllegalArgumentException("Either complaintId or consumerId must be provided");
            }
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaintId"));
                complaint.setConsumerId(rs.getLong("consumerId"));
                complaint.setComplaintType(rs.getString("complaintType"));
                complaint.setCategory(rs.getString("category"));
                complaint.setLandMark(rs.getString("landMark"));
                complaint.setCustomerName(rs.getString("customerName"));
                complaint.setProblem(rs.getString("problem"));
                complaint.setAddress(rs.getString("address"));
                complaint.setMobileNumber(rs.getString("mobileNumber"));
                complaint.setStatus(rs.getString("status")); // Added status
            }
        }
        return complaint;
    }

    public List<Complaint> getAllComplaints() throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Complaint");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaintId"));
                complaint.setConsumerId(rs.getLong("consumerId"));
                complaint.setComplaintType(rs.getString("complaintType"));
                complaint.setCategory(rs.getString("category"));
                complaint.setLandMark(rs.getString("landMark"));
                complaint.setCustomerName(rs.getString("customerName"));
                complaint.setProblem(rs.getString("problem"));
                complaint.setAddress(rs.getString("address"));
                complaint.setMobileNumber(rs.getString("mobileNumber"));
                complaint.setStatus(rs.getString("status")); // Added status
                complaints.add(complaint);
            }
        }
        return complaints;
    }

    public List<Complaint> getComplaintsByConsumerId(Long consumerId) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Complaint WHERE consumerId = ?");
            stmt.setLong(1, consumerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaintId"));
                complaint.setConsumerId(rs.getLong("consumerId"));
                complaint.setComplaintType(rs.getString("complaintType"));
                complaint.setCategory(rs.getString("category"));
                complaint.setLandMark(rs.getString("landMark"));
                complaint.setCustomerName(rs.getString("customerName"));
                complaint.setProblem(rs.getString("problem"));
                complaint.setAddress(rs.getString("address"));
                complaint.setMobileNumber(rs.getString("mobileNumber"));
                complaint.setStatus(rs.getString("status")); // Include status
                complaints.add(complaint);
            }
        }
        return complaints;
    }

 // Add these to ComplaintDAO.java
    public int getComplaintCountByStatus(String status) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM Complaint WHERE status = ?");
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    public List<Complaint> getRecentComplaintsByConsumerId(long consumerId, int limit) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Complaint WHERE consumerId = ? ORDER BY complaintId DESC FETCH FIRST ? ROWS ONLY");
            stmt.setLong(1, consumerId);
            stmt.setInt(2, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaintId"));
                complaint.setConsumerId(rs.getLong("consumerId"));
                complaint.setComplaintType(rs.getString("complaintType"));
                complaint.setCategory(rs.getString("category"));
                complaint.setStatus(rs.getString("status"));
                complaints.add(complaint);
            }
        }
        return complaints;
    }
    
    public Complaint getLatestComplaintByConsumerId(long consumerId) throws SQLException {
        Complaint complaint = null;
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Complaint WHERE consumerId = ? ORDER BY complaintId DESC LIMIT 1");
            stmt.setLong(1, consumerId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaintId"));
                complaint.setConsumerId(rs.getLong("consumerId"));
                complaint.setComplaintType(rs.getString("complaintType"));
                complaint.setCategory(rs.getString("category"));
                complaint.setLandMark(rs.getString("landMark"));
                complaint.setCustomerName(rs.getString("customerName"));
                complaint.setProblem(rs.getString("problem"));
                complaint.setAddress(rs.getString("address"));
                complaint.setMobileNumber(rs.getString("mobileNumber"));
                complaint.setStatus(rs.getString("status"));
            }
        }
        return complaint;
    }

    public List<Complaint> getComplaintsByStatus(String status) throws SQLException {
        List<Complaint> complaints = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Complaint WHERE status = ?");
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Complaint complaint = new Complaint();
                complaint.setComplaintId(rs.getInt("complaintId"));
                complaint.setConsumerId(rs.getLong("consumerId"));
                complaint.setComplaintType(rs.getString("complaintType"));
                complaint.setCategory(rs.getString("category"));
                complaint.setLandMark(rs.getString("landMark"));
                complaint.setCustomerName(rs.getString("customerName"));
                complaint.setProblem(rs.getString("problem"));
                complaint.setAddress(rs.getString("address"));
                complaint.setMobileNumber(rs.getString("mobileNumber"));
                complaint.setStatus(rs.getString("status"));
                complaints.add(complaint);
            }
        }
        return complaints;
    }
    
    public boolean updateComplaintStatus(int complaintId, String status) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Complaint SET status = ? WHERE complaintId = ?");
            stmt.setString(1, status);
            stmt.setInt(2, complaintId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}

