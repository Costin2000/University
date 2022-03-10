#include <stdio.h>
#include <stdlib.h>

// variabile globale
int n = 10;          // numar de noduri din graf
int n2 = 12;
int adjMat1[100][100];       // matricea de adiacenta
int adjMat2[100][100];       // matricea de adiacenta
int distance_bfs[100][100];  // vectorul de distante pentru BFS
int visit_bfs[100];          // vectorul de culori pentru BFS
int parents_bfs[100];        // vectorul de parinti pentru BFS
int visit_dfs[100];          // vectorul de culori pentru DFS
int d_dfs[100];              // vectorul care memoreaza timpul de inceput pentru DFS
int f_dfs[100];              // vectorul care memoreaza timpul de finalizare pentru DFS
int parents_dfs[100];        // vectorul de parinti pentru DFS
int time_dfs;                // timp pentru parcurgerea in adancime

// structura pentru coada
struct queue {
  int begin;
  int size;
  int elements[];
};

// functia care initializeaza o coada goala
struct queue *create_queue() {
  struct queue *q = (struct queue *)malloc(100 * sizeof(struct queue));
  q->size = 0;
  q->begin = 0;
  return q;
}

// functia care adauga un element in coada
struct queue *enqueue(struct queue *q, int elem) {
  q->elements[q->size] = elem;
  q->size = q->size + 1;
  return q;
}

// functia care returneaza primul element din coada
struct queue *top(struct queue *q, int *x) {
  *x = q->elements[q->begin];
  return q;
}

// functia care elimina un element din coada
struct queue *dequeue(struct queue *q) {
  q->begin = q->begin + 1;
  return q;
}

// functia care verifica daca o coada este goala
int is_empty(struct queue *q) {
  if (q->size == q->begin) {
    return 1;
  }
  return 0;
}

// functia care printeaza o coada (folosita pentru parcurgerea in latime)
void print_queue(struct queue *q) {
  // se printeaza informatii despre fiecare nod din coada astfel:
  // nodul curent
  // parintele nodului curent
  // distanta de la nodul radacina al subarborelui generat de algoritm la nodul
  // curent culoarea nodului curent
  printf("   \tQ = {");

  for (int i = q->begin; i < q->size; ++i) {

    if (i < q->size - 1) {

      printf("%c, ", (char)q->elements[i] + 65);
    } else {

      printf("%c", (char)q->elements[i] + 65);
    }
  }

  printf("}\n");

  for (int i = q->begin; i < q->size; ++i) {

    if (visit_bfs[q->elements[i]] == 1) {

      printf("   \t%c: p(%c)=%c, d(%c)=%d, c(%c)=%s\n", (char)q->elements[i] + 65,
           (char)q->elements[i] + 65, (char)parents_bfs[q->elements[i]] + 65,
           (char)q->elements[i] + 65, (*distance_bfs)[q->elements[i]], (char)q->elements[i] + 65, "gri");

    } else {
        printf("   \t%c: p(%c)=%c, d(%c)=%d, c(%c)=%s\n", (char)q->elements[i] + 65,
           (char)q->elements[i] + 65, (char)parents_bfs[q->elements[i]] + 65,
           (char)q->elements[i] + 65, (*distance_bfs)[q->elements[i]], (char)q->elements[i] + 65, "alb");
    }
  }
}


// parcurgerea in latime
void BFS(int n, int adjMat[100][100]) {
  int i; // iterator printre noduri
  int t; // variabila timp
  int prev_elem = -1;

  for (i = 0, t = 1; i < n; ++i) {
    if (visit_bfs[i] == 0) {          // daca nu am vizitat nodul curent

      struct queue *q = create_queue(); // creaza o coada goala
      q = enqueue(q, i);                // baga in coada elementul curent
      distance_bfs[i][i] = 0;    // actualizez distanta pentru primul element (0)
      visit_bfs[i] = 1; // il marchez ca vizitat

      printf("\nSC: %c\n", (char)i + 65);

      while (is_empty(q) == 0) { // cat timp coada nu este goala

        printf("Step %d: \n", t++);
        print_queue(q);     // printeaza coada la momentul curent

        if (prev_elem != -1) { // ultimul element scos din coada

          printf("  \tc(%c)=negru\n\n", (char)prev_elem + 65);
        } else {

          printf("\n");
        }

        int current_elem;          // declar elementul curent din coada
        q = top(q, &current_elem); // ii atribui valoarea din coada
        int j;                     // iterator printre noduri

        for (j = 0; j < n; ++j) {

          // daca exista muchie de la nodul din coada la cel curent in iterare
          // din graf si acesta nu a fost vizitat
          if ((adjMat[current_elem][j] == 1) && (visit_bfs[j] == 0)) {

            q = enqueue(q, j);                        // bag elementul in coada
            distance_bfs[i][j] = distance_bfs[i][current_elem] + 1; // actualizez distanta lui
            parents_bfs[j] = current_elem; // atribui parintele nodului curent
            visit_bfs[j] = 1;      // il marchez ca vizitat
          }
        }

        visit_bfs[current_elem] = 1; // marchez elementul curent ca vizitat
        q = dequeue(q);                // il scot din coada
        prev_elem = current_elem;      // ultimul element scos din coada
      }
    }
  }

  printf("Step %d:\n   \tQ = { }\n\tc(%c)=negru\n", t, (char)prev_elem + 65);
}

// exploreaza conform algoritmului DFS
void explore(int n, int u, int p, int adjMat[100][100]) {
  d_dfs[u] = ++time_dfs; // atribui timpul de inceput al nodului curent
  int j;                 // declar iteratorul
  visit_dfs[u] = 1;    // marchez nodul curent ca "gri"
  // afisez nodul curent inainte de apelul recursiv

  printf("\n%d. %c - c(%c)=gri d(%c)=%d p(%c)=%c", d_dfs[u], (char)u + 65, (char)u + 65,
         (char)u + 65, d_dfs[u], (char)u + 65, (char)p + 65);

  // parcurg toate nodurile
  for (j = 0; j < n; ++j) {
    // daca exista muchie de la nodul curent la acesta si cel din urma este inca
    // "alb"
    if (adjMat[u][j] == 1 && visit_dfs[j] == 0) {
      parents_dfs[j] = u; // ii marchez parintele
      // apelez functia de explorare pentru nodurile adiacente celui curent
      explore(n, j, u, adjMat);
    }
  }

  f_dfs[u] = ++time_dfs; // atribui timpul de finalizare al nodului curent
  printf("\n%d. %c - c(%c)=negru f(%c)=%d", f_dfs[u], (char)u + 65, (char)u + 65,
         (char)u + 65, f_dfs[u]);

  visit_dfs[u] = 2; // setez culoarea nodului curent ca "negru"
}

//  parcurgerea in adancime
void DFS(int n, int adjMat[100][100]) {
  int i; // iteratorul

    if (visit_dfs[0] == 0) { // daca nodul nu a mai fost vizitat
      printf("\n\t\t---\nNod start: %c", (char)0 + 65);
      explore(n, 0, -20, adjMat); // apelez functia de explorare pentru acesta

      // reinitializez vectorul de culori pentru urmatoarea iteratie
      int j;
      time_dfs = 0;
      for (j = 0; j < n; j++) {
        if (j != 0) {
          // resetez vectorii distantelor
          d_dfs[j] = 0;
          f_dfs[j] = 0;
          // resetez culoarea nodurilor
          visit_dfs[j] = 0;
        }
      }
    }

}

// functia main
int main() {
  // muchiile grafului
  adjMat1[0][1] = 1; // A-B
  adjMat1[0][2] = 1; // A-C
  adjMat1[0][7] = 1; // A-H
  adjMat1[1][3] = 1; // B-D
  adjMat1[1][4] = 1; // B-E
  adjMat1[1][7] = 1; // B-H
  adjMat1[1][8] = 1; // B-I
  adjMat1[2][3] = 1; // C-D
  adjMat1[3][4] = 1; // D-E
  adjMat1[3][9] = 1; // D-J
  adjMat1[4][5] = 1; // E-F
  adjMat1[4][6] = 1; // E-G
  adjMat1[5][6] = 1; // F-G
  adjMat1[7][8] = 1; // H-I
  adjMat1[8][0] = 1; // I-A

  adjMat2[0][1] = 1; // A-B
  adjMat2[0][6] = 1; // A-G
  adjMat2[1][2] = 1; // B-C
  adjMat2[1][6] = 1; // B-G
  adjMat2[2][3] = 1; // C-D
  adjMat2[2][4] = 1; // C-E
  adjMat2[4][5] = 1; // E-F
  adjMat2[6][7] = 1; //G-H
  adjMat2[7][0] = 1; // H-A
  adjMat2[8][9] = 1; // I-J
  adjMat2[8][10] = 1; //I-K
  adjMat2[9][10] = 1; //J-K
  adjMat2[10][11] = 1;//K-L


  printf("\n------------------------------\n");
  printf("\n--- Parcurgere pe latime --- \n");
  BFS(n, adjMat1); // parcurgerea in latime
  printf("\n------------------------------\n--- Parcurgere pe adancime ---\n");
  DFS(n, adjMat1); // parcurgerea in adancime


  for (int i = 0; i < 100; i++) {

    visit_bfs[i] = 0;
    parents_bfs[i] = 0;
    visit_dfs[i] = 0;
    d_dfs[i] = 0;
    f_dfs[i] = 0;
    parents_dfs[i] = 0;

  }
  time_dfs = 0;


  for (int i = 0; i < 100; i++) {

    for (int j = 0; j < 100; j++) {
      distance_bfs[i][j];
    }
  }

  printf("\n------------------------------\n");
  printf("\n--- Parcurgere pe latime --- \n");
  BFS(n2, adjMat2); // parcurgerea in latime
  printf("\n------------------------------\n--- Parcurgere pe adancime ---\n");
  DFS(n2, adjMat2); // parcurgerea in adancime


  printf("\n------------------------------\n");
  return 0;
}
