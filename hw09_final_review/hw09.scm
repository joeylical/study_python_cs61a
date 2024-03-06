(define (reverse lst)
    (if (null? lst)
        '()
        (append
            (reverse (cdr lst))
            (cons (car lst) nil)))
)

