#include <stdio.h>
#include "WearhouseManager.h"


Package *create_package(long priority, const char* destination){

	Package *pachet=(Package*)malloc(sizeof(Package));
	pachet->priority=priority;

	if(destination==NULL) 
	{
		pachet->destination=NULL;
	}
	else
	{
		pachet->destination = malloc(strlen(destination)+1) ;
		strcpy(pachet->destination, destination);
	}
	//pachet->destination=destination;
	return pachet;
}

void destroy_package(Package* package){//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	free(package->destination);	
	free(package);
	// TODO: 3.1
}

Manifest* create_manifest_node(void){
	Manifest* manifest=(Manifest*)malloc(sizeof(Manifest));
	manifest->package=NULL;
	manifest->next=NULL;
	manifest->prev=NULL;
	
	return manifest;
}

void destroy_manifest_node(Manifest* manifest_node){//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	/*Manifest* lista=manifest_node,*aux;
	
	while(lista!=NULL)
	{
		aux=lista->next;
		free(lista);
		lista=aux;
	}*/
	free(manifest_node->package);
	free(manifest_node);
	// TODO: 3.1.

}

Wearhouse* create_wearhouse(long capacity){
	
	if(capacity==0) return NULL;

	Wearhouse* depozit=(Wearhouse*)malloc(sizeof(Wearhouse));

	if(depozit==NULL)
	{
		fprintf(stderr,"eroare\n");
		exit(EXIT_FAILURE);
	}

	depozit->packages=(Package**)malloc(capacity*sizeof(Package*));
	
	if(depozit->packages==NULL)
	{
		fprintf(stderr,"eroare\n");
		exit(EXIT_FAILURE);
	}

	//depozit->packages[0]=NULL;
	depozit->size=0;
	depozit->capacity=capacity;

	return	depozit;
	//return NULL;
}

Wearhouse *open_wearhouse(const char* file_path){
	ssize_t read_size;
	char* line = NULL;
	size_t len = 0;
	char* token = NULL;
	Wearhouse *w = NULL;


	FILE *fp = fopen(file_path, "r");
	if(fp == NULL)
		goto file_open_exception;

	if((read_size = getline(&line, &len, fp)) != -1){
		token = strtok(line, ",\n ");
		w = create_wearhouse(atol(token));

		free(line);
		line = NULL;
		len = 0;
	}

	while((read_size = getline(&line, &len, fp)) != -1){
		token = strtok(line, ",\n ");
		long priority = atol(token);
		token = strtok(NULL, ",\n ");
		Package *p = create_package(priority, token);
		w->packages[w->size++] = p;

		free(line);
		line = NULL;
		len = 0;
	}

	free(line);


	fclose(fp);
	return w;

	file_open_exception:
	return NULL;
}

long wearhouse_is_empty(Wearhouse *w){
	if (w->size==0 || w==NULL )
		return 1;
	return 0;
}

long wearhouse_is_full(Wearhouse *w){
	if(w->size==w->capacity )
		return 1;
	return 0;
}

long wearhouse_max_package_priority(Wearhouse *w){
	if(wearhouse_is_empty(w)==1) return 0;

	long max=w->packages[0]->priority;
	for(long i=0;i<w->size;i++)
	{
		if((w->packages[i]->priority)>max)
		{
			max=(w->packages[i]->priority);
		}	
	}
	
	return max;
	//return 0;
}

long wearhouse_min_package_priority(Wearhouse *w){
	if(wearhouse_is_empty(w)==1) return 0;
	
	long min=w->packages[0]->priority;
	for(long i=0;i<w->size;i++)
		if(w->packages[i]->priority<min)
			min=(w->packages[i]->priority);
	
	return min;
	//return 0;
}


void wearhouse_print_packages_info(Wearhouse *w){
	for(long i = 0; i < w->size; i++){
		printf("P: %ld %s\n",
				w->packages[i]->priority,
				w->packages[i]->destination);
	}
	printf("\n");
}

