package task4;

import java.util.ArrayList;
import java.util.concurrent.RecursiveTask;

public class Task4 extends RecursiveTask<Void> {
    ArrayList<Integer> partialPath;
    int destination;

    public Task4(ArrayList<Integer> partialPath, int destination) {
        this.partialPath = partialPath;
        this.destination = destination;
    }

    @Override
    protected Void compute() {
        if (partialPath.get(partialPath.size() - 1) == destination) {
            System.out.println(partialPath);
            return null;
        }

        // se verifica nodurile pentru a evita ciclarea in graf
        int lastNodeInPath = partialPath.get(partialPath.size() - 1);
        ArrayList<Task4> tasks = new ArrayList<>();

        for (int[] ints : Main.graph) {

            if (ints[0] == lastNodeInPath) {

                if (partialPath.contains(ints[1]))
                    continue;
                ArrayList<Integer> newPartialPath = new ArrayList<>(partialPath);
                newPartialPath.add(ints[1]);
                Task4 task = new Task4(newPartialPath, destination);
                tasks.add(task);
                task.fork();
            }
        }
        tasks.forEach(Task4::join);
        return null;
    }
}
