#lang racket
(require "lib.scm")

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define dx 0.00001)
(define (deriv g)
  (λ (x) (/ (- (g (+ x dx)) (g x))
            dx)))

(define (newton-transform g)
  (λ (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (λ (x) (+ (cube x)
            (* a (square x))
            (* b x)
            c)))

(newtons-method (cubic 2 3 5) 1)