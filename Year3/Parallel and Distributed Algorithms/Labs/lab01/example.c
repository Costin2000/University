#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define NUM_THREADS 2

void *f(void *arg) {

  	long id = *(long*)arg;

  	// Exercitiul 3

  	for (int i = 0; i < 100; i++) {

  		printf("Al %d-lea Hello World din thread-ul %ld!\n", i, id);
  	}
  	//printf("Hello World din thread-ul %ld!\n", id);
  	pthread_exit(NULL);
}

// Prima functie pentru exercitiul 4
void *func1(void *arg) {

  	long id = *(long*)arg;

  	printf("Hello World din thread-ul %ld, din prima functie!\n", id);
  	pthread_exit(NULL);
}

// A doua functie pentru exercitiul 4
void *func2(void *arg) {

  	long id = *(long*)arg;

  	printf("Hello World din thread-ul %ld, din a doua functie!\n", id);
  	pthread_exit(NULL);
}

int main(int argc, char *argv[]) {

	// Codul comentat foloseste numarul de core-uri de pe
	// calculatorul curent pentru exercitiul 2.

	/*long cores = sysconf(_SC_NPROCESSORS_CONF);
	pthread_t threads[cores];
  	int r;
  	long id;
  	void *status;
	long ids[cores];

  	for (id = 0; id < cores; id++) {
		ids[id] = id; 
		r = pthread_create(&threads[id], NULL, f, &ids[id]);

		if (r) {
	  		printf("Eroare la crearea thread-ului %ld\n", id);
	  		exit(-1);
		}
  	}

  	for (id = 0; id < cores; id++) {
		r = pthread_join(threads[id], &status);

		if (r) {
	  		printf("Eroare la asteptarea thread-ului %ld\n", id);
	  		exit(-1);
		}
  	}*/

  	long cores = sysconf(_SC_NPROCESSORS_CONF);
	pthread_t threads[NUM_THREADS];
  	int r;
  	long id;
  	void *status;
	long ids[NUM_THREADS];

	// Implementarea pentru exercitiul 4
  	for (id = 0; id < NUM_THREADS; id++) {
		ids[id] = id;

		if (id == 0) {
			r = pthread_create(&threads[id], NULL, func1, &ids[id]);

		} else {
			r = pthread_create(&threads[id], NULL, func2, &ids[id]);

		}
		

		if (r) {
	  		printf("Eroare la crearea thread-ului %ld\n", id);
	  		exit(-1);
		}
  	}

  	for (id = 0; id < NUM_THREADS; id++) {
		r = pthread_join(threads[id], &status);

		if (r) {
	  		printf("Eroare la asteptarea thread-ului %ld\n", id);
	  		exit(-1);
		}
	}



  	pthread_exit(NULL);
}
