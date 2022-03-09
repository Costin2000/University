package testing;

public class ThreadClass extends Thread {

    private final int id;

    public ThreadClass(int id) {
        this.id = id;
    }

    @Override
    public void run() {

        try {
            // shared space is locked
           Main.mySemaphore.acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        if (this.id == 2) {
            System.out.println("Hello from thread " + this.id);
        }

        Main.mySemaphore.release();
    }
}
