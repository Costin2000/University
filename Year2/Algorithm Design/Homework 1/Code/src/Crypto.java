import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Scanner;

class PersonalComputer {
	public Integer P;
	public Integer U;

	public Integer getP() {
		return P;
	}

	public Integer getU() {
		return U;
	}

	public PersonalComputer(Integer p, Integer u) {
		P = p;
		U = u;
	}

}

public class Crypto {
	public static void main(String[] args) throws IOException {


		// citesc din fisier datele de intrare
		int N;
		int B;
		Scanner scanner = new Scanner(new File("crypto.in"));
		N = scanner.nextInt();
		B = scanner.nextInt();
		ArrayList<PersonalComputer> calculatoare = new ArrayList<>();
		for (int i = 0; i < N; i++) {
			PersonalComputer cNew = new PersonalComputer(scanner.nextInt(), scanner.nextInt());
			calculatoare.add(cNew);
		}

		//sortez vectorul crescator dupa performanta
		calculatoare.sort(Comparator.comparing(PersonalComputer::getP));

		// numarul initial de monede pe care le face gigel pe ora
		int nrMonede = calculatoare.get(0).getP();

		// costul initial pentru a mari cu 1 numarul de monede/ora
		int totalSumPerUpgrade = calculatoare.get(0).getU();
		int currentIndex = 0;
		int exit = 0;

		// creez o bucla infinita din care ies daca nu mai am suficienti
		// bani pentru a creste numarul de monede cu 1
		while (true) {
			int copie = currentIndex + 1;

			//calculez cat trebuie sa cheltuiesc ca sa creasca cu 1 numarul de monede
			//daca au mai multe calculatoare performanta == performanta_minima
			// adun costurile de upgrade al tuturor acestor calculatoare
			// pt a le upgrada in acelasi timp, astfel avand o eficienta mai buna.
			// Suma costurilor acestora devine noua suma pe care gigel
			//trebuie sa o plateasca pt a produce o moneda in plus pe ora
			for (int i = copie ; i < N; i++) {
				if (nrMonede == calculatoare.get(i).getP()) {
					currentIndex ++;
					totalSumPerUpgrade = totalSumPerUpgrade + calculatoare.get(i).getU();
				} else {
					break;
				}
			}

			//daca toate calculatoarele au aceeasi performanta le dau upgrade
			// tuturor in acelasi timp pana raman fara bani
			if (currentIndex == (N - 1)) {
				while (B >= totalSumPerUpgrade) {
					B = B - totalSumPerUpgrade;
					nrMonede++;
				}
				break;
			}

			// dau upgrade calculatoarelor cu aceeasi performanta
			// (care este cea minima) pana cand ajung la
			// a doua cea mai slaba performanta sau pana cand raman fara bani
			if (B >= totalSumPerUpgrade) {
				while (true) {
					B = B - totalSumPerUpgrade;
					nrMonede++;
					if (nrMonede == calculatoare.get(currentIndex + 1).getP()) {
						break;
					}
					if (B < totalSumPerUpgrade) {
						exit = 1;
						break;
					}
				}
			} else {
				exit = 1;
			}

			//daca exit e 1 se iese din bucla infinita
			if (exit == 1) {
				break;
			}
		}

		// afisez rezultatul
		BufferedWriter writer = new BufferedWriter(new FileWriter("crypto.out"));
		writer.write(Integer.toString(nrMonede));
		writer.close();
	}
}
