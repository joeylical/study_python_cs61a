(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (begin ;(displayln first) (displayln rests)
  (if (null? rests)
    '()
    (cons (cons first (car rests)) (cons-all first (cdr rests))))))
    ; (if (list? first)
    ;   (cons (append first (car rests)) (cons-all first (cdr rests)))
    ;   (append (append (cons first nil) (car rests)) (cons-all first (cdr rests)))))))

(define (cons-all-dbg first rests)
  (begin 
    ; (display "DEBUG: ")
    ; (displayln first) 
    ; (display "DEBUG: ")
    ; (displayln rests)
    (cons-all first rests)))

; (cons-all-dbg '1 '((2 3) (2 4) (3 5)))
; (cons-all-dbg '(0 0) '((3) (4) (5)))
; (exit)

(define (zip pairs)
  (begin
    (display "DEBUG: ")
    (displayln pairs)
    (if (null? pairs)
      pairs
      (if (null? (car pairs))
        ; (cons (map car pairs) nil)
        ; (map (lambda (x) '()) pairs)
        nil
        (cons (map car pairs) (zip (map cdr pairs)))
        ))))

; (zip '((1 2) (3 4) (5 6)))
; ; ((1 3 5) (2 4 6))
; (zip '((1 2)))
; ; ((1) (2))
; (zip '())
; ; (() ())
; (exit)

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
    (define mk (lambda (x a) 
      (if (null? a)
          nil
          (cons (cons x (cons (car a) nil)) (mk (+ x 1) (cdr a))))
      ))
    (mk 0 s)
  )
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (real-list-change total denoms)
  ; BEGIN PROBLEM 17
  (define denoms (filter (lambda (x) (>= total x)) denoms))
  (if (<= total 0)
    '((nil))
    (begin
      (define (created d) (cons d
                            (if (null? (cdr d))
                              nil
                              (created (cdr d)))))
      (define test (created denoms))
      
      ; reduce append is importent
      (reduce append (map (lambda (d)
              (map (lambda (e) (cons-all-dbg (car d) e)) (real-list-change (- total (car d)) d)))
              test)))
    )
  )
  ; END PROBLEM 
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
  (begin
    (define result (real-list-change total denoms))
    ; the result is a tree
    ; need to flat the tree into a list
    (display "DEBUG: ")
    (displayln result)
    (define (flat l)
      (begin
        (display "DEBUG: ")
        (displayln l)
        (if (list? (caar l))
          (reduce append (map flat l))
          l)))
      
    (flat result))
  )
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 18
          (begin
            expr)
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (begin
            (cons form (cons params (map let-to-lambda body))))
           ; END PROBLEM 18
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 18
           (begin 
            (define p (zip values))
            (define formal (car p))
            (define params (car (cdr p)))
           (append (cons (cons 'lambda (cons formal (map let-to-lambda body))) nil) (map let-to-lambda params)))
           ; END PROBLEM 18
           ))
        (else
         ; BEGIN PROBLEM 18
          (begin
            (map let-to-lambda expr))
         ; END PROBLEM 18
         )))