#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
int N = 4;



void permutari(int vec[], int l, int r, int size)
{
    int i;
    if (l == r)
    {
        for(int i = 0; i < size; i++)
            printf("%d ", vec[i]);
        printf("\n");
    }

    else
    {
        for (i = l; i <= r; i++)
        {
            int aux;
            aux = vec[l];
            vec[l] = vec[i];
            vec[i] = aux;

            permutari(vec, l+1, r, size);
            aux = vec[l];
            vec[l] = vec[i];
            vec[i] = aux;
        }
    }
}



int power(int x, unsigned int y)
{
    if (y == 0)
        return 1;
    else if (y%2 == 0)
        return power(x, y/2)*power(x, y/2);
    else
        return x*power(x, y/2)*power(x, y/2);
}

void submultimi(int v[], int n) {

	int subset_size = power(2, n);

	for (int i = 0; i < subset_size; i++) {


		int subset[n];
		for (int j = 0; j < n; j++) {

			if(i & (1 << j)) {
                subset[j] = v[j];
			}
		}

		for (int j = 0; j < n; j++) {
			if(i & (1 << j))
				printf("%d", subset[j]);
		}
		printf("\n");
	}
}


void genTable(int size, int s[]) {

	for (int i = 1; i <= size; i++) {

		for (int j = 1; j <= size; j++) {

			if (j == s[i]) {

				printf("D ");
			}
			else {
				printf("* ");
			}

		}
		printf("\n");
	}
	printf("\n");
}


//verifica daca reginele sun in siguranta
int valid(int k, int s[]) {

	for (int i = 1; i < k; i++) {

		if (s[k] == s[i] || (k - i) == abs(s[k] - s[i])) {
			return 0;
		}
	}
	return 1;
}

void genQueens(int size, int k, int s[], int u[]) {

	if (k == (size + 1)) {
		genTable(size, s);
	}

	else {

		for (s[k] = 1; s[k] <= size; s[k]++) {

			if (valid(k, s) == 1) {

				genQueens(size, k + 1, s, u);
			}
		}
	}
}

int main()
{
    //Pt Permutari
    //-------------------
    int vec[] = {1, 2, 3};
    permutari(vec, 0, 2, 3);
    //-------------------

    //Pt submultimi
    //-----------------------
    submultimi(vec, 3);
    printf("\n");
    //-----------------------

    //Pt dame
    //-----------------------
    int s[100] = {0};
    int u[100] = {0};
    genQueens(4, 1, s, u);
    //------------------------
    return 0;
}

