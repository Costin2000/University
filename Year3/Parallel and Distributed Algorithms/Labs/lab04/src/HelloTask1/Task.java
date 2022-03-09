package HelloTask1;

public class Task extends Thread {
    private int id;
    public Task(int id) {
        this.id = id;
    }

    @Override
    public void run() {
        System.out.println("Hello from thread #" + this.id);
    }
}
