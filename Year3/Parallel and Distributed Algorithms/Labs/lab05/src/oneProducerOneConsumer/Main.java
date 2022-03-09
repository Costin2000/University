package oneProducerOneConsumer;

/**
 * DO NOT MODIFY
 */
public class Main {
    static final int N = 10;

    public static void main(String[] args) {
        Buffer buffer 		= new Buffer();
        Thread[] threads 	= new Thread[2];

        threads[0] = new Thread(new Producer(buffer));
        threads[0].start();

        threads[1] = new Thread(new Consumer(buffer));
        threads[1].start();

        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

}/* DO NOT MODIFY */