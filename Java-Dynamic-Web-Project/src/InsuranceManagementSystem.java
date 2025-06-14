// InsuranceManagementSystem.java
/*package com.insurance;

import com.insurance.service.*;
import com.insurance.dao.*;
import com.insurance.model.Complaint;
import com.insurance.utils.DatabaseUtility;
import java.util.Scanner;

public class InsuranceManagementSystem {
    private static Scanner scanner = new Scanner(System.in);
    private static CustomerService customerService = new CustomerService();
    private static PolicyService policyService = new PolicyService();
    private static BillService billService = new BillService();
    private static ComplaintService complaintService = new ComplaintService();
    private static ComplaintDAO complaintDAO = new ComplaintDAO();

    public static void main(String[] args) {
        try {
            DatabaseUtility.initializeDatabase();
            boolean exit = false;
            while (!exit) {
                displayMainMenu();
                int choice = getMenuChoice();
                
                switch (choice) {
                    case 1:
                        policyService.listAllPolicies();
                        break;
                    case 2:
                        customerService.registerCustomer();
                        break;
                    case 3:
                        System.out.println("You have selected the Search Customer Feature (by Email).");
                        customerService.searchCustomerByEmail();
                        break;
                    case 4:
                        customerService.searchCustomerById();
                        break;
                    case 5:
                        customerService.viewCustomersByEmailDomain();
                        break;
                    case 6:
                        System.out.println("Good Bye Administrator!!. Terminating the Program");
                        exit = true;
                        break;
                    case 7:
                        billService.addBill();
                        break;
                    case 8:
                        billService.searchBillByConsumerId();
                        break;
                    case 9:
                        billService.searchBillByBillNumberOrEmail();
                        break;
                    case 10:
                        complaintService.registerComplaint();
                        break;
                    case 11:
                        System.out.println(complaintDAO.getAllComplaints());
                        break;
                    case 12:
                        System.out.print("Enter Complaint ID or Consumer ID: ");
                        String input = scanner.nextLine();
                        Complaint complaint = null;
                        
                        try {
                            int complaintId = Integer.parseInt(input);
                            complaint = complaintDAO.getComplaintById(complaintId, null);
                        } catch (NumberFormatException e) {
                            try {
                                long consumerId = Long.parseLong(input);
                                complaint = complaintDAO.getComplaintById(null, consumerId);
                            } catch (NumberFormatException ex) {
                                System.out.println("Invalid input. Please enter a valid Complaint ID or Consumer ID.");
                            }
                        }
                        
                        if (complaint != null) {
                            System.out.println(complaint);
                        } else {
                            System.out.println("No complaint found with the given ID");
                        }
                        break;

                    default:
                        System.out.println("You have selected an inappropriate option. Kindly select an appropriate option.");
                }
            }
        } catch (Exception e) {
            System.out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }

    private static void displayMainMenu() {
        System.out.println("\n===== Insurance Management System =====");
        System.out.println("1. Policy Listing");
        System.out.println("2. Customer Registration");
        System.out.println("3. Search Customer by Email");
        System.out.println("4. Search Customer by CustomerId");
        System.out.println("5. View Customers by Email Domain");
        System.out.println("6. Exit");
        System.out.println("7. Add Bill Details");
        System.out.println("8. Search Bills by Consumer ID");
        System.out.println("9. Search Bill by Bill Number or Email");
        System.out.println("10. Register Complaint");
        System.out.println("11. Get All Complaints");
        System.out.println("12. Search Complaint by Id");
        System.out.print("Please enter your choice (1-12): ");
    }

    private static int getMenuChoice() {
        while (true) {
            try {
                return Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.print("Invalid input. Please enter a number (1-12): ");
            }
        }
    }
}*/



import service.*;
import dao.*;
import model.Complaint;
import utils.DatabaseUtility;
import java.util.Scanner;
import java.sql.SQLException;

