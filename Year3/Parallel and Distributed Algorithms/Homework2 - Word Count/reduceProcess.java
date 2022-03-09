import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.BrokenBarrierException;

public class reduceProcess extends Thread {

    public Integer id;

    public reduceProcess(Integer id) {
        this.id = id;
    }

    @Override
    public void run() {

        //threadul coordonator aranjeaza rezultatele de la task in functie de fisierul caruia ii apartin
        if(id == 0) {
            for (int i = 0; i < Tema2.nrFiles; i++) {
                Tema2.beforeReduces.add(new beforeReduce( Tema2.filePaths.get(i),
                        new ArrayList<HashMap<Integer, Integer>>(),
                        new ArrayList<ArrayList<String>>()));
            }

            for (afterMap mapResult : Tema2.afterMaps) {
                for (beforeReduce tasksForReduce : Tema2.beforeReduces) {
                    if (mapResult.fileName.equals(tasksForReduce.filename)) {
                        tasksForReduce.wordOccurences.add(mapResult.nrAppearances);
                        tasksForReduce.allMaxes.add(mapResult.maxes);
                    }
                }
            }
        }

        //astept ca threadul coordonator sa termine ordonarea
        try {
            Tema2.barrier.await();
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }

        int start = (int) (id * (double) Tema2.beforeReduces.size() / (Tema2.nrThreads));
        int end = (int) Math.min((id + 1) * (double) Tema2.beforeReduces.size() / (Tema2.nrThreads), Tema2.beforeReduces.size());

        //fiecare thread isi proceseaza partea
        for (int j = start; j < end; j++) {

            beforeReduce currentTask = Tema2.beforeReduces.get(j);
            Integer nrWords = 0;
            Integer fibonacci = 0;

            for (HashMap<Integer, Integer> wordOcc : currentTask.wordOccurences) {
                for (Map.Entry<Integer, Integer> entry : wordOcc.entrySet()) {
                    nrWords += entry.getValue();
                    fibonacci += Tema2.getFiboNumber(entry.getKey() + 1) * entry.getValue();
                }
            }
            Float rank = fibonacci.floatValue() / nrWords.floatValue();


            int maxLen = 0;
            int occurences = 0;

            for (ArrayList<String> maxes : currentTask.allMaxes) {
                for (String currentWord : maxes ) {
                    if (currentWord.length() > maxLen) {
                        maxLen = currentWord.length();
                        occurences = 1;
                    }
                    else if (currentWord.length() == maxLen) {
                        occurences++;
                    }
                }
            }


            try {
                Tema2.mutex.acquire();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            Tema2.afterReduce.add(new afterReduce(currentTask.filename, String.format("%.2f", rank), maxLen, occurences));

            Tema2.mutex.release();
        }

        try {
            Tema2.barrier.await();
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }

        //astept ca toate threadurile sa isi proceseze partile

        //threadul coordonator afiseaza rezultatul
        if (id == 0) {
            //sortez dupa rang
            //---------------------------------------------------
            Tema2.afterReduce.sort((afterReduce r1, afterReduce r2) ->
                    Float.compare(Float.parseFloat(r2.rank), Float.parseFloat(r1.rank)));
            //---------------------------------------------------

            try {
                BufferedWriter writer = new BufferedWriter(new FileWriter(Tema2.output));
                for (int i = 0; i < Tema2.afterReduce.size(); i++) {
                    writer.write(Tema2.afterReduce.get(i).filename.substring(12, Tema2.afterReduce.get(i).filename.length()) +
                            ',' + Tema2.afterReduce.get(i).rank + "," + Tema2.afterReduce.get(i).maxLen + "," +
                            Tema2.afterReduce.get(i).numOfOccurences + "\n");
                }
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
