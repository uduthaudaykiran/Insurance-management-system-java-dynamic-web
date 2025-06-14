// BillService.java
package service;

import dao.BillDAO;
import model.Bill;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class BillService {
    private BillDAO billDAO = new BillDAO();
    private Scanner scanner = new Scanner(System.in);

    public void addBill() {
        try {
            System.out.println("\n--- Add Bill Details ---");

            System.out.print("Enter Consumer ID: ");
            long consumerId = Long.parseLong(scanner.nextLine());
            if (consumerId <= 0) {
                System.out.println("Invalid Consumer ID. It must be a positive number.");
                return;
            }

            System.out.print("Enter Bill Number: ");
            int billNumber = Integer.parseInt(scanner.nextLine());
            if (billNumber <= 0) {
                System.out.println("Invalid Bill Number. It must be a positive number.");
                return;
            }

            System.out.print("Enter Due Amount: ");
            double dueAmount = Double.parseDouble(scanner.nextLine());
            if (dueAmount < 0) {
                System.out.println("Invalid Due Amount. It cannot be negative.");
                return;
            }

            System.out.print("Enter Payable Amount: ");
            double payableAmount = Double.parseDouble(scanner.nextLine());
            if (payableAmount < 0) {
                System.out.println("Invalid Payable Amount. It cannot be negative.");
                return;
            }

            System.out.print("Enter Status (PENDING/PAID/OVERDUE): ");
            String status = scanner.nextLine().toUpperCase();

            Bill bill = new Bill(consumerId, billNumber, dueAmount, payableAmount, status);
            billDAO.addBill(bill);
            System.out.println("Bill added successfully.");
        } catch (NumberFormatException e) {
            System.out.println("Invalid number format. Please enter valid numbers.");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

   /* public void searchBillByConsumerId() {
        try {
            System.out.print("\nEnter Consumer ID to search bills: ");
            long consumerId = Long.parseLong(scanner.nextLine());
            if (consumerId <= 0) {
                System.out.println("Invalid Consumer ID. It must be a positive number.");
                return;
            }

            List<Bill> bills = billDAO.getBillsByConsumerId(consumerId);
            if (bills.isEmpty()) {
                System.out.println("No bills found for this consumer ID.");
                return;
            }

            System.out.println("\nBills for Consumer ID: " + consumerId);
            System.out.println("BillID\tBillNo\tDue Amount\tPayable Amount\tStatus");
            for (Bill bill : bills) {
                System.out.printf("%d\t%d\t%.2f\t%.2f\t%s\t%s\n",
                        bill.getBillId(),
                        bill.getBillNumber(),
                        bill.getDueAmount(),
                        bill.getPayableAmount(),
                        bill.getStatus()
                );
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid Consumer ID format. Please enter a valid number.");
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }*/
    

        public List<Bill> searchBillByConsumerId(long consumerId) throws SQLException {
            return billDAO.getBillsByConsumerId(consumerId);
        }

        public void searchBillByConsumerId() {
            try {
                System.out.print("\nEnter Consumer ID to search bills: ");
                long consumerId = Long.parseLong(scanner.nextLine());
                if (consumerId <= 0) {
                    System.out.println("Invalid Consumer ID. It must be a positive number.");
                    return;
                }

                List<Bill> bills = billDAO.getBillsByConsumerId(consumerId);
                if (bills.isEmpty()) {
                    System.out.println("No bills found for this consumer ID.");
                    return;
                }

                System.out.println("\nBills for Consumer ID: " + consumerId);
                System.out.println("BillID\tBillNo\tDue Amount\tPayable Amount\tStatus");
                for (Bill bill : bills) {
                    System.out.printf("%d\t%d\t%.2f\t%.2f\t%s\n",
                            bill.getBillId(),
                            bill.getBillNumber(),
                            bill.getDueAmount(),
                            bill.getPayableAmount(),
                            bill.getStatus()
                    );
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid Consumer ID format. Please enter a valid number.");
            } catch (SQLException e) {
                System.out.println("Database error: " + e.getMessage());
            }
        }
    
    

    public void searchBillByBillNumberOrEmail() {
        try {
            System.out.print("\nEnter Bill Number or Email to search: ");
            String input = scanner.nextLine();

            List<Bill> bills = new ArrayList<>();
            try {
                int billNumber = Integer.parseInt(input);
                if (billNumber <= 0) {
                    System.out.println("Invalid Bill Number. It must be a positive number.");
                    return;
                }
                Bill bill = billDAO.getBillByBillNumber(billNumber);
                if (bill != null) {
                    bills.add(bill);
                }
            } catch (NumberFormatException e) {
                bills = billDAO.getBillsByEmail(input);
            }

            if (!bills.isEmpty()) {
                System.out.println("\nBill Details:");
                for (Bill bill : bills) {
                    System.out.println("Bill ID: " + bill.getBillId());
                    System.out.println("Consumer ID: " + bill.getConsumerId());
                    System.out.println("Bill Number: " + bill.getBillNumber());
                    System.out.println("Due Amount: " + bill.getDueAmount());
                    System.out.println("Payable Amount: " + bill.getPayableAmount());
                    System.out.println("Status: " + bill.getStatus());
                    System.out.println("-------------------------");
                }
            } else {
                System.out.println("No bill found with this bill number or email.");
            }
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
    }

    public void closeScanner() {
        if (scanner != null) {
            scanner.close();
        }
    }
}
