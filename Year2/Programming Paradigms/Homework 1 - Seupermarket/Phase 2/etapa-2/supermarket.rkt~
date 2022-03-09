#lang racket
(require racket/match)

(provide (all-defined-out))

(define ITEMS 5)

;; Actualizăm structura counter cu informația et:
;; Exit time (et) al unei case reprezintă timpul până la ieșirea primului client de la casa respectivă,
;; adică numărul de produse de procesat pentru acest client + întârzierile suferite de casă (dacă există).
;; Ex:
;; la C3 s-au așezat întâi Ana cu 3 produse și apoi Geo cu 7 produse,
;; și C3 a fost întârziată cu 5 minute => et pentru C3 este 3 + 5 = 8 (timpul până când va ieși Ana).


; Redefinim structura counter.
(define-struct counter (index tt et queue) #:transparent)


; TODO
; Actualizați implementarea empty-counter astfel încât să conțină și câmpul et.
(define (empty-counter index)
  (make-counter index 0 0 '()))

; TODO
; Implementați o funcție care aplică o transformare casei cu un anumit index.
; f = funcție unară care se aplică pe un argument de tip casă, counters = listă de case,
; index = indexul casei din counters căreia îi veți aplica transformarea f
; Veți întoarce lista actualizată de case.
; Dacă nu există în counters o casă cu acest index, veți întoarce lista nemodificată.

(define (check-counter x acc index f)
  (cond
    ((equal? (counter-index x) index) (append acc (list (f x))))
    (else (append acc (list x)))))

(define (update f counters index)
  (foldl (lambda (x acc) (check-counter x acc index f)) '() counters))

; TODO
; Memento: tt+ crește tt-ul unei case cu un număr dat de minute.
; Actualizați implementarea tt+ pentru:
; - a ține cont de noua reprezentare a unei case
; - a permite ca operații de tip tt+ să fie pasate ca argument funcției update în cel mai facil mod
; Obs: Pentru compatibilitatea cu primul argument al lui update, trebuie să obținem ușor din tt+ 
; o funcție unară care se aplică pe un argument de tip casă (v. funcții curry).
; Am eliminat parametrii lui tt+ din define-ul de mai jos astfel încât voi să determinați
; cum este cel mai bine ca tt+ să își primească parametrii.
; Din acest motiv checker-ul nu testează separat această funcție, dar asistentul va verifica
; faptul că ați implementat-o conform cerințelor.
(define (tt+ minutes)
  (lambda (x)
      (make-counter (counter-index x) (+ minutes (counter-tt x)) (counter-et x) (counter-queue x))))

; TODO
; Implementați o funcție care crește et-ul unei case cu un număr dat de minute.
; Păstrați formatul folosit pentru tt+.
; Checker-ul nu testează separat această funcție.
(define (et+ minutes)
    (lambda (x)
      (make-counter (counter-index x) (counter-tt x) (+ minutes (counter-et x)) (counter-queue x))))

; TODO
; Memento: add-to-counter adaugă o persoană (reprezentată prin nume și număr de produse) la o casă. 
; Actualizați implementarea add-to-counter pentru aceleași rațiuni pentru care am modificat tt+.
; Atenție la cum se modifică tt și et!
; Checker-ul nu testează separat această funcție.

(define (verify-et counter queue pair)
  (cond
    ((null? queue) (+ (cdr pair) (counter-et counter)))
    (else (counter-et counter))
    ))

(define (add-to-counter pair)
  (lambda (x)
        (make-counter (counter-index x) (+ (counter-tt x) (cdr pair))
                      (verify-et x (counter-queue x) pair) (append (counter-queue x) (list pair)))))

; TODO
; Întrucât vom folosi atât min-tt (implementat în etapa 1) cât și min-et (funcție nouă),
; definiți-vă o funcție mai abstractă din care să derive ușor atât min-tt cât și min-et.
; Prin analogie cu min-tt, definim min-et astfel:
; min-et = funcție care primește o listă de case și intoarce o pereche dintre:
; - indexul casei (din listă) care are cel mai mic et
; - et-ul acesteia
; (când mai multe case au același et, este preferată casa cu indexul cel mai mic)

(define (time-helper counters f-index f-time x y)
 (cond
    ((null? counters) (cons x y))
    
    ((< (f-time (car counters)) y)
     (time-helper (cdr counters) f-index f-time (f-index (car counters)) (f-time (car counters))))
    
    ((and (equal? (f-time (car counters)) y) (< (f-index (car counters)) x))
     (time-helper (cdr counters) f-index f-time (f-index (car counters)) (f-time (car counters))))
    
    (else (time-helper (cdr counters) f-index f-time x y))))

(define min-tt
  (lambda (counters)
    (time-helper counters counter-index counter-tt (counter-index (car counters)) (counter-tt (car counters)))))

(define (min-et counters)
  (time-helper counters counter-index counter-et (counter-index (car counters)) (counter-et (car counters))))

; TODO
; Implementați o funcție care scoate prima persoană din coada unei case.
; Funcția presupune, fără să verifice, că există minim o persoană la coada casei C.
; Veți întoarce o nouă structură obținută prin modificarea cozii de așteptare.
; Atenție la cum se modifică tt și et!
; Dacă o casă tocmai a fost părăsită de cineva, înseamnă că ea nu mai are întârzieri.

(define (update-tt old-tt et products)
  (cond
    ((> et products) (- old-tt et))
    (else (- old-tt products))))

(define (remove-first-from-counter C)
  (cond
  ((null? (counter-queue C)) C)
  ((equal? 1 (length (counter-queue C)))
   (make-counter (counter-index C) (update-tt (counter-tt C) (counter-et C) (cdr (car (counter-queue C))))
                0 (cdr (counter-queue C))))
  (else (make-counter (counter-index C) (update-tt (counter-tt C) (counter-et C) (cdr (car (counter-queue C))))
                (cdr (car (cdr (counter-queue C)))) (cdr (counter-queue C))))))

; TODO
; Implementați funcția care simulează fluxul clienților pe la case.
; ATENȚIE: Față de etapa 1, funcția serve operează cu următoarele modificări:
; - nu mai avem doar 4 case, ci:
;   - fast-counters (o listă de case pentru maxim ITEMS produse)
;   - slow-counters (o listă de case fără restricții)
;   (Sugestie: folosiți funcția update pentru a obține comportamentul pe liste de case)
; - requests conține 4 tipuri de cereri (cele 2 din etapa anterioară plus 2 noi):
;   - (<name> <n-items>) - persoana <name> trebuie așezată la coadă la o casă
;   - (delay <index> <minutes>) - casa <index> este întârziată cu <minutes> minute
;   - (remove-first) - cea mai avansată persoană părăsește casa la care se află
;   - (ensure <average>) - cât timp tt-ul mediu al tuturor caselor este mai mare decât
;                          <average>, se adaugă case fără restricții (case slow)
; Sistemul trebuie să proceseze cele 4 tipuri de cereri în ordine, astfel:
; - persoanele vor fi distribuite la casele cu tt minim (dintre casele la care au voie)
;   (ca înainte, dar acum folosiți fast-counters și slow-counters)
; - când o casă suferă o întârziere, tt-ul și et-ul ei cresc (chiar dacă nu are clienți)
;   (puțin diferit față de etapa 1, și acum folosiți fast-counters și slow-counters)
; - persoana care părăsește supermarketul este persoana fruntașă la casa cu et-ul minim
;   (dintre casele care au clienți); dacă nicio casă nu are clienți, cererea e ignorată
; - tt-ul mediu (ttmed) se calculează pentru toate casele (și cele fast, și cele slow), 
;   iar la nevoie veți adăuga case slow una câte una, până când ttmed <= <average>
; Considerați că indecșii caselor încep de la 1 și sunt mereu în ordine.
; Ex:
; fast-counters conține casele 1-2, slow-counters conține casele 3-15
; => la nevoie veți adăuga întâi casa 16, apoi casa 17, etc.
; (puteți determina matematic de câte case noi este nevoie sau
;  puteți adăuga recursiv una câte una până când condiția este îndeplinită)
(define (serve requests fast-counters slow-counters)

  (define (update-time index minutes counters)
    (update (et+ minutes) (update (tt+ minutes) counters index) index))
  
  (define (add-delay index minutes)
    (cond
      ((<= index (counter-index (last fast-counters)))
       (serve (cdr requests) (update-time index minutes fast-counters) slow-counters))
      (else (serve (cdr requests) fast-counters (update-time index minutes slow-counters)))))


  (define (verify-min-tt req name n-items fast slow)
    (cond
      ((<= (car (min-tt (append fast slow))) (counter-index (last fast)))
       (serve (cdr req) (update (add-to-counter (cons name n-items)) fast (car (min-tt (append fast slow)))) slow))
      (else
       (serve (cdr req) fast (update (add-to-counter (cons name n-items)) slow (car (min-tt (append fast slow))))))))

  (define (distribute name n-items)
    (cond
      ((<= n-items ITEMS)
       (verify-min-tt requests name n-items fast-counters slow-counters))
      (else
       (serve (cdr requests) fast-counters (update (add-to-counter (cons name n-items)) slow-counters (car (min-tt slow-counters)))))))
  
  (if (null? requests)
      (append fast-counters slow-counters)
      (match (car requests)
        [(list 'delay index minutes) (add-delay index minutes)]
        [(list 'ensure average) (ensure-necessity average requests fast-counters slow-counters)]
        [(list name n-items) (distribute name n-items)]
        [(list 'remove-first) (remove-first requests fast-counters slow-counters)])))

(define (update-fast f fast-counters slow-counters)
  (update remove-first-from-counter fast-counters
                      (car (min-et (filter (lambda (x) (not (null? (counter-queue x)))) (append fast-counters slow-counters))))))


(define (update-slow f fast-counters slow-counters)
  (update remove-first-from-counter slow-counters
                      (car (min-et (filter (lambda (x) (not (null? (counter-queue x)))) (append fast-counters slow-counters))))))

(define (available-counters fast-counters slow-counters)
  (filter (lambda (x) (not (null? (counter-queue x)))) (append fast-counters slow-counters)))

(define (remove-first requests fast-counters slow-counters)
    (cond
      ((and (null? fast-counters) (null? slow-counters)) (serve (cdr requests) fast-counters slow-counters))
      
      ((equal? #t (null? (available-counters fast-counters slow-counters)))
       (serve (cdr requests) fast-counters slow-counters))
      
      ((<= (car (min-et (available-counters fast-counters slow-counters))) (counter-index (last fast-counters)))
            (serve (cdr requests) (update-fast remove-first-from-counter fast-counters slow-counters) slow-counters))
      
      (else (serve (cdr requests) fast-counters (update-slow remove-first-from-counter fast-counters slow-counters)))))

(define (ttmed counters)
    (/ (foldl (lambda (x acc) (+ acc (counter-tt x))) 0 counters) (length counters)))

  (define (ensure-necessity average requests fast slow)
    (cond
      ((<= (ttmed (append fast slow)) average)
       (serve (cdr requests) fast slow))
      (else (ensure-necessity average requests fast (append slow (list (empty-counter (+ 1 (counter-index (last slow))))))))))


