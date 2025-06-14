// Consumer.java
package model;

public class Consumer {
    private long consumerId;
    private String customerName;
    private String mobileNumber;
    private String address;

    // Constructors, getters and setters
    public Consumer() {}

    public Consumer(long consumerId, String customerName, String mobileNumber, String address) {
        this.consumerId = consumerId;
        this.customerName = customerName;
        this.mobileNumber = mobileNumber;
        this.address = address;
    }

    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}