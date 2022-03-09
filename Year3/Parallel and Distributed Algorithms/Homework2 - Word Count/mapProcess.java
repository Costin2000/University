import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.concurrent.BrokenBarrierException;

public class mapProcess extends Thread {
    public int id;

    public mapProcess(int id) {
        this.id = id;
    }
    
    @Override
    public void run() {

        // threadul coordonator creeaza taskurile initiale
        //---------------------------------------------------------------------------------
        if(id == 0) {
            //citeste din fisierul de input
            try {
                BufferedReader br = new BufferedReader(new FileReader(Tema2.input));

                String line;
                line = br.readLine();
                Tema2.substringSize = Integer.parseInt(line);

                line = br.readLine();
                Tema2.nrFiles = Integer.parseInt(line);

                for (int i = 0; i < Tema2.nrFiles; i++) {
                    line = br.readLine();
                    Tema2.filePaths.add(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

            //calculez lungimile fisierelor
            //-------------------------------------------------------
            ArrayList<Integer> filesSizes = new ArrayList<>();
            try {
                for (int i = 0; i < Tema2.nrFiles; i++) {
                    int fileLength = 0;
                    BufferedReader br = new BufferedReader(new FileReader("../" + Tema2.filePaths.get(i)));
                    while (br.read() != -1) {
                        fileLength++;
                    }
                    filesSizes.add(fileLength);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
            //-------------------------------------------------------

            //creez taskurile pentru mapping
            //-------------------------------------------------------
            try {
                for (int i = 0; i < Tema2.nrFiles; i++) {
                    int nrChars = 0;
                    int charactersRead = 0;
                    int offset = 0;

                    while (charactersRead < filesSizes.get(i)) {
                        if (nrChars == 0) {
                            offset = charactersRead;
                        }

                        charactersRead++;
                        nrChars++;

                        if (nrChars == Tema2.substringSize) {
                            BufferedReader br = new BufferedReader(new FileReader("../" + Tema2.filePaths.get(i)));
                            br.skip(charactersRead - 1);
                            String nextChar = Character.toString((char) br.read());
                            if (!Tema2.separators.contains(nextChar)) {
                                nextChar = Character.toString((char) br.read());
                                while (!Tema2.separators.contains(nextChar) && charactersRead < filesSizes.get(i)) {
                                    nrChars++;
                                    charactersRead++;
                                    nextChar = Character.toString((char) br.read());
                                }
                            }
                            Tema2.beforeMap.add(new beforeMap(Tema2.filePaths.get(i), offset, nrChars));
                            offset = offset + nrChars;
                            nrChars = 0;
                        }
                    }
                    if (nrChars > 0) {
                        Tema2.beforeMap.add(new beforeMap(Tema2.filePaths.get(i), offset, nrChars));
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        //------------------------------------------------------------------

        try {
            Tema2.barrier.await();
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }

        int start = (int) (id * (double) Tema2.beforeMap.size() / (Tema2.nrThreads));
        int end = (int) Math.min((id + 1) * (double) Tema2.beforeMap.size() / (Tema2.nrThreads), Tema2.beforeMap.size());

        //fiecare thread isi face partea care ii este asignata
        for (int j  = start; j < end; j++) {
            beforeMap task = Tema2.beforeMap.get(j);

            afterMap result = new afterMap(task.fileName,new HashMap<Integer, Integer>(),new ArrayList<String>());
            String fileName = "../" + task.fileName;


            try {
                BufferedReader br = new BufferedReader(new FileReader(fileName));
                br.skip(task.offset);

                //salvez toata secventa intr-un string
                String sequence = "";
                for(int i = 0; i < task.size; i++) {
                    sequence += Character.toString((char) br.read());
                }

                //folosind string tokenizer am aflat cuvintele
                StringTokenizer tokenizer = new StringTokenizer(sequence, Tema2.separators);
                int max = 0;

                //verific toate cuvintele si salvez ce este necesar
                while(tokenizer.hasMoreTokens()) {
                    String word = tokenizer.nextToken();
                    if (word.length() > max) {
                        result.maxes.clear();
                        result.maxes.add(word);
                        max = word.length();
                    } else if (word.length() == max) {
                        result.maxes.add(word);
                    }
                    if(result.nrAppearances.get(word.length()) != null) {
                        result.nrAppearances.put(word.length(), result.nrAppearances.get(word.length()) + 1);
                    } else if(word.length() != 0){
                        result.nrAppearances.put(word.length(), 1);
                    }
                }
            }  catch (IOException e) {
                e.printStackTrace();
            }

            //rezultatele le salvez intr-un array la care au acces toate threadurile
            try {
                Tema2.mutex.acquire();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            Tema2.afterMaps.add(result);

            Tema2.mutex.release();
        }
    }
}
