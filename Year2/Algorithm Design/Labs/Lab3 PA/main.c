#include<stdio.h>

void problemaRucsacului(int n, float greutate[], float valoare[], float capacitate) {

   float masuri[n], valFinalaRucsac = 0, copieCapacitate;
   int i, j;
   copieCapacitate = capacitate;

   float pondere[n];

    for (i = 0; i < n; i++) {
      pondere[i] = valoare[i] / greutate[i];
    }

    //sortăm descrescător obiectele după pondere
    for (i = 0; i < n; i++) {
        for (j = i + 1; j < n; j++) {
            if (pondere[i] < pondere[j]) {
                float aux;
                aux = pondere[j];
                pondere[j] = pondere[i];
                pondere[i] = aux;

                aux = greutate[j];
                greutate[j] = greutate[i];
                greutate[i] = aux;

                aux = valoare[j];
                valoare[j] = valoare[i];
                valoare[i] = aux;
             }
        }
    }

   for (i = 0; i < n; i++)
      masuri[i] = 0.0;

    //adăugăm fracţiuni din obiectul cu cea mai mare valoare per kg
    //până epuizăm stocul şi apoi adăugăm fracţiuni din obiectul cu
    //valoarea următoare
   for (i = 0; i < n; i++) {
      if (greutate[i] > copieCapacitate)
         break;
      else {
         masuri[i] = 1.0;
         valFinalaRucsac = valFinalaRucsac + valoare[i];
         copieCapacitate = copieCapacitate - greutate[i];
      }
   }

   if (i < n)
      masuri[i] = copieCapacitate / greutate[i];

   valFinalaRucsac = valFinalaRucsac + (masuri[i] * valoare[i]);

   printf("Valoarea maxima a rucsacului este %f", valFinalaRucsac);

}




void spectacole(int s[], int f[], int n){
	int i, j, nr = 1;
	printf ("Programul pentru spectacole este :\n");


    //sortam spectacolele dupa ora de incheiere
	for ( i = 0; i < (n-1) ; i++) {
        for ( j = i+1; j < n; j++) {
           if(f[j] < f[i]) {
                int aux = 0;
                aux = f[i];
                f[i] = f[j];
                f[j] = aux;

                aux = s[i];
                s[i] = s[j];
                s[j] = aux;
           }
        }
	}

	i = 0;
	printf("Spectacolul nr %d ocupa intervalul %d-%d\n", nr, s[i], f[i]);
	nr++;

	// cand gasim un spectacol care sa poata fi urmatorul, il selectam
	for (j = 1; j < n; j++) {
		if (s[j] >= f[i]) {
			printf ("Spectacolul nr %d ocupa intervalul %d-%d\n", nr, s[j], f[j]);
			i = j;
			nr++;
		}
	}

    printf ("Deci vor fi %d Spectacole", --nr);
}



int main()
{
    //Pentru problema rucsacului
    //-----------------------------------
    float greutate[] = {10, 30, 20};
    float profit[] = {60, 120, 100};
    float capacity = 50;
    int nrObiecte = 3;
    problemaRucsacului(nrObiecte, greutate, profit, capacity);
    printf("\n\n");
    //-----------------------------------

    //Pentru problema spectacolelor
    //-----------------------------------

	int s[] =  {10, 11, 12, 14, 16, 17};
	int f[] =  {11, 13, 13, 18, 17, 19};
	int n = 6;
	spectacole(s, f, n);
	//------------------------------------


}
