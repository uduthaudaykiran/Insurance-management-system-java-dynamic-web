// ComplaintService.java

package service;

import dao.ComplaintDAO;
import model.Complaint;
import java.sql.SQLException;
import java.util.Scanner;

public class ComplaintService {
    private ComplaintDAO complaintDAO = new ComplaintDAO();
    private Scanner scanner = new Scanner(System.in);

    public void registerComplaint() {
        try {
            System.out.println("\n--- Register Complaint ---");

            System.out.print("Enter Consumer Number: ");
            long consumerId = Long.parseLong(scanner.nextLine());
            if (consumerId <= 0) {
                System.out.println("Invalid Consumer Number. It must be a positive number.");
                return;
            }

            System.out.print("Enter Complaint Type: ");
            String complaintType = scanner.nextLine();
            if (complaintType.isEmpty()) {
                System.out.println("Complaint Type cannot be empty.");
                return;
            }

            System.out.print("Enter Category: ");
            String category = scanner.nextLine();
            if (category.isEmpty()) {
                System.out.println("Category cannot be empty.");
                return;
            }

            System.out.print("Enter Landmark: ");
            String landMark = scanner.nextLine();
            if (landMark.isEmpty()) {
                System.out.println("Landmark cannot be empty.");
                return;
            }

            System.out.print("Enter Customer Name: ");
            String customerName = scanner.nextLine();
            if (customerName.isEmpty()) {
                System.out.println("Customer Name cannot be empty.");
                return;
            }

            System.out.print("Enter Problem Description: ");
            String problem = scanner.nextLine();
            if (problem.isEmpty()) {
                System.out.println("Problem Description cannot be empty.");
                return;
            }

            System.out.print("Enter Address: ");
            String address = scanner.nextLine();
            if (address.isEmpty()) {
                System.out.println("Address cannot be empty.");
                return;
            }

            System.out.print("Enter Mobile Number: ");
            String mobileNumber = scanner.nextLine();
            if (!mobileNumber.matches("\\d{10}")) {
                System.out.println("Invalid Mobile Number. It must be a 10-digit number.");
                return;
            }

            Complaint complaint = new Complaint(consumerId, complaintType, category, landMark, 
                                                customerName, problem, address, mobileNumber);
            complaintDAO.registerComplaint(complaint);
            System.out.println("Complaint registered successfully.");
        } catch (NumberFormatException e) {
            System.out.println("Invalid Consumer Number format. Please enter a valid number.");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    // Close the scanner when the service is no longer needed
    public void closeScanner() {
        if (scanner != null) {
            scanner.close();
        }
    }
}
