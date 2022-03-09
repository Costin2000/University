package multipleProducersMultipleConsumers;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class Buffer {
	BlockingQueue<Integer> values = new ArrayBlockingQueue<> (110) ;

	void put(int value) {
		//this.value = value;
		try {
			values.put(value);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	int get() {
		try {
			return values.take();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
}
