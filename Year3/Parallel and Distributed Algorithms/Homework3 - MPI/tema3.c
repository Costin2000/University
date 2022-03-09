#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define min(a,b) (((a) < (b)) ? (a) : (b))

int main (int argc, char *argv[])
{
    int  numtasks, rank;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    MPI_Comm_rank(MPI_COMM_WORLD,&rank);

    int recv_num;
    if(rank == 0 || rank == 1 || rank == 2) {
        char inputFile[100];
        
        sprintf(inputFile, "cluster%d.txt", rank);
        
        FILE *fptr;

        fptr = fopen(inputFile,"r");
        if(fptr == NULL)
        {
            printf("Error!");   
            exit(1);             
        }

        int nrWorkers;
        fscanf(fptr, "%d", &nrWorkers);

        char topology[1000];
        sprintf(topology, "%d:", rank);

        int workersRanks[nrWorkers];
        for(int i = 0; i < nrWorkers; i++) {
            fscanf(fptr, "%d", &workersRanks[i]);
            if(i != nrWorkers - 1) {
                sprintf(topology+strlen(topology), "%d,", workersRanks[i]);
            } else {
                sprintf(topology+strlen(topology), "%d", workersRanks[i]);
            }
        }

        //le transmit workerilor care este procesul lor coodonator
        for(int i = 0; i < nrWorkers; i++) {
            MPI_Send(&rank, 1, MPI_INT, workersRanks[i] , 1, MPI_COMM_WORLD);
        }

        int topologyLength = strlen(topology);

        //trimit lungimea tpologiei celorlalte doua procese coordonator si primesc lungimile topologiilor lor
        int lengthTopA;
        int lengthTopB;

        
        if(rank == 0) {
            MPI_Send(&topologyLength, 1, MPI_INT, 1, 1, MPI_COMM_WORLD);
            MPI_Send(&topologyLength, 1, MPI_INT, 2, 1, MPI_COMM_WORLD);
            
            MPI_Recv(&lengthTopA, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&lengthTopB, 1, MPI_INT, 2, 1, MPI_COMM_WORLD, NULL);
        } else if(rank == 1) {
            MPI_Send(&topologyLength, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
            MPI_Send(&topologyLength, 1, MPI_INT, 2, 1, MPI_COMM_WORLD);

            MPI_Recv(&lengthTopA, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&lengthTopB, 1, MPI_INT, 2, 1, MPI_COMM_WORLD, NULL);
        } else if(rank == 2) {
            MPI_Send(&topologyLength, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
            MPI_Send(&topologyLength, 1, MPI_INT, 1, 1, MPI_COMM_WORLD);

            MPI_Recv(&lengthTopA, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&lengthTopB, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, NULL);
        }

        //trimit tpologiei celorlalte doua procese coordonator si primesc topologiile lor
        //si compun intreaga topologie
        char topA[1000];
        char topB[1000];
        char fullTopology[10000];

        if(rank == 0) {
            MPI_Send(&topology, topologyLength, MPI_CHAR, 1, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 1);
            MPI_Send(&topology, topologyLength, MPI_CHAR, 2, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 2);

            MPI_Recv(&topA, lengthTopA, MPI_CHAR, 1, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&topB, lengthTopB, MPI_CHAR, 2, 1, MPI_COMM_WORLD, NULL);

            sprintf(fullTopology, "%s ", topology);
            sprintf(fullTopology+strlen(fullTopology), "%s ", topA);
            sprintf(fullTopology+strlen(fullTopology), "%s", topB);

        } else if(rank == 1) {
            MPI_Send(&topology, topologyLength, MPI_CHAR, 0, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 0);
            MPI_Send(&topology, topologyLength, MPI_CHAR, 2, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 2);

            MPI_Recv(&topA, lengthTopA, MPI_CHAR, 0, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&topB, lengthTopB, MPI_CHAR, 2, 1, MPI_COMM_WORLD, NULL);

            sprintf(fullTopology, "%s ", topA);
            sprintf(fullTopology+strlen(fullTopology), "%s ", topology);
            sprintf(fullTopology+strlen(fullTopology), "%s", topB);

        } else if(rank == 2) {
            MPI_Send(&topology, topologyLength, MPI_CHAR, 0, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 0);
            MPI_Send(&topology, topologyLength, MPI_CHAR, 1, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 1);

            MPI_Recv(&topA, lengthTopA, MPI_CHAR, 0, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&topB, lengthTopB, MPI_CHAR, 1, 1, MPI_COMM_WORLD, NULL);

            sprintf(fullTopology, "%s ", topA);
            sprintf(fullTopology + strlen(fullTopology), "%s ", topB);
            sprintf(fullTopology + strlen(fullTopology), "%s", topology);
        }

        // afisez topologia
        printf("%d -> %s\n", rank, fullTopology);
        
        //trimit tuturor proceselor subordonate lungimea stringului si topologia full
        int fullTopologyLength = strlen(fullTopology);
        for(int i = 0; i < nrWorkers; i++) {
            MPI_Send(&fullTopologyLength, 1, MPI_INT, workersRanks[i] , 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, workersRanks[i]);
            MPI_Send(&fullTopology, fullTopologyLength, MPI_CHAR, workersRanks[i] , 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, workersRanks[i]);
        }

        
        int arrayLen = 0;
        //extrag marimea vectorului
        if(rank == 0) {
            arrayLen = (int) strtol(argv[1], NULL, 10);
            MPI_Send(&arrayLen, 1, MPI_INT, 1 , 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 1);
            MPI_Send(&arrayLen, 1, MPI_INT, 2 , 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 2);
        } else {
            MPI_Recv(&arrayLen, 1, MPI_INT, 0 , 1, MPI_COMM_WORLD, NULL);
        }

        //0 creeaza vectorul si il trimite celorlalti coordonatori
        int array[arrayLen];

        if(rank == 0) {
            for(int i = 0; i < arrayLen; i++) {
                array[i] = i;
            }
            MPI_Send(&array, arrayLen, MPI_INT, 1 , 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 1);
            MPI_Send(&array, arrayLen, MPI_INT, 2 , 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 2);
        } else {
           MPI_Recv(&array, arrayLen, MPI_INT, 0 , 1, MPI_COMM_WORLD, NULL);
        }

        //aflu cati workeri are topologia
        int topologyNrWorkers;
        topologyNrWorkers = nrWorkers;

        int nrWorkersA, nrWorkersB;;
        if(rank == 0) {
            MPI_Send(&nrWorkers, 1, MPI_INT, 1, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 1);
            MPI_Send(&nrWorkers, 1, MPI_INT, 2, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 2);
            
            MPI_Recv(&nrWorkersA, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&nrWorkersB, 1, MPI_INT, 2, 1, MPI_COMM_WORLD, NULL);

            topologyNrWorkers += nrWorkersA + nrWorkersB; 
        } else if(rank == 1) {
            MPI_Send(&nrWorkers, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 0);
            MPI_Send(&nrWorkers, 1, MPI_INT, 2, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 2);

            MPI_Recv(&nrWorkersA, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&nrWorkersB, 1, MPI_INT, 2, 1, MPI_COMM_WORLD, NULL);

            topologyNrWorkers += nrWorkersA + nrWorkersB; 
        } else if(rank == 2) {
            MPI_Send(&nrWorkers, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 0);
            MPI_Send(&nrWorkers, 1, MPI_INT, 1, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 1);

            MPI_Recv(&nrWorkersA, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&nrWorkersB, 1, MPI_INT, 1, 1, MPI_COMM_WORLD, NULL);

            topologyNrWorkers += nrWorkersA + nrWorkersB; 
        }

        //calculez startul si endul pentru fiecare worker din topologie
        int start[topologyNrWorkers];
        int end[topologyNrWorkers];
        for(int i = 0; i < topologyNrWorkers; i++) {
            start[i] = i * (double)arrayLen / topologyNrWorkers;
	        end[i] = min((i + 1) * (double)arrayLen / topologyNrWorkers, arrayLen);
        }

        
        //trimit secventele din vector pe care trebuie workerii sa le modifice
        
        if(rank == 0) {
            for(int i = 0; i < nrWorkers; i++) {
                int sequenceLength = end[i] - start[i];
                int sequence[sequenceLength];
                int contor = 0;
                for(int j = start[i]; j < end[i]; j++) {
                    sequence[contor] = array[j];
                    contor++;
                }
                
                MPI_Send(&sequenceLength, 1, MPI_INT, workersRanks[i], 1, MPI_COMM_WORLD);
                printf("M(%d,%d)\n", rank, workersRanks[i]);
                MPI_Send(&sequence, sequenceLength, MPI_INT, workersRanks[i], 1, MPI_COMM_WORLD);
                printf("M(%d,%d)\n", rank, workersRanks[i]);
            }
        } else if(rank == 1) {

            int fromWhere = nrWorkersA;
            for(int i = 0; i < nrWorkers; i++) {
                int sequenceLength = end[fromWhere] - start[fromWhere];
                int sequence[sequenceLength];
                int contor = 0;
                for(int j = start[fromWhere]; j < end[fromWhere]; j++) {
                    sequence[contor] = array[j];
                    contor++;
                }
                fromWhere++;
                MPI_Send(&sequenceLength, 1, MPI_INT, workersRanks[i], 1, MPI_COMM_WORLD);
                printf("M(%d,%d)\n", rank, workersRanks[i]);
                MPI_Send(&sequence, sequenceLength, MPI_INT, workersRanks[i], 1, MPI_COMM_WORLD);
                printf("M(%d,%d)\n", rank, workersRanks[i]);
            }
        } else if(rank == 2) {
            int fromWhere = nrWorkersA + nrWorkersB;
            for(int i = 0; i < nrWorkers; i++) {
                int sequenceLength = end[fromWhere] - start[fromWhere];
                int sequence[sequenceLength];
                int contor = 0;
                for(int j = start[fromWhere]; j < end[fromWhere]; j++) {
                    sequence[contor] = array[j];
                    contor++;
                }
                fromWhere++;
                MPI_Send(&sequenceLength, 1, MPI_INT, workersRanks[i], 1, MPI_COMM_WORLD);
                printf("M(%d,%d)\n", rank, workersRanks[i]);
                MPI_Send(&sequence, sequenceLength, MPI_INT, workersRanks[i], 1, MPI_COMM_WORLD);
                printf("M(%d,%d)\n", rank, workersRanks[i]);
            }
        }
        
        
        //primesc secventele modificate
        if(rank == 0) {
            for(int i = 0; i < nrWorkers; i++) {
                int sequenceLength = end[i] - start[i];
                int sequence[sequenceLength];

                MPI_Recv(&sequence, sequenceLength, MPI_INT, workersRanks[i] , 1, MPI_COMM_WORLD, NULL);
                int contor = 0;
                for(int j = start[i]; j < end[i]; j++) {
                    array[j] = sequence[contor];
                    contor++;
                }
            }
        } else if(rank == 1) {
            int fromWhere = nrWorkersA;
            for(int i = 0; i < nrWorkers; i++) {
                int sequenceLength = end[fromWhere] - start[fromWhere];
                int sequence[sequenceLength];

                MPI_Recv(&sequence, sequenceLength, MPI_INT, workersRanks[i] , 1, MPI_COMM_WORLD, NULL);
                int contor = 0;
                for(int j = start[fromWhere]; j < end[fromWhere]; j++) {
                    array[j] = sequence[contor];
                    contor++;
                }
                fromWhere++;  
            }
        } else if(rank == 2) {
            int fromWhere = nrWorkersA + nrWorkersB;
            for(int i = 0; i < nrWorkers; i++) {
                int sequenceLength = end[fromWhere] - start[fromWhere];
                int sequence[sequenceLength];

                MPI_Recv(&sequence, sequenceLength, MPI_INT, workersRanks[i] , 1, MPI_COMM_WORLD, NULL);
                int contor = 0;
                for(int j = start[fromWhere]; j < end[fromWhere]; j++) {
                    array[j] = sequence[contor];
                    contor++;
                }
                fromWhere++;
            }
        }


        if(rank == 0) {
            int arrayFrom1[arrayLen];
            int arrayFrom2[arrayLen];

            //primeste celelalte doua arrayuri de la procesele coordonatoare
            MPI_Recv(&arrayFrom1, arrayLen, MPI_INT, 1 , 1, MPI_COMM_WORLD, NULL);
            MPI_Recv(&arrayFrom2, arrayLen, MPI_INT, 2 , 1, MPI_COMM_WORLD, NULL);

            //le combin
            int start1 = start[nrWorkers];
            int end1 = end[nrWorkers + nrWorkersA - 1];

            int start2 = start[nrWorkers + nrWorkersA];
            int end2 = end[topologyNrWorkers - 1];

            for(int i = start1; i < end1; i++) {
                array[i] = arrayFrom1[i];
            }

            for(int i = start2; i < end2; i++) {
                array[i] = arrayFrom2[i];
            }

        } else if(rank == 1){
            //ii trimite taskului 0 vectorul lui modificat
            MPI_Send(&array, arrayLen, MPI_INT, 0, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 0);
        } else if(rank == 2) {
            //ii trimite taskului 0 vectorul lui modificat
            MPI_Send(&array, arrayLen, MPI_INT, 0, 1, MPI_COMM_WORLD);
            printf("M(%d,%d)\n", rank, 0);
        }

        //procesul 0 printeaza rezultatul final
        if(rank == 0) {
            printf("Rezultat: ");
            for(int i = 0; i < arrayLen; i++) {  
                if(i == arrayLen - 1) {
                    printf("%d\n", array[i]);
                } else {
                    printf("%d ", array[i]);
                }
            }
        }
       

    } else {
        //aflu threadul coordonator
        int threadCoordonator;
        MPI_Recv(&threadCoordonator, 1, MPI_INT, MPI_ANY_SOURCE , 1, MPI_COMM_WORLD, NULL);

        
        //aflu topologia
        int fullTopologyLength;
        MPI_Recv(&fullTopologyLength, 1, MPI_INT, threadCoordonator , 1, MPI_COMM_WORLD, NULL);
        char fullTopology[1000];
        MPI_Recv(&fullTopology, fullTopologyLength, MPI_CHAR, threadCoordonator , 1, MPI_COMM_WORLD, NULL);

        
        //afisez topologia
        printf("%d -> %s\n", rank, fullTopology);

        
        //primesc lungimea secventei din vector
        int sequenceLength;
        MPI_Recv(&sequenceLength, 1, MPI_INT, threadCoordonator , 1, MPI_COMM_WORLD, NULL);
            
        //primesc secventa
        int sequence[sequenceLength];
        MPI_Recv(&sequence, sequenceLength, MPI_INT, threadCoordonator , 1, MPI_COMM_WORLD, NULL);
        

        //incrementez toate elementele din secventa
        for(int i = 0; i < sequenceLength; i++) {
            sequence[i] *= 2;
        }

        MPI_Send(&sequence, sequenceLength, MPI_INT, threadCoordonator, 1, MPI_COMM_WORLD);
        printf("M(%d,%d)\n", rank, threadCoordonator);
        
        
    }
    MPI_Finalize();

}

