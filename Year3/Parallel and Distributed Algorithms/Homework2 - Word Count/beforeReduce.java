import java.util.ArrayList;
import java.util.HashMap;

public class beforeReduce {

    public String filename;
    public ArrayList<HashMap<Integer, Integer>> wordOccurences;
    public ArrayList<ArrayList<String>> allMaxes;

    public beforeReduce(String filename, ArrayList<HashMap<Integer, Integer>> wordOccurences, ArrayList<ArrayList<String>> allMaxes) {
        this.filename = filename;
        this.wordOccurences = wordOccurences;
        this.allMaxes = allMaxes;
    }

}
