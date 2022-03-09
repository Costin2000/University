package functii.Utile;

public class GenrePopular {

    /*
    aceasta clasa se foloseste la metoda popular
    din clasa Recommendation
     */

    //tip de film
    private final String tip;

    //de cate ori este vizualizat acest tip
    private final int nrViz;

    /**
     * Getter pentru tip
     */
    public String getTip() {
        return tip;
    }

    /**
     * Getter pentru numar vizualizari
     */
    public int getNrViz() {
        return nrViz;
    }


    GenrePopular(final String nume) {
        this.tip = nume;
        this.nrViz = 0;
    }
}
