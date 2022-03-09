package testing;

import java.util.concurrent.Semaphore;

public class Main {

    public static Semaphore mySemaphore = new Semaphore(1);

    public static void main(String[] args) {

        Thread[] threads = new ThreadClass[8];

        for (int i = 0; i < 8; i++) {
            threads[i] = new ThreadClass(i);
        }

        for (var thread : threads) {
            thread.start();
        }

        for (var thread: threads) {

            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

    }
}
