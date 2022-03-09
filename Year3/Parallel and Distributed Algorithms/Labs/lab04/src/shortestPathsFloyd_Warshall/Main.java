package shortestPathsFloyd_Warshall;

import java.util.concurrent.CyclicBarrier;

public class Main {

    public static CyclicBarrier barrier;

    static int M = 9;
    static int[][] graph = {{0, 1, M, M, M},
            {1, 0, 1, M, M},
            {M, 1, 0, 1, 1},
            {M, M, 1, 0, M},
            {M, M, 1, M, 0}};

    public static void main(String[] args) {

        // Parallelize me (You might want to keep the original code in order to compare)
        /*for (int k = 0; k < 5; k++) {
            for (int i = 0; i < 5; i++) {
                for (int j = 0; j < 5; j++) {
                    graph[i][j] = Math.min(graph[i][k] + graph[k][j], graph[i][j]);
                }
            }
        }*/

        // Initiem thread-urile
        int numOfThreads = 5;
        Thread[] threads = new Thread[numOfThreads];
        barrier = new CyclicBarrier(numOfThreads);

        for (int i = 0; i < numOfThreads; i++) {
            threads[i] = new Thread(new TaskFW(i, numOfThreads));
            threads[i].start();
        }

        for (int i = 0; i < numOfThreads; i++) {
            try {
                threads[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }


        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                System.out.print(graph[i][j] + " ");
            }
            System.out.println();
        }
    }
}
