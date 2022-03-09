import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

class Actiune {
	public Integer currentValue;
	public Integer minValue;
	public Integer maxValue;

	public Integer getCurrentValue() {
		return currentValue;
	}

	public Integer getMinValue() {
		return minValue;
	}

	public Integer getMaxValue() {
		return maxValue;
	}

	public Actiune(Integer currentValue, Integer minValue, Integer maxValue) {
		this.currentValue = currentValue;
		this.minValue = minValue;
		this.maxValue = maxValue;
	}
}

public class Stocks {

	public static void main(String[] args) throws IOException {

		//citesc din fisier
		Scanner scanner = new Scanner(new File("stocks.in"));
		int N;
		int B;
		int L;
		N = scanner.nextInt();
		B = scanner.nextInt();
		L = scanner.nextInt();
		ArrayList<Actiune> actiuni = new ArrayList<>();
		for (int i = 0; i < N; i++) {
			Actiune aNew = new Actiune(scanner.nextInt(), scanner.nextInt(), scanner.nextInt());
			actiuni.add(aNew);
		}

		// imi declar un array tridimensional
		// dp[i][j][k] - reprezinta profitul maxim cand iau in considerare
		// doar primele i elemente, am un buget de j si o pierdere maxima
		// de k
		long[][][] dp = new long[N + 1][B + 1][L + 1];


		// strabat vectorul tridimensional cu un for triplu
		for (int i = 1; i <= N; i++) {

			// pt fiecare iteratie calculez profitul si pierderile maxime pe care
			// le pot avea cu elementul
			int profitCurr = actiuni.get(i - 1).getMaxValue()
					- actiuni.get(i - 1).getCurrentValue();

			int pierderiCurr = actiuni.get(i - 1).getCurrentValue()
					- actiuni.get(i - 1).getMinValue();

			for (int j = 1; j <= B; j++) {
				for (int k = 1; k <= L; k++) {

					// verific sa nu am pierderi mai mari decat limita admisa (k)
					// si sa nu depasesc bugetul curent (j)
					if (j >= actiuni.get(i - 1).getCurrentValue() && pierderiCurr <= k) {
						//daca se respecta conditiile, recurenta este la fel ca la knapsack
						//cu un singur criteriu. Se verifica daca obiectul curent merita
						//adaugat sau nu
						dp[i][j][k] = Math.max(dp[i - 1][j][k],
								dp[i - 1][j - actiuni.get(i - 1).getCurrentValue()]
										[k - pierderiCurr] + profitCurr);
					} else {
						//daca nu se respecta conditiile, elementul din tabela devine
						//elementul de la cazul precedent
						dp[i][j][k] = dp[i - 1][j][k];
					}
				}
			}
		}

		//salvez profitul maxim intr-o variabila
		long profitMax =  dp[N][B][L];

		//scriu in fisier
		BufferedWriter writer = new BufferedWriter(new FileWriter("stocks.out"));
		writer.write(Long.toString(profitMax));
		writer.close();
	}
}
