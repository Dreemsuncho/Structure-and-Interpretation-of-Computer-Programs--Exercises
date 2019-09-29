#lang sicp
(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

; In applicative-order the arguments in the function must be resolved before the function proceed, then get in recursive loop because the p-function call itself and program never stop.
; Normal-order returns 0 because the arguments in the function are resolved when they are need.

; Conclusion: Scheme interpreter never terminates because it uses applicative-order of evaluation
