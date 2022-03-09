import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Valley {

	public static void main(String[] args) throws IOException {

		Scanner scanner = new Scanner(new File("valley.in"));

		//citesc arrayul din fisier si concomitent salvez inaltimea minima
		int N;
		N = scanner.nextInt();
		ArrayList<Integer> vale = new ArrayList<>();
		int min = Integer.MAX_VALUE;
		int idxMin = -1;
		for (int i = 0; i < N; i++) {
			int val = scanner.nextInt();
			if (val < min) {
				min = val;
				idxMin = i;
			}
			vale.add(val);
		}

		long nrModif = 0;

		/*
		tratez problema pe 3 cazuri:
		1) cand elementul minim nu este unul din capetele array-ului
		2) cand elementul minim coincide cu capatul din stanga al array-ului
		3) cand elementul minim coincide cu capatul din dreapta al array-ului
		 */

		//tratez primul caz, can nu se afla la capete
		if (idxMin != 0 && idxMin != (N - 1)) {

			// strabat arrayul de la 1 la idx min si calculez numarul
			// de decrementari pt ca aceasta parte sa devina descrescatoare
			int prev = vale.get(0);
			for (int i = 1; i < idxMin; i++) {
				if (vale.get(i) > prev) {
					nrModif = nrModif + (vale.get(i) - prev);
				} else {
					prev = vale.get(i);
				}
			}

			// strabat arrayul de la N-2 la idx min si calculez numarul
			// de decrementari pt ca [v[idxMin] , v[idxMin + 1], ..., v[N-1]
			// sa fie crescator
			prev = vale.get(N - 1);
			for (int i = N - 2; i > idxMin; i--) {
				if (vale.get(i) > prev) {
					nrModif = nrModif + (vale.get(i) - prev);
				} else {
					prev = vale.get(i);
				}
			}
		} else {
			// daca ne aflam in cazul 3 si minimul e la capatul drept
			// ne asiguram ca v[n - 2] sa fie egal cu minimul, iar
			// restul arrayului ( {0, 1, 2, 3, ..., N - 3} ) sa fie
			// ordonat descrescator, calculand numarul total de decrementari
			// necesar
			if (idxMin == (N - 1)) {
				nrModif = vale.get(N - 2) - vale.get(N - 1);
				int prev = vale.get(0);
				for (int i = 1; i < N - 2; i++) {
					if (vale.get(i) > prev) {
						nrModif = nrModif + (vale.get(i) - prev);
					} else {
						prev = vale.get(i);
					}
				}
			} else {
				// daca ne aflam in cazul 3 si minimul e la capatul stang
				// ne asiguram ca v[1] sa fie egal cu minimul, iar
				// restul arrayului ( {2, 3, ..., N - 1} ) sa fie
				// ordonat crescator, calculand numarul total de decrementari
				// necesar
				nrModif = vale.get(1) - vale.get(0);
				int prev = vale.get(N - 1);
				for (int i = N - 2; i > 2; i--) {
					if (vale.get(i) > prev) {
						nrModif = nrModif + (vale.get(i) - prev);
					} else {
						prev = vale.get(i);
					}
				}
			}
		}

		//afisez rezultatul final
		BufferedWriter writer = new BufferedWriter(new FileWriter("valley.out"));
		writer.write(Long.toString(nrModif));
		writer.close();
	}
}
