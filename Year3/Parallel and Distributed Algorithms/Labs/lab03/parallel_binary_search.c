#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>

#define INSIDE -1 // daca numarul cautat este in interiorul intervalului
#define OUTSIDE -2 // daca numarul cautat este in afara intervalului

#define min(a, b) ((a) < (b) ? (a) : (b))

/* Scalabilitate program */

// Procesorul pe care a fost rulat codul are 4 core-uri,
// deci vom analiza performanta folosind 4 thread-uri

// In urma rularii versiunii paralele am obtinut urmatorele rezultate:

/* catalin@MacBookPro-11:~/Desktop/APD/laboratoare/lab03$ time ./parallel_binary_search 100 3 4


real	0m0,003s
user	0m0,003s
sys	    0m0,000s


*/

// iar in urma rularii versiunii seriale am obtinut:

/*catalin@MacBookPro-11:~/Desktop/APD/laboratoare/lab03$ time ./parallel_binary_search 100 3 4


real	0m0,004s
user	0m0,000s
sys	    0m0,004s

*/

struct my_arg {
	int id;
	int N;
	int P;
	int number;
	int left;
	int right;
	int *keep_running;
	int *v;
	int *found;
};

/*
void binary_search() {
	while (keep_running) {
		int mid = left + (right - left) / 2;
		if (left > right) {
			printf("Number not found\n");
			break;
		}

		if (v[mid] == number) {
			keep_running = 0;
			printf("Number found at position %d\n", mid);
		} else if (v[mid] > number) {
			left = mid + 1;
		} else {
			right = mid - 1;
		}
	}
}
*/

void *f(void *arg)
{
	struct my_arg* data = (struct my_arg*) arg;

	while (*data->keep_running) {

		// TODO: implementati parallel binary search
		int mid = data->left + (data->right - data->left) / 2;
		
		if (data->left > data->right) {
			printf("%d) Number not found\n", data->id);
			break;
		}

		if (data->v[mid] == data->number) {
			*data->keep_running = 0;
			*data->found = mid;
			printf("%d) Number found at position %d\n", data->id, mid);
		} else if (data->v[mid] > data->number) {
			data->right = mid - 1;
		} else {
			data->left = mid + 1;
		}
	}

	pthread_exit(NULL);
}

void display_vector(int *v, int size) {
	int i;

	for (i = 0; i < size; i++) {
		printf("%d ", v[i]);
	}

	printf("\n");
}


int main(int argc, char *argv[])
{
	int r, N, P, number, keep_running, left, right;
	int *v;
	int *found;
	void *status;
	pthread_t *threads;
	struct my_arg *arguments;

	if (argc < 4) {
		printf("Usage:\n\t./ex N P number\n");
		return 1;
	}

	N = atoi(argv[1]);
	P = atoi(argv[2]);
	number = atoi(argv[3]);

	keep_running = 1;
	left = 0;
	right = N;

	v = (int*) malloc(N * sizeof(int));
	threads = (pthread_t*) malloc(P * sizeof(pthread_t));
	arguments = (struct my_arg*) malloc(P * sizeof(struct my_arg));
	found = (int*) malloc(P * sizeof(int));

	for (int i = 0; i < N; i++) {
		v[i] = i * 2;
	}

	display_vector(v, N);

	for (int i = 0; i < P; i++) {
		arguments[i].id = i;
		arguments[i].N = N;
		arguments[i].P = P;
		arguments[i].number = number;
		left = i * (double)(N/P);
		arguments[i].left = left;
		right = min((i + 1) * (double)N / P, N);
		arguments[i].right = right;
		arguments[i].keep_running = &keep_running;
		arguments[i].v = v;
		arguments[i].found = found;

		r = pthread_create(&threads[i], NULL, f, &arguments[i]);

		if (r) {
			printf("Eroare la crearea thread-ului %d\n", i);
			exit(-1);
		}
	}
	printf("\n\n\n");

	for (int i = 0; i < P; i++) {
		r = pthread_join(threads[i], &status);

		if (r) {
			printf("Eroare la asteptarea thread-ului %d\n", i);
			exit(-1);
		}
	}

	free(v);
	free(threads);
	free(arguments);

	return 0;
}