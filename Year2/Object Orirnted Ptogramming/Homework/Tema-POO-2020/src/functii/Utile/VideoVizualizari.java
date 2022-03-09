package functii.Utile;

public class VideoVizualizari {

    /*
    aceasta clasa este folosita pentru metoda "mostViewed"
    din clasa Query
     */

    //nume video
    private final String nume;
    //numarul de vizualizari
    private final int vizualizari;

    /**
     * Functie getter nume
     */
    public String getNume() {
        return nume;
    }

    /**
     * Functie getter vizualizari
     */
    public int getVizualizari() {
        return vizualizari;
    }

    public VideoVizualizari(final String nume, final int vizualizari) {
        this.nume = nume;
        this.vizualizari = vizualizari;
    }
}
