// Customer.java
package model;

public class Customer {
    private long consumerId;
    private int billNumber;
    private String title;
    private String customerName;
    private String email;
    private String mobileNumber;
    private String userId;
    private String password;
    private String confirmPassword;

    // Constructors, getters and setters
    public Customer() {}

    public Customer(long consumerId, int billNumber, String title, String customerName, 
                   String email, String mobileNumber, String userId, 
                   String password, String confirmPassword) {
        this.consumerId = consumerId;
        this.billNumber = billNumber;
        this.title = title;
        this.customerName = customerName;
        this.email = email;
        this.mobileNumber = mobileNumber;
        this.userId = userId;
        this.password = password;
        this.confirmPassword = confirmPassword;
    }

    // Getters and setters for all fields
    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }
    
    public int getBillNumber() { return billNumber; }
    public void setBillNumber(int billNumber) { this.billNumber = billNumber; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }

    @Override
    public String toString() {
        return "Customer [consumerId=" + consumerId + ", billNumber=" + billNumber + ", title=" + title
                + ", customerName=" + customerName + ", email=" + email + ", mobileNumber=" + mobileNumber
                + ", userId=" + userId + "]";
    }
}