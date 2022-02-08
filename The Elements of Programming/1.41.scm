#lang racket
(require "lib.scm")

(define (twice f)
  (λ (x) (f (f x))))

  (((twice (twice twice)) inc) 5) ; 21
  (((twice (twice twice)) inc) 6)
  (((twice (twice twice)) inc) 1)