#lang sicp

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (improve x guess)
  (/ (+ (/ x (square guess))
	(* 2 guess))
     3))

(define (good-enough? x guess)
  (< (abs (- (cube guess) x))
     (* x 0.00001)))

(define (cube-root-iter x guess)
  (if (good-enough? x guess)
      guess
      (cube-root-iter x (improve x guess))))

(define (cube-root x)
  (cube-root-iter x 1.0))


; Another solution

(define (cube-root x)
  (cube-root-iter 1 0 x))

(define (cube-root-iter guess old-guess x)
  (if (good-enough?  guess old-guess)
      guess
      (cube-root-iter (improve guess x)
                 guess
                 x)))

(define (good-enough? guess old-guess)
  (< (abs (- guess old-guess))
     (* guess 0.001)))

(define (square x)
  (* x x))

(define (improve guess x)
  (/ (+ (/ x (square guess))
        (* 2 guess))
     3))

(exact->inexact (cube-root 27))
