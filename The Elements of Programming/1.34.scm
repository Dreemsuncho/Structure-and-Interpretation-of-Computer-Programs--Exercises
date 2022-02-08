#lang racket
(require "lib.scm")

; Exercise 1.34: Suppose we define the procedure
(define (f g) (g 2))
; Then we have
(f square)
; 4
(f (lambda (z) (* z (+ z 1))))
; 6
; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.
(f f)
; then
; (f 2)
; then
; (2 2)
; then
; Error: application: not a procedure;
;  expected a procedure that can be applied to arguments
;   given: 2
