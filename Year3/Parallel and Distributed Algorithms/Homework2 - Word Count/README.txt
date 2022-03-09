Brebu Costin-Bogdan 336CB

La acesta tema nu am utilizat executor service si am implementat logica de map & reduce utilizand aceleasi lucruri
ca si la prima tema.
Am considerat threadul coordonator ca fiind threadul cu id 0, iar in main (Tema2.java) am creeat doar threadurile
necesare.

beforeMap
-----------------------------------------------
Taskurile care trebuie procesate de threaduri in etapa de mapping sunt de acest tip.
-----------------------------------------------

afterMap
-----------------------------------------------
Taskurile procesate in etapa de mapp vor avea aceasta forma
-----------------------------------------------

mapProcess
-----------------------------------------------
Threadul coordonator:
    - Citeste din fisierul de input pathurile fisierelor, numarul de threaduri si size-ul fragmentelor
    - Creeaza taskurile initiale pe care le salveaza intr-un array de tipul 'beforeMap' respectand reguliele mentionate
    in cerinta. Se imparte textul in fragmente de lungimea citita anterior. In cazul in care un cuvant este taiat in
    acest proces, taskul care il preia este cel care contine partea din stanga a cuvantului.


Toate threadurile asteapta ca threadul coordonator sa creeze taskurile datorita unei bariere.
Cand acesta a terminat, threadurile incep procesarea lor.
Threadurile isi scot secventele de text care trebuie procesate si le salveaza intr-un string. Utilizand stringTokenizer
se determina cuvintele si avandu-le determinam cuvantul de lungime maxima, lungimile celorlalte cuvinte si frecventa
lor. Toate rezultatele obtinute se salveaza intr-un vector in interiorul unui mutex.
-----------------------------------------------

beforeReduce
-----------------------------------------------
Taskurile care se proceseaza in etapa de reduce sunt de acest tip
--------------------------------------------

afterReduce
-----------------------------------------------
Rezultatele etipei de reduce au aceasta forma
-----------------------------------------------

reduceProcess
-----------------------------------------------
Theadul coordonator ordoneaza rezultatele obtinute in functie de fisierul din care provin.
Se asteapta ca acesta sa termine si dupa se incepe procesarea(cu o bariera).

Threadurile incep etapa de reduce. Fiecare  thread se ocupa de fisierele asignate.
Pentru fiecare fisier, se determina rangul, lungimea maxima a unui cuvant si cate cuvinte exista cu aceasta lungime.
Aceste rezultate sunt salvate int-un array cu ajutorul unui mutex.

Intr-o alta bariera se asteapta terminarea etapei de reduce pentru ca threadul coordonator sa poata afisa rezultatul
final in fisierul de output.
-----------------------------------------------

Tema2
-----------------------------------------------
Se extrage din args numarul de threaduri, fisierul de input si cel de output.
Se creeaza threadurile care executa functia de run din 'mapProcess' si ulterior cele care executa functia run din
'reduceProcess'.
-----------------------------------------------