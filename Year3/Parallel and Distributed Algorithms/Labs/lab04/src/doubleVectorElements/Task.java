package doubleVectorElements;

public class Task implements Runnable {
    int threadID;
    int elems;
    int numOfThreads;

    public Task(int threadID, int elems, int numOfThreads) {
        this.threadID = threadID;
        this.elems = elems;
        this.numOfThreads = numOfThreads;
    }

    // Folosim formulele pentru impartirea array-ului in bucati egale
    // pentru fiecare thread
    @Override
    public void run() {
        int start = (int) (threadID * (double) elems / numOfThreads);
        int end = (int) Math.min((threadID + 1) * (double) elems / numOfThreads, elems);

        for(int i = start; i < end; ++i) {
            Main.v[i] *= 2;
        }
    }
}
