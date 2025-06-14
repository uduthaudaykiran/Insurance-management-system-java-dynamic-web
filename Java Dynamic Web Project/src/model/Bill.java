// Bill.java
package model;

import java.sql.Date;

public class Bill {
    private int billId;
    private long consumerId;
    private int billNumber;
    private double dueAmount;
    private double payableAmount;
    private String status; // Added status field

    // Constructors, getters and setters
    public Bill() {}

    public Bill(long consumerId, int billNumber, double dueAmount, double payableAmount, String status) {
        this.consumerId = consumerId;
        this.billNumber = billNumber;
        this.dueAmount = dueAmount;
        this.payableAmount = payableAmount;
        this.status = status;
    }

    // Getters and setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }
    
    public int getBillNumber() { return billNumber; }
    public void setBillNumber(int billNumber) { this.billNumber = billNumber; }
    
    public double getDueAmount() { return dueAmount; }
    public void setDueAmount(double dueAmount) { this.dueAmount = dueAmount; }
    
    public double getPayableAmount() { return payableAmount; }
    public void setPayableAmount(double payableAmount) { this.payableAmount = payableAmount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Bill [billId=" + billId + ", consumerId=" + consumerId + ", billNumber=" + billNumber
                + ", dueAmount=" + dueAmount + ", payableAmount=" + payableAmount + ", status=" + status + "]";
    }
}
