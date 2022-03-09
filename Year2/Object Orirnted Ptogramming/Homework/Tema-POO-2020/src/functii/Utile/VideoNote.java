package functii.Utile;

import fileio.MovieInputData;
import fileio.SerialInputData;

import java.util.ArrayList;

public class VideoNote {
    private final String titlu; //titlul videoclipului
    private final int sezon; //sezonul videoclipului
    private final ArrayList<Double> note; //notele filmului

    /**
     * Functie getter titlu
     */
    public String getTitlu() {
        return titlu;
    }

    /**
     * Functie getter sezon
     */
    public int getSezon() {
        return sezon;
    }

    /**
     * Functie getter note
     */
    public ArrayList<Double> getNote() {
        return note;
    }

    /**
     * Functie getter adauga in lista de note o nota
     */
    public void adaugareNota(final VideoNote video, final double nota) {
        video.note.add(nota);
    }

    protected VideoNote(final String titlu, final int sezon, final double grade) {
        this.sezon = sezon;
        this.titlu = titlu;
        this.note = new ArrayList<>();
        this.note.add(grade);
    }

    protected VideoNote() {
        this.note = new ArrayList<>();
        this.titlu = new String();
        this.sezon = 0;
    }

    /**
     * Functie care intoarce indicii unde se gaseste filmul
     */
    public ArrayList<Integer> findVideoWithSameName(final ArrayList<VideoNote> lista,
                                                    final String nume) {
        ArrayList<Integer> indexes = new ArrayList<>();
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).titlu.equals(nume)) {
                indexes.add(i);
            }
        }

        return indexes;
    }

    /**
     * Functie care intoarce indexul unde se gaseste videoul
     */
    public int findVideoWithSameNameAndSeason(final ArrayList<VideoNote> lista,
                                              final String nume, final int sezon1) {
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).titlu.equals(nume)
                    && lista.get(i).sezon == sezon1) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Functie care intoarce indexul unde se gaseste videoul
     */
    public int findMovie(final ArrayList<VideoNote> lista, final String nume) {
        for (int i = 0; i < lista.size(); i++) {
            if (lista.get(i).titlu.equals(nume)) {
                return i;
            }
        }
        return -1;
    }

    /**
     * Functie care intoarce media notelor unui film
     */
    public double notaFilm(final VideoNote film) {
        double ma = 0;
        for (int i = 0; i < film.note.size(); i++) {
            ma = ma + film.note.get(i);
        }

        ma = ma / film.note.size();
        return ma;
    }

    /**
     * Functie care intoarce media notelur unui film fara a sti indexul
     * unde acesta se afla in lista
     */
    public double notaFilm2(final MovieInputData film, final ArrayList<VideoNote> lista) {
        int index = findMovie(lista, film.getTitle());
        if (index == -1) {
            return 0;
        }
        return notaFilm(lista.get(index));
    }



    /**
     * Functie care intoarce nota unui serial
     */
    public double notaSerial(final SerialInputData serial, final ArrayList<VideoNote> lista) {
        double ma = 0;
        VideoNote ajutor = new VideoNote();
        ArrayList<Integer> indexes = ajutor.findVideoWithSameName(lista, serial.getTitle());

        for (int i = 0; i < indexes.size(); i++) {
            double sum = 0;
            for (int j = 0; j < lista.get(indexes.get(i)).note.size(); j++) {
                sum = sum + lista.get(indexes.get(i)).note.get(j);
            }
            ma = ma + (sum / lista.get(indexes.get(i)).note.size());
        }

        ma = ma / serial.getNumberSeason();
        return ma;

    }





}
