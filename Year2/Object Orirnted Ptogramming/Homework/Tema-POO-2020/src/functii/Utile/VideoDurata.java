package functii.Utile;

public class VideoDurata {

    /*
    aceasta clasa este folosita pentru metoda "longest"
    din clasa Query
     */

    //nume videoclip
    private final String nume;
    //durata video
    private final int durata;

    /**
     * Functie getter nume
     */
    public String getNume() {
        return nume;
    }

    /**
     * Functie getter durata
     */
    public int getDurata() {
        return durata;
    }


    protected VideoDurata(final String nume, final int durata) {
        this.durata = durata;
        this.nume = nume;
    }

}


