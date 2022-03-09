package functii.Utile;

public class VideoMedieNote {

    /*
    aceasta clasa este folosita pentru metoda "ratings"
    din clasa Query
     */

    //nume video
    private final String titlu;
    //nota acestuia
    private final double notaFinala;

    /**
     * Functie getter titlu
     */
    public String getTitlu() {
        return titlu;
    }

    /**
     * Functie getter notaFinala
     */
    public double getNotaFinala() {
        return notaFinala;
    }

    protected VideoMedieNote(final String titlu, final double notaFinala) {
        this.notaFinala = notaFinala;
        this.titlu = titlu;
    }

}
