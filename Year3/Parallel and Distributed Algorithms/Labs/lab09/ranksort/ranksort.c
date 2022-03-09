#include<mpi.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

#define N 1000
#define MASTER 0

#define min(a,b) (((a) < (b)) ? (a) : (b))

void compareVectors(int * a, int * b) {
	// DO NOT MODIFY
	int i;
	for(i = 0; i < N; i++) {
		if(a[i]!=b[i]) {
			printf("Sorted incorrectly\n");
			return;
		}
	}
	printf("Sorted correctly\n");
}

void displayVector(int * v) {
	// DO NOT MODIFY
	int i;
	int displayWidth = 2 + log10(v[N-1]);
	for(i = 0; i < N; i++) {
		printf("%*i", displayWidth, v[i]);
	}
	printf("\n");
}

int cmp(const void *a, const void *b) {
	// DO NOT MODIFY
	int A = *(int*)a;
	int B = *(int*)b;
	return A-B;
}
 
int main(int argc, char * argv[]) {
	int rank, i, j;
	int nProcesses;
	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &nProcesses);

	int start = rank * (double)N / nProcesses;
	int end = min((rank + 1) * (double)N / nProcesses, N);

	int pos[N];
	int sorted = 0;
	int *v = (int*)malloc(sizeof(int)*N);
	int *vQSort = (int*)malloc(sizeof(int)*N);
	int* results = malloc(sizeof(int) * N);

	for (i = 0; i < N; i++)
		pos[i] = 0;

	
	printf("Hello from %i/%i\n", rank, nProcesses);

    if (rank == MASTER) {
        // generate random vector

		srand(42);

		for (i = 0; i < N; i++) {
            v[i] = rand() % N;
        }    
    }

    // send the vector to all processes
	MPI_Bcast(v, N, MPI_INT, MASTER, MPI_COMM_WORLD);

	for (i = start; i < end; i++) {
        for (j = 0; j < N; j++) {
            if (v[j] < v[i] || (j < i && v[j] == v[i])) {
                ++pos[i - start];
            }
        }
    }

	MPI_Gather(pos, end - start, MPI_INT, pos, end - start, MPI_INT, MASTER, MPI_COMM_WORLD);


	if(rank == 0) {
		// DO NOT MODIFY
		displayVector(v);

		// make copy to check it against qsort
		// DO NOT MODIFY
		for(i = 0; i < N; i++)
			vQSort[i] = v[i];
		qsort(vQSort, N, sizeof(int), cmp);

		// sort the vector v
		for (i = 0; i < N; i++) {
            results[pos[i]] = v[i];
        }
		
        // recv the new pozitions

		displayVector(results);
		compareVectors(results, vQSort);
	} else {
		
        // compute the positions
        // send the new positions to process MASTER
	}

	MPI_Finalize();
	return 0;
}
