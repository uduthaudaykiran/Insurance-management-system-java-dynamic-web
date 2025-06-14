// CustomerService.java
package service;

import dao.CustomerDAO;
import exceptions.EmailAlreadyExistException;
import exceptions.CustomerNotFoundException;
import model.Customer;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class CustomerService {
    private CustomerDAO customerDAO = new CustomerDAO();
    private Scanner scanner = new Scanner(System.in);

    public void registerCustomer() {
        try {
            System.out.println("\n--- Customer Registration ---");

            System.out.print("Enter Consumer ID (13 digits): ");
            long consumerId = Long.parseLong(scanner.nextLine());
            if (String.valueOf(consumerId).length() != 13) {
                System.out.println("Invalid Consumer ID. It must be a 13-digit number.");
                return;
            }

            System.out.print("Enter Bill Number (5 digits): ");
            int billNumber = Integer.parseInt(scanner.nextLine());
            if (String.valueOf(billNumber).length() != 5) {
                System.out.println("Invalid Bill Number. It must be a 5-digit number.");
                return;
            }

            System.out.print("Enter Title (Mr/Mrs/Ms): ");
            String title = scanner.nextLine();
            if (!title.matches("Mr|Mrs|Ms")) {
                System.out.println("Invalid Title. It must be one of Mr, Mrs, or Ms.");
                return;
            }

            System.out.print("Enter Customer Name: ");
            String customerName = scanner.nextLine();
            if (customerName.isEmpty()) {
                System.out.println("Customer Name cannot be empty.");
                return;
            }

            System.out.print("Enter Email: ");
            String email = scanner.nextLine();
            if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                System.out.println("Invalid Email format.");
                return;
            }

            System.out.print("Enter Mobile Number: ");
            String mobileNumber = scanner.nextLine();
            if (!mobileNumber.matches("\\d{10}")) {
                System.out.println("Invalid Mobile Number. It must be a 10-digit number.");
                return;
            }

            System.out.print("Enter User ID (5-20 chars): ");
            String userId = scanner.nextLine();
            if (userId.length() < 5 || userId.length() > 20) {
                System.out.println("Invalid User ID. It must be between 5 and 20 characters.");
                return;
            }

            System.out.print("Enter Password: ");
            String password = scanner.nextLine();
            if (password.isEmpty()) {
                System.out.println("Password cannot be empty.");
                return;
            }

            System.out.print("Confirm Password: ");
            String confirmPassword = scanner.nextLine();
            if (!password.equals(confirmPassword)) {
                System.out.println("Password and Confirm Password do not match!");
                return;
            }

            Customer customer = new Customer(consumerId, billNumber, title, customerName, 
                                             email, mobileNumber, userId, password, confirmPassword);
            customerDAO.registerCustomer(customer);
            System.out.println("Customer registered successfully.");
        } catch (NumberFormatException e) {
            System.out.println("Invalid number format. Please enter valid numbers for ID and Bill Number.");
        } catch (EmailAlreadyExistException e) {
            System.out.println("Error: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public void searchCustomerById() {
        try {
            System.out.print("\nEnter Customer ID to search: ");
            long consumerId = Long.parseLong(scanner.nextLine());
            if (consumerId <= 0) {
                System.out.println("Invalid Customer ID. It must be a positive number.");
                return;
            }

            Customer customer = customerDAO.getCustomerById(consumerId);
            if (customer != null) {
                System.out.println("\nCustomer Details:");
                System.out.println("Consumer ID: " + customer.getConsumerId());
                System.out.println("Name: " + customer.getTitle() + " " + customer.getCustomerName());
                System.out.println("Email: " + customer.getEmail());
                System.out.println("Mobile: " + customer.getMobileNumber());
                System.out.println("User ID: " + customer.getUserId());
            } else {
                System.out.println("No Such Customer Exist with the Given Customer Id.");
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid Customer ID format. Please enter a valid number.");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public void viewCustomersByEmailDomain() {
        try {
            System.out.print("\nEnter Email Domain (e.g., gmail, yahoo): ");
            String domain = scanner.nextLine();
            if (domain.isEmpty()) {
                System.out.println("Email Domain cannot be empty.");
                return;
            }

            List<Customer> customers = customerDAO.getCustomersByEmailDomain(domain);
            if (customers.isEmpty()) {
                throw new CustomerNotFoundException("No such customer is registered with " + domain);
            }

            System.out.println("\nCustomers with @" + domain + " domain:");
            System.out.println("CustomerID\tCustomerName\tCustomerEmail");
            for (Customer customer : customers) {
                System.out.println(customer.getConsumerId() + "\t" + 
                                   customer.getCustomerName() + "\t" + 
                                   customer.getEmail());
            }
        } catch (CustomerNotFoundException e) {
            System.out.println(e.getMessage());
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public void searchCustomerByEmail() {
        try {
            System.out.print("\nEnter Customer Email: ");
            String email = scanner.nextLine();
            if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
                System.out.println("Invalid Email format.");
                return;
            }

            Customer customer = customerDAO.getCustomerByEmail(email);
            if (customer == null) {
                throw new CustomerNotFoundException("No customer found with email: " + email);
            }

            System.out.println("\nCustomer Details:");
            System.out.println("CustomerID: " + customer.getConsumerId());
            System.out.println("CustomerName: " + customer.getCustomerName());
            System.out.println("CustomerEmail: " + customer.getEmail());
            System.out.println("MobileNumber: " + customer.getMobileNumber());
            System.out.println("UserID: " + customer.getUserId());
            // Add other details as needed
        } catch (CustomerNotFoundException e) {
            System.out.println(e.getMessage());
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