public class InsuranceManagementSystem {
    private static Scanner scanner = new Scanner(System.in);
    private static CustomerService customerService = new CustomerService();
    private static PolicyService policyService = new PolicyService();
    private static BillService billService = new BillService();
    private static ComplaintService complaintService = new ComplaintService();
    private static ComplaintDAO complaintDAO = new ComplaintDAO();

    public static void main(String[] args) {
        try {
            DatabaseUtility.initializeDatabase();
            boolean exit = false;
            while (!exit) {
                displayMainMenu();
                int choice = getMenuChoice();
                
                switch (choice) {
                    case 1:
                        policyService.listAllPolicies();
                        break;
                    case 2:
                        customerService.registerCustomer();
                        break;
                    case 3:
                        System.out.println("You have selected the Search Customer Feature (by Email).");
                        customerService.searchCustomerByEmail();
                        break;
                    case 4:
                        customerService.searchCustomerById();
                        break;
                    case 5:
                        customerService.viewCustomersByEmailDomain();
                        break;
                    case 6:
                        displaySubMenu();
                        int subChoice = getMenuChoice();
                        handleSubMenuChoice(subChoice);
                        break;
                    case 7:
                        System.out.println("Good Bye Administrator!!. Terminating the Program");
                        exit = true;
                        break;
                    default:
                        System.out.println("You have selected an inappropriate option. Kindly select an appropriate option.");
                }
            }
        } catch (Exception e) {
            System.out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }

    private static void displayMainMenu() {
        System.out.println("\n===== Insurance Management System =====");
        System.out.println("1. Policy Listing");
        System.out.println("2. Customer Registration");
        System.out.println("3. Search Customer by Email");
        System.out.println("4. Search Customer by CustomerId");
        System.out.println("5. View Customers by Email Domain");
        System.out.println("6. Other Options");
        System.out.println("7. Exit");
        System.out.print("Please enter your choice (1-7): ");
    }

    private static void displaySubMenu() {
        System.out.println("\n===== Other Options =====");
        System.out.println("1. Add Bill Details");
        System.out.println("2. Search Bills by Consumer ID");
        System.out.println("3. Search Bill by Bill Number or Email");
        System.out.println("4. Register Complaint");
        System.out.println("5. Get All Complaints");
        System.out.println("6. Search Complaint by Id");
        System.out.print("Please enter your choice (1-6): ");
    }

    private static void handleSubMenuChoice(int choice) {
        try {
            switch (choice) {
                case 1:
                    billService.addBill();
                    break;
                case 2:
                    billService.searchBillByConsumerId();
                    break;
                case 3:
                    billService.searchBillByBillNumberOrEmail();
                    break;
                case 4:
                    complaintService.registerComplaint();
                    break;
                case 5:
                    System.out.println(complaintDAO.getAllComplaints());
                    break;
                case 6:
                    System.out.print("Enter Complaint ID or Consumer ID: ");
                    String input = scanner.nextLine();
                    Complaint complaint = null;
                    
                    try {
                        int complaintId = Integer.parseInt(input);
                        complaint = complaintDAO.getComplaintById(complaintId, null);
                    } catch (NumberFormatException e) {
                        try {
                            long consumerId = Long.parseLong(input);
                            complaint = complaintDAO.getComplaintById(null, consumerId);
                        } catch (NumberFormatException ex) {
                            System.out.println("Invalid input. Please enter a valid Complaint ID or Consumer ID.");
                        }
                    }
                    
                    if (complaint != null) {
                        System.out.println(complaint);
                    } else {
                        System.out.println("No complaint found with the given ID");
                    }
                    break;
                default:
                    System.out.println("You have selected an inappropriate option. Kindly select an appropriate option.");
            }
        } catch (SQLException e) {
            System.out.println("A database error occurred: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static int getMenuChoice() {
        while (true) {
            try {
                return Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.print("Invalid input. Please enter a number: ");
            }
        }
    }
}




