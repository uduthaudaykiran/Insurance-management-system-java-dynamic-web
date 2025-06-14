// DatabaseUtility.java
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtility {
    private static final String DB_URL = "jdbc:derby://localhost:1527/sample;create=true";
    private static final String USER = "user";
    private static final String PASS = "123";

    public static Connection getConnection() throws SQLException {
    	try {
			Class.forName("org.apache.derby.jdbc.ClientDriver");
		} catch (ClassNotFoundException e) {
			throw new SQLException("No JDBC for Berby found",e);
		}
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }

    public static void initializeDatabase() {
        try (Connection conn = getConnection()) {
            // Create Customer table
            conn.createStatement().execute(
                "CREATE TABLE Customer (" +
                "consumerId BIGINT PRIMARY KEY, " +
                "billNumber INTEGER, " +
                "title VARCHAR(10), " +
                "customerName VARCHAR(50), " +
                "email VARCHAR(100) UNIQUE, " +
                "mobileNumber VARCHAR(15), " +
                "userId VARCHAR(20), " +
                "password VARCHAR(30), " +
                "confirmPassword VARCHAR(30))"
            );

            // Create Policy table
            conn.createStatement().execute(
                "CREATE TABLE Policy (" +
                "policyId INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, " +
                "policyType VARCHAR(20), " +
                "policyTitle VARCHAR(20), " +
                "sumAssured DECIMAL(15,2), " +
                "premium DECIMAL(10,2), " +
                "term INTEGER)"
            );

            // Create Bill table
            conn.createStatement().execute(
                "CREATE TABLE Bill (" +
                "billId INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, " +
                "consumerId BIGINT, " +
                "billNumber INTEGER, " +
                "dueAmount DECIMAL(10,2), " +
                "payableAmount DECIMAL(10,2), " +
                "status VARCHAR(20) DEFAULT 'PENDING', " +  // Added status column 
                "FOREIGN KEY (consumerId) REFERENCES Customer(consumerId))"
            );

            // Create Complaint table
            conn.createStatement().execute(
                "CREATE TABLE Complaint (" +
                "complaintId INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY, " +
                "consumerId BIGINT, " +
                "complaintType VARCHAR(50), " +
                "category VARCHAR(50), " +
                "landMark VARCHAR(100), " +
                "customerName VARCHAR(50), " +
                "problem VARCHAR(200), " +
                "address VARCHAR(200), " +
                "mobileNumber VARCHAR(15), " +
                "status VARCHAR(20) DEFAULT 'OPEN', " +  // Added status column
                "FOREIGN KEY (consumerId) REFERENCES Customer(consumerId))"
            );

            // Insert sample policies
            conn.createStatement().execute(
                "INSERT INTO Policy (policyType, policyTitle, sumAssured, premium, term) VALUES " +
                "('GeneralInsurance', 'BimaGold', 500000.00, 12000.00, 5), " +
                "('HealthInsurance', 'Janand', 300000.00, 8000.00, 3), " +
                "('MotorInsurance', 'Vridhdhi', 200000.00, 5000.00, 2), " +
                "('GeneralInsurance', 'ChildCareer', 400000.00, 10000.00, 10), " +
                "('HealthInsurance', 'Floater', 600000.00, 15000.00, 5), " +
                "('MotorInsurance', 'Conventional', 250000.00, 6000.00, 3)"
            );

            System.out.println("Database tables created and sample data inserted successfully.");
        } catch (SQLException e) {
            if (e.getSQLState().equals("X0Y32")) {
                System.out.println("Database already exists.");
            } else {
                e.printStackTrace();
            }
        }
    }
}