void destroy_wearhouse(Wearhouse* wearhouse){//!!!!!!!!!!!!!!!!!!!
	for(int i=0;i<wearhouse->size;i++)
		destroy_package(wearhouse->packages[i]);
	free(wearhouse);
	
	// TODO: 3.2
}


Robot* create_robot(long capacity){
	Robot* robot=(Robot*)malloc(sizeof(Robot));
	if (robot==NULL) return NULL;

	if(robot==NULL) return NULL;
	//robot->manifest=(Manifest*)malloc(sizeof(Manifest));
	robot->manifest=NULL;
	robot->size=0;
	robot->capacity=capacity;
	robot->next=NULL;
	 //TODO: 3.2
	return robot;
}

int robot_is_full(Robot* robot){
	if(robot->size==robot->capacity)
		return 1;
	 
	return 0;
}

int robot_is_empty(Robot* robot){
	if(robot->size==0)
		return 1;
	 
	return 0;
}

Package* robot_get_wearhouse_priority_package(Wearhouse *w, long priority){
	if(wearhouse_is_empty(w)==1) return NULL;
	
	for(long i=0;i<w->size;i++)
		if(w->packages[i]->priority==priority)
			return w->packages[i];
	return NULL;
}

void robot_remove_wearhouse_package(Wearhouse *w, Package* package){
	if(wearhouse_is_empty(w)==1) return;

	long poz;		

	for(poz=0;poz<w->size;poz++)
		if(w->packages[poz]==package)
		{
			for(long i=poz;i<(w->size-1);i++)
			{
				w->packages[i]=w->packages[i+1];
			}
			break;		
		}
	w->size--;

	// TODO: 3.2
}

void robot_load_one_package(Robot* robot, Package* package){

	//robot -> n manifeste cu cate 1 pachet!
	
	if(robot->capacity==0 || robot->size==robot->capacity) return;
		 
	Manifest* newManifest = (Manifest*)malloc(sizeof(Manifest));
	newManifest->package =  package;	
	newManifest->prev=NULL;
	newManifest->next=NULL;

	if(robot->size==0) //cand nu are manifeste
	{
		robot->manifest = newManifest;
		robot->size=1;
		return;
	}
	
	Manifest* listaMan;//=(Manifest*)malloc(sizeof(Manifest));
	listaMan = robot->manifest;

	//newManifest->prev=NULL;
	newManifest->next = listaMan;
	newManifest->prev=NULL;
  	
	listaMan->prev = newManifest;
	robot->manifest = newManifest;
	
	robot->size++;
	

	Manifest *p0, *p2, *p3, *p1;

	int needSwap = 0;			
	int amSwap;
	do
	{
		p1 = robot->manifest;
		amSwap = 0;
			
		while (p1->next!=NULL)
		{	
			p2 = p1->next;
			needSwap=0;
			
			if(p1->package->priority < p2->package->priority)
			{needSwap = 1;}
			else if(p1->package->priority == p2->package->priority)
			{
				int retCmp = strcmp(p1->package->destination, p2->package->destination);
				if (retCmp > 0)
					needSwap = 1;
			}

			if (needSwap == 1)
			{		
				p0 = p1->prev;		
				p3 = p2->next;		

				if (p0!=NULL) p0->next = p2;
				
				p2->next = p1;		
				p1->next = p3;
				p2->prev = p0;
				p1->prev = p2;

				if (p3!=NULL) p3->prev = p1;
				if(p2->prev==NULL)
					robot->manifest=p2;

				amSwap = 1;
			}
			else
			{
				p1 = p2;
			}
		}
		
	}while(amSwap == 1);	

}


long robot_load_packages(Wearhouse* wearhouse, Robot* robot){
	if(robot==NULL || wearhouse==NULL || wearhouse->size==0 || robot->size>=robot->capacity) return 0;
	
	long cont=0;
	long nrElDeInserat;

	if (robot->capacity -robot->size < wearhouse->size)
		nrElDeInserat = robot->capacity -robot->size;
	else
		nrElDeInserat = wearhouse->size;

	
	for(long i=0;i<nrElDeInserat;i++)
	{		
		
		robot_load_one_package(robot, robot_get_wearhouse_priority_package(wearhouse,wearhouse_max_package_priority(wearhouse)));
		robot_remove_wearhouse_package(wearhouse,robot_get_wearhouse_priority_package(wearhouse,wearhouse_max_package_priority(wearhouse)));	
		cont++;
	}
	return cont;
}

