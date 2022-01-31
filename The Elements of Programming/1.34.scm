#lang racket
(require "lib.scm")

; Exercise 1.34: Suppose we define the procedure
(define (f g) (g 2))
; Then we have
(f square)
; 4
(f (lambda (z) (* z (+ z 1))))
; 6
; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.
