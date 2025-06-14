// PolicyDAO.java
package dao;

import model.Policy;
import utils.DatabaseUtility;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PolicyDAO {
    public List<Policy> getAllPolicies() throws SQLException {
        List<Policy> policies = new ArrayList<>();
        try (Connection conn = DatabaseUtility.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Policy");
            
            while (rs.next()) {
                Policy policy = new Policy();
                policy.setPolicyId(rs.getInt("policyId"));
                policy.setPolicyType(rs.getString("policyType"));
                policy.setPolicyTitle(rs.getString("policyTitle"));
                policy.setSumAssured(rs.getDouble("sumAssured"));
                policy.setPremium(rs.getDouble("premium"));
                policy.setTerm(rs.getInt("term"));
                policies.add(policy);
            }
        }
        return policies;
    }
}