package functii.Utile;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import actor.ActorsAwards;
import fileio.ActionInputData;
import fileio.ActorInputData;
import fileio.MovieInputData;
import fileio.SerialInputData;
import fileio.UserInputData;

public class Query {


    //num_ratings

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul ascendent
     */
    public int swapNrRatingsAsc(final UserInputData user1, final UserInputData user2) {
        if (user1.getRated().size() > user2.getRated().size()) {
            return 1;
        }
        if (user1.getRated().size() == user2.getRated().size()
                && user1.getUsername().compareTo(user2.getUsername()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int swapNrRatingsDesc(final UserInputData user1, final UserInputData user2) {
        if (user1.getRated().size() < user2.getRated().size()) {
            return 1;
        }
        if (user1.getRated().size() == user2.getRated().size()
                && user1.getUsername().compareTo(user2.getUsername()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "num_ratings"
     */
    public String usersNrRatings(final List<UserInputData> useri, final ActionInputData query) {
        List<UserInputData> copie = new ArrayList<>();
        copie = useri;
        List<String> primeleN = new ArrayList<>();
        String mesaj = new String();

        //sortez lista in modul cerut
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (copie.size() - 1); i++) {
                for (int j = i + 1; j < copie.size(); j++) {
                    if (swapNrRatingsAsc(copie.get(i), copie.get(j)) == 1) {
                        Collections.swap(copie, i, j);
                    }
                }
            }
        }

        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (copie.size() - 1); i++) {
                for (int j = i + 1; j < copie.size(); j++) {
                    if (swapNrRatingsDesc(copie.get(i), copie.get(j)) == 1) {
                        Collections.swap(copie, i, j);
                    }
                }
            }
        }

        //adaug in noua lista doar userii care au dat cel putin o nota
        List<UserInputData> copie2 = new ArrayList<>();
        for (int i = 0; i < copie.size(); i++) {
            if (copie.get(i).getRated().size() != 0) {
                copie2.add(copie.get(i));
            }
        }

        //afisez doar cati useri mi se cer
        if (query.getNumber() >= copie2.size()) {
            for (int i = 0; i < copie2.size(); i++) {
                primeleN.add(copie2.get(i).getUsername());
            }
            mesaj = "Query result: " + primeleN;
        }

        if (query.getNumber() < copie2.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(copie2.get(i).getUsername());
            }
            mesaj = "Query result: " + primeleN;
        }

        return mesaj;
    }


    //filter_description


    /**
     * Functie care face implementare pentru
     * query-ul "filter_description"
     */
    public String filterDescription(final List<ActorInputData> actori,
                                    final ActionInputData query) {
        List<ActorInputData> copie = new ArrayList<>();
        List<String> primeleN = new ArrayList<>();
        String mesaj = new String();
        int verif;

        for (int i = 0; i < actori.size(); i++) {
            verif = 1;
            char[] aux = actori.get(i).getCareerDescription().toLowerCase().toCharArray();
            //transform toate caracterele care nu sunt litere in spatiu
            for (int k = 0; k < aux.length; k++) {
                if (aux[k] > 'z' || aux[k] < 'a') {
                    aux[k] = ' ';
                }
            }
            String aux2 = String.valueOf(aux);
            //aleg doar actorii care au cuvintele specificate in descriere
            for (int j = 0; j < query.getFilters().get(2).size(); j++) {
                if (!aux2.contains(" " + query.getFilters().get(2).get(j) + " ")) {
                    verif = 0;
                }
            }
            if (verif == 1) {
                copie.add(actori.get(i));
            }
        }

        //sortez cum mi se cere
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (copie.size() - 1); i++) {
                for (int j = i + 1; j < copie.size(); j++) {
                    if (copie.get(i).getName().compareTo(copie.get(j).getName()) > 0) {
                        Collections.swap(copie, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (copie.size() - 1); i++) {
                for (int j = i + 1; j < copie.size(); j++) {
                    if (copie.get(i).getName().compareTo(copie.get(j).getName()) < 0) {
                        Collections.swap(copie, i, j);
                    }
                }
            }
        }

        //afisez cati actori sunt ceruti
        if (query.getNumber() >= actori.size()) {
            for (int i = 0; i < copie.size(); i++) {
                primeleN.add(copie.get(i).getName());
            }
            mesaj = "Query result: " + primeleN;
        }
        if (query.getNumber() < actori.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(copie.get(i).getName());
            }
            mesaj = "Query result: " + primeleN;
        }
        return mesaj;
    }



    //LONGEST

    /**
     * Functie care returneaza durata unui serial
     */
    public int durataSerial(final SerialInputData serial) {
        int durata = 0;
        for (int i = 0; i < serial.getNumberSeason(); i++) {
            durata = durata + serial.getSeasons().get(i).getDuration();
        }
        return durata;

    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int sortLongestAsc(final VideoDurata video1, final VideoDurata video2) {
        if (video1.getDurata() > video2.getDurata()) {
            return 1;
        }
        if (video1.getDurata() == video2.getDurata()
                && video1.getNume().compareTo(video2.getNume()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int sortLongestDesc(final VideoDurata video1, final VideoDurata video2) {
        if (video1.getDurata() < video2.getDurata()) {
            return 1;
        }
        if (video1.getDurata() == video2.getDurata()
                && video1.getNume().compareTo(video2.getNume()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "longest"
     */
    public String longest(final List<MovieInputData> filme,
                          final List<SerialInputData> seriale, final ActionInputData query) {
        ArrayList<VideoDurata> lista = new ArrayList<>();
        List<MovieInputData> copieFilme = new ArrayList<>();
        List<SerialInputData> copieSeriale = new ArrayList<>();
        List<String> primeleN = new ArrayList<>();
        String mesaj = new String();


        if (query.getObjectType().equals("movies")) {
            //selectam filmele care se potrivesc filtrelor
            for (int i = 0; i < filme.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {
                    if (filme.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1) != null && query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (!filme.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieFilme.add(filme.get(i));
                }
            }

            for (int i = 0; i < copieFilme.size(); i++) {
                VideoDurata aux = new VideoDurata(copieFilme.get(i).getTitle(),
                        copieFilme.get(i).getDuration());
                lista.add(aux);
            }
        } else {
            //selectam serialele care se potrivesc filtrelor
            for (int i = 0; i < seriale.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {
                    if (seriale.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (
                        !seriale.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieSeriale.add(seriale.get(i));
                }
            }

            for (int i = 0; i < copieSeriale.size(); i++) {
                VideoDurata aux = new VideoDurata(copieSeriale.get(i).getTitle(),
                        durataSerial(copieSeriale.get(i)));
                lista.add(aux);
            }
        }

        //sortam cum este cerut
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (sortLongestAsc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (sortLongestDesc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }

        //afisez cate videouri se cer
        if (query.getNumber() >= lista.size()) {
            for (int i = 0; i < lista.size(); i++) {
                primeleN.add(lista.get(i).getNume());
            }
            mesaj = "Query result: " + primeleN;
        }
        if (query.getNumber() < lista.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(lista.get(i).getNume());
            }
            mesaj = "Query result: " + primeleN;
        }
        return mesaj;

    }


    //awards

    /**
     * Functie care returneaza cate premii are acorul dat ca parametru
     */
    public int nrAwards(final ActorInputData actor) {
        int nrPremii = 0;
        if (actor.getAwards().containsKey(ActorsAwards.BEST_SUPPORTING_ACTOR)) {
            nrPremii = nrPremii + actor.getAwards().get(ActorsAwards.BEST_SUPPORTING_ACTOR);
        }
        if (actor.getAwards().containsKey(ActorsAwards.BEST_DIRECTOR)) {
            nrPremii = nrPremii + actor.getAwards().get(ActorsAwards.BEST_DIRECTOR);
        }
        if (actor.getAwards().containsKey(ActorsAwards.BEST_PERFORMANCE)) {
            nrPremii = nrPremii + actor.getAwards().get(ActorsAwards.BEST_PERFORMANCE);
        }
        if (actor.getAwards().containsKey(ActorsAwards.BEST_SCREENPLAY)) {
            nrPremii = nrPremii + actor.getAwards().get(ActorsAwards.BEST_SCREENPLAY);
        }
        if (actor.getAwards().containsKey(ActorsAwards.PEOPLE_CHOICE_AWARD)) {
            nrPremii = nrPremii + actor.getAwards().get(ActorsAwards.PEOPLE_CHOICE_AWARD);
        }

        return nrPremii;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul ascendent
     */
    public int swapAwardsAsc(final ActorInputData actor1, final ActorInputData actor2) {
        if (nrAwards(actor1) > nrAwards(actor2)) {
            return 1;
        }
        if  (nrAwards(actor1)
                == nrAwards(actor2) && actor1.getName().compareTo(actor2.getName()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int swapAwardsDesc(final ActorInputData actor1, final ActorInputData actor2) {
        if (nrAwards(actor1) < nrAwards(actor2)) {
            return 1;
        }
        if  (nrAwards(actor1)
                == nrAwards(actor2) && actor1.getName().compareTo(actor2.getName()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "awards"
     */
    public String awards(final List<ActorInputData> actori, final ActionInputData query) {

        String mesaj = new String();
        List<ActorInputData> lista = new ArrayList<>();
        List<String> primeleN = new ArrayList<>();

        //aleg actorii care se potrivesc filtrelor
        for (int i = 0; i < actori.size(); i++) {
            int verif = 1;

            int aux = query.getFilters().size() - 1;
            if (query.getFilters().get(aux) != null) {
                for (int j = 0; j < query.getFilters().get(aux).size(); j++) {
                    if (
!actori.get(i).getAwards().containsKey(ActorsAwards.valueOf(query.getFilters().get(aux).get(j)))) {
                        verif = 0;
                    }
                }
            }


            if (verif == 1) {
                lista.add(actori.get(i));
            }
        }

        //sortez cum este cerut
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (swapAwardsAsc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (swapAwardsDesc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }


        for (int i = 0; i < lista.size(); i++) {
            primeleN.add(lista.get(i).getName());
        }

        mesaj = "Query result: " + primeleN;
        return mesaj;
    }


    //favorite

    /**
     * Functie care intoarce de cate ori este un film trecut la favorite
     */
    public int nrFav(final String nume, final List<UserInputData> useri) {
        int nrFav = 0;
        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getFavoriteMovies().contains(nume)) {
                nrFav++;
            }
        }
        return nrFav;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul ascendent
     */
    public int swapFavAsc(final VideoFavorite video1, final VideoFavorite video2) {
        if (video1.getNrFav() > video2.getNrFav()) {
            return 1;
        }
        if (video1.getNrFav() == video2.getNrFav()
                && video1.getNume().compareTo(video2.getNume()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int swapFavDesc(final VideoFavorite video1, final VideoFavorite video2) {
        if (video1.getNrFav() < video2.getNrFav()) {
            return 1;
        }
        if (video1.getNrFav() == video2.getNrFav()
                && video1.getNume().compareTo(video2.getNume()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "favorite"
     */
    public String favorite(final List<MovieInputData> filme,
                           final List<SerialInputData> seriale,
                           final List<UserInputData> useri, final ActionInputData query) {
        ArrayList<VideoFavorite> lista = new ArrayList<>();
        List<MovieInputData> copieFilme = new ArrayList<>();
        List<SerialInputData> copieSeriale = new ArrayList<>();
        List<String> primeleN = new ArrayList<>();
        String mesaj = new String();

        if (query.getObjectType().equals("movies")) {
            //selectez doar filmele care se potrivesc filtrelor
            for (int i = 0; i < filme.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {

                    if (filme.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (!filme.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieFilme.add(filme.get(i));
                }
            }

            for (int k = 0; k < copieFilme.size(); k++) {
                if (nrFav(copieFilme.get(k).getTitle(), useri) > 0) {
                    VideoFavorite aux = new VideoFavorite(copieFilme.get(k).getTitle(),
                            nrFav(copieFilme.get(k).getTitle(), useri));
                    lista.add(aux);
                }
            }
        }
        if (query.getObjectType().equals("shows")) {
            //selectez doar serialele care se potrivesc filtrelor
            for (int i = 0; i < seriale.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null
                        && query.getFilters().get(0).get(0) != null) {
                    if (seriale.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (
                    !seriale.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieSeriale.add(seriale.get(i));
                }
            }

            //adaug doar videourile care au fost bagate la favorite macar o data
            for (int k = 0; k < copieSeriale.size(); k++) {
                if (nrFav(copieSeriale.get(k).getTitle(), useri) > 0) {
                    VideoFavorite aux = new VideoFavorite(copieSeriale.get(k).getTitle(),
                            nrFav(copieSeriale.get(k).getTitle(), useri));
                    lista.add(aux);
                }
            }
        }

        //sortez cum se cere
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (swapFavAsc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (swapFavDesc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }

        //afisez cate videouri sunt cerute
        if (query.getNumber() >= lista.size()) {
            for (int i = 0; i < lista.size(); i++) {
                primeleN.add(lista.get(i).getNume());
            }
            mesaj = "Query result: " + primeleN;
        }
        if (query.getNumber() < lista.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(lista.get(i).getNume());
            }
            mesaj = "Query result: " + primeleN;
        }
        return mesaj;

    }


    // most_viewed

    /**
     * Functie care intoarce de cate ori a fost un film vizualizat
     */
   public int nrViz(final String titlu, final List<UserInputData> useri) {
        int nrViz = 0;

        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getHistory().containsKey(titlu)) {
                nrViz = nrViz + useri.get(i).getHistory().get(titlu);
            }
        }
        return nrViz;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul ascendent
     */
    public int sortMostViewedAsc(final VideoVizualizari video1, final VideoVizualizari video2) {
        if (video1.getVizualizari() > video2.getVizualizari()) {
            return 1;
        }
        if (video1.getVizualizari() == video2.getVizualizari()
                && video1.getNume().compareTo(video2.getNume()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int sortMostViewedDesc(final VideoVizualizari video1, final VideoVizualizari video2) {
        if (video1.getVizualizari() < video2.getVizualizari()) {
            return 1;
        }
        if (video1.getVizualizari() == video2.getVizualizari()
                && video1.getNume().compareTo(video2.getNume()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "most_viewed"
     */
    public String mostViewed(final List<MovieInputData> filme,
                              final List<SerialInputData> seriale,
                              final List<UserInputData> useri,
                              final ActionInputData query) {
        ArrayList<VideoVizualizari> lista = new ArrayList<>();
        List<MovieInputData> copieFilme = new ArrayList<>();
        List<SerialInputData> copieSeriale = new ArrayList<>();
        List<String> primeleN = new ArrayList<>();
        String mesaj = new String();

        if (query.getObjectType().equals("movies")) {
            //selectez doar filmele care se potrivesc filtrelor
            for (int i = 0; i < filme.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {
                    if (filme.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1) != null
                        && query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (!filme.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieFilme.add(filme.get(i));
                }
            }

            for (int k = 0; k < copieFilme.size(); k++) {
                if (nrViz(copieFilme.get(k).getTitle(), useri) > 0) {
                    VideoVizualizari aux = new VideoVizualizari(copieFilme.get(k).getTitle(),
                            nrViz(copieFilme.get(k).getTitle(), useri));
                    lista.add(aux);
                }
            }
        }
        if (query.getObjectType().equals("shows")) {
            //selectez doar serialele care se potrivesc filtrelor
            for (int i = 0; i < seriale.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {
                    if (seriale.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (
                    !seriale.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieSeriale.add(seriale.get(i));
                }
            }
            for (int k = 0; k < copieSeriale.size(); k++) {
                if (nrViz(copieSeriale.get(k).getTitle(), useri) > 0) {
                    VideoVizualizari aux = new VideoVizualizari(copieSeriale.get(k).getTitle(),
                            nrViz(copieSeriale.get(k).getTitle(), useri));
                    lista.add(aux);
                }
            }
        }

        //sortez cum se cere
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (sortMostViewedAsc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (sortMostViewedDesc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }

        //afisez cate se cer
        if (query.getNumber() >= lista.size()) {
            for (int i = 0; i < lista.size(); i++) {
                primeleN.add(lista.get(i).getNume());
            }
            mesaj = "Query result: " + primeleN;
        }
        if (query.getNumber() < lista.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(lista.get(i).getNume());
            }
            mesaj = "Query result: " + primeleN;
        }
        return mesaj;
    }


    //Ratings

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul ascendent
     */
    public int swapRatingsAsc(final VideoMedieNote video1, final VideoMedieNote video2) {
        if (video1.getNotaFinala() > video2.getNotaFinala()) {
            return 1;
        }
        if (video1.getNotaFinala() == video2.getNotaFinala()
                && video1.getTitlu().compareTo(video2.getTitlu()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int swapRatingsDesc(final VideoMedieNote video1, final VideoMedieNote video2) {
        if (video1.getNotaFinala() < video2.getNotaFinala()) {
            return 1;
        }
        if (video1.getNotaFinala() == video2.getNotaFinala()
                && video1.getTitlu().compareTo(video2.getTitlu()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "ratings"
     */
    public String ratings(final List<MovieInputData> filme,
                          final List<SerialInputData> seriale,
                          final ArrayList<VideoNote> filmeNote,
                          final ActionInputData query) {
        ArrayList<VideoMedieNote> lista = new ArrayList<>();
        VideoNote ajutor = new VideoNote();
        List<MovieInputData> copieFilme = new ArrayList<>();
        List<SerialInputData> copieSeriale = new ArrayList<>();
        List<String> primeleN = new ArrayList<>();
        String mesaj = new String();

        if (query.getObjectType().equals("movies")) {
            //selectez doar filmele care se potrivesc filtrelor
            for (int i = 0; i < filme.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {
                    if (filme.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
                        if (!filme.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieFilme.add(filme.get(i));
                }
            }

            for (int k = 0; k < copieFilme.size(); k++) {
                if (ajutor.notaFilm2(copieFilme.get(k), filmeNote) > 0) {
                    VideoMedieNote aux = new
                            VideoMedieNote(copieFilme.get(k).getTitle(),
                            ajutor.notaFilm2(copieFilme.get(k), filmeNote));
                    lista.add(aux);
                }
            }
        }
        if (query.getObjectType().equals("shows")) {
            //selectez doar serialele care se potrivesc filtrelor
            for (int i = 0; i < seriale.size(); i++) {
                int verif = 1;

                if (query.getFilters().get(0) != null && query.getFilters().get(0).get(0) != null) {
                    if (seriale.get(i).getYear()
                            != Integer.parseInt(query.getFilters().get(0).get(0))) {
                        verif = 0;
                    }
                }

                if (query.getFilters().get(1).get(0) != null) {
                    for (int j = 0; j < query.getFilters().get(1).size(); j++) {
        if (!seriale.get(i).getGenres().contains(query.getFilters().get(1).get(j))) {
                            verif = 0;
                        }
                    }
                }

                if (verif == 1) {
                    copieSeriale.add(seriale.get(i));
                }
            }
            for (int k = 0; k < copieSeriale.size(); k++) {
                if (ajutor.notaSerial(copieSeriale.get(k), filmeNote) > 0) {
                    VideoMedieNote aux = new
                            VideoMedieNote(copieSeriale.get(k).getTitle(),
                            ajutor.notaSerial(copieSeriale.get(k), filmeNote));
                    lista.add(aux);
                }
            }
        }

        //asortez cum se cere
        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (swapRatingsAsc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (lista.size() - 1); i++) {
                for (int j = i + 1; j < lista.size(); j++) {
                    if (swapRatingsDesc(lista.get(i), lista.get(j)) == 1) {
                        Collections.swap(lista, i, j);
                    }
                }
            }
        }

        //afisez cate se cer
        if (query.getNumber() >= lista.size()) {
            for (int i = 0; i < lista.size(); i++) {
                primeleN.add(lista.get(i).getTitlu());
            }
            mesaj = "Query result: " + primeleN;
        }
        if (query.getNumber() < lista.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(lista.get(i).getTitlu());
            }
            mesaj = "Query result: " + primeleN;
        }
        return mesaj;

    }


    //Average

    /**
     * Functie care intoarce media notelor filmelor unui actor
     */
    public double medieActor(final ActorInputData actor, final List<MovieInputData> filme,
                             final List<SerialInputData> seriale,
                             final ArrayList<VideoNote> filmeNote) {
        double medieActor = 0;
        int nr = 0;
        VideoNote ajutor = new VideoNote();

        for (int i = 0; i < actor.getFilmography().size(); i++) {
            //verific daca este film sau serial
            int index1 = -1;
            int index2 = -1;
            for (int j = 0; j < filme.size(); j++) {
                if (actor.getFilmography().get(i).equals(filme.get(j).getTitle())) {
                    index1 = j;
                }
            }

            for (int j = 0; j < seriale.size(); j++) {
                if (actor.getFilmography().get(i).equals(seriale.get(j).getTitle())) {
                    index2 = j;
                }
            }

            if (index1 != -1) {
                if (ajutor.notaFilm2(filme.get(index1), filmeNote) != 0) {
                    medieActor = medieActor + ajutor.notaFilm2(filme.get(index1), filmeNote);
                    nr = nr + 1;
                }
            }

            if (index2 != -1) {
                if (ajutor.notaSerial(seriale.get(index2), filmeNote) != 0) {
                    medieActor = medieActor + ajutor.notaSerial(seriale.get(index2), filmeNote);
                    nr = nr + 1;
                }
            }
        }
        if (nr != 0) {
            medieActor = medieActor / nr;
        }

        return  medieActor;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul ascendent
     */
    public int sortareAveregeAsc(final ActorInputData actor1,
                                 final ActorInputData actor2,
                                 final List<MovieInputData> filme,
                                 final List<SerialInputData> seriale,
                                 final ArrayList<VideoNote> filmeNote) {
        if (medieActor(actor1, filme, seriale, filmeNote)
                > medieActor(actor2, filme, seriale, filmeNote)) {
            return 1;
        }
        if (medieActor(actor1, filme, seriale, filmeNote)
                == medieActor(actor2, filme, seriale, filmeNote)
                && actor1.getName().compareTo(actor2.getName()) > 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care arata daca doua elemente trebuie interschimbate
     * pentru cazul descendent
     */
    public int sortareAveregeDesc(final ActorInputData actor1,
                                  final ActorInputData actor2,
                                  final List<MovieInputData> filme,
                                  final List<SerialInputData> seriale,
                                  final ArrayList<VideoNote> filmeNote) {
        if (medieActor(actor1, filme, seriale, filmeNote)
                < medieActor(actor2, filme, seriale, filmeNote)) {
            return 1;
        }
        if (medieActor(actor1, filme, seriale, filmeNote)
                == medieActor(actor2, filme, seriale, filmeNote)
                && actor1.getName().compareTo(actor2.getName()) < 0) {
            return 1;
        }
        return 0;
    }

    /**
     * Functie care face implementare pentru
     * query-ul "average"
     */
    public String average(final List<ActorInputData> actori,
                          final List<MovieInputData> filme,
                          final List<SerialInputData> seriale,
                          final ArrayList<VideoNote> filmeNote,
                          final ActionInputData query) {

        String mesaj = new String();
        List<ActorInputData> copieActori = new ArrayList<>();
        ArrayList<String> primeleN = new ArrayList<>();
        ArrayList<ActorMedie> actoriMedii = new ArrayList<>();

        for (int i = 0; i < actori.size(); i++) {
            ActorMedie aux = new
                    ActorMedie(actori.get(i).getName(),
                    medieActor(actori.get(i), filme, seriale, filmeNote));

            actoriMedii.add(aux);
            if (medieActor(actori.get(i), filme, seriale, filmeNote) > 0) {
                copieActori.add(actori.get(i));
            }
        }


        if (query.getSortType().equals("asc")) {
            for (int i = 0; i < (copieActori.size() - 1); i++) {
                for (int j = i + 1; j < copieActori.size(); j++) {
                    if (sortareAveregeAsc(copieActori.get(i), copieActori.get(j),
                            filme, seriale, filmeNote) == 1) {
                        Collections.swap(copieActori, i, j);
                    }
                }
            }
        }
        if (query.getSortType().equals("desc")) {
            for (int i = 0; i < (copieActori.size() - 1); i++) {
                for (int j = i + 1; j < copieActori.size(); j++) {
                    if (sortareAveregeDesc(copieActori.get(i), copieActori.get(j),
                            filme, seriale, filmeNote) == 1) {
                        Collections.swap(copieActori, i, j);
                    }
                }
            }
        }

        if (query.getNumber() >= copieActori.size()) {
            for (int i = 0; i < copieActori.size(); i++) {
                primeleN.add(copieActori.get(i).getName());
            }
            mesaj = "Query result: " + primeleN;
        }
        if (query.getNumber() < copieActori.size()) {
            for (int i = 0; i < query.getNumber(); i++) {
                primeleN.add(copieActori.get(i).getName());
            }
            mesaj = "Query result: " + primeleN;
        }
        return mesaj;
    }
}
