package functii.Utile;
import fileio.ActionInputData;
import fileio.MovieInputData;
import fileio.SerialInputData;
import fileio.UserInputData;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Recommendation {

    //STANDARD

    /**
     * Metoda care implementeaza recommendation de tip "standard"
     */
    public String standard(final UserInputData user, final List<MovieInputData> filme) {
        String mesaj;
        for (int i = 0; i < filme.size(); i++) {
            if (!user.getHistory().containsKey(filme.get(i).getTitle())) {
                mesaj = "StandardRecommendation result: " + filme.get(i).getTitle();
                return mesaj;
            }
        }
        mesaj = "StandardRecommendation cannot be applied!";
        return mesaj;
    }

    //BEST UNSEEN

    /**
     * Metoda care implementeaza recommendation de tip "Best unseen"
     */
    public String bestUnseen(final UserInputData user,
                             final List<MovieInputData> filme,
                             final List<SerialInputData> seriale,
                             final ArrayList<VideoNote> lista) {
        String mesaj;
        double notaMax = -1;
        VideoNote ajutor = new VideoNote();
        String bestMovie = "BestRatedUnseenRecommendation cannot be applied!";

        for (int i = 0; i < filme.size(); i++) {
            //daca nu a vazut videoclipul
            if (!user.getHistory().containsKey(filme.get(i).getTitle())) {
                if (ajutor.notaFilm2(filme.get(i), lista) > notaMax) {
                    notaMax = ajutor.notaFilm2(filme.get(i), lista);
                    bestMovie = filme.get(i).getTitle();
                }

            }
        }

        for (int i = 0; i < seriale.size(); i++) {
            //daca nu a vazut videoclipul
            if (!user.getHistory().containsKey(seriale.get(i).getTitle())) {
                if (ajutor.notaSerial(seriale.get(i), lista) > notaMax) {
                    notaMax = ajutor.notaSerial(seriale.get(i), lista);
                    bestMovie = seriale.get(i).getTitle();
                }
            }
        }
        if (bestMovie.equals("BestRatedUnseenRecommendation cannot be applied!")) {
            return bestMovie;
        }

        mesaj = "BestRatedUnseenRecommendation result: " + bestMovie;
        return mesaj;

    }

    //POPULAR

    /**
     * Metoda care intoarce numarul de vizualizari pt un film
     */
    public int nrVizualizariFilm(final List<UserInputData> useri,
                                 final MovieInputData film) {
        int nrViz = 0;
        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getHistory().containsKey(film.getTitle())) {
                nrViz = nrViz + useri.get(i).getHistory().get(film.getTitle());
            }
        }
        return nrViz;
    }

    /**
     * Metoda care intoarce numarul de vizualizari pt un serial
     */
    public int nrVizualizariSerial(final List<UserInputData> useri,
                                   final SerialInputData serial) {
        int nrViz = 0;

        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getHistory().containsKey(serial.getTitle())) {
                nrViz = nrViz + useri.get(i).getHistory().get(serial.getTitle());
            }
        }

        return nrViz;
    }

    /**
     * Metoda care intoarce numarul de vizualizari
     * pe care le are un gen de filme
     */
    public int popularitateGen(final String gen,
                               final List<UserInputData> useri,
                               final List<SerialInputData> seriale,
                               final List<MovieInputData> filme) {
        int nrViz = 0;

        for (int i = 0; i < filme.size(); i++) {
            if (filme.get(i).getGenres().contains(gen)) {
                nrViz = nrViz + nrVizualizariFilm(useri, filme.get(i));
            }
        }

        for (int i = 0; i < seriale.size(); i++) {
            if (seriale.get(i).getGenres().contains(gen)) {
                nrViz = nrViz + nrVizualizariSerial(useri, seriale.get(i));
            }
        }
        return nrViz;
    }

    /**
     * Metoda care implementeaza recommendation de tip "popular"
     */
    public String popular(final UserInputData utilizator,
                          final List<UserInputData> useri,
                          final List<SerialInputData> seriale,
                          final List<MovieInputData> movies) {
        String mesaj = "PopularRecommendation cannot be applied!";

        if (utilizator.getSubscriptionType().equals("BASIC")) {
            mesaj = "PopularRecommendation cannot be applied!";
            return mesaj;
        }

        ArrayList<GenrePopular> genuriNrViz = new ArrayList<>();
        genuriNrViz.add(new GenrePopular("Drama"));
        genuriNrViz.add(new GenrePopular("Horror"));
        genuriNrViz.add(new GenrePopular("Thriller"));
        genuriNrViz.add(new GenrePopular("Action"));
        genuriNrViz.add(new GenrePopular("Adventure"));
        genuriNrViz.add(new GenrePopular("Science Fiction"));
        genuriNrViz.add(new GenrePopular("Comedy"));
        genuriNrViz.add(new GenrePopular("Animation"));
        genuriNrViz.add(new GenrePopular("Fantasy"));
        genuriNrViz.add(new GenrePopular("Romance"));
        genuriNrViz.add(new GenrePopular("Family"));
        genuriNrViz.add(new GenrePopular("War"));
        genuriNrViz.add(new GenrePopular("History"));
        genuriNrViz.add(new GenrePopular("Thriller"));
        genuriNrViz.add(new GenrePopular("Crime"));
        genuriNrViz.add(new GenrePopular("TV Movie"));
        genuriNrViz.add(new GenrePopular("Sci-Fi & Fantasy"));
        genuriNrViz.add(new GenrePopular("Action & Adventure"));
        genuriNrViz.add(new GenrePopular("Kids"));
        genuriNrViz.add(new GenrePopular("Action & Adventure"));

        for (int i = 0; i < (genuriNrViz.size() - 1); i++) {
            for (int j = i + 1; j < genuriNrViz.size(); j++) {
                if (popularitateGen(genuriNrViz.get(i).getTip(), useri, seriale, movies)
                        < popularitateGen(genuriNrViz.get(i).getTip(), useri, seriale, movies)) {
                    Collections.swap(genuriNrViz, i, j);
                }
            }
        }

        for (int i = 0; i < genuriNrViz.size(); i++) {
            for (int j = 0; j < movies.size(); j++) {
                if (movies.get(j).getGenres().contains(genuriNrViz.get(i).getTip())
                        && !utilizator.getHistory().containsKey(movies.get(j).getTitle())) {
                    mesaj = "PopularRecommendation result: " + movies.get(j).getTitle();
                    return mesaj;
                }
            }
            for (int j = 0; j < seriale.size(); j++) {
                if (seriale.get(j).getGenres().contains(genuriNrViz.get(i).getTip())
                        && !utilizator.getHistory().containsKey(seriale.get(j).getTitle())) {
                    mesaj = "PopularRecommendation result: " + seriale.get(j).getTitle();
                    return mesaj;
                }
            }
        }

        mesaj = "PopularRecommendation cannot be applied!";
        return mesaj;
    }

    //FAVORITE

    /**
     * Metoda care implementeaza intoarce de care ori a fost bagat un film la favorite
     */
    public int nrFavoriteFilm(final List<UserInputData> useri, final MovieInputData film) {
        int nrFav = 0;
        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getFavoriteMovies().contains(film.getTitle())) {
                nrFav++;
            }
        }
        return nrFav;
    }

    /**
     * Metoda care implementeaza intoarce de care ori a fost bagat un film la favorite
     */
    public int nrFavoriteSerial(final List<UserInputData> useri, final SerialInputData serial) {
        int nrFav = 0;
        for (int i = 0; i < useri.size(); i++) {
            if (useri.get(i).getFavoriteMovies().contains(serial.getTitle())) {
                nrFav++;
            }
        }
        return nrFav;
    }

    /**
     * Metoda care implementeaza recommendation de tip "favorite"
     */
    public String favorite(final UserInputData utilizator,
                           final List<UserInputData> useri,
                           final List<SerialInputData> seriale,
                           final List<MovieInputData> movies) {
        String mesaj = "FavoriteRecommendation cannot be applied!";
        String mostPopularMovie = new String();
        int nrMaxFav = 0;

        if (utilizator.getSubscriptionType().equals("BASIC")) {
            mesaj = "FavoriteRecommendation cannot be applied!";
            return mesaj;
        }

        for (int i = 0; i < movies.size(); i++) {
            if (!utilizator.getHistory().containsKey(movies.get(i).getTitle())) {
                if (nrFavoriteFilm(useri, movies.get(i)) > nrMaxFav) {
                    nrMaxFav = nrFavoriteFilm(useri, movies.get(i));
                    mostPopularMovie = movies.get(i).getTitle();
                }
            }
        }

        for (int i = 0; i < seriale.size(); i++) {
            if (!utilizator.getHistory().containsKey(seriale.get(i).getTitle())) {
                if (nrFavoriteSerial(useri, seriale.get(i)) > nrMaxFav) {
                    nrMaxFav = nrFavoriteSerial(useri, seriale.get(i));
                    mostPopularMovie = seriale.get(i).getTitle();
                }
            }
        }

        if (nrMaxFav == 0) {
            return mesaj;
        }

        mesaj = "FavoriteRecommendation result: " + mostPopularMovie;
        return mesaj;

    }

    //SEARCH

    /**
     * Metoda care arata daca doua elemente trb interschimbate
     */
    public int swapSearchAsc(final VideoMedieNote video1,
                             final VideoMedieNote video2) {
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
     * Metoda care implementeaza recommendation "search"
     */
    public String search(final UserInputData utilizator,
                         final ActionInputData query,
                         final List<SerialInputData> seriale,
                         final List<MovieInputData> movies,
                         final ArrayList<VideoNote> lista) {
        String mesaj = "SearchRecommendation cannot be applied!";
        ArrayList<VideoMedieNote> listaFilme = new ArrayList<>();
        ArrayList<String> listaOrdonata = new ArrayList<>();
        VideoNote ajutor = new VideoNote();

        if (utilizator.getSubscriptionType().equals("BASIC")) {
            mesaj = "SearchRecommendation cannot be applied!";
            return mesaj;
        }

        for (int i = 0; i < movies.size(); i++) {
            if (!utilizator.getHistory().containsKey(movies.get(i).getTitle())) {
                if (movies.get(i).getGenres().contains(query.getGenre())) {
                    int j = ajutor.findMovie(lista, movies.get(i).getTitle());
                    if (j == -1) {
                        VideoMedieNote element = new VideoMedieNote(movies.get(i).getTitle(),
                                0);
                        listaFilme.add(element);
                    }
                    if (j != -1) {
                        VideoMedieNote element = new VideoMedieNote(movies.get(i).getTitle(),
                                ajutor.notaFilm(lista.get(j)));
                        listaFilme.add(element);
                    }
                }
            }
        }

        for (int i = 0; i < seriale.size(); i++) {
            if (!utilizator.getHistory().containsKey(seriale.get(i).getTitle())) {
                if (seriale.get(i).getGenres().contains(query.getGenre())) {
                    VideoMedieNote element = new VideoMedieNote(seriale.get(i).getTitle(),
                            ajutor.notaSerial(seriale.get(i), lista));
                    listaFilme.add(element);
                }

            }
        }

        for (int i = 0; i < (listaFilme.size() - 1); i++) {
            for (int j = i + 1; j < listaFilme.size(); j++) {
                if (swapSearchAsc(listaFilme.get(i), listaFilme.get(j)) == 1) {
                    Collections.swap(listaFilme, i, j);
                }
            }
        }


        for (int i = 0; i < listaFilme.size(); i++) {
            listaOrdonata.add(listaFilme.get(i).getTitlu());
        }
        if (listaOrdonata.size() != 0) {
            mesaj = "SearchRecommendation result: " + listaOrdonata;
            return mesaj;
        }
        return mesaj;

    }
}
