package task3;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.atomic.AtomicInteger;

public class Task3 implements Runnable {
    int step;
    int[] graph;
    ExecutorService tpe;
    AtomicInteger submitted;

    private static boolean check(int[] arr, int step) {
        for (int i = 0; i <= step; i++) {
            for (int j = i + 1; j <= step; j++) {
                if (arr[i] == arr[j] || arr[i] + i == arr[j] + j || arr[i] + j == arr[j] + i)
                    return false;
            }
        }
        return true;
    }

    private static void printQueens(int[] sol) {
        StringBuilder aux = new StringBuilder();
        for (int i = 0; i < sol.length; i++) {
            aux.append("(").append(sol[i] + 1).append(", ").append(i + 1).append("), ");
        }
        aux = new StringBuilder(aux.substring(0, aux.length() - 2));
        System.out.println("[" + aux + "]");
    }

    public Task3(int step, int[] graph, ExecutorService tpe) {
        this.step = step;
        this.graph = graph;
        this.tpe = tpe;
        this.submitted = new AtomicInteger(1);
    }

    private Task3(int step, int[] graph, ExecutorService tpe, AtomicInteger submitted) {
        this.step = step;
        this.graph = graph;
        this.tpe = tpe;
        this.submitted = submitted;
        submitted.incrementAndGet();
    }

    @Override
    public void run() {
        if (Main.N == step) {
            printQueens(graph);
            if(submitted.decrementAndGet() == 0) {
                tpe.shutdown();
            }
            return;
        }

        for (int i = 0; i < Main.N; ++i) {
            int[] newGraph = graph.clone();
            newGraph[step] = i;

            if (check(newGraph, step)) {
                tpe.submit(new Task3(step + 1, newGraph, tpe, submitted));
            }
        }

        if(submitted.decrementAndGet() == 0) {
            tpe.shutdown();
        }
    }
}
