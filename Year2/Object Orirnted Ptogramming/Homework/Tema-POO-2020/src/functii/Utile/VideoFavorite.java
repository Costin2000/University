package functii.Utile;

public class VideoFavorite {

    /*
    aceasta clasa este folosita pentru metoda "favorite"
    din clasa Query
     */

    //nume video
    private final String nume;

    //de cate ori a fost adaugat videoul la favorite
    private final int nrFav;

    /**
     * Functie getter nume
     */
    public String getNume() {
        return nume;
    }

    /**
     * Functie getter nr favorite
     */
    public int getNrFav() {
        return nrFav;
    }

    protected VideoFavorite(final String nume, final int nrFav) {
        this.nrFav = nrFav;
        this.nume = nume;
    }
}
