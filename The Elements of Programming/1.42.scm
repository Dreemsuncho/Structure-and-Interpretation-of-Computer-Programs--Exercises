#lang racket
(require "lib.scm")

(define (compose f g)
  (λ (x) (f (g x))))

((compose square inc) 6)