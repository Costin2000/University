package shortestPathsFloyd_Warshall;

public class TaskFW implements Runnable {

    int threadID;
    int size;

    public TaskFW(int threadID, int size) {
        this.threadID = threadID;
        this.size = size;
    }

    // Paralelizam ultimul for
    public void run() {
        for(int k = 0; k < size; ++k) {
            for(int i = 0; i < size; ++i) {
                Main.graph[i][threadID] = Math.min(Main.graph[i][k]
                        + Main.graph[k][threadID], Main.graph[i][threadID]);
            }

            // Asteptam ca cele 5 thread-uri sa termine executia codului
            try {
                Main.barrier.await();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
