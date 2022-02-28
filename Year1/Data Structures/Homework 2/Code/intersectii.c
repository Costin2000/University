#include "intersectii.h"


// functie ajutatoare
void afiseaza_lista_intervale(ListaIntervale2D *lista) {
    int i;
    for (i = 0; i < lista->dimensiune; i++) {
        Interval2D *interv = lista->intervale[i];
        printf("{punct stanga x: %d, punct stanga y: %d, punct dreapta x: %d, punct dreapta y: %d}\n",
                    interv->punct_stanga->x, interv->punct_stanga->y,
                    interv->punct_dreapta->x, interv->punct_dreapta->y);
    }
}


ListaIntervale2D* citeste_intrare(char *nume_fisier_intrare) {

    ListaIntervale2D* lista=(ListaIntervale2D*)malloc(sizeof(ListaIntervale2D));

    FILE* filePointer=fopen(nume_fisier_intrare, "r");

    if(filePointer==NULL)
        return NULL;


    int nrSegmente,numar,i;
    fscanf( filePointer,"%d",&nrSegmente);

    lista->dimensiune = nrSegmente;

    lista->intervale=(Interval2D **)malloc(lista->dimensiune*sizeof(Interval2D*));

    for( i=0; i<nrSegmente; i++ )
    {
        lista->intervale[i] = (Interval2D*)malloc(sizeof(Interval2D));
        lista->intervale[i]->punct_stanga = (Punct2D*)malloc(sizeof(Punct2D));
        lista->intervale[i]->punct_dreapta = (Punct2D*)malloc(sizeof(Punct2D));

        fscanf( filePointer,"%d",&numar);
        lista->intervale[i]->punct_stanga->x = numar;

        fscanf( filePointer,"%d", &numar);
        lista->intervale[i]->punct_stanga->y = numar;

        fscanf( filePointer,"%d", &numar);
        lista->intervale[i]->punct_dreapta->x = numar;

        fscanf( filePointer,"%d", &numar);
        lista->intervale[i]->punct_dreapta->y = numar;

    }
    fclose(filePointer);


    return lista;
}

int yMax(ListaIntervale2D *lista)
{
	int max=0,i;
	for ( i=0; i<lista->dimensiune; i++)
	{
		if(max < lista->intervale[i]->punct_stanga->y)
			max = lista->intervale[i]->punct_stanga->y;
		
		if(max < lista->intervale[i]->punct_dreapta->y)
			max = lista->intervale[i]->punct_dreapta->y;
	}
	return max;
}

typedef struct punctAux {//structura ajutatoare
    	int x;//coordonata ox
    	int y;//coordonata oy
	int indexPunct;//ia valoarea pozitiei segmentului corespunzator in lista 
	int parte; //ia val 0 daca e pct din stanga, 1 daca e pct din dreapta
	int tip; //0 daca face parte dintr-un segm orizontal si 1 in caz contrar
} PunctInfo;

PunctInfo ** sortare(ListaIntervale2D *lista)
{
	PunctInfo** vPuncte = (PunctInfo**)malloc(lista->dimensiune*2*(sizeof(PunctInfo*)));
	PunctInfo* aux = (PunctInfo*)malloc(sizeof(PunctInfo));
	int cont=0, needSwap=0, i=0, j=0;
	
	for( i=0;i<lista->dimensiune;i++)
	{
		
		vPuncte[cont]=(PunctInfo*)malloc(sizeof(PunctInfo));
		vPuncte[cont]->x = lista->intervale[i]->punct_stanga->x;
		vPuncte[cont]->y = lista->intervale[i]->punct_stanga->y;
		vPuncte[cont]->indexPunct = i;
		vPuncte[cont]->parte = 0;
		if(lista->intervale[i]->punct_stanga->x == lista->intervale[i]->punct_dreapta->x)
			vPuncte[cont]->tip = 1;
		else 
			vPuncte[cont]->tip = 0;

		cont++;	
		
		vPuncte[cont] = (PunctInfo*)malloc(sizeof(PunctInfo));
		vPuncte[cont]->x = lista->intervale[i]->punct_dreapta->x;
		vPuncte[cont]->y = lista->intervale[i]->punct_dreapta->y;
		vPuncte[cont]->indexPunct = i;
		vPuncte[cont]->parte = 1;
		if(lista->intervale[i]->punct_stanga->x == lista->intervale[i]->punct_dreapta->x)
			vPuncte[cont]->tip = 1;
		else 
			vPuncte[cont]->tip = 0;
		
		cont++;
	}
	

	for( i=0;i<(cont-1);i++)
	{
		for( j=i+1;j<cont;j++)
		{
			needSwap = 0;
			if(vPuncte[i]->x > vPuncte[j]->x)
				{needSwap = 1;}
			else if( (vPuncte[i]->x == vPuncte[j]->x) && (vPuncte[i]->tip == 0) && (vPuncte[j]->tip == 1) )
				{needSwap = 1;}
			if (vPuncte[i]->indexPunct == vPuncte[j]->indexPunct && vPuncte[i]->tip == 1)
            		{
                		if(vPuncte[i]->y > vPuncte[j]->y)
                    		needSwap = 1;
            		}
			if(needSwap == 1)
			{
				aux = vPuncte[i];
				vPuncte[i] = vPuncte[j];
				vPuncte[j] = aux;
			}
		}
	}
	return vPuncte;
}

// ! Functie pentru actualizarea in arbore
// ! O veti da ca parametru cand initializati arborele
void actualizare_cu_delta(Nod *nod, int v2) {
    nod->info += v2;
}

// ! Functie pentru combinarea raspunsurilor in arbore
// ! O veti da ca parametru cand initializati arborele
int suma_raspunsurilor(int r1, int r2) {
    return r1 + r2;
}


int calculeaza_numar_intersectii(ListaIntervale2D *lista) {
    // TODO calculati numarul de intersectii folosind arbori de intervale conform enuntului
    // Hint: initializarea arborelui: )
    // ArboreDeIntervale *arbore = construieste_arbore(0, y_max, 0, actualizare_cu_delta, suma_raspunsurilor);
	
	ArboreDeIntervale *arbore = construieste_arbore(0, yMax(lista), 0, actualizare_cu_delta, suma_raspunsurilor);
	
	PunctInfo** vPuncte = sortare(lista);
	Interval *interval;

	int nrIntersectii = 0,i;

	for(i=0;i<(lista->dimensiune*2);i++)
	{

		if(vPuncte[i]->parte == 0 && vPuncte[i]->tip == 0)//daca e capat stanga al segmentului orizontal
		{
			interval = malloc(sizeof(Interval));
			interval->capat_stanga = vPuncte[i]->y;
			interval->capat_dreapta = vPuncte[i]->y;
			actualizare_interval_in_arbore(arbore,interval, 1);
		}
		if(vPuncte[i]->parte == 1 && vPuncte[i]->tip == 0)//daca e capat dreapta al segmentului orizontal
		{
			interval = malloc(sizeof(Interval));
			interval->capat_stanga = vPuncte[i]->y;
			interval->capat_dreapta = vPuncte[i]->y;
			actualizare_interval_in_arbore(arbore,interval, -1);
		}
		if(vPuncte[i]->tip == 1)//daca e segment vertical
		{
			interval = malloc(sizeof(Interval));
			interval->capat_stanga = vPuncte[i]->y;
			interval->capat_dreapta = vPuncte[i+1]->y;
			nrIntersectii = nrIntersectii + interogare_interval_in_arbore(arbore, interval);
			i++;
		}	
	}

	
    return nrIntersectii;
}


int max(int a, int b)
{
    if(a>b)
        return a;
    return b;
}

int min(int a, int b)
{
    if(a<b)
        return a;
    return b;
}





int intersectie(Interval2D* seg1 ,Interval2D* seg2 )
{
    	int x1,y1,x2,y2,x3,y3,x4,y4, m1,m2;
    	x1 = seg1->punct_stanga->x;
    	y1 = seg1->punct_stanga->y;
    	x2 = seg1->punct_dreapta->x;
    	y2 = seg1->punct_dreapta->y;
    	x3 = seg2->punct_stanga->x;
    	y3 = seg2->punct_stanga->y;
    	x4 = seg2->punct_dreapta->x;
    	y4 = seg2->punct_dreapta->y;

    	if(y1 == y2)
        	m1 = 0;
    	else
        	m1 = 1;

    	if(y3==y4)
        	m2 = 0;
    	else
        	m2 = 1;


    	if(m2 == 0 && m1 == 0 && y2 == y3 && (min(x3,x4) == max(x1,x2) || max(x3,x4) == min(x1,x2)))
	//orizontale si un capat coincide
        	return 1;

    	if(m1 == 1 && m2 == 1 && x1 == x3 && (min(y3,y4) == max(y1,y2) || max(y3,y4) == min(y1,y2)))
	//verticale si un capat coincide
        	return 1;

    	if(m1 == 0 && m2 == 1 && (y2<=max(y3,y4) && y2>=min(y3,y4)) && (x4<=max(x1,x2) && x4>=min(x1,x2)))
	//unul vertical si altul orizontal
        	return 1;

    	if(m1 == 1 && m2 == 0 && (y3<=max(y1,y2) && y3>=min(y1,y2)) && (x2<=max(x3,x4) && x2>=min(x3,x4)))
	//unul vertical si altul orizontal
        	return 1;

		

    	return 0;
}

int calculeaza_numar_intersectii_trivial(ListaIntervale2D *lista) {
	int nrDeIntersectii = 0,i,j;
	for( i=0; i<(lista->dimensiune-1);i++)
		for( j = i+1;j<lista->dimensiune;j++)
			nrDeIntersectii = nrDeIntersectii+intersectie(lista->intervale[i],lista->intervale[j]);
			
    // TODO: solutia triviala, verific fiecare segment cu fiecare segment daca se intersecteaza 
    return nrDeIntersectii;
}
