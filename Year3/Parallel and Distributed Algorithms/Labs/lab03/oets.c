#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <math.h>

#define min(a, b) ((a) < (b) ? (a) : (b))

pthread_barrier_t barrier;

/* Scalabilitate program */

// Procesorul pe care a fost rulat codul are 4 core-uri,
// deci vom analiza performanta folosind 4 thread-uri

// In urma rularii versiunii paralele am obtinut urmatorele rezultate:

/* catalin@MacBookPro-11:~/Desktop/APD/laboratoare/lab03$ time ./oets 10000 4

real	0m0,968s
user	0m0,968s
sys	    0m0,873s
*/

// iar in urma rularii versiunii seriale am obtinut:

/*catalin@MacBookPro-11:~/Desktop/APD/laboratoare/lab03$ time ./oets 10000 4

real	0m1,086s
user	0m0,601s
sys	    0m0,961s
*/

// Numar elemente
int N;

// Numar thread-uri
int P;
int *v;
int *vQSort;

void compare_vectors(int *a, int *b) {
	int i;

	for (i = 0; i < N; i++) {
		if (a[i] != b[i]) {
			printf("Sortare incorecta\n");
			return;
		}
	}

	printf("Sortare corecta\n");
}

void display_vector(int *v) {
	int i;
	int display_width = 2 + log10(N);

	for (i = 0; i < N; i++) {
		printf("%*i", display_width, v[i]);
	}

	printf("\n");
}

int cmp(const void *a, const void *b) {
	int A = *(int*)a;
	int B = *(int*)b;
	return A - B;
}

void get_args(int argc, char **argv)
{
	if(argc < 3) {
		printf("Numar insuficient de parametri: ./oets N P\n");
		exit(1);
	}

	N = atoi(argv[1]);
	P = atoi(argv[2]);
}

void init()
{
	int i;
	v = malloc(sizeof(int) * N);
	vQSort = malloc(sizeof(int) * N);

	if (v == NULL || vQSort == NULL) {
		printf("Eroare la malloc!");
		exit(1);
	}

	srand(42);

	for (i = 0; i < N; i++)
		v[i] = rand() % N;
}

void print()
{
	printf("v:\n");
	display_vector(v);
	printf("vQSort:\n");
	display_vector(vQSort);
	compare_vectors(v, vQSort);
}

void *thread_function(void *arg)
{
	int thread_id = *(int *)arg;

	// implementati aici OETS paralel
	int start = thread_id * (double)N / P;
	int end = min((thread_id + 1) * (double)N / P, N);

	int start_odd_phase, start_even_phase;

	if (start % 2 == 0) {
		start_even_phase = start;
		start_odd_phase = start + 1;

	} else {
		start_even_phase = start + 1;
		start_odd_phase = start;

	}

	for (int i = 0; i < N; i++) {

		// Incepem faza para
		for (int even_idx = start_even_phase; even_idx < end && (even_idx < N - 1); even_idx += 2) {

			if(v[even_idx] > v[even_idx + 1]) {
				int aux = v[even_idx];
				v[even_idx] = v[even_idx + 1];
				v[even_idx + 1] = aux;
			}

		}

		pthread_barrier_wait(&barrier);

		// Incepem faza impara
		for (int odd_idx = start_odd_phase; odd_idx < end && (odd_idx < N - 1); odd_idx += 2) {

			if(v[odd_idx] > v[odd_idx + 1]) {
				int aux = v[odd_idx];
				v[odd_idx] = v[odd_idx + 1];
				v[odd_idx + 1] = aux;
			}

		}

		pthread_barrier_wait(&barrier);
	}

	pthread_exit(NULL);
}

int main(int argc, char *argv[])
{
	get_args(argc, argv);
	init();

	int i, r;
	//int aux;
	pthread_t tid[P];
	int thread_id[P];

	// Initializam bariera
	r = pthread_barrier_init(&barrier, NULL, P);

	if(r != 0) {
		printf("Eroare la initializarea barierei\n");
		exit(-1);
	}


	// se sorteaza vectorul etalon
	for (i = 0; i < N; i++)
		vQSort[i] = v[i];
	qsort(vQSort, N, sizeof(int), cmp);

	// se creeaza thread-urile
	for (i = 0; i < P; i++) {
		thread_id[i] = i;
		pthread_create(&tid[i], NULL, thread_function, &thread_id[i]);
	}

	// se asteapta thread-urile
	for (i = 0; i < P; i++) {
		pthread_join(tid[i], NULL);
	}

	// bubble sort clasic - trebuie transformat in OETS si paralelizat
	/*int sorted = 0;
	while (!sorted) {
		sorted = 1;

		for (i = 0; i < N-1; i++) {
			if(v[i] > v[i + 1]) {
				aux = v[i];
				v[i] = v[i + 1];
				v[i + 1] = aux;
				sorted = 0;
			}
		}
	}*/

	// se afiseaza vectorul etalon
	// se afiseaza vectorul curent
	// se compara cele doua
	print();

	free(v);
	free(vQSort);

	// Dezalocam bariera
	r = pthread_barrier_destroy(&barrier);

	if(r != 0) {
		printf("Eroare la distrugerea barierei\n");
		exit(-1);
	}

	return 0;
}
