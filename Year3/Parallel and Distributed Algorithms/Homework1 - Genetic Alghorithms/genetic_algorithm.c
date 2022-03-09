#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "genetic_algorithm.h"

#define min(a,b) (((a) < (b)) ? (a) : (b))

int read_input(sack_object **objects, int *object_count, int *sack_capacity, int *generations_count, int argc, char *argv[])
{
	FILE *fp;

	if (argc < 3) {
		fprintf(stderr, "Usage:\n\t./tema1 in_file generations_count\n");
		return 0;
	}

	fp = fopen(argv[1], "r");
	if (fp == NULL) {
		return 0;
	}

	if (fscanf(fp, "%d %d", object_count, sack_capacity) < 2) {
		fclose(fp);
		return 0;
	}

	if (*object_count % 10) {
		fclose(fp);
		return 0;
	}

	sack_object *tmp_objects = (sack_object *) calloc(*object_count, sizeof(sack_object));

	for (int i = 0; i < *object_count; ++i) {
		if (fscanf(fp, "%d %d", &tmp_objects[i].profit, &tmp_objects[i].weight) < 2) {
			free(objects);
			fclose(fp);
			return 0;
		}
	}

	fclose(fp);

	*generations_count = (int) strtol(argv[2], NULL, 10);
	
	if (*generations_count == 0) {
		free(tmp_objects);

		return 0;
	}

	*objects = tmp_objects;

	return 1;
}

void print_objects(const sack_object *objects, int object_count)
{
	for (int i = 0; i < object_count; ++i) {
		printf("%d %d\n", objects[i].weight, objects[i].profit);
	}
}

void print_generation(const individual *generation, int limit)
{
	for (int i = 0; i < limit; ++i) {
		for (int j = 0; j < generation[i].chromosome_length; ++j) {
			printf("%d ", generation[i].chromosomes[j]);
		}

		printf("\n%d - %d\n", i, generation[i].fitness);
	}
}

void print_best_fitness(const individual *generation)
{
	printf("%d\n", generation[0].fitness);
}

void compute_fitness_function(const sack_object *objects, individual *generation, int object_count, int sack_capacity, int start, int end)
{
	int weight;
	int profit;

	for (int i = start; i < end; ++i) {
		weight = 0;
		profit = 0;

		for (int j = 0; j < generation[i].chromosome_length; ++j) {
			if (generation[i].chromosomes[j]) {
				weight += objects[j].weight;
				profit += objects[j].profit;
			}
		}

		generation[i].fitness = (weight <= sack_capacity) ? profit : 0;
	}
}

int cmpfunc(const void *a, const void *b)
{
	int i;
	individual *first = (individual *) a;
	individual *second = (individual *) b;

	int res = second->fitness - first->fitness; // decreasing by fitness
	if (res == 0) {
		int first_count = 0, second_count = 0;

		for (i = 0; i < first->chromosome_length && i < second->chromosome_length; ++i) {
			first_count += first->chromosomes[i];
			second_count += second->chromosomes[i];
		}

		res = first_count - second_count; // increasing by number of objects in the sack
		if (res == 0) {
			return second->index - first->index;
		}
	}

	return res;
}

void mutate_bit_string_1(const individual *ind, int generation_index)
{
	int i, mutation_size;
	int step = 1 + generation_index % (ind->chromosome_length - 2);

	if (ind->index % 2 == 0) {
		// for even-indexed individuals, mutate the first 40% chromosomes by a given step
		mutation_size = ind->chromosome_length * 4 / 10;
		for (i = 0; i < mutation_size; i += step) {
			ind->chromosomes[i] = 1 - ind->chromosomes[i];
		}
	} else {
		// for even-indexed individuals, mutate the last 80% chromosomes by a given step
		mutation_size = ind->chromosome_length * 8 / 10;
		for (i = ind->chromosome_length - mutation_size; i < ind->chromosome_length; i += step) {
			ind->chromosomes[i] = 1 - ind->chromosomes[i];
		}
	}
}

void mutate_bit_string_2(const individual *ind, int generation_index)
{
	int step = 1 + generation_index % (ind->chromosome_length - 2);

	// mutate all chromosomes by a given step
	for (int i = 0; i < ind->chromosome_length; i += step) {
		ind->chromosomes[i] = 1 - ind->chromosomes[i];
	}
}

void crossover(individual *parent1, individual *child1, int generation_index)
{
	individual *parent2 = parent1 + 1;
	individual *child2 = child1 + 1;
	int count = 1 + generation_index % parent1->chromosome_length;

	memcpy(child1->chromosomes, parent1->chromosomes, count * sizeof(int));
	memcpy(child1->chromosomes + count, parent2->chromosomes + count, (parent1->chromosome_length - count) * sizeof(int));

	memcpy(child2->chromosomes, parent2->chromosomes, count * sizeof(int));
	memcpy(child2->chromosomes + count, parent1->chromosomes + count, (parent1->chromosome_length - count) * sizeof(int));
}

