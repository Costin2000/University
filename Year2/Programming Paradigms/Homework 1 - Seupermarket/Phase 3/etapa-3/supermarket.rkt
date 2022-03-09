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

(define (check-counter x acc index f)
  (cond
    ((equal? (counter-index x) index) (append acc (list (f x))))
    (else (append acc (list x)))))

(define (update f counters index)
  (foldl (lambda (x acc) (check-counter x acc index f)) '() counters))

(define (tt+ minutes)
  (lambda (x)
      (make-counter (counter-index x) (+ minutes (counter-tt x)) (counter-et x) (counter-queue x))))

(define (et+ minutes)
    (lambda (x)
      (make-counter (counter-index x) (counter-tt x) (+ minutes (counter-et x)) (counter-queue x))))

(define (verify-et counter queue name n-items)
  (cond
    ((equal? #t (queue-empty? queue)) (+ n-items (counter-et counter)))
    (else (counter-et counter))
    ))

(define (add-to-counter name items)     ; testată de checker
  (λ (C)                                ; nu modificați felul în care funcția își primește argumentele
    (make-counter (counter-index C) (+ (counter-tt C) items)
                  (verify-et C (counter-queue C) name items) (enqueue (cons name items) (counter-queue C)))))

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

(define (update-tt old-tt et products)
  (cond
    ((> et products) (- old-tt et))
    (else (- old-tt products))))

(define (one-element-in-queue? C)
  (cond
    ((or (and (equal? 1 (length (queue-left (counter-queue C))))
              (equal? 0 (length (queue-right (counter-queue C)))))
         (and (equal? 0 (length (queue-left (counter-queue C))))
              (equal? 1 (length (queue-right (counter-queue C)))))) #t)
    (else #f)))

(define (remove-first-from-counter C)   ; testată de checker
  (cond
    ((equal? #t (queue-empty? (counter-queue C))) C)
    
    ((equal? #t (one-element-in-queue? C))
     (make-counter (counter-index C) (update-tt (counter-tt C) (counter-et C) (cdr (top (counter-queue C))))
      0 (dequeue (counter-queue C))))
    
    (else (make-counter (counter-index C) (update-tt (counter-tt C) (counter-et C) (cdr (top (counter-queue C))))
                        (cdr (top (dequeue (counter-queue C)))) (dequeue (counter-queue C))))))

; TODO
; Implementați o funcție care calculează starea unei case după un număr dat de minute.
; Funcția presupune, fără să verifice, că în acest timp nu a ieșit nimeni din coadă, 
; deci va avea efect doar asupra câmpurilor tt și et.
; (cu alte cuvinte, este responsabilitatea utilizatorului să nu apeleze această funcție
; cu minutes > timpul până la ieșirea primului client din coadă)
; Atenție: casele fără clienți nu trebuie să ajungă la timpi negativi!

(define (verify-times C minutes)
  (cond
    ((< minutes (counter-et C))
     (make-counter (counter-index C) (- (counter-tt C) minutes) (- (counter-et C) minutes) (counter-queue C)))
    (else (make-counter (counter-index C) 0 0 (counter-queue C)))
    ))

(define (pass-time-through-counter minutes)
  (λ (C)
    (cond
      ((equal? #t (queue-empty? (counter-queue C))) (verify-times C minutes))
      ((and (> minutes (counter-et C)) (> minutes (counter-tt C))) (make-counter (counter-index C) 0 0 (counter-queue C)))
      ((and (<= minutes (counter-tt C)) (> minutes (counter-et C)))
       (make-counter (counter-index C) (- (counter-tt C) minutes) 0 (counter-queue C)))
      (else (make-counter (counter-index C) (- (counter-tt C) minutes) (- (counter-et C) minutes) (counter-queue C))))))

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

(define (sort-by-index x y)
  (cond
    ((equal? (counter-et x) (counter-et y)) (< (counter-index x) (counter-index y)))
    (else (< (counter-et x) (counter-et y)))
    ))

(define (sort-list counters)
  (sort counters (lambda (x y) (sort-by-index x y))))

(define (always-zero x)
  (cond
    ((not (equal? x 0)) 0)
    (else 0)))

(define (modify-elem og-list index value)
  (append (take og-list (- index 1))
        (list value)
        (drop og-list (+ (- index 1) 1))))

(define (remove-elem og-list index)
  (append (take og-list (- index 1))
        (drop og-list (+ (- index 1) 1))))

(define (available-counters fast-counters slow-counters)
  (filter (lambda (x) (not (null? (counter-queue x)))) (append fast-counters slow-counters)))

(define (serve-helper finished requests fast-counters slow-counters)

  (define (update-time index minutes counters)
    (update (et+ minutes) (update (tt+ minutes) counters index) index))
  
  (define (add-delay index minutes)
    (cond
      ((<= index (counter-index (last fast-counters)))
       (serve-helper finished (cdr requests) (update-time index minutes fast-counters) slow-counters))
      (else (serve-helper finished (cdr requests) fast-counters (update-time index minutes slow-counters)))))


  (define (verify-min-tt req name n-items fast slow)
    (cond
      ((<= (car (min-tt (append fast slow))) (counter-index (last fast)))
       (serve-helper finished (cdr req) (update (add-to-counter name n-items) fast (car (min-tt (append fast slow)))) slow))
      (else
       (serve-helper finished (cdr req) fast (update (add-to-counter name n-items) slow (car (min-tt (append fast slow))))))))

  (define (distribute name n-items)
    (cond
      ((<= n-items ITEMS)
       (verify-min-tt requests name n-items fast-counters slow-counters))
      (else
       (serve-helper finished (cdr requests) fast-counters
                     (update (add-to-counter name n-items) slow-counters (car (min-tt slow-counters)))))))


  (if (null? requests)
      (cons finished (append fast-counters slow-counters))
      (match (car requests)
        [(list 'delay index minutes) (add-delay index minutes)]
        [(list 'ensure average) (ensure-necessity average finished requests fast-counters slow-counters)]
        [(list name n-items) (distribute name n-items)]
        [number (wait number finished requests fast-counters slow-counters
                      (sort-list (append fast-counters slow-counters))
                      (build-list (length (append fast-counters slow-counters)) (lambda (x) (always-zero x))) 0
                      (length (append fast-counters slow-counters)))]
        )))

(define (serve requests fast-counters slow-counters)
  (serve-helper '() requests fast-counters slow-counters))

(define (ttmed counters)
    (/ (foldl (lambda (x acc) (+ acc (counter-tt x))) 0 counters) (length counters)))

  (define (ensure-necessity average finished requests fast slow)
    (cond
      ((<= (ttmed (append fast slow)) average)
       (serve-helper finished (cdr requests) fast slow))
      (else (ensure-necessity average finished requests fast (append slow (list (empty-counter (+ 1 (counter-index (last slow))))))))))

(define (verify-index minutes finished requests fast slow sorted check-list stop max-size)
  (cond
    ((<= (counter-index (car sorted)) (counter-index (last fast)))
     (wait minutes (append finished (list (cons (counter-index (car sorted)) (car (top (counter-queue (car sorted)))))))
           requests (update remove-first-from-counter fast (counter-index (car sorted))) slow
           (sort-list (update remove-first-from-counter sorted (counter-index (car sorted))))
           (modify-elem check-list (counter-index (car sorted)) (counter-et (car sorted))) stop max-size))
    
    (else (wait minutes (append finished (list (cons (counter-index (car sorted)) (car (top (counter-queue (car sorted)))))))
           requests fast (update remove-first-from-counter slow (counter-index (car sorted)))
           (sort-list (update remove-first-from-counter sorted (counter-index (car sorted))))
           (modify-elem check-list (counter-index (car sorted)) (counter-et (car sorted))) stop max-size))
    ))

(define (verify-index2 minutes finished requests fast slow sorted check-list stop max-size)
  (cond
    ((<= (counter-index (car sorted)) (counter-index (last fast)))
     (wait minutes finished requests (update (pass-time-through-counter
                                              (- minutes (list-ref check-list (- (counter-index (car sorted)) 1))))
                                              fast (counter-index (car sorted))) slow
           (sort-list (cdr sorted)) check-list (+ stop 1) max-size))
    (else (wait minutes finished requests fast (update (pass-time-through-counter
                                                        (- minutes (list-ref check-list (- (counter-index (car sorted)) 1))))
                                                        slow (counter-index (car sorted)))
           (sort-list (cdr sorted)) check-list (+ stop 1) max-size))
    ))

(define (check-integrity minutes finished requests fast slow sorted check-list stop max-size)
  (cond
    ((equal? #t (queue-empty? (counter-queue (car sorted))))
     (verify-index2 minutes finished requests fast slow sorted check-list stop max-size))
    (else (verify-index minutes finished requests fast slow sorted check-list stop max-size))))

(define (wait minutes finished requests fast slow sorted check-list stop max-size)

  (cond
    ((equal? stop max-size) (serve-helper finished (cdr requests) fast slow))
    ((>= (- minutes (list-ref check-list (- (counter-index (car sorted)) 1))) (counter-et (car sorted)))
     (check-integrity minutes finished requests fast slow sorted check-list stop max-size))
    (else (verify-index2 minutes finished requests fast slow sorted check-list stop max-size))))
      
