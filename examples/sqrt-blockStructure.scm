#lang sicp

(define (sqrt x)
  (define (good-enough? guess x)
    (define (square x)
      (* x x))
    (< (abs (- (square guess) x)) 0.001))
  
  (define (sqrt-iter guess x)  
    (define (improve guess x)
      (define (average x y)
        (/ (+ x y)2))
      (average guess (/ x guess)))
    (if (good-enough? guess x)
	guess
	(sqrt-iter (improve guess x) x)))
  
  (sqrt-iter 1.0 x))
