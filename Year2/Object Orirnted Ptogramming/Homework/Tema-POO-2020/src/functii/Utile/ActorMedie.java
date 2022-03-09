package functii.Utile;

public class ActorMedie {

    /*
    aceasta clasa este folosita pentru metoda "average"
    din clasa Query
     */

    //numele actorului
    private final String nume;
    //media notelor filmelor in care a jucat
    private final double medie;

    /**
     * getter nume
     */
    public String getNume() {
        return nume;
    }

    /**
     * getter medie
     */
    public double getMedie() {
        return medie;
    }


    protected ActorMedie(final String nume, final double medie) {
        this.medie = medie;
        this.nume = nume;
    }




}
