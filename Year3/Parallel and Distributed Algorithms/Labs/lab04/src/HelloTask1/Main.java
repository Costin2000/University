package HelloTask1;

public class Main {
    public static int cores;

    public static void main(String[] args) {
        cores = Runtime.getRuntime().availableProcessors();

        // Initiem thread-urile
        Thread[] threads = new Thread[cores];
        for (int i = 0; i < cores; i++) {
            threads[i] = new Task(i);
            threads[i].start();
        }

        for (int i = 0; i < cores; i++) {
            try {
                threads[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
