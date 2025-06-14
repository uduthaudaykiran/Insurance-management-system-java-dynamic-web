// PolicyService.java
package service;

import dao.PolicyDAO;
import model.Policy;
import java.sql.SQLException;
import java.util.List;

public class PolicyService {
    private PolicyDAO policyDAO = new PolicyDAO();

    public void listAllPolicies() {
        try {
            List<Policy> policies = policyDAO.getAllPolicies();
            System.out.println("\n--- List of Available Policies ---");
            System.out.println("ID\tType\t\tTitle\t\tSum Assured\tPremium\tTerm");
            for (Policy policy : policies) {
                System.out.printf("%d\t%-15s\t%-10s\t%,.2f\t%,.2f\t%d\n",
                    policy.getPolicyId(),
                    policy.getPolicyType(),
                    policy.getPolicyTitle(),
                    policy.getSumAssured(),
                    policy.getPremium(),
                    policy.getTerm());
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving policies: " + e.getMessage());
        }
    }
}
