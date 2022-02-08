#lang racket
(require "lib.scm")

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (log-info "next guess" next)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (fib x)
  (fixed-point (λ  (x) (+ 1 (/ 1 x)))
               1.0))

(log-info "Fibonacci Result:" (fib 1))



; xˣ = 1000
; x = 1000 - log(x)
; x = 1000 - log(x)
(newline)
(fixed-point (λ (x) (/ (log 1000) (log x)))
                       10)

(newline)
(define (x-to-the-x y)
  (fixed-point (lambda (x) (average x (/ (log y) (log x))))
               10.0))

(x-to-the-x 1000)