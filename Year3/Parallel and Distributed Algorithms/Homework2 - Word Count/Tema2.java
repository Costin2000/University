import java.io.*;
import java.util.*;
import java.util.concurrent.*;


public class Tema2 {

    public static String separators = ";:/?~\\.,><`[]{}()!@#$%^&-_+'=*\"| \t\r\n";
    public static ArrayList<beforeMap> beforeMap = new ArrayList<>();
    public static ArrayList<beforeReduce> beforeReduces = new ArrayList<>();
    public static ArrayList<afterMap> afterMaps = new ArrayList<>();
    public static ArrayList<afterReduce> afterReduce = new ArrayList<>();
    public static Semaphore mutex = new Semaphore(1);
    public static CyclicBarrier barrier;
    public static Integer nrThreads;
    public static ArrayList<String> filePaths = new ArrayList<>();
    public static Integer substringSize = 0;
    public static Integer nrFiles = 0;
    public static String output;
    public static String input;

    public static Integer getFiboNumber(int n) {
        if (n <= 1)
            return n;
        return getFiboNumber(n-1) + getFiboNumber(n-2);
    }


    public static void main(String[] args) throws IOException {

        if (args.length < 3) {
            System.err.println("Usage: Tema2 <workers> <in_file> <out_file>");
            return;
        }

        nrThreads = Integer.parseInt(args[0]);
        barrier = new CyclicBarrier(nrThreads);

        input = args[1];
        output = args[2];

        //pornesc threadurile prntru efectuarea etapei de map
        //----------------------------------------------
        mapProcess[] threads = new mapProcess[nrThreads];


        for (int i = 0; i < nrThreads; i++) {
            threads[i] = new mapProcess(i);
        }

        for (var thread : threads) {
            thread.start();
        }

        for (var thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        //----------------------------------------------


        //pornesc thradurile pentru rezolvarea taskurilor de reduce
        //---------------------------------------------------
        reduceProcess[] reduceThreads = new reduceProcess[nrThreads];
        for (int i = 0; i < nrThreads; i++) {
            reduceThreads[i] = new reduceProcess(i);
        }

        for (var thread : reduceThreads) {
            thread.start();
        }

        for (var thread : reduceThreads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        //---------------------------------------------------
    }
}
