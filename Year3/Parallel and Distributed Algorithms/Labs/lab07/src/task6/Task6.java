package task6;

import java.util.ArrayList;
import java.util.concurrent.RecursiveTask;

public class Task6 extends RecursiveTask<Void> {
    private int step;
    private int[] graph;

    public Task6(int step, int[] graph) {
        this.step = step;
        this.graph = graph;
    }

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

    @Override
    protected Void compute() {
        if (Main.N == step) {
            printQueens(graph);
            return null;
        }
        ArrayList<Task6> tasks = new ArrayList<>();
        for (int i = 0; i < Main.N; ++i) {
            int[] newGraph = graph.clone();
            newGraph[step] = i;

            if (check(newGraph, step)) {
                Task6 task = new Task6(step + 1, newGraph);
                tasks.add(task);
                task.fork();
            }
        }
        tasks.forEach(Task6::join);
        return null;
    }
}
