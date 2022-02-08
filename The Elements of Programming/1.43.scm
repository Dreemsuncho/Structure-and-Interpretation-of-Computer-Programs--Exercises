#lang racket
(require "lib.scm")

(define (compose f g)
  (λ (x) (f (g x))))

(define (repeated f x)
  (if (= x 0)
      (λ (x) x)
      (compose f (repeated f (- x 1)))))

((repeated square 2) 5)
((repeated square 2) 5)
