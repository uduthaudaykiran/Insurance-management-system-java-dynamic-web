// Complaint.java
package model;

public class Complaint {
    private int complaintId;
    private long consumerId;
    private String complaintType;
    private String category;
    private String landMark;
    private String customerName;
    private String problem;
    private String address;
    private String mobileNumber;
    private String status; // Added status field

    // Constructors, getters and setters
    public Complaint() {}

    public Complaint(long consumerId, String complaintType, String category, String landMark, 
                     String customerName, String problem, String address, String mobileNumber) {
        this.consumerId = consumerId;
        this.complaintType = complaintType;
        this.category = category;
        this.landMark = landMark;
        this.customerName = customerName;
        this.problem = problem;
        this.address = address;
        this.mobileNumber = mobileNumber;
        this.status = "OPEN"; // Default status
    }

    // Getters and setters
    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }
    
    public long getConsumerId() { return consumerId; }
    public void setConsumerId(long consumerId) { this.consumerId = consumerId; }
    
    public String getComplaintType() { return complaintType; }
    public void setComplaintType(String complaintType) { this.complaintType = complaintType; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getLandMark() { return landMark; }
    public void setLandMark(String landMark) { this.landMark = landMark; }
    
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    
    public String getProblem() { return problem; }
    public void setProblem(String problem) { this.problem = problem; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Complaint [complaintId=" + complaintId + ", consumerId=" + consumerId + ", complaintType="
                + complaintType + ", category=" + category + ", landMark=" + landMark + ", customerName="
                + customerName + ", problem=" + problem + ", address=" + address + ", mobileNumber="
                + mobileNumber + ", status=" + status + "]";
    }
}
