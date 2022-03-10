#lang racket
(require racket/match)

(provide (all-defined-out))

(define ITEMS 5)

;; C1, C2, C3, C4 sunt case într-un supermarket.
;; C1 acceptă doar clienți care au cumparat maxim ITEMS produse (ITEMS este definit mai sus).
;; C2 - C4 nu au restricții.
;; Considerăm că procesarea fiecărui produs la casă durează un minut.
;; Casele pot suferi întarzieri (delay).
;; La un moment dat, la fiecare casă există 0 sau mai mulți clienți care stau la coadă.
;; Timpul total (tt) al unei case reprezintă timpul de procesare al celor aflați la coadă,
;; adică numărul de produse cumpărate de ei + întârzierile suferite de casa respectivă (dacă există).
;; Ex:
;; la C3 sunt Ana cu 3 produse și Geo cu 7 produse,
;; și C3 nu are întârzieri => tt pentru C3 este 10.


; Definim o structură care descrie o casă prin:
; - index (de la 1 la 4)
; - tt (timpul total descris mai sus)
; - queue (coada cu persoanele care așteaptă)
(define-struct counter (index tt queue) #:transparent)


; TODO
; Implementați o functie care intoarce o structură counter goală.
; tt este 0 si coada este vidă.
; Obs: la definirea structurii counter se creează automat o funcție make-counter pentru a construi date de acest tip
(define (empty-counter index)
  (make-counter index 0 '()))


; TODO
; Implementați o funcție care crește tt-ul unei case cu un număr dat de minute.
(define (tt+ C minutes)
  (match C
    [(counter index tt queue)
     (struct-copy counter C [tt (+ (match C [(counter index tt queue) tt]) minutes)])]))
;(define (tt+ C minutes)
  ;(struct-copy counter C [tt (+ (match C [(counter index tt queue) tt]) minutes)]))



; TODO
; Implementați o funcție care primește o listă de case și intoarce o pereche dintre:
; - indexul casei (din listă) care are cel mai mic tt
; - tt-ul acesteia
; Obs: când mai multe case au același tt, este preferată casa cu indexul cel mai mic
(define (min-tt counters)
  (min-tt-helper counters (create-pereche-index-tt (car counters))))

;functie care compara indexul si tt unei case cu cele din pereche
;daca acea casa are tt-ul mai mic sau are tt-ul egal dar indexul mai mic, atunci intoarce true
(define (compare-min-tt c pereche)
  (cond
    ((< (match c [(counter index tt queue) tt]) (cdr pereche)) #t)
    ((and (= (match c [(counter index tt queue) tt]) (cdr pereche))
          (< (match c [(counter index tt queue) index]) (car pereche))) #t)
    (else #f)
    ))

; creaza o pereche in forma ceruta in enuntul pentru min-tt
(define (create-pereche-index-tt c)
  (cons (match c [(counter index tt queue) index]) (match c [(counter index tt queue) tt])))

;helper pentru min-tt
(define (min-tt-helper counters pereche)
  (cond
    ((null? counters) pereche)
    ((compare-min-tt (car counters) pereche)
     (min-tt-helper (cdr counters) (create-pereche-index-tt (car counters))))
    (else (min-tt-helper (cdr counters) pereche))))



; TODO
; Implementați o funcție care adaugă o persoană la o casă.
; C = casa, name = numele persoanei, n-items = numărul de produse cumpărate
; Veți întoarce o nouă structură obținută prin așezarea perechii (name . n-items)
; la sfârșitul cozii de așteptare.
(define (add-to-counter C name n-items)
  (struct-copy counter C  [tt (+(match C [(counter index tt queue) tt]) n-items)]
               [queue (append (match C [(counter index tt queue) queue]) (list (cons name n-items)))]))


; TODO
; Implementați funcția care simulează fluxul clienților pe la case.
; requests = listă de cereri care pot fi de 2 tipuri:
; - (<name> <n-items>) - persoana <name> trebuie așezată la coadă la o casă
; - (delay <index> <minutes>) - casa <index> este întârziată cu <minutes> minute
; C1, C2, C3, C4 = structuri corespunzătoare celor 4 case
; Sistemul trebuie să proceseze aceste cereri în ordine, astfel:
; - persoanele vor fi distribuite la casele cu tt minim (dintre casele la care au voie)
; - când o casă suferă o întârziere, tt-ul ei crește
(define (serve requests C1 C2 C3 C4)

  ; puteți să vă definiți aici funcții ajutătoare (define în define)
  ; - avantaj: aveți acces la variabilele requests, C1, C2, C3, C4 fără a le retrimite ca parametri
  ; puteți de asemenea să vă definiți funcțiile ajutătoare în exteriorul lui "serve"
  ; - avantaj: puteți să vă testați fiecare funcție imediat ce ați implementat-o

  (if (null? requests)
      (list C1 C2 C3 C4)
      (match (car requests)
        [(list 'delay index minutes) (serve (cdr requests)
                                            (car (intarziere (EL2(car requests)) (EL3(car requests)) C1 C2 C3 C4))
                                            (EL2 (intarziere (EL2(car requests)) (EL3(car requests)) C1 C2 C3 C4))
                                            (EL3 (intarziere (EL2(car requests)) (EL3(car requests)) C1 C2 C3 C4))
                                            (EL4 (intarziere (EL2(car requests)) (EL3(car requests)) C1 C2 C3 C4)))]
        [(list name n-items)         (serve (cdr requests)
                                            (car (nou-cumparator (car (car requests)) (EL2 (car requests)) (casa-potrivita (EL2 (car requests)) C1 C2 C3 C4) C1 C2 C3 C4))
                                            (EL2 (nou-cumparator (car (car requests)) (EL2 (car requests)) (casa-potrivita (EL2 (car requests)) C1 C2 C3 C4) C1 C2 C3 C4))
                                            (EL3 (nou-cumparator (car (car requests)) (EL2 (car requests)) (casa-potrivita (EL2 (car requests)) C1 C2 C3 C4) C1 C2 C3 C4))
                                            (EL4 (nou-cumparator (car (car requests)) (EL2 (car requests)) (casa-potrivita (EL2 (car requests)) C1 C2 C3 C4) C1 C2 C3 C4)))])))

; in toarce al doilea element din lista data ca param
(define (EL2 L)
  (car (cdr L)))

; in toarce al treilea element din lista data ca param
(define (EL3 L)
  (car (cdr (cdr L))))

; in toarce al patrulea element din lista data ca param
(define (EL4 L)
  (car (cdr (cdr (cdr L)))))

; alege casa potrivita pentru clientul dat ca param
; (se verifica mai intai cate produse are)
(define (casa-potrivita n-items C1 C2 C3 C4)
  (if (<= n-items ITEMS )
      (min-tt (list C1 C2 C3 C4))
      (min-tt (list C2 C3 C4))))

;intoarce o lista (C1 C2 C3 C4) cu casa la care s-a asezat clientul nou modificata
(define (nou-cumparator name n-items pereche C1 C2 C3 C4)
  (cond
    ((= (car pereche) (match C1 [(counter index tt queue) index])) (list (add-to-counter C1 name n-items) C2 C3 C4))
    ((= (car pereche) (match C2 [(counter index tt queue) index])) (list C1 (add-to-counter C2 name n-items) C3 C4))
    ((= (car pereche) (match C3 [(counter index tt queue) index])) (list C1 C2 (add-to-counter C3 name n-items) C4))
    (else (list C1 C2 C3 (add-to-counter C4 name n-items)))))

;intoarce o lista (C1 C2 C3 C4) cu casa la care s-a modificat tt-ul casei data ca param
(define (intarziere index minutes C1 C2 C3 C4)
  (cond
    ((= index (match C1 [(counter index tt queue) index])) (list (tt+ C1 minutes) C2 C3 C4))
    ((= index (match C2 [(counter index tt queue) index])) (list C1 (tt+ C2 minutes) C3 C4))
    ((= index (match C3 [(counter index tt queue) index])) (list C1 C2 (tt+ C3 minutes) C4))
    (else (list C1 C2 C3 (tt+ C4 minutes)))))
        