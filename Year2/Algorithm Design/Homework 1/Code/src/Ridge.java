import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

class Varf {

	public Integer inaltime;

	public Integer costEscavare;

	public Integer getInaltime() {
		return inaltime;
	}

	public Integer getCostEscavare() {
		return costEscavare;
	}

	public Varf(Integer inaltime, Integer costEscavare) {
		this.inaltime = inaltime;
		this.costEscavare = costEscavare;
	}

}


public class Ridge {

	public static void main(String[] args) throws IOException {

		int N;
		Scanner scanner = new Scanner(new File("ridge.in"));
		N = scanner.nextInt();
		ArrayList<Varf> varfuri = new ArrayList<>();

		//citesc din fisier si retin in arrayul declarat anterior
		for (int i = 0; i < N; i++) {
			Varf vNew = new Varf(scanner.nextInt(), scanner.nextInt());
			varfuri.add(vNew);
		}

		/*
		In cel mai rau caz, atunci cand se intampla ca vec[i] == vec[i-1]
		trebuie sa decrementam vec[i] cu cel mult 2. In prima faza il
		decrementez pentru a nu mai fi egal cu v[i-1], iar odata scazut
		acesta poate deveni egal cu v[i-1] si ar mai trebui scazut o data,
		tinant cont de costuri la ambele decrementari.
		*/

		/*
		aloc memorie pt tabela dp
		aceasta va avea N linii si 3 coloane
		dp[i][j] - va reprezenta costul decrementarii inaltimii varfului
		i cu j unitati
		 */
		long [][]dp = new long[N][3];

		/*
		initializez costurile pt primul varf deoarece acesta
		nu are un varf precedent, deci nu depinde de nimeni
		*/

		// pretul cand acesta ramane nemodificat
		dp[0][0] = 0;
		// pret cand se extrage o unitate
		dp[0][1] = varfuri.get(0).getCostEscavare();
		// pret cand se extrag doua unitati
		dp[0][2] = varfuri.get(0).getCostEscavare() * 2;

		//imi strabat tabela dp
		for (int i = 1; i < N; i++) {
			for (int j = 0; j < 3; j++) {
				// Am doua cazuri
				/*
				 - cand varful curent are inaltimea mai mare sau egala
					ca doi, si nu sunt riscuri
				 - cand varful curent are inaltimea mai mica decat doi,
					deci exista riscul sa se ajunga la o inaltime negativa
				 */

				if (varfuri.get(i).getInaltime() - j >= 0) {

					//initializez variabila de minim
					long minimum = Long.MAX_VALUE;

					//daca elementul curent nu e egal cu elementul trecut nedecrementat
					if (varfuri.get(i).getInaltime() - j != varfuri.get(i - 1).getInaltime()) {
						minimum = Math.min(minimum, dp[i - 1][0]);
					}

					//daca elementul curent nu e egal cu elementul trecut decrementat cu unu
					if (varfuri.get(i).getInaltime() - j
							!= (varfuri.get(i - 1).getInaltime() - 1)) {
						minimum = Math.min(minimum, dp[i - 1][1]);
					}

					//daca elementul curent nu e egal cu elementul trecut decrementat cu doi
					if (varfuri.get(i).getInaltime() - j
							!= (varfuri.get(i - 1).getInaltime() - 2)) {
						minimum = Math.min(minimum, dp[i - 1][2]);
					}

					//setez in tabela de rutare variabila corespunzatoare
					dp[i][j] = (long) j * varfuri.get(i).getCostEscavare() + minimum;
				} else {
					/*
					daca ne aflam in cazul in care inaltimea varfului curent ar deveni
					negativa o setam cu un numar foarte mare pt a nu se pune problema
					ca aceasta sa devina o solutie valida
					 */
					dp[i][j] = Long.MAX_VALUE;
				}
			}
		}

		long costMin = Long.MAX_VALUE;

		// selectez minimul din ultima line a tabelei
		for (int i = 0; i < 3; i++) {
			costMin = Math.min(costMin, dp[N - 1][i]);
		}

		//afisez rezultatul obtinut
		BufferedWriter writer = new BufferedWriter(new FileWriter("ridge.out"));
		writer.write(Long.toString(costMin));
		writer.close();


	}
}
