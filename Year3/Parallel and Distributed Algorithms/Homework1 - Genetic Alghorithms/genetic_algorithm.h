#ifndef GENETIC_ALGORITHM_H
#define GENETIC_ALGORITHM_H

#include <stdio.h>
#include "sack_object.h"
#include "individual.h"
#include <pthread.h>

struct individualsAttributes {
	const sack_object *objects;
	individual *current_generation;
	individual *next_generation;
	individual *tmp;
	int object_count;
	int generations_count;
	int sack_capacity;
	int nrThreads;
	int threadID;
    pthread_barrier_t* barrier;
};

// reads input from a given file
int read_input(sack_object **objects, int *object_count, int *sack_capacity, int *generations_count, int argc, char *argv[]);

// displays all the objects that can be placed in the sack
void print_objects(const sack_object *objects, int object_count);

// displays all or a part of the individuals in a generation
void print_generation(const individual *generation, int limit);

// displays the individual with the best fitness in a generation
void print_best_fitness(const individual *generation);

// computes the fitness function for each individual in a generation
void compute_fitness_function(const sack_object *objects, individual *generation, int object_count, int sack_capacity, int start, int end);

// compares two individuals by fitness and then number of objects in the sack (to be used with qsort)
int cmpfunc(const void *a, const void *b);

// performs a variant of bit string mutation
void mutate_bit_string_1(const individual *ind, int generation_index);

// performs a different variant of bit string mutation
void mutate_bit_string_2(const individual *ind, int generation_index);

// performs one-point crossover
void crossover(individual *parent1, individual *child1, int generation_index);

// copies one individual
void copy_individual(const individual *from, const individual *to);

// deallocates a generation
void free_generation(individual *generation);

//merges two sorted parts of a vector in one sorted part
void merge(individual *current_generation, int low, int mid, int high);

//merge sort algorithm
void merge_sort(individual *current_generation, int low, int high);

// runs the genetic algorithm
void* run_genetic_algorithm(void* arg);

// verifies if barrier waiting process was successful
void verifyBarrier(int r);

#endif