Package* robot_get_destination_highest_priority_package(Robot* robot, const char* destination){
	
	if(robot_is_empty(robot)==1) return NULL;

	Manifest* listaManifeste=robot->manifest;
	int max=0;
	Package* pachetMax;
	for(long i=0;i<robot->size;i++)
	{	
		if(listaManifeste->package->priority>max && strcmp(listaManifeste->package->destination,destination)==0)
		{
			max=listaManifeste->package->priority;
			pachetMax=listaManifeste->package;
		}
		listaManifeste=listaManifeste->next;		
	}

	return pachetMax;
}

void destroy_robot(Robot* robot){
	
	Manifest* lista=robot->manifest,*aux;
	
	while(lista!=NULL)
	{
		aux=lista->next;
		destroy_manifest_node(lista);
		lista=aux;
	}
	free(robot);
}




// Attach to specific truck
int robot_attach_find_truck(Robot* robot, Parkinglot *parkinglot){
	int found_truck = 0;
	long size = 0;
	Truck *arrived_iterator = parkinglot->arrived_trucks->next;
	Manifest* m_iterator = robot->manifest;


	while(m_iterator != NULL){
		while(arrived_iterator != parkinglot->arrived_trucks){
			size  = truck_destination_robots_unloading_size(arrived_iterator);
			if(strncmp(m_iterator->package->destination, arrived_iterator->destination, MAX_DESTINATION_NAME_LEN) == 0 &&
					size < (arrived_iterator->capacity-arrived_iterator->size)){
				found_truck = 1;
				break;
			}

			arrived_iterator = arrived_iterator->next;
		}

		if(found_truck)
			break;
		m_iterator = m_iterator->next;
	}

	if(found_truck == 0)
		return 0;


	Robot* prevr_iterator = NULL;
	Robot* r_iterator = arrived_iterator->unloading_robots;
	while(r_iterator != NULL){
		Package *pkg = robot_get_destination_highest_priority_package(r_iterator, m_iterator->package->destination);
		if(m_iterator->package->priority >= pkg->priority)
			break;
		prevr_iterator = r_iterator;
		r_iterator = r_iterator->next;
	}

	robot->next = r_iterator;
	if(prevr_iterator == NULL)
		arrived_iterator->unloading_robots = robot;
	else
		prevr_iterator->next = robot;

	return 1;
}

void robot_print_manifest_info(Robot* robot){
	Manifest *iterator = robot->manifest;
	while(iterator != NULL){
		printf(" R->P: %s %ld\n", iterator->package->destination, iterator->package->priority);
		iterator = iterator->next;
	}

	printf("\n");
}



Truck* create_truck(const char* destination, long capacity, long transit_time, long departure_time){
	Truck *camion=(Truck*)malloc(sizeof(Truck));
	camion->manifest=(Manifest*)malloc(sizeof(Manifest));
	camion->manifest=NULL;
	camion->unloading_robots=(Robot*)malloc(sizeof(Robot));
	camion->unloading_robots=NULL;
	if(destination==NULL) 
	{
		camion->destination=NULL;
	}
	else
	{
		camion->destination = malloc(strlen(destination)+1) ;
		strcpy(camion->destination, destination);
	}
	camion->size=0;
	camion->capacity=capacity;
	camion->in_transit_time=0;
	camion->transit_end_time=transit_time;
	camion->departure_time=departure_time;
	camion->next=NULL;

	return camion;
}

int truck_is_full(Truck *truck){
	if(truck->capacity==truck->size )
		return 1;
	return 0;
}

int truck_is_empty(Truck *truck){
	if(truck==NULL || truck->capacity==0 || truck->size==0)
		return 1;
	return 0;
}

