#include <stdlib.h>
#include "genetic_algorithm.h"


int main(int argc, char *argv[]) {

	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	int nrThreads = (int) strtol(argv[3], NULL, 10);
	pthread_t threads[nrThreads];
	int r;
	long id;
    void *status;
	pthread_barrier_t barrier;
	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------


	// array with all the objects that can be placed in the sack
	sack_object *objects = NULL;

	// number of objects
	int object_count = 0;

	// maximum weight that can be carried in the sack
	int sack_capacity = 0;

	// number of generations
	int generations_count = 0;

	if (!read_input(&objects, &object_count, &sack_capacity, &generations_count, argc, argv)) {
		return 0;
	}


	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------
	
	struct individualsAttributes specificatii[nrThreads];
	individual *current_generation = (individual*) calloc(object_count, sizeof(individual));
	individual *next_generation = (individual*) calloc(object_count, sizeof(individual));
	individual *tmp = NULL;
	
	
	// Initializam bariera
    r = pthread_barrier_init(&barrier, NULL, nrThreads);
    if(r != 0) {
        printf("Eroare la initializarea barierei\n");
        exit(-1);
    }

	
	for (int i = 0; i < nrThreads; i++) {
		specificatii[i].objects = objects;
		specificatii[i].current_generation = current_generation;
		specificatii[i].next_generation = next_generation;
		specificatii[i].tmp = tmp;
		specificatii[i].object_count = object_count;
		specificatii[i].generations_count = generations_count;
		specificatii[i].sack_capacity = sack_capacity;
		specificatii[i].nrThreads = nrThreads;
		specificatii[i].threadID = i;
		specificatii[i].barrier = &barrier;

		
        r = pthread_create(&threads[i], NULL, run_genetic_algorithm, (void *) &specificatii[i]);

        if (r) {
            printf("Eroare la crearea thread-ului %d\n", i);
            exit(-1);
        }
	} 

	//dau join
	for (id = 0; id < nrThreads; id++) {
        r = pthread_join(threads[id], &status);
 
        if (r) {
            printf("Eroare la asteptarea thread-ului %ld\n", id);
            exit(-1);
        }
    }

	// Dezalocam bariera
    r = pthread_barrier_destroy(&barrier);
    if(r != 0) {
        printf("Eroare la distrugerea barierei\n");
        exit(-1);
    }

	//-----------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------

	free(objects);

	return 0;
}
