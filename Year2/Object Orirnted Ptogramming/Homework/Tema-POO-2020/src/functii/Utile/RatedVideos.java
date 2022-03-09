package functii.Utile;

public class RatedVideos {

    private final String titlu;
    private final int sezon;

    /**
     * getter titlu
     */
    public String getTitlu() {
        return titlu;
    }

    /**
     * getter sezon
     */
    public int getSezon() {
        return sezon;
    }

    /**
     * initializeaza campurile
     */
    protected RatedVideos(final String titlu, final int sezon) {
        this.sezon = sezon;
        this.titlu = titlu;
    }

}
