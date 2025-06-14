// Policy.java
package model;

public class Policy {
    private int policyId;
    private String policyType;
    private String policyTitle;
    private double sumAssured;
    private double premium;
    private int term;

    // Constructors, getters and setters
    public Policy() {}

    public Policy(String policyType, String policyTitle, double sumAssured, double premium, int term) {
        this.policyType = policyType;
        this.policyTitle = policyTitle;
        this.sumAssured = sumAssured;
        this.premium = premium;
        this.term = term;
    }

    // Getters and setters
    public int getPolicyId() { return policyId; }
    public void setPolicyId(int policyId) { this.policyId = policyId; }
    
    public String getPolicyType() { return policyType; }
    public void setPolicyType(String policyType) { this.policyType = policyType; }
    
    public String getPolicyTitle() { return policyTitle; }
    public void setPolicyTitle(String policyTitle) { this.policyTitle = policyTitle; }
    
    public double getSumAssured() { return sumAssured; }
    public void setSumAssured(double sumAssured) { this.sumAssured = sumAssured; }
    
    public double getPremium() { return premium; }
    public void setPremium(double premium) { this.premium = premium; }
    
    public int getTerm() { return term; }
    public void setTerm(int term) { this.term = term; }

    @Override
    public String toString() {
        return "Policy [policyId=" + policyId + ", policyType=" + policyType + ", policyTitle=" + policyTitle
                + ", sumAssured=" + sumAssured + ", premium=" + premium + ", term=" + term + "]";
    }
}