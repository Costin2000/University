package main;

import functii.Utile.Command;
import functii.Utile.Query;
import functii.Utile.Recommendation;
import functii.Utile.VideoNote;
import checker.Checkstyle;
import checker.Checker;
import common.Constants;
//import jdk.swing.interop.SwingInterOpUtils;
import fileio.ActionInputData;
import fileio.ActorInputData;
import fileio.Input;
import fileio.InputLoader;
import fileio.MovieInputData;
import fileio.SerialInputData;
import fileio.UserInputData;
import fileio.Writer;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * The entry point to this homework. It runs the checker
 * that tests your implentation.
 */

public final class Main {

    /**
     * for coding style
     */
    private Main() {
    }

    /**
     * Call the main checker and the coding style checker
     *
     * @param args from command line
     * @throws IOException in case of exceptions to reading / writing
     */
    public static void main(final String[] args) throws IOException {
        File directory = new File(Constants.TESTS_PATH);
        Path path = Paths.get(Constants.RESULT_PATH);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }

        File outputDirectory = new File(Constants.RESULT_PATH);

        Checker checker = new Checker();
        checker.deleteFiles(outputDirectory.listFiles());

        for (File file : Objects.requireNonNull(directory.listFiles())) {

            String filepath = Constants.OUT_PATH + file.getName();
            File out = new File(filepath);
            boolean isCreated = out.createNewFile();
            if (isCreated) {
                action(file.getAbsolutePath(), filepath);
            }
        }

        checker.iterateFiles(Constants.RESULT_PATH, Constants.REF_PATH, Constants.TESTS_PATH);
        Checkstyle test = new Checkstyle();
        test.testCheckstyle();
    }

    /**
     * Functie care intoarce userul cerut de actiune
     */
    public int findUser(final List<UserInputData> useri, final ActionInputData actiune) {
        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getUsername().equals(actiune.getUsername())) {
                return i;
            }
        }
        return -1;
    }
    /**
     * @param filePath1 for input file
     * @param filePath2 for output file
     * @throws IOException in case of exceptions to reading / writing
     */
    public static void action(final String filePath1,
                              final String filePath2) throws IOException {
        InputLoader inputLoader = new InputLoader(filePath1);
        Input input = inputLoader.readData();
        Writer fileWriter = new Writer(filePath2);
        JSONArray arrayResult = new JSONArray();

        /*List<ActorInputData> actori = input.getActors();
        List<UserInputData> useri = input.getUsers();
        List<ActionInputData> actiuni = input.getCommands();
        List<MovieInputData> filme = input.getMovies();
        List<SerialInputData> seriale = input.getSerials();
        Main var = new Main();

        ArrayList<VideoNote> filmeNote = new ArrayList<>();


        for (int i = 0; i < actiuni.size(); i++) {

            String mesaj = new String();

            if (actiuni.get(i).getActionType().equals("command")) {
                if (actiuni.get(i).getType().equals("favorite")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Command ajutor = new Command();
                    mesaj = ajutor.favourite(useri.get(j), actiuni.get(i).getTitle());
                }

                if (actiuni.get(i).getType().equals("view")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Command ajutor = new Command();
                    mesaj = ajutor.view(useri.get(j), actiuni.get(i).getTitle());
                    }

                if (actiuni.get(i).getType().equals("rating")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Command ajutor = new Command();
                    mesaj = ajutor.rating(useri.get(j), actiuni.get(i).getTitle(),
                            actiuni.get(i).getSeasonNumber(), actiuni.get(i).getGrade(), filmeNote);
            }
            }
            //QUERYES

            if (actiuni.get(i).getActionType().equals("query")) {
                if (actiuni.get(i).getCriteria().equals("num_ratings")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.usersNrRatings(useri, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("filter_description")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.filterDescription(actori, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("longest")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.longest(filme, seriale, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("awards")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.awards(actori, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("favorite")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.favorite(filme, seriale, useri, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("most_viewed")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.mostViewed(filme, seriale, useri, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("ratings")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.ratings(filme, seriale, filmeNote, actiuni.get(i));
                }

                if (actiuni.get(i).getCriteria().equals("average")) {
                    Query ajutor = new Query();
                    mesaj = ajutor.average(actori, filme, seriale, filmeNote, actiuni.get(i));
                }

            }
            //RECOMANDARI
            if (actiuni.get(i).getActionType().equals("recommendation")) {

                if (actiuni.get(i).getType().equals("standard")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Recommendation ajutor = new Recommendation();
                    mesaj = ajutor.standard(useri.get(j), filme);
                }

                if (actiuni.get(i).getType().equals("best_unseen")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Recommendation ajutor = new Recommendation();
                    mesaj = ajutor.bestUnseen(useri.get(j), filme, seriale, filmeNote);
                }

                if (actiuni.get(i).getType().equals("popular")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Recommendation ajutor = new Recommendation();
                    mesaj = ajutor.popular(useri.get(j), useri, seriale, filme);
                }

                if (actiuni.get(i).getType().equals("favorite")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Recommendation ajutor = new Recommendation();
                    mesaj = ajutor.favorite(useri.get(j), useri, seriale, filme);
                }

                if (actiuni.get(i).getType().equals("search")) {
                    int j = var.findUser(useri, actiuni.get(i));
                    Recommendation ajutor = new Recommendation();
                    mesaj = ajutor.search(useri.get(j), actiuni.get(i), seriale, filme, filmeNote);

                }
            }
            org.json.simple.JSONObject object = new JSONObject();
            object = fileWriter.writeFile(actiuni.get(i).getActionId(), mesaj, mesaj);
            arrayResult.add(object);
        }*/

        org.json.simple.JSONObject object = new JSONObject();
        object = fileWriter.writeFile(1, "", "ana"  + "mere");
        arrayResult.add(object);
        fileWriter.closeJSON(arrayResult);

    }
}
