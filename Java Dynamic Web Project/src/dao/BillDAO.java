package dao;

import model.Bill;
import utils.DatabaseUtility;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    private Connection conn;

    public void beginTransaction() throws SQLException {
        conn = DatabaseUtility.getConnection();
        conn.setAutoCommit(false);
    }

    public void commitTransaction() throws SQLException {
        if (conn != null) {
            conn.commit();
            conn.setAutoCommit(true);
            conn.close();
        }
    }

    public void rollbackTransaction() throws SQLException {
        if (conn != null) {
            conn.rollback();
            conn.setAutoCommit(true);
            conn.close();
        }
    }

    public void addBill(Bill bill) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO Bill (consumerId, billNumber, dueAmount, payableAmount, status) VALUES (?, ?, ?, ?, ?)");
            
            stmt.setLong(1, bill.getConsumerId());
            stmt.setInt(2, bill.getBillNumber());
            stmt.setDouble(3, bill.getDueAmount());
            stmt.setDouble(4, bill.getPayableAmount());
            stmt.setString(5, bill.getStatus());
            
            stmt.executeUpdate();
        }
    }

    public List<Bill> getBillsByConsumerId(long consumerId) throws SQLException {
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Bill WHERE consumerId = ?");  // Removed the status filter
            stmt.setLong(1, consumerId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("billId"));
                bill.setConsumerId(rs.getLong("consumerId"));
                bill.setBillNumber(rs.getInt("billNumber"));
                bill.setDueAmount(rs.getDouble("dueAmount"));
                bill.setPayableAmount(rs.getDouble("payableAmount"));
                bill.setStatus(rs.getString("status"));
                bills.add(bill);
            }
        }
        return bills;
    }

    public Bill getBillByBillNumber(int billNumber) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Bill WHERE billNumber = ?");
            stmt.setInt(1, billNumber);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("billId"));
                bill.setConsumerId(rs.getLong("consumerId"));
                bill.setBillNumber(rs.getInt("billNumber"));
                bill.setDueAmount(rs.getDouble("dueAmount"));
                bill.setPayableAmount(rs.getDouble("payableAmount"));
                bill.setStatus(rs.getString("status"));
                return bill;
            }
            return null;
        }
    }

    public List<Bill> getBillsByEmail(String email) throws SQLException {
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT b.* FROM Bill b " +
                "JOIN Customer c ON b.consumerId = c.consumerId " +
                "WHERE c.email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("billId"));
                bill.setConsumerId(rs.getLong("consumerId"));
                bill.setBillNumber(rs.getInt("billNumber"));
                bill.setDueAmount(rs.getDouble("dueAmount"));
                bill.setPayableAmount(rs.getDouble("payableAmount"));
                bill.setStatus(rs.getString("status"));
                bills.add(bill);
            }
        }
        return bills;
    }

    public void updateBillStatus(int billId, String status) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Bill SET status = ? WHERE billId = ?");
            stmt.setString(1, status);
            stmt.setInt(2, billId);
            stmt.executeUpdate();
        }
    }

    public boolean billExists(int billId) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM Bill WHERE billId = ?");
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            rs.next();
            return rs.getInt(1) > 0;
        }
    }
    
    public Bill getBillById(int billId) throws SQLException {
        try (Connection conn = DatabaseUtility.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT * FROM Bill WHERE billId = ?");
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("billId"));
                bill.setConsumerId(rs.getLong("consumerId"));
                bill.setBillNumber(rs.getInt("billNumber"));
                bill.setDueAmount(rs.getDouble("dueAmount"));
                bill.setPayableAmount(rs.getDouble("payableAmount"));
                bill.setStatus(rs.getString("status"));
                return bill;
            }
            return null;
        }
    }

}
