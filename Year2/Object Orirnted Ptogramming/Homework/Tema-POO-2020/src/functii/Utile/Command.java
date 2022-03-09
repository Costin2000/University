package functii.Utile;

import fileio.UserInputData;

import java.util.ArrayList;

public class Command {

    /**
     * Metoda prin care un user adauga un film la favorite
     */
    public String favourite(final UserInputData user, final String movie) {
        String mesaj;
        /*se verifica daca userul a vazut filmul
        pentu ca altfel nu poate sa il adauge la favorite*/
        if (!user.getHistory().containsKey(movie)) {
            mesaj = "error -> " + movie + " is not seen";
            return mesaj;
        }

        /* se verifica daca a mai dat nota acestui film
        deoarece nu poate sa il adauge a doua oara*/
        if (user.getFavoriteMovies().contains(movie)) {
            mesaj = "error -> " + movie + " is already in favourite list";
            return mesaj;
        }

        //se adauga filmul
        user.getFavoriteMovies().add(movie);
        mesaj = "success -> " + movie + " was added as favourite";
        return mesaj;
    }

    /**
     * Metoda prin care un user adauga un film la istoric
     */
    public String view(final UserInputData user, final String movie) {
        String mesaj;

        /* Daca nu contine in istoric filmul il adauga */
        if (!user.getHistory().containsKey(movie)) {
            user.getHistory().put(movie, 1);
            mesaj = "success -> " + movie +  " was viewed with total views of 1";
            return mesaj;
        }

        /*daca il contine afiseaza de cate ori l-a vazut*/
        user.getHistory().put(movie, user.getHistory().get(movie) + 1);
        mesaj = "success -> " + movie +  " was viewed with total views of "
                + user.getHistory().get(movie);
        return mesaj;

    }

    /**
     * Metoda prin care un user adauga rating unui videoclip
     */
    public String rating(final UserInputData user, final String movie,
                         final int sezon, final double grade,
                         final ArrayList<VideoNote> filmeNote) {
        String mesaj;
        RatedVideos var = new RatedVideos(movie, sezon);
        VideoNote ajutor = new VideoNote();

        //daca videoul nu a fost vazut nu poate sa dea nota
        if (!user.getHistory().containsKey(movie)) {
            mesaj = "error -> " + movie + " is not seen";
            return mesaj;
        }

        //verific daca a mai dat nota aceluias film
        for (int i = 0; i < user.getRated().size(); i++) {
            if (user.getRated().get(i).getTitlu().equals(movie)
                    && user.getRated().get(i).getSezon() == sezon) {
                mesaj = "error -> " + movie + " has been already rated";
                return mesaj;
            }
        }


        user.getRated().add(var); //adaug in lista utilizatorului de filme la care a dat nota

        //verific daca videoclipul mai avea vreo nota pana acum
        int i = ajutor.findVideoWithSameNameAndSeason(filmeNote, movie, sezon);
        if (i != -1) { //daca nu e prima lui nota
            filmeNote.get(i).adaugareNota(filmeNote.get(i), grade);
        }
        if (i == -1) { //daca e prima lui nota se adauga filmul in lista
            ajutor = new VideoNote(movie, sezon, grade);
            filmeNote.add(ajutor);
        }
        mesaj = "success -> " + movie + " was rated with " + grade + " by " + user.getUsername();
        return mesaj;

    }


}
