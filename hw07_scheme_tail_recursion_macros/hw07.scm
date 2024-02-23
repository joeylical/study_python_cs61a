(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (car (cddr s))
)


(define (sign num)
  (cond ((< num 0) -1)
        ((= num 0) 0)
        ((> num 0) 1))
)


(define (square x) (* x x))

; Passed after reformating the code = =
(define (pow x y)
  (cond ((= y 1) x)
        ((even? y)  (square 
                      (pow x 
                        (/ y 2)
                      )
                    )
        )
        ((odd? y)  (* 
                      x 
                      (pow 
                        x 
                        (- 
                          y 
                          1
                        )
                      )
                    )
        )
  )
)

(define (u s l)
  (cond
    ((null? s) l)
    ((null?
      (filter
        (lambda
          (n)
          (eq? n (car s)))
        l)) (u  (cdr s) (append l (list (car s)))))
    (else (u (cdr s) l)))
)

;; correct but not keep order
; (define (unique s)
;   'YOUR-CODE-HERE
;   (cond
;     ((null? s) s)
;     ((null? (filter (lambda (n)(= n (car s))) (unique (cdr s)))) (cons (car s) (unique (cdr s))))
;     (else (unique (cdr s))))
; )

(define (unique s)
  'YOUR-CODE-HERE
  (u s '())
)

(define (rep x n r)
  (if (= n 0)
    r
    (rep x (- n 1) (append r (list x)))
  )
)

(define (replicate x n)
  (rep x n '())
)

(define (acc combiner i n term result)
  (if (= i n)
    (combiner (term i) result)
    (acc combiner (+ i 1) n term (combiner (term i) result))
  )
)

(define (accumulate combiner start n term)
  (acc combiner 1 n term start)
)


(define (accumulate-tail combiner start n term)
  (acc combiner 1 n term start)
)

; (            list-of (* x x)  for x   in '(3 4 5) if (odd? x))
(define-macro (list-of map-expr for var in lst      if filter-expr)
  'YOUR-CODE-HERE
  (list 'map 
    (list 'lambda (list var) map-expr)
      (list 'filter
        (list 'lambda (list var) filter-expr)
        lst
    )
  )
)