long truck_destination_robots_unloading_size(Truck* truck){//test 19
	
	if(truck==NULL || truck->capacity==0) return 0;
	long numar=0;
	Robot* listaRob=truck->unloading_robots;	
	Manifest* listaMan;
	
	if(listaRob==NULL || listaRob->size==0 || listaRob->capacity==0) return 0;
	

	while(listaRob!=NULL)
	{
		listaMan=listaRob->manifest;
		if(listaMan!=NULL)
		{
			for(long i=0;i<listaRob->size;i++)
			{
				if(strcmp(listaMan->package->destination, truck->destination)==0)
				{
					numar=numar+listaRob->size;
					break;
				}
					
				listaMan=listaMan->next;
			}
		}
		listaRob=listaRob->next;
	}	
	return numar;
}


void truck_print_info(Truck* truck){
	printf("T: %s %ld %ld %ld %ld %ld\n", truck->destination, truck->size, truck->capacity,
			truck->in_transit_time, truck->transit_end_time, truck->departure_time);

	Manifest* m_iterator = truck->manifest;
	while(m_iterator != NULL){
		printf(" T->P: %s %ld\n", m_iterator->package->destination, m_iterator->package->priority);
		m_iterator = m_iterator->next;
	}

	Robot* r_iterator = truck->unloading_robots;
	while(r_iterator != NULL){
		printf(" T->R: %ld %ld\n", r_iterator->size, r_iterator->capacity);
		robot_print_manifest_info(r_iterator);
		r_iterator = r_iterator->next;
	}
}


void destroy_truck(Truck* truck){
	Manifest* lista=truck->manifest,*aux;
	
	while(lista!=NULL)
	{
		aux=lista->next;
		destroy_manifest_node(lista);
		lista=aux;
	}
	
	Robot* listaR=truck->unloading_robots,*auxR;
	
	while(listaR!=NULL)
	{
		auxR=listaR->next;
		destroy_robot(listaR);
		listaR=auxR;
	}

	free(truck->destination);
	free(truck);
	// TODO: 3.3
}

void robot_unload_packages(Truck* truck, Robot* robot){//test 20

	Manifest* listaMan=robot->manifest;
		
	while(listaMan!=NULL)
	{

		if (truck->capacity==truck->size) break;

		if(strcmp(listaMan->package->destination,truck->destination)==0)
		{
			Manifest* aux;
                        

                        if(listaMan->prev==NULL)
			{
				robot->manifest=listaMan->next;
			}
			if(listaMan->next!=NULL) (listaMan->next)->prev = listaMan->prev;
			if(listaMan->prev!=NULL) (listaMan->prev)->next = listaMan->next;
			
			aux = listaMan;
			listaMan=listaMan->next;

			robot->size--;

			if(truck->manifest==NULL)
			{
				truck->manifest = aux;
				truck->manifest->next=NULL;
				truck->manifest->prev=NULL;
				truck->size=1;
			}
			else 
			{
				truck->manifest->prev=aux;
				aux->prev=NULL;
				aux->next=truck->manifest;
				truck->manifest=aux;
				truck->size++;
			}
			
		}
		else
			listaMan = listaMan->next;

	}
	
}

Parkinglot* create_parkinglot(void){
	Parkinglot* parcare=(Parkinglot*)malloc(sizeof(Parkinglot*));
	
	parcare->arrived_trucks  = (Truck*)malloc(sizeof(Truck));
	parcare->departed_trucks = (Truck*)malloc(sizeof(Truck));
	parcare->pending_robots  = (Robot*)malloc(sizeof(Robot));
	parcare->standby_robots  = (Robot*)malloc(sizeof(Robot));

	parcare->arrived_trucks->next = parcare->arrived_trucks;
	parcare->departed_trucks->next = parcare->departed_trucks;
	parcare->pending_robots->next = parcare->pending_robots;
	parcare->standby_robots->next = parcare->standby_robots;
	//parcare->arrived_trucks=NULL;
	//parcare->departed_trucks=NULL;
	//parcare->pending_robots=NULL;
	//parcare->standby_robots=NULL;
	return parcare;
}

