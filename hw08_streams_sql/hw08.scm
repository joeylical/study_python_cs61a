(define (rle s)
    (begin
        ; first s, n -> times, news
        (define (first s n)
            (if (null? s)
                (cons 0 s)
                (if (= n (car s))
                    (cons (+ (car (first (cdr-stream s) n)) 1) (cdr (first (cdr-stream s) n)))
                    (cons 0 s))))
            
        (if (null? s)
            '()
            (begin
                (define t (first s (car s)))
                (if (null? s)
                    '()
                    (cons-stream (cons (car s) (cons (car t) nil)) (rle (cdr t))))))))



(define (group-by-nondecreasing s)
    ; cons-stream in cons-stream
    (if (null? s)
        '()
        (begin
            (define (seq s max chain)
                (if (null? s)
                    (cons chain s)
                    (if (<= max (car s))
                        (seq (cdr-stream s) (car s) (append chain (cons (car s) nil)))
                        (cons chain s))))
            (define result (seq s (car s) '()))
            (define chain (car result))
            (define news (cdr result))
            (cons-stream chain (group-by-nondecreasing news)))))


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

