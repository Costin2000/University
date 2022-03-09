#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define NUM_THREADS 2

int a = 0;

// Declaram mutex-ul
pthread_mutex_t mutex;

void *f(void *arg)
{
	int r;

	// Blocam executia functiei f (prin mutex) pentru a permite
	// un singur thread la un anumit moment de timp
	r = pthread_mutex_lock(&mutex);

	if(r != 0) {
		printf("Eroare la inchiderea mutex-ului\n");
		exit(-1);
	}

	a += 2;

	// Deblocam mutex-ul pentru a permite altui
	// thread sa intre in aceasta zona
	r = pthread_mutex_unlock(&mutex);

	if(r != 0) {
		printf("Eroare la deschiderea mutex-ului\n");
		exit(-1);
	}

	pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
	int i, r;
	void *status;
	pthread_t threads[NUM_THREADS];
	int arguments[NUM_THREADS];

	// Initializam mutex-ul
	r = pthread_mutex_init(&mutex, NULL);

	if(r != 0) {
		printf("Eroare la crearea mutex-ului\n");
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

	// Dezalocam mutex-ul
	r = pthread_mutex_destroy(&mutex);
	
	if(r != 0) {
		printf("Eroare la distrugerea mutex-ului\n");
		exit(-1);
	}

	printf("a = %d\n", a);

	return 0;
}
