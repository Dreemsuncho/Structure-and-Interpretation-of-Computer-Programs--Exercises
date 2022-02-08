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


(define (average-damp f)
  (λ (x) (average x (f x))))


(define (sqrt x)
  (fixed-point (average-damp (λ (y) (/ x y)))
               1.0))

(sqrt 25)

(define (cube-root x)
  (fixed-point (average-damp (λ (y) (/ x (square y))))
               1.0))
(cube-root 25)

; Newton’s method
(define dx 0.00001)
(define (deriv g)
  (λ (x) (/ (- (g (+ x dx)) (g x))
            dx)))

(define (newton-transform g)
  (λ (x) (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt2 x)
  (newtons-method (λ (y) (- (square y) x)) 1.0))

(sqrt2 25)