Parkinglot* open_parckinglot(const char* file_path){
	ssize_t read_size;
	char* line = NULL;
	size_t len = 0;
	char* token = NULL;
	Parkinglot *parkinglot = create_parkinglot();

	FILE *fp = fopen(file_path, "r");
	if(fp == NULL)
		goto file_open_exception;

	while((read_size = getline(&line, &len, fp)) != -1){
		token = strtok(line, ",\n ");
		// destination, capacitym transit_time, departure_time, arrived
		if(token[0] == 'T'){
			token = strtok(NULL, ",\n ");
			char *destination = token;

			token = strtok(NULL, ",\n ");
			long capacity = atol(token);

			token = strtok(NULL, ",\n ");
			long transit_time = atol(token);

			token = strtok(NULL, ",\n ");
			long departure_time = atol(token);

			token = strtok(NULL, ",\n ");
			int arrived = atoi(token);

			Truck *truck = create_truck(destination, capacity, transit_time, departure_time);

			if(arrived)
				truck_arrived(parkinglot, truck);
			else
				truck_departed(parkinglot, truck);

		}else if(token[0] == 'R'){
			token = strtok(NULL, ",\n ");
			long capacity = atol(token);

			Robot *robot = create_robot(capacity);
			parkinglot_add_robot(parkinglot, robot);

		}

		free(line);
		line = NULL;
		len = 0;
	}
	free(line);

	fclose(fp);
	return parkinglot;

	file_open_exception:
	return NULL;
}

void parkinglot_add_robot(Parkinglot* parkinglot, Robot *robot){//21
	

	if(robot==NULL || parkinglot==NULL) return;
	
	Robot *head, *lista, *inainte;

	if(robot->size==0)
	{
		// vreau sa bag 6
		// [] 8 6 5
	
		head = parkinglot->standby_robots;
		

		if(head->next==head)//daca lista are 1 elem
		{
			head->next=robot;
			robot->next=head;
		}
		else
		{
			lista=head->next;
			if(lista->capacity <= robot->capacity)// daca se pune pe prima poz
			{
				robot->next = lista;
				head->next=robot;
				return;
			}
			if(lista->next==head &&	lista->capacity > robot->capacity)
			{
				robot->next=head;
				lista->next=robot;
			}
			inainte=lista;
			lista=lista->next;

			while(lista!=head)//8 6 3   4
			{
				if(lista->capacity <= robot->capacity)// daca se pune pe ultima poz
				{
					robot->next=lista;
					inainte->next=robot;
					return;
				}
				else 	//avansez
				{
					inainte=lista;
					lista=lista->next;
				}
			}

			robot->next=head;
			inainte->next=robot;
			return;					
		}
	}
	else
	{
		head = parkinglot->pending_robots;
		

		if(head->next==head)//daca lista are 1 elem
		{
			head->next=robot;
			robot->next=head;
		}
		else
		{
			lista=head->next;
			if(lista->size <= robot->size)// daca se pune pe prima poz
			{
				robot->next = lista;
				head->next=robot;
				return;
			}
			if(lista->next==head &&	lista->size > robot->size)
			{
				robot->next=head;
				lista->next=robot;
			}
			inainte=lista;
			lista=lista->next;

			while(lista!=head)//8 6 3   4
			{
				if(lista->size <= robot->size)// daca se pune pe ultima poz
				{
					robot->next=lista;
					inainte->next=robot;
					return;
				}
				else 	//avansez
				{
					inainte=lista;
					lista=lista->next;
				}
			}

			robot->next=head;
			inainte->next=robot;
			return;					
		}
	}
		
}

void parkinglot_remove_robot(Parkinglot *parkinglot, Robot* robot){//test 22

	
	Robot* head=parkinglot->pending_robots;
	if(robot!=NULL || parkinglot!=NULL || head->next!=head) 
	{
		Robot* inainte=NULL, *lista=head->next;
		
		if(robot==lista && lista->next==head)
		{
			head->next=head;
			free(lista);
			return;
		}
		if(robot==lista && lista->next!=head)
		{
			head->next=lista->next;
			free(lista);
			return;
		}
		while(lista!=head)
		{
			inainte=lista;
			lista=lista->next;
			
			
			if(lista ==robot && lista->next==head)
			{
				inainte->next=head;
				free(lista);
				return;
			}
			else if(lista==robot)
			{
				inainte->next=lista->next;
				free(lista);
				return;
			}
		}
	}

	
	head=parkinglot->standby_robots;
	
	if(robot==NULL || parkinglot==NULL || head->next==head) return;
	
	Robot *inainte=NULL, *lista=head->next;
	
	if(robot==lista && lista->next==head)
	{
		head->next=head;
		free(lista);
		return;
	}
	if(robot==lista && lista->next!=head)
	{
		head->next=lista->next;
		free(lista);
		return;
	}
	while(lista!=head)
	{
		inainte=lista;
		lista=lista->next;
		
		
		if(lista ==robot && lista->next==head)
		{
			inainte->next=head;
			free(lista);
			return;
		}
		else if(lista==robot)
		{
			inainte->next=lista->next;
			free(lista);
			return;
		}
	}
		
		
	
}

int parckinglot_are_robots_peding(Parkinglot* parkinglot){
	if(parkinglot->pending_robots->next!=parkinglot->pending_robots)
		return 1;
	return 0;
}

int parkinglot_are_arrived_trucks_empty(Parkinglot* parkinglot){
	
	Truck* head=parkinglot->arrived_trucks;
	if(head->next==head)
		return 1;
	
	int verificare=1;
	Truck* camioaneSosite=head->next;
	
	while(camioaneSosite!=head)
	{
		if(camioaneSosite->size!=0)
			verificare=0;
		camioaneSosite=camioaneSosite->next;
	}
	return verificare;

}


int parkinglot_are_trucks_in_transit(Parkinglot* parkinglot){
	if(parkinglot->departed_trucks->next==parkinglot->departed_trucks)
		return 0;
	return 1;
}


void destroy_parkinglot(Parkinglot* parkinglot){
	Truck* HeadAT=parkinglot->arrived_trucks,*listaAT=parkinglot->arrived_trucks->next,*auxAT;	
	while(listaAT!=HeadAT)
	{
		auxAT=listaAT->next;
		destroy_truck(listaAT);
		listaAT=auxAT;
	}
	//destroy_truck(HeadAT);

	Truck* HeadDT=parkinglot->departed_trucks,*listaDT=parkinglot->departed_trucks->next,*auxDT;	
	while(listaDT!=HeadDT)
	{
		auxDT=listaDT->next;
		destroy_truck(listaDT);
		listaDT=auxDT;
	}
	//destroy_truck(HeadDT);
	
	Robot* HeadPR=parkinglot->pending_robots,*listaPR=parkinglot->pending_robots->next,*auxPR;	
	while(listaPR!=HeadPR)
	{
		auxPR=listaPR->next;
		destroy_robot(listaPR);
		listaPR=auxPR;
	}
	//destroy_robot(HeadPR);

	Robot* HeadSR=parkinglot->standby_robots,*listaSR=parkinglot->standby_robots->next,*auxSR;	
	while(listaSR!=HeadSR)
	{
		auxSR=listaSR->next;
		destroy_robot(listaSR);
		listaSR=auxSR;
	}
	//destroy_robot(HeadSR);
	
	free(parkinglot);
}

void parkinglot_print_arrived_trucks(Parkinglot* parkinglot){
	Truck *iterator = parkinglot->arrived_trucks->next;
	while(iterator != parkinglot->arrived_trucks)
	{
		truck_print_info(iterator);
		iterator = iterator->next;
	}

	printf("\n");

}

void parkinglot_print_departed_trucks(Parkinglot* parkinglot){
	Truck *iterator = parkinglot->departed_trucks->next;
	while(iterator != parkinglot->departed_trucks){
		truck_print_info(iterator);
		iterator = iterator->next;
	}
	printf("\n");

}

