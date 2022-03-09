package multipleProducersMultipleConsumersNBuffer;

import java.util.Queue;
import java.util.concurrent.Semaphore;

public class Buffer {
    
    Queue<Integer> queue;
    private Semaphore gol;
    private Semaphore plin;
    
    public Buffer(int size) {
        queue = new LimitedQueue<>(size);
        gol = new Semaphore(1);
        plin = new Semaphore(0);
    }

	public void put(int value) {
        try {
            gol.acquire();
        } catch(InterruptedException e) {
            e.printStackTrace();
        }

        queue.add(value);

        plin.release();
	}

	public int get() {
        int a = -1;

        try {
            plin.acquire();
        } catch(InterruptedException e) {
            e.printStackTrace();
        }

        Integer result = queue.poll();
        if (result != null) {
            a = result;
        }
        gol.release();
        return a;
	}
}
