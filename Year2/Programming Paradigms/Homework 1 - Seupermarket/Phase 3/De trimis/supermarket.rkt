#lang racket
(require racket/match)
(require "queue.rkt")

(provide (all-defined-out))

(define ITEMS 5)

;; ATENȚIE: Pentru această etapă a temei este necesar să implementați
;;          întâi TDA-ul queue în fișierul queue.rkt.
;; Reveniți la sarcinile din acest fișier după ce ați implementat tipul 
;; queue și ați verificat implementarea folosind checker-ul.


; Structura counter nu se modifică.
; Ceea ce se modifică este implementarea câmpului queue:
; - în loc de listă, acesta va fi o coadă (o structură de tip queue)
; - acest lucru nu este vizibil în definiția structurii counter,
;   ci în implementarea operațiilor acestui tip de date (tipul counter)
(define-struct counter (index tt et queue) #:transparent)


; TODO
; Actualizați funcțiile de mai jos astfel încât ele să folosească
; o structură de tip queue pentru reprezentarea cozii de persoane.
; Elementele cozii continuă să fie perechi (nume . nr_produse).
; Este esențial să respectați "bariera de abstractizare", adică să
; operați cu coada doar folosind interfața acestui TDA:
; - empty-queue
; - queue-empty?
; - enqueue
; - dequeue
; - top
; Obs: Doar câteva funcții vor necesita actualizări.
(define (empty-counter index)           ; testată de checker
  (make-counter index 0 0 empty-queue))

(define (update f counters index)
  (foldl (λ (x aux)
           (if (equal? (counter-index x) index)
               (append aux (list (f x)))
               (append aux (list x))))
                  '()
                  counters))

(define (tt+ C minutes)
  (struct-copy counter C [tt (+ (counter-tt C) minutes)]))

(define (et+ C minutes)
  (struct-copy counter C [et (+ (counter-et C) minutes)]))

(define (add-to-counter name items)     ; testată de checker
  (λ (C)                                ; nu modificați felul în care funcția își primește argumentele
    (if (queue-empty? (counter-queue C))
        (struct-copy counter C
                     [tt (+ (counter-tt C) items)]
                     [et (+ (counter-et C) items)]
                     [queue (enqueue (cons name items) (counter-queue C))])
        (struct-copy counter C
                     [tt (+ (counter-tt C) items)]
                     [queue (enqueue (cons name items) (counter-queue C))]))))

(define (create-pereche c functie)
  (cons (counter-index c) (functie c)))

(define (findMin functie)
  (lambda (counters)
    (findMin-helper functie counters (create-pereche (car counters) functie))))

(define (findMin-helper functie counters pereche)
  (cond
    ((null? counters) pereche)
    ((< (functie (car counters)) (cdr pereche)) (findMin-helper functie (cdr counters) (create-pereche (car counters) functie)))
    ((and (= (functie (car counters)) (cdr pereche)) (< (counter-index (car counters)) (car pereche))) (findMin-helper functie (cdr counters) (create-pereche (car counters) functie)))
    (else (findMin-helper functie (cdr counters) pereche))))
        

(define min-tt (findMin counter-tt)) ; folosind funcția de mai sus
(define min-et (findMin counter-et)) ; folosind funcția de mai sus


; intoarce numarul de alimente al primului client din coada casei data ca parametru
(define (top-nrAlimente C)
  (cdr (top (counter-queue C))))

 
(define (remove-first-from-counter C)   ; testată de checker
  (if (queue-empty? (dequeue (counter-queue C)))
      (struct-copy counter C
                   [tt (- (counter-tt C) (counter-et C))]
                   [et 0]
                   [queue (dequeue (counter-queue C))])
      (struct-copy counter C
                   [tt (- (counter-tt C) (counter-et C))]
                   [et (cdr (top (dequeue (counter-queue C))))]
                   [queue (dequeue (counter-queue C))])))


; TODO
; Implementați o funcție care calculează starea unei case după un număr dat de minute.
; Funcția presupune, fără să verifice, că în acest timp nu a ieșit nimeni din coadă, 
; deci va avea efect doar asupra câmpurilor tt și et.
; (cu alte cuvinte, este responsabilitatea utilizatorului să nu apeleze această funcție
; cu minutes > timpul până la ieșirea primului client din coadă)
; Atenție: casele fără clienți nu trebuie să ajungă la timpi negativi!
(define (pass-time-through-counter minutes)
  (λ (C)
    (cond
      ((< (counter-tt C) minutes) (struct-copy counter C
                                               [tt 0]
                                               [et 0]))
      (else (struct-copy counter C
                         [tt (- (counter-tt C) minutes)]
                         [et (- (counter-et C) minutes)]))
      )))
  

; TODO
; Implementați funcția care simulează fluxul clienților pe la case.
; ATENȚIE: Față de etapa 2, apar modificări în:
; - formatul listei de cereri (parametrul requests)
; - formatul rezultatului funcției (explicat mai jos)
; requests conține 4 tipuri de cereri (3 moștenite din etapa 2 plus una nouă):
;   - (<name> <n-items>) - persoana <name> trebuie așezată la coadă la o casă            (ca înainte)
;   - (delay <index> <minutes>) - casa <index> este întârziată cu <minutes> minute       (ca înainte)
;   - (ensure <average>) - cât timp tt-ul mediu al tuturor caselor este mai mare decât
;                          <average>, se adaugă case fără restricții (case slow)         (ca înainte)
;   - <x> - trec <x> minute de la ultima cerere, iar starea caselor se actualizează
;           corespunzător (cu efect asupra câmpurilor tt, et, queue)                     (   NOU!   )
; Obs: Au dispărut cererile de tip remove-first, pentru a lăsa loc unui mecanism mai 
; sofisticat de a scoate clienții din coadă (pe măsură ce trece timpul).
; Sistemul trebuie să proceseze cele 4 tipuri de cereri în ordine, astfel:
; - persoanele vor fi distribuite la casele cu tt minim (dintre casele la care au voie)  (ca înainte)
; - când o casă suferă o întârziere, tt-ul și et-ul ei cresc (chiar dacă nu are clienți) (ca înainte)
; - tt-ul mediu (ttmed) se calculează pentru toate casele (și cele fast, și cele slow), 
;   iar la nevoie veți adăuga case slow una câte una, până când ttmed <= <average>       (ca înainte)
; - când timpul prin sistem avansează cu <x> minute, tt-ul, et-ul și queue-ul tuturor 
;   caselor se actualizează pentru a reflecta trecerea timpului; dacă unul sau mai mulți 
;   clienți termină de stat la coadă, ieșirile lor sunt contorizate în ordine cronologică.
; Rezultatul funcției serve va fi o pereche cu punct între:
; - lista sortată cronologic a clienților care au părăsit supermarketul
;   - fiecare element din listă va avea forma (index_casă . nume)
;   - dacă mai mulți clienți ies simultan, sortați-i crescător după indexul casei
; - lista caselor în starea finală (ca rezultatul din etapele 1 și 2)
; Obs: Pentru a contoriza ieșirile din cozi, puteți să lucrați într-o funcție ajutătoare
; (cu un parametru în plus față de funcția serve), pe care serve doar o apelează.
(define (serve requests fast-counters slow-counters)
  (serve-aux requests fast-counters slow-counters '()))

(define (serve-aux requests fast-counters slow-counters clienti-iesiti)
  (if (null? requests)
      (cons clienti-iesiti (append fast-counters slow-counters))
      (match (car requests)
        [(list 'ensure <average>) (serve-aux (cdr requests) fast-counters (deschid-case (car requests) fast-counters slow-counters) clienti-iesiti)]
        [(list name n-items) (serve-aux (cdr requests) (car (addToCounter (car requests) fast-counters slow-counters)) (car (cdr (addToCounter (car requests) fast-counters slow-counters))) clienti-iesiti)]
        [(list 'delay <index> <minutes>) (serve-aux (cdr requests) (delay (car requests) fast-counters) (delay (car requests) slow-counters) clienti-iesiti)]
        [<x> (serve-aux (cdr requests)
                        (car (case<x> fast-counters slow-counters (car requests) clienti-iesiti))
                        (car (cdr (case<x> fast-counters slow-counters (car requests) clienti-iesiti)))
                        (car (cdr (cdr (case<x> fast-counters slow-counters (car requests) clienti-iesiti)))))]
        )))


;<x>
;----------------------------------------------------------------------
;scoate toate casele care nu au clienti
(define (case-nenule counters)
  (filter (λ (x)
            (not (queue-empty? (counter-queue x)))) counters))

;daca o sa plece unul din clienti
(define (pleaca-client? counters minutes)
  (cond
    ((null? (case-nenule counters)) minutes)
    ((< (cdr (min-et (case-nenule counters))) minutes)  (cdr (min-et (case-nenule counters))))
    (else minutes)))

;intoarce un client daca urmeaza sa iasa 
(define (client-care-iese counter minutes)
  (if (and (<= (counter-et counter) minutes) (not (queue-empty? (counter-queue counter))))
      (list (cons (counter-index counter) (car (top (counter-queue counter)))))
      '()
      ))


;situatia in care casa nu are clienti dar are tt
(define (need-to-leave counter minutes)
  (if (and (<= (counter-et counter) minutes) (not (queue-empty? (counter-queue counter))))
      (remove-first-from-counter counter)
      ((pass-time-through-counter minutes) counter)))
      
;actualizeaza toate casele dint-o lista de case
(define (actualizare-case counters minutes actualizate clienti-plecati)
  (if (null? counters)
      (cons actualizate clienti-plecati)
      (actualizare-case (cdr counters) minutes (append actualizate (list (need-to-leave (car counters) minutes))) (append clienti-plecati  (client-care-iese (car counters) minutes))))) 

(define (case<x> fast-counters slow-counters minute clienti-plecati)
  (if (zero? minute)
      (list fast-counters slow-counters clienti-plecati)
      (case<x> (car (actualizare-case fast-counters (pleaca-client? (append fast-counters slow-counters) minute) '() '())) ;fast-counters
               (car (actualizare-case slow-counters (pleaca-client? (append fast-counters slow-counters) minute) '() '())) ;slow-counters
               (- minute (pleaca-client? (append fast-counters slow-counters) minute))
               (append clienti-plecati (cdr (actualizare-case fast-counters (pleaca-client? (append fast-counters slow-counters) minute) '() '()))
                       (cdr (actualizare-case slow-counters (pleaca-client? (append fast-counters slow-counters) minute) '() '()))))))
  
;----------------------------------------------------------------------

;Pt Adaugarea unui client (<name> <n-items>)
;-----------------------------------------------------------------------------------------------
(define (addToCounter cerere fast-counters slow-counters)
  (if (and (<= (car (cdr cerere)) ITEMS) (<= (cdr (min-tt fast-counters)) (cdr (min-tt slow-counters))))
      (list (actualizare-add (min-tt fast-counters) cerere fast-counters ) slow-counters)
      (list fast-counters (actualizare-add (min-tt slow-counters) cerere slow-counters ))))


(define (actualizare-add pereche cerere lista-case)
  (foldl (λ (x aux)
           (if (= (match x [(counter index tt et queue) index]) (car pereche))
               (append aux (list ((add-to-counter (car cerere) (car (cdr cerere))) x)))
               (append aux (list x))))
                  '()
                 lista-case))
;------------------------------------------------------------------------------------------------

;Pt (ensure <average>)
;------------------------------------------------------------------------------------------------
(define (deschid-case cerere fast-counters slow-counters)
  (if (<= (calcul-medie (append fast-counters slow-counters) 0 (length (append fast-counters slow-counters))) (car (cdr cerere)))
      slow-counters
      (deschid-case cerere fast-counters (append slow-counters (list (empty-counter (+ 1 (length (append fast-counters slow-counters)))))))))

(define (calcul-medie lista tt-total sizeInit)
  (if (null? lista)
      (/ tt-total sizeInit)
      (calcul-medie (cdr lista) (+ tt-total (match (car lista) [(counter index tt et queue) tt])) sizeInit)))
;------------------------------------------------------------------------------------------------

;Pt Intarzierea unei case (delay <index> <minutes>)
;------------------------------------------------------------------------------------------------
(define (delay cerere lista-case)
  (foldl (λ (x aux)
           (if (= (match x [(counter index tt et queue) index]) (car (cdr cerere)))
               (append aux (list (intarziere x (car (cdr (cdr cerere))))))
               (append aux (list x))))
                  '()
                  lista-case))

(define (intarziere casa minute)
   (tt+ (et+ casa minute) minute))
;-----------------------------------------------------------------------------------------------

