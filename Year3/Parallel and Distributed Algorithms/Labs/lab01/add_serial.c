#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/*
    schelet pentru exercitiul 5
*/

#define min(a,b)            (((a) < (b)) ? (a) : (b))

int* arr;
int array_size;

// Structura folosita pentru a stoca indexii pe care ii va parcurge
// unul dintre thread-uri
struct coreParameters {
    int start;
    int end;
};

// Pentru exercitiul 6, in urma folosirii time la rulare se poate
// observa cum procesorul este mai putin incarcat in implementarea
// ce foloseste mai multe thread-uri. In schimb, pentru acest exemplu
// timpul efectiv de rulare nu se modifica extrem de mult pentru ca este
// un task relativ usor de realizat pentru un calculator.


// Functia add100 va prelua din structura indexul de start si de final
// pentru a incrementa cu 100 doar o parte din vector
void *add100(void *arg) {

    struct coreParameters *myParameters = (struct coreParameters*) arg;

    int start = myParameters->start;
    int end = myParameters->end;


    for (int i = start; i < end; i++) {

        arr[i] += 100;
    }
    
    pthread_exit(NULL);
}

int main(int argc, char *argv[]) {

    long cores = sysconf(_SC_NPROCESSORS_CONF);
    pthread_t threads[cores];
    int r;
    long id;
    void *status;
    long ids[cores];
    struct coreParameters arrays[cores];

    if (argc < 2) {
        perror("Specificati dimensiunea array-ului\n");
        exit(-1);
    }

    array_size = atoi(argv[1]);

    arr = malloc(array_size * sizeof(int));
    for (int i = 0; i < array_size; i++) {
        arr[i] = i;
    }

    for (int i = 0; i < array_size; i++) {
        printf("%d", arr[i]);
        if (i != array_size - 1) {
            printf(" ");
        } else {
            printf("\n");
        }
    }

    // TODO: aceasta operatie va fi paralelizata
  	/*for (int i = 0; i < array_size; i++) {
        arr[i] += 100;
    }*/

    for (id = 0; id < cores; id++) {

        ids[id] = id; 

        // Calculam indexii pentru distribuirea vectorului pe core-urile masinii
        int start = id * (double)array_size / cores;
        int end = min((id + 1) * (double)array_size / cores, array_size);

        // Stocam intr-un vector de structuri indexii
        arrays[id].start = start;
        arrays[id].end = end;

        r = pthread_create(&threads[id], NULL, add100, &arrays[id]);

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
    }

    for (int i = 0; i < array_size; i++) {
        printf("%d", arr[i]);
        if (i != array_size - 1) {
            printf(" ");
        } else {
            printf("\n");
        }
    }

  	pthread_exit(NULL);
}