void parkinglot_print_pending_robots(Parkinglot* parkinglot){
	Robot *iterator = parkinglot->pending_robots->next;
	while(iterator != parkinglot->pending_robots){
		printf("R: %ld %ld\n", iterator->size, iterator->capacity);
		robot_print_manifest_info(iterator);
		iterator = iterator->next;
	}
	printf("\n");

}

void parkinglot_print_standby_robots(Parkinglot* parkinglot){
	Robot *iterator = parkinglot->standby_robots->next;
	while(iterator != parkinglot->standby_robots){
		printf("R: %ld %ld\n", iterator->size, iterator->capacity);
		robot_print_manifest_info(iterator);
		iterator = iterator->next;
	}
	printf("\n");

}


void truck_departed(Parkinglot *parkinglot, Truck* truck){
	Truck* head=parkinglot->arrived_trucks;
	if(truck!=NULL || parkinglot!=NULL || head->next!=head) 
	{
		Truck* inainte=NULL, *lista=head->next;
		
		if(truck==lista && lista->next==head)
		{
			head->next=head;
		}
		else
		if(truck==lista && lista->next!=head)
		{
			head->next=lista->next;
			
		}
		else
		while(lista!=head)
		{
			inainte=lista;
			lista=lista->next;
			
			
			if(lista ==truck && lista->next==head)
			{
				inainte->next=head;
				break;
			}
			else if(lista==truck)
			{
				inainte->next=lista->next;
				break;
			}
		}
	}
	head = parkinglot->departed_trucks;
	Truck *inainte=NULL, *lista;	

		if(head->next==head)//daca lista are doar head
		{
			head->next=truck;
			truck->next=head;
			return;
		}
		lista=head->next;
		if(lista->departure_time >= truck->departure_time)// daca se pune pe prima poz imediat dupa head
		{
			truck->next = lista;
			head->next=truck;
			return;
		}
		if(lista->next==head &&	lista->departure_time < truck->departure_time)
		{
			truck->next=head;
			lista->next=truck;
			return;
		}
		
		inainte=lista;
		lista=lista->next;

		while(lista!=head)//8 6 3   4
		{
			if(lista->departure_time >= truck->departure_time)// daca se pune pe ultima poz
			{
				truck->next=lista;
				inainte->next=truck;
				return;
			}
			else 	//avansez
			{
				inainte=lista;
				lista=lista->next;
			}
		}

		truck->next=head;
		inainte->next=truck;
		return;					
			
	
}


void truck_arrived(Parkinglot *parkinglot, Truck* truck){//29
	// eliminarea 
	Truck* head=parkinglot->departed_trucks;
	if(truck!=NULL || parkinglot!=NULL || head->next!=head) 
	{
		Truck* inainte=NULL, *lista=head->next;
		
		if(truck==lista && lista->next==head)
		{
			head->next=head;
		}
		else
		if(truck==lista && lista->next!=head)
		{
			head->next=lista->next;
		}
		else
		while(lista!=head)
		{
			inainte=lista;
			lista=lista->next;
			
			
			if(lista ==truck && lista->next==head)
			{
				inainte->next=head;
				break;
			}
			else if(lista==truck)
			{
				inainte->next=lista->next;
				break;
			}
		}
	}
	//introducere in ordine
	Truck *inainte, *lista;

	truck->size=0;
	truck->manifest=NULL;
	head=parkinglot->arrived_trucks;
	if(head->next==head)//daca lista are doar head
	{
		head->next=truck;
		truck->next=head;
		return;
	}
	lista=head->next;
	if(lista->next==head &&	strcmp(lista->destination ,truck->destination)<0)
	{
		truck->next=head;
		lista->next=truck;
		return;
	}
	if(lista->next==head &&	strcmp(lista->destination ,truck->destination)==0 && lista->departure_time<truck->departure_time)
	{
		truck->next=head;
		lista->next=truck;
		return;
	}
	if(strcmp(lista->destination, truck->destination)>0)// daca se pune pe prima poz imediat dupa head
	{
		truck->next = lista;
		head->next=truck;
		return;
	}
	if(strcmp(lista->destination, truck->destination)==0 && lista->departure_time>truck->departure_time)//tot pe prima pozitie
	{
		truck->next = lista;
		head->next=truck;
		return;
	}
	
	inainte=lista;
	lista=lista->next;

	while(lista!=head)//8 6 3   4
	{
		if(strcmp(lista->destination , truck->destination)>0)// daca se pune pe ultima poz
		{
			truck->next=lista;
			inainte->next=truck;
			return;
		}
		if(strcmp(lista->destination,truck->destination)==0 &&  lista->departure_time>truck->departure_time)
		{
			truck->next=lista;
			inainte->next=truck;
			return;
		}
		
		inainte=lista;
		lista=lista->next;
	}

	truck->next=head;
	inainte->next=truck;
	return;		
	
	// TODO: 3.5
	// Search through departed list, if exists node is found remove it
	// Note: this must remove the node not deallocate it

}

