#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 2

// Declaram bariera
pthread_barrier_t barrier;

void *f(void *arg)
{
	int thread_id = *(int *)arg;
	int r;

	if (thread_id == 1) {
		printf("1\n");
	}

	// Folosim bariera pentru a executa cu siguranta
	// thread-ul 1 primul
	r = pthread_barrier_wait(&barrier);

	// Daca s-a executat alt thread ==> eroare
	if (r != PTHREAD_BARRIER_SERIAL_THREAD && r != 0) {
		printf("Eroare la procesul de wait\n");
		exit(-1);
	}

	if (thread_id == 0) {
		printf("2\n");
	}

	pthread_exit(NULL);
}

int main(int argc, char **argv)
{
	int i, r;
	void *status;
	pthread_t threads[NUM_THREADS];
	int arguments[NUM_THREADS];

	// Initializam bariera
	r = pthread_barrier_init(&barrier, NULL, 2);

	if(r != 0) {
		printf("Eroare la initializarea barierei\n");
		exit(-1);
	}

	for (i = 0; i < NUM_THREADS; i++) {
		arguments[i] = i;
		r = pthread_create(&threads[i], NULL, f, &arguments[i]);

		if (r) {
			printf("Eroare la crearea thread-ului %d\n", i);
			exit(-1);
		}
	}

	for (i = 0; i < NUM_THREADS; i++) {
		r = pthread_join(threads[i], &status);

		if (r) {
			printf("Eroare la asteptarea thread-ului %d\n", i);
			exit(-1);
		}
	}

	// Dezalocam bariera
	r = pthread_barrier_destroy(&barrier);

	if(r != 0) {
		printf("Eroare la distrugerea barierei\n");
		exit(-1);
	}

	return 0;
}
