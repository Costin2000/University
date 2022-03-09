package task1;

import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.atomic.AtomicInteger;

public class Task1 extends Thread{
    private ExecutorService tpe;
    private ArrayList<Integer> path;
    private final int dest;
    private AtomicInteger inq;

    public Task1(ExecutorService tpe, ArrayList<Integer> pt, int Dst, AtomicInteger inq) {
        this.tpe = tpe;
        path = pt;
        dest = Dst;
        this.inq = inq;
    }

    @Override
    public void run() {
        if (path.get(path.size() - 1) == dest) {
            System.out.println(path);
            int left = inq.decrementAndGet();
            if (left == 0)
                tpe.shutdown();
            return;
        }
        int lastNode = path.get(path.size() - 1);

        for (int[] ints : Main.graph) {
            if(ints[0] == lastNode)  {
                if (path.contains(ints[1]))
                    continue;
                ArrayList<Integer> newPath = new ArrayList<>(path);
                newPath.add(ints[1]);
                tpe.submit(new Task1(tpe, newPath, dest, inq));
            }
        }

        int left = inq.decrementAndGet();
        if (left == 0)
            tpe.shutdown();
    }
}
