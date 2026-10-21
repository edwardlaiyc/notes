package lab3;

public class Plane {
    private PlaneSeat[] seat;
    private int numEmptySeat;

    public Plane() {
        this.seat = new PlaneSeat[12];
        for (int i = 0; i < 12; i++) {
            this.seat[i] = new PlaneSeat(i + 1); // seatId 1 to 12
        }
        this.numEmptySeat = 12;
    }
    private PlaneSeat[] sortSeats() {
        PlaneSeat[] clonedSeat = this.seat.clone();

        for (int i = 0; i < clonedSeat.length - 1; i++) {
            int minIdx = i;
            for (int j = i + 1; j < clonedSeat.length; j++) {
                if (clonedSeat[j].getCustomerId() < clonedSeat[minIdx].getCustomerId()) {
                    minIdx = j;
                }
            }
            PlaneSeat temp = clonedSeat[minIdx];
            clonedSeat[minIdx] = clonedSeat[i];
            clonedSeat[i] = temp;
        }
        return clonedSeat;
    }
    public void showNumEmptySeats() {
        System.out.println("There are " + numEmptySeat + " empty seats.");
    }
    public void showEmptySeats() {
        System.out.println("The following seats are empty:");
        for (PlaneSeat s : seat) {
            if (!s.isOccupied()) {
                System.out.println("SeatID " + s.getSeatId());
            }
        }
    }
    public void showAssignedSeats(boolean bySeatId) {
        PlaneSeat[] displaySeats = bySeatId ? this.seat : sortSeats();
        System.out.println("The seat assignments are as follow:");
        for (PlaneSeat s : displaySeats) {
            if (s.isOccupied()) {
                System.out.println("SeatID " + s.getSeatId() + " assigned to CustomerID " + s.getCustomerId() + ".");
            }
        }
    }
    public void assignSeat(int seatId, int cust_id) {
        // Validate seatId range
        if (seatId < 1 || seatId > 12) {
            System.out.println("Invalid SeatID.");
            return;
        }

        PlaneSeat target = seat[seatId - 1];
        if (target.isOccupied()) {
            System.out.println("Seat already assigned to a customer.");
        } else {
            target.assign(cust_id);
            numEmptySeat--;
            System.out.println("Seat Assigned!");
        }
    }
    public void unAssignSeat(int seatId) {
        if (seatId < 1 || seatId > 12) {
            System.out.println("Invalid SeatID.");
            return;
        }

        PlaneSeat target = seat[seatId - 1];
        if (target.isOccupied()) {
            target.unAssign();
            numEmptySeat++;
            System.out.println("Seat Unassigned!");
        } else {
            System.out.println("Seat was not assigned.");
        }
    }
}