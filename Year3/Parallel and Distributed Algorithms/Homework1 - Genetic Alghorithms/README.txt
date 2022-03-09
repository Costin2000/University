Brebu Costin-Bogdan 336CB
---------------------------------------------------------------------------------------------------


--------------------
genetic_algorithm.h
--------------------
    Mi-am facut o structura (individualsAttributes) pe care o pasez ca argument in functia void pe 
care o apelez la creearea threadurilor.
    Mi-am trecut si antetele functiilor noi creeate.
    
    Functiile, merge si merge_sort, pe care le-am folosit pentru implementarea algoritmului de
merge sort au fost preluate de pe Geekss for Geeks si adaptate pentru problema noastra.
    Linkul:   
    "https://www.geeksforgeeks.org/merge-sort-using-multi-threading/"


--------------------
genetic_algorithm.c
--------------------
    Am adaugat functiile mentionate anterior la care am modificat conditia de sortare utilizand
"cmpfunc" deja implementat.
    O alta functie noua este "verifyBarrier" care verifica daca o bariera a asteptat cu
succes toate threadurile

Functii modificate:

    - compute_fitness_function:
        - careia i-am adaugat doi parametrii 'int start' si 'int end' pentru a puteaa paraleliza
        for-ul. Fiecare thread actioneaza doar asupra unei parti din vector
    
    - run_genetic_algorithm
        - am facut-o void* pentru a o putea da ca paramentru la creearea threadurilor in main
        - primeste ca parametru un element de tipul 'individualsAttributes' careia ii extrag
        membrii in afara de vectori.
        - fiecare for din functie a fost paralelizat ca la laborator
        - dupa fiecare paralelizare am folosit o bariera pentru a fi sigur ca rezultatul final 
        nu este alterat
        - in locul quicksort-ului am utilizat merge sort-ul multi-threaded pentru o scalabilitate
        mai buna. Dupa ce se exuta sortarile pe bucatele, execut cate merge-uri sunt necesare
        pentru ca vectorul sa devina sortat in intregime.
        - printarile le-am pus intr-un if pentru a fi executate doar de threadul 0


-----------
tema1_par.c
-----------
    -am creeat un array de tipul 'individualsAttributes' de dimensiune nrThreads
    -am initializat o bariera
    -in interiorul unui for de la 0 la nrThreads
        - mi-am initializat fiecare element din vector
        - am facut threadurile pe care le-am apelat cu functia run_genetic_algorithm
    -le-am dat join threadurilor
    -am distrus bariera