void copy_individual(const individual *from, const individual *to)
{
	memcpy(to->chromosomes, from->chromosomes, from->chromosome_length * sizeof(int));
}

void free_generation(individual *generation)
{
	int i;

	for (i = 0; i < generation->chromosome_length; ++i) {
		free(generation[i].chromosomes);
		generation[i].chromosomes = NULL;
		generation[i].fitness = 0;
	}
}


// merge function for merging two parts
void merge(individual *current_generation, int low, int mid, int high)
{

	individual left[mid - low + 1];
	individual right[high - mid]; 
 

    int n1 = mid - low + 1;
	int n2 = high - mid;
	int i, j;
 
    // sortez partea din stanga
    for (i = 0; i < n1; i++)
        left[i] = current_generation[i + low];
 
    // sortez partea din dreapta
    for (i = 0; i < n2; i++)
        right[i] = current_generation[i + mid + 1];
 
    int k = low;
    i = j = 0;
 
    // merge partea din stanga si dreapta
    while (i < n1 && j < n2) {
        if (cmpfunc(&left[i], &right[j]) < 0) {
            current_generation[k++] = left[i++];
		} else {
            current_generation[k++] = right[j++];
		}
    }
 
    // inserez restul de valori ramase din stanga
    while (i < n1) {
        current_generation[k++] = left[i++];
    }
 
    // inserez restul de valori din dreapta
    while (j < n2) {
        current_generation[k++] = right[j++];
    }
}
 
// merge sort function
void merge_sort(individual *current_generation, int low, int high)
{
    // calculez mid-ul
    int mid = low + (high - low) / 2;
    if (low < high) {
 
        // apelez pentru prima parte
        merge_sort(current_generation, low, mid);
 
        // capelez pt a doua parte
        merge_sort(current_generation, mid + 1, high);
 
        // le dau merge celor doua
        merge(current_generation, low, mid, high);
    }
}

void verifyBarrier(int r) {
	if (r != PTHREAD_BARRIER_SERIAL_THREAD && r != 0) {
			printf("Eroare la procesul de wait\n");
			exit(-1);
		}
}
 