void truck_transfer_unloading_robots(Parkinglot* parkinglot, Truck* truck){
	Robot* robot=truck->unloading_robots;
	Robot* aux;
		
	while(robot!=NULL)
	{
		aux=robot;
		robot=robot->next;
		parkinglot_add_robot(parkinglot,aux);
	}
	truck->unloading_robots=NULL;
}


// Depends on parking_turck_departed
void truck_update_depatures(Parkinglot* parkinglot, long day_hour){
	Truck* head=parkinglot->arrived_trucks;
	Truck* lista=head->next;
	Truck* aux;//12 11.45
	while(lista!=head)
	{
		aux=lista->next;
		if(lista->departure_time==day_hour)
			truck_departed(parkinglot, lista);
		lista=aux;
	}
}

// Depends on parking_turck_arrived
void truck_update_transit_times(Parkinglot* parkinglot){
	Truck* lista=parkinglot->departed_trucks->next;
	Truck* head=parkinglot->departed_trucks;
	Truck* aux;
	while(lista!= head)
	{
		aux=lista;
		lista=lista->next;
		aux->in_transit_time++;
		if(aux->in_transit_time == aux->transit_end_time)
		{
			aux->in_transit_time=0;
			truck_arrived(parkinglot,aux);
		}
	}
}

void robot_swarm_collect(Wearhouse *wearhouse, Parkinglot *parkinglot){
	Robot *head_robot = parkinglot->standby_robots;
	Robot *current_robot = parkinglot->standby_robots->next;
	while(current_robot != parkinglot->standby_robots){

		// Load packages from wearhouse if possible
		if(!robot_load_packages(wearhouse, current_robot)){
			break;
		}

		// Remove robot from standby list
		Robot *aux = current_robot;
		head_robot->next = current_robot->next;
		current_robot = current_robot->next;

		// Add robot to the
		parkinglot_add_robot(parkinglot, aux);
	}
}


void robot_swarm_assign_to_trucks(Parkinglot *parkinglot){

	Robot *current_robot = parkinglot->pending_robots->next;

	while(current_robot != parkinglot->pending_robots){
		Robot* aux = current_robot;
		current_robot = current_robot->next;
		parkinglot_remove_robot(parkinglot, aux);
		int attach_succeded = robot_attach_find_truck(aux, parkinglot);
		if(!attach_succeded)
			parkinglot_add_robot(parkinglot, aux);
	}
}

void robot_swarm_deposit(Parkinglot* parkinglot){
	Truck *arrived_iterator = parkinglot->arrived_trucks->next;
	while(arrived_iterator != parkinglot->arrived_trucks){
		Robot *current_robot = arrived_iterator->unloading_robots;
		while(current_robot != NULL){
			robot_unload_packages(arrived_iterator, current_robot);
			Robot *aux = current_robot;
			current_robot = current_robot->next;
			arrived_iterator->unloading_robots = current_robot;
			parkinglot_add_robot(parkinglot, aux);
		}
		arrived_iterator = arrived_iterator->next;
	}
}

