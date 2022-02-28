#include "arbori_intervale.h"

void actualizare_cu_delta(Nod *nod, int v2) ;
int suma_raspunsurilor(int r1, int r2);
Interval* construct_interval(int st, int dr);


Interval* construct_interval2(int st, int dr) {
    Interval *interval =(Interval*) malloc(sizeof(Interval));
    if (interval == NULL) {
        exit(1);
    }
    interval->capat_stanga = st;
    interval->capat_dreapta = dr;
    return interval;
}

Nod* creare_nod(int stanga, int dreapta)
{
	Nod* node = (Nod*)malloc(sizeof(Nod));
	node->info = 0;
	node->interval = construct_interval2(stanga,dreapta);
	int mijloc;
	if( stanga < dreapta )
	{
		mijloc = (stanga+dreapta)/2;
		node->copil_stanga = creare_nod(stanga, mijloc);
		node->copil_dreapta = creare_nod(mijloc + 1, dreapta);
	}
	return node;
}

void Size(Nod * t,int size)
{
	if(t != NULL)
	{
		size++;
		Size(t->copil_stanga,size);
		Size(t->copil_dreapta,size);
	}
}

ArboreDeIntervale *construieste_arbore(int capat_stanga, int capat_dreapta,
        int valoare_predifinita_raspuns_copil,
        void (*f_actualizare)(Nod *nod, int v_actualizare),
        int (*f_combinare_raspunsuri_copii)(int raspuns_stanga, int raspuns_dreapta)) 
{
	ArboreDeIntervale* arbore = (ArboreDeIntervale*)malloc(sizeof(ArboreDeIntervale));
	arbore-> radacina=creare_nod(capat_stanga, capat_dreapta);
	arbore-> dimensiune = 0;
	Size(arbore-> radacina,arbore-> dimensiune);
	arbore->valoare_predifinita_raspuns_copil = valoare_predifinita_raspuns_copil;
	arbore->f_actualizare = actualizare_cu_delta;
	arbore->f_combinare_raspunsuri_copii = suma_raspunsurilor;
	return arbore;
    // TODO implementati functia de constructie a arborelui prezentata in enunt
    // TODO initializati campurile unui ArboreDeIntervale*
    //return NULL;
}


void actualizare_interval_pentru_nod(ArboreDeIntervale *arbore, Nod *nod,
                                        Interval *interval, int v_actualizare) {
	int mijloc;
	if (interval->capat_stanga <= nod->interval->capat_stanga  
		&& nod->interval->capat_dreapta<=interval->capat_dreapta)
	{
		
		arbore->f_actualizare(nod, v_actualizare);
	}
	else 
	{
		mijloc = (nod->interval->capat_stanga + nod->interval->capat_dreapta)/2;
		if(interval->capat_stanga<=mijloc)
			actualizare_interval_pentru_nod(arbore, nod->copil_stanga, interval, v_actualizare);
		if(mijloc<interval->capat_dreapta)
			actualizare_interval_pentru_nod(arbore, nod->copil_dreapta, interval, v_actualizare);
		arbore->f_actualizare(nod, v_actualizare);
	}    
	// TODO implementati functia de actualizare pentru un nod
    // Hint: pentru a actualiza un nod cand este cazul folositi arbore->f_actualizare(nod, v_actualizare);
}


// Functia este deja implementata, se cheama functia de mai sus cu radacina arborelui
void actualizare_interval_in_arbore(ArboreDeIntervale *arbore, 
                                        Interval *interval, int v_actualizare) {
    actualizare_interval_pentru_nod(arbore, arbore->radacina, interval, v_actualizare);
}


int interogare_interval_pentru_nod(ArboreDeIntervale *arbore, Nod *nod, Interval *interval) {

	int valoare_stanga=0,valoare_dreapta=0,mijloc;
	
	if(interval->capat_stanga<=nod->interval->capat_stanga  && nod->interval->capat_dreapta<=interval->capat_dreapta)
		return nod->info;
	else
	{
		mijloc=(nod->interval->capat_stanga + nod->interval->capat_dreapta)/2;
		
		if(interval->capat_stanga <= mijloc)
			valoare_stanga = interogare_interval_pentru_nod(arbore,nod->copil_stanga,interval);

		if(mijloc<interval->capat_dreapta)
			valoare_dreapta = interogare_interval_pentru_nod(arbore,nod->copil_dreapta,interval);

		return arbore->f_combinare_raspunsuri_copii(valoare_stanga, valoare_dreapta);
	}
    // TODO implementati functia de interogare pentru un nod prezentata in enunt
    // Hint: cand vreti sa calculati combinarea raspunsurilor folositi
    // arbore->f_combinare_raspunsuri_copii(raspuns_copil_stanga, raspuns_copil_drepta)
    //return 0;
}


// Functia este deja implementata, se cheama functia de mai sus cu radacina arborelui
int interogare_interval_in_arbore(ArboreDeIntervale *arbore, Interval *interval) {
    return interogare_interval_pentru_nod(arbore, arbore->radacina, interval);
}


// ----- DOAR pentru bonus si DOAR daca considerati ca e necesara ----- //
void seteaza_info_in_nod_la_valoare_capat_dreapta(Nod* nod) {
    // TODO cred ca e destul de clar ce vrea sa faca functia asta
}


void seteaza_info_in_arbore_la_valoare_capat_dreapta(ArboreDeIntervale* arbore) {
    seteaza_info_in_nod_la_valoare_capat_dreapta(arbore->radacina);
}