void* run_genetic_algorithm(void* arg)
{
	int count, cursor, r;


	struct individualsAttributes* specificatii = (struct individualsAttributes*) arg;
	
	int object_count = specificatii->object_count;
	int	generations_count = specificatii->generations_count;
	int	sack_capacity = specificatii->sack_capacity;
	int	nrThreads = specificatii->nrThreads;
	int	threadID = specificatii->threadID;
	pthread_barrier_t*	barrier = specificatii->barrier;
	
	//calculez indecşii de start si end pt fiecare thread
	int start = threadID * (double)object_count / nrThreads;
	int end = min((threadID + 1) * (double)object_count / nrThreads, object_count);
	
	//paralizez initializarile, fiecare thread face o parte
	for (int i = start; i < end; ++i) {
		specificatii->current_generation[i].fitness = 0;
		specificatii->current_generation[i].chromosomes = (int*) calloc(object_count, sizeof(int));
		specificatii->current_generation[i].chromosomes[i] = 1;
		specificatii->current_generation[i].index = i;
		specificatii->current_generation[i].chromosome_length = object_count;

		specificatii->next_generation[i].fitness = 0;
		specificatii->next_generation[i].chromosomes = (int*) calloc(object_count, sizeof(int));
		specificatii->next_generation[i].index = i;
		specificatii->next_generation[i].chromosome_length = object_count;
	}
	
	// astept ca toate threadurile sa termine partea lor
	r = pthread_barrier_wait(barrier);
	verifyBarrier(r);

	// calculez pentru fiecare thread low, mid si high cu care voi apela functia de merge sort
	int low = (threadID) * (object_count / nrThreads);
    int high = (threadID + 1) * (object_count / nrThreads) - 1;
	int mid = low + (high - low) / 2;
	
	// iterez prin fiecare generatie
	for (int k = 0; k < generations_count; ++k) {

		cursor = 0;

		// paralelizez compute_fitness_function
		compute_fitness_function(specificatii->objects, specificatii->current_generation, object_count, sack_capacity, start, end);
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);

		//execut algoritmul de merge sort
		if (low < high) {
			merge_sort(specificatii->current_generation, low, mid);
			merge_sort(specificatii->current_generation, mid + 1, high);
			merge(specificatii->current_generation, low, mid, high);
		}

		//astept sa ajunga toate threadurile
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);

		//in functie de cate treaduri am primit ca parametru, fac cate mergeuri este nevoie
		if(threadID == 0 && nrThreads >= 2) {
			int partLength = object_count / nrThreads;
			int midHelper = partLength;
			int rightMargin = partLength * 2; 

			for(int cont = 0; cont < nrThreads - 1; cont++) {
				if(cont == nrThreads - 2) {
					merge(specificatii->current_generation, 0, midHelper - 1, object_count -1);
				} else {
					merge(specificatii->current_generation, 0, midHelper - 1, rightMargin - 1);
					midHelper = rightMargin;
					rightMargin = rightMargin + partLength;
				}
				
			}
		}
		
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);
		


		// pastrez copiii de elita
		count = object_count * 3 / 10;
		//calculez partea fiecarui thread
		int startCount = threadID * (double)count / nrThreads;
		int endCount = min((threadID + 1) * (double)count / nrThreads, count);

		//paralelizez selectia
		for (int i = startCount; i < endCount; ++i) {
			copy_individual(specificatii->current_generation + i, specificatii->next_generation + i);
		}
		cursor = count;

		
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);

		
		// mutatia pentru primii 20% copii
		count = object_count * 2 / 10;

		//calculez partea fiecarui thread
		startCount = threadID * (double)count / nrThreads;
		endCount = min((threadID + 1) * (double)count / nrThreads, count);

		for (int i = startCount; i < endCount; ++i) {
			copy_individual(specificatii->current_generation + i, specificatii->next_generation + cursor + i);
			mutate_bit_string_1(specificatii->next_generation + cursor + i, k);
		}

		cursor += count;

		
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);

		// mutatia pentru primii 20% copii
		count = object_count * 2 / 10;

		//calculez partea fiecarui thread
		startCount = threadID * (double)count / nrThreads;
		endCount = min((threadID + 1) * (double)count / nrThreads, count);

		for (int i = startCount; i < endCount; ++i) {
			copy_individual(specificatii->current_generation + i + count, specificatii->next_generation + cursor + i);
			mutate_bit_string_2(specificatii->next_generation + cursor + i, k);
		}
		cursor += count;
		
		
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);

		// crossover first 30% parents with one-point crossover
		// (if there is an odd number of parents, the last one is kept as such)
		count = object_count * 3 / 10;


		if (count % 2 == 1) {
			copy_individual(specificatii->current_generation + object_count - 1, specificatii->next_generation + cursor + count - 1);
			count--;
		}

		//calculez startul si endul pt fiecare thread
		startCount = threadID * (double)count / nrThreads;
		endCount = min((threadID + 1) * (double)count / nrThreads, count);
		
		//paralelizez
		for (int i = startCount; i < endCount && (i < count - 1); i += 2) {
			crossover(specificatii->current_generation + i, specificatii->next_generation + cursor + i, k);
		}


		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);


		// trec la generatia urmatoare
		specificatii->tmp = specificatii->current_generation;
		specificatii->current_generation = specificatii->next_generation;
		specificatii->next_generation = specificatii->tmp;

		//paralelizez
		for (int i = start; i < end; ++i) {
			specificatii->current_generation[i].index = i;
		}
		
		r = pthread_barrier_wait(barrier);
		verifyBarrier(r);


		if (k % 5 == 0 && threadID == 0) {
			print_best_fitness(specificatii->current_generation);
		}
	}

	//paralelizez
	compute_fitness_function(specificatii->objects, specificatii->current_generation, object_count, sack_capacity, start, end);
	
	r = pthread_barrier_wait(barrier);
	verifyBarrier(r);

	//aplic merge sort din nou
	if (low < high) {
		merge_sort(specificatii->current_generation, low, mid);
		merge_sort(specificatii->current_generation, mid + 1, high);
		merge(specificatii->current_generation, low, mid, high);
	}

	
	r = pthread_barrier_wait(barrier);
	verifyBarrier(r);

	
	//in functie de cate treaduri am primit ca parametru, fac cate mergeuri este nevoie
	if(threadID == 0 && nrThreads >= 2) {
		int partLength = object_count / nrThreads;
		int midHelper = partLength;
		int rightMargin = partLength * 2; 

		for(int cont = 0; cont < nrThreads - 1; cont++) {
			if(cont == nrThreads - 2) {
				merge(specificatii->current_generation, 0, midHelper - 1, object_count -1);
			} else {
				merge(specificatii->current_generation, 0, midHelper - 1, rightMargin - 1);
				midHelper = rightMargin;
				rightMargin = rightMargin + partLength;
			}
			
		}
	}
		
	r = pthread_barrier_wait(barrier);
	verifyBarrier(r);

	if (threadID == 0) {
		print_best_fitness(specificatii->current_generation);
	}

 	pthread_exit(NULL);
}