package lab3;

public class PlaneSeat {
    private int seatId;
    private boolean assigned;
    private int customerId;

    public PlaneSeat(int seatId) { this.seatId = seatId; }
    public int getSeatId() { return this.seatId; }
    public int getCustomerId() { return this.customerId; }
    public boolean isOccupied() { return this.assigned; }
    public void assign(int cust_id) {
        this.assigned = true;
        this.customerId = cust_id;
    }
    public void unAssign() {
        this.assigned = false;
        this.customerId = 0;
    }
}