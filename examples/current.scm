#lang sicp

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* 2 (f (- n 2)))
	 (* 3 (f (- n 3))))))

(define (f2 n)
  (define (iter a b c)
    (cond (< a 3)
         
         )))
