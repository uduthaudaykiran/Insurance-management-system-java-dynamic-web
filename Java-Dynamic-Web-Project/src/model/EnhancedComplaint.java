// EnhancedComplaint.java
package model;

public class EnhancedComplaint extends Consumer {
    private int complaintId;
    private String complaintType;
    private String category;
    private String landMark;
    private String problem;
    private String status; 

    // Constructors
    public EnhancedComplaint() {}

    public EnhancedComplaint(long consumerId, String customerName, String mobileNumber, String address,
                           String complaintType, String category, String landMark, String problem, String status) {
        super(consumerId, customerName, mobileNumber, address);
        this.complaintType = complaintType;
        this.category = category;
        this.landMark = landMark;
        this.problem = problem;
        this.status=status;
    }

    // Getters and setters for complaint-specific fields
    public int getComplaintId() { return complaintId; }
    public void setComplaintId(int complaintId) { this.complaintId = complaintId; }
    
    public String getComplaintType() { return complaintType; }
    public void setComplaintType(String complaintType) { this.complaintType = complaintType; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getLandMark() { return landMark; }
    public void setLandMark(String landMark) { this.landMark = landMark; }
    
    public String getProblem() { return problem; }
    public void setProblem(String problem) { this.problem = problem; }

    public String getStatus() {
    return status;
    }

    public void setStatus(String status) {
    this.status = status;
    }

    @Override
    public String toString() {
        return "EnhancedComplaint [complaintId=" + complaintId + ", complaintType=" + complaintType
                + ", category=" + category + ", landMark=" + landMark + ", problem=" + problem
                + ", consumerId=" + getConsumerId() + ", customerName=" + getCustomerName()
                + ", mobileNumber=" + getMobileNumber() + ", address=" + getAddress() + ", status=" + status
                + "]";
    }
}