import java.util.ArrayList;
import java.util.HashMap;

public class afterMap {
    public String fileName;
    public HashMap<Integer, Integer> nrAppearances;
    public ArrayList<String> maxes;

    @Override
    public String toString() {
        return "mapResult{" +
                "fileName='" + fileName + '\'' +
                ", nrAppearances=" + nrAppearances +
                ", maxes=" + maxes +
                '}';
    }

    public afterMap(String fileName, HashMap<Integer, Integer> nrAppearances, ArrayList<String> maxes) {
        this.fileName = fileName;
        this.nrAppearances = nrAppearances;
        this.maxes = maxes;
    }
}
