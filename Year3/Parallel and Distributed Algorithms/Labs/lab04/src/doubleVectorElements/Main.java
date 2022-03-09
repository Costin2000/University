package doubleVectorElements;

public class Main {

    static int v[];
    public static void main(String[] args) {
        int N = 100000013;
        v = new int[N];
        int numOfThreads = Runtime.getRuntime().availableProcessors();

        Thread[] threads = new Thread[numOfThreads];

        for (int i = 0; i < N; i++) {
            v[i] = i;
        }

        // Parallelize me using P threads
        /*for (int i = 0; i < N; i++) {
            v[i] = v[i] * 2;
        }*/

        for (int i = 0; i < numOfThreads; i++) {
            threads[i] = new Thread(new Task(i, N, numOfThreads));
            threads[i].start();
        }

        for (int i = 0; i < numOfThreads; i++) {
            try {
                threads[i].join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        for (int i = 0; i < N; i++) {
            if (v[i] != i * 2) {
                System.out.println("Wrong answer");
                System.exit(1);
            }
        }
        System.out.println("Correct");
    }
}
