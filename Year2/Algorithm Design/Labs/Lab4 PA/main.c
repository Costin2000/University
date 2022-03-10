#include <stdio.h>
#include <stdlib.h>

int InmultireaMatricelor(int p[], int i, int j)
{
    if (i == j)
        return 0;
    int min = 100000;
    int nrOp = 0;

    for (int k = i; k < j; k++)
    {
        nrOp = InmultireaMatricelor(p, i, k) + InmultireaMatricelor(p, k + 1, j) + p[i - 1] * p[k] * p[j];
        if (nrOp < min) {
            min = nrOp;
        }
    }
    return min;
}

int max(int a, int b)
{
    if(a > b)
        return a;
    else
        return b;
}


int pbRucsacului(int capacitate, int greutati[], int valoare[], int size)
{
    int matr[size + 1][capacitate + 1];

    for (int i = 0; i <= size; i++)
    {
        for (int j = 0; j <= capacitate; j++)
        {
            if (i == 0 || j == 0)
                matr[i][j] = 0;
            else if (greutati[i - 1] <= j)
                matr[i][j] = max(valoare[i - 1] + matr[i - 1][j - greutati[i - 1]], matr[i - 1][j]);
            else
                matr[i][j] = matr[i - 1][j];
        }
    }
    return matr[size][capacitate];
}

int subsir(int vec[], int i, int n, int anterior)
{
    if (i == n) {
        return 0;
    }

    int excl = subsir(vec, i + 1, n, anterior);

    int nrEl = 0;
    if (vec[i] > anterior) {
        nrEl = 1 + subsir(vec, i + 1, n, vec[i]);
    }

    return max(nrEl, excl);
}


int main()
{
    //Pt ex1
    //------------------------------------------------------------------------
    int arr[] = { 2, 4, 3, 5, 2 };
    int size = 5;
    printf("Numarul optim de operatii este %d \n", InmultireaMatricelor(arr, 1, size - 1));
    //------------------------------------------------------------------------

    //Pt ex2
    //------------------------------------------------------------------------
    int valoare[] = { 60, 120, 100 };
    int greutate[] = { 10, 30, 20 };
    int capacitate = 50;
    size = 3;
    printf("Valoarea maxima pe care o pot avea in rucsac este %d \n", pbRucsacului(capacitate, greutate, valoare, size));
    //------------------------------------------------------------------------

    //Pt ex3
    //------------------------------------------------------------------------
    int vec[] = { 1, 2, 9, 3, 8, 4, 7 };
    int n = 7;
    printf("Cel mai lung subsir crescator este %d", subsir(vec, 0, n, 0));
    //------------------------------------------------------------------------

}
