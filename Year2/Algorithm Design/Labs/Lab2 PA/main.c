#include <stdio.h>
#include <stdlib.h>

//Ex1
//------------------------------------
void han (int n, char a, char b, char c)
{
    if (n==1)
        printf("Mut din %c in %c\n",a,b);
    else
    {
        han(n-1,a,c,b);
        printf("Mut din %c in %c\n",a,b);
        han(n-1,c,b,a);
    }
}
//------------------------------------

//EX2
//------------------------------------
int max(int vct[], int inf, int sup)
{
    int mij, max1, max2;
    if(sup==inf)
    {
        return vct[sup];
    }
    else
    {
        mij= (sup + inf)/2;
        max1 = max(vct,inf,mij);
        max2 = max(vct,mij+1,sup);
        if(max1 > max2)
            return max1;
        else
            return max2;
    }
}
//-----------------------------------

//EX3
//-----------------------------------
void merge(int vec[], int inf, int mij, int sup)
{
    int i, j, k;

    int nrLeft = mij - inf + 1; //nr de elemente din jumatatea din stanga
    int nrRight = sup - mij; //nr de elemente din jumatatea din dreapta
    int L[nrLeft], R[nrRight]; //initializez vectorii

    for (i = 0; i < nrLeft; i++) //umplem vectorul cu partea stanga
        L[i] = vec[inf + i];
    for (j = 0; j < nrRight; j++)//umplem vectorul cu partea dreapta
        R[j] = vec[mij + 1 + j];

    i = 0;
    j = 0;
    k = inf; // Initial index of merged subarray

    while (i < nrLeft && j < nrRight){
        if (L[i] <= R[j]){
            vec[k] = L[i];
            i++;
        }
        else{
            vec[k] = R[j];
            j++;
        }
        k++;
    }

    //copiez daca au mai ramas din elemente in L
    while (i < nrLeft){
        vec[k] = L[i];
        i++;
        k++;
    }

    //copiez daca au mai ramas elemente in R
    while (j < nrRight){
        vec[k] = R[j];
        j++;
        k++;
    }
}

void mergeSort(int arr[], int inf, int sup)
{
    if (inf < sup) {
        int mij = inf + (sup - inf) / 2;
        mergeSort(arr, inf, mij);
        mergeSort(arr, mij + 1, sup);
        merge(arr, inf, mij, sup);
    }
}

void afiseazaVector(int vec[], int size)
{
    for (int i = 0; i < size; i++)
        printf("%d ", vec[i]);
    printf("\n");
}
//-----------------------------------

//EX4
//-----------------------------------
int binarySearch(int vec[], int inf, int sup, int x)
{
    if (sup >= inf) {
        int mij = inf + (sup - inf) / 2;
        if (vec[mij] == x)
            return mij;
        if (vec[mij] > x)
            return binarySearch(vec, inf, mij - 1, x);
        return binarySearch(vec, mij + 1, sup, x);
    }
    return -1;
}
//-----------------------------------

//EX5
//-----------------------------------
int count(int vec[], int inf, int sup, int x)
{
    // daca vectorul are un singur element
    if (inf == sup)
    {
        if(vec[inf] == x) // daca acela este exact cel cautat
            return 1;
        return 0;
    }

    return count(vec, inf,(inf + sup) / 2, x) + count(vec, 1 + (inf + sup) / 2, sup, x);
}
//------------------------------------


int main()
{
    //Pt ex 1
    //------------------------
    printf("Exercitiul 1, turnul din hanoi cu 3 discuri:\n");
    han(3,'A','B','C');
    printf("\n");
    //------------------------


    //Pt ex 2
    //------------------------
    int vec2[] = { 3, 2, 5, 2, 4 };
    printf("Exercitiul 2, trebuie gasit elementul maxim din vectorul {3, 2, 5, 2, 4} \nRezultatul este: %d \n\n", max(vec2,0,4));
    //-------------------------

    //Pt ex 3
    //------------------------
    int vec3[] = { 3, 2, 1, 4, 3, 5, 2 };
    mergeSort(vec3,0,6);
    printf("Exercitiul 3 am facut merge-sort pe vectorul {3, 2, 1, 4, 3, 5, 2} \nA rezultat vectorul: ");
    afiseazaVector(vec3,7);
    printf("\n");
    //-----------------------

    //Pt ex 4
    //------------------------
    int vec4[] = { 1, 3, 4, 5, 7, 8, 9 };
    printf("Exercitiul 4, binary search pe vectorul { 1, 3, 4, 5, 7, 8, 9 } cautand elementul 3\nA rezultat ca acesta se afla la indicele: %d \n\n",
            binarySearch(vec4, 0, 6, 3));
    //------------------------

    //Pt ex 5
    //------------------------
    int vec5[] = { 2, 1, 3, 1, 1, 4, 2, 1, 8, 1 };
    printf("Exercitul 5, cautam de cate ori apare elementul 1 in vectorul { 2, 1, 3, 1, 1, 4, 2, 1, 8, 1 } \nNe da rezultatul: %d\n",count(vec5, 0, 9, 1));
    //------------------------
    return 0;
}
