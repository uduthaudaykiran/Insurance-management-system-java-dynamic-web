// ThreadedBillService.java

package service;

import thread.BillGenerationThread;
import java.util.Scanner;

public class ThreadedBillService {
    private Scanner scanner = new Scanner(System.in);

    public void generateBillsConcurrently() {
        System.out.println("\n--- Concurrent Bill Generation ---");
        System.out.println("Enter consumer IDs separated by commas (e.g., 123,456,789): ");
        String input = scanner.nextLine();
        
        if (input.isEmpty()) {
            System.out.println("Input cannot be empty. Please enter valid consumer IDs.");
            return;
        }

        String[] consumerIds = input.split(",");
        for (String idStr : consumerIds) {
            try {
                long consumerId = Long.parseLong(idStr.trim());
                if (consumerId <= 0) {
                    System.out.println("Invalid consumer ID: " + idStr + ". It must be a positive number.");
                    continue;
                }
                BillGenerationThread thread = new BillGenerationThread(consumerId);
                thread.start();
            } catch (NumberFormatException e) {
                System.out.println("Invalid consumer ID format: " + idStr + ". Please enter valid numbers.");
            }
        }
    }

    // Close the scanner when the service is no longer needed
    public void closeScanner() {
        if (scanner != null) {
            scanner.close();
        }
    }
}
