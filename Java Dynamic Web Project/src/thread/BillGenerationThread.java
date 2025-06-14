// BillGenerationThread.java
package thread;

import dao.BillDAO;
import model.Bill;
import java.sql.SQLException;
import java.util.List;

public class BillGenerationThread extends Thread {
    private long consumerId;
    
    public BillGenerationThread(long consumerId) {
        this.consumerId = consumerId;
    }
    
    @Override
    public void run() {
        try {
            BillDAO billDAO = new BillDAO();
            List<Bill> bills = billDAO.getBillsByConsumerId(consumerId);
            
            if (bills.isEmpty()) {
                System.out.println("No bills found for consumer ID: " + consumerId);
                return;
            }
            
            System.out.println("\nGenerating bills for consumer ID: " + consumerId);
        System.out.println("BillID\tBillNo\tDue Amount\tPayable Amount\tStatus");
        for (Bill bill : bills) {
            System.out.printf("%d\t%d\t%,.2f\t%,.2f\t%s\n",
                bill.getBillId(),
                bill.getBillNumber(),
                bill.getDueAmount(),
                bill.getPayableAmount(),
                bill.getStatus());
            // Simulate some processing time
            Thread.sleep(500);
        }
    } catch (SQLException e) {
        System.out.println("Database error while generating bills: " + e.getMessage());
    } catch (InterruptedException e) {
        System.out.println("Bill generation interrupted for consumer ID: " + consumerId);
    }
}
}