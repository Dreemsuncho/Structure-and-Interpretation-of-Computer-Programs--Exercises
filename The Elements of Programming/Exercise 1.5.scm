(define (p) (p))
(define (test x y)
  (if (= x 0)
      0
      y))

; In applicative-order of evaluation (such as scheme) the arguments in the function must be resolved before function proceed, then get in recursive loop because the p-function call itself and program never stop.
; Conversely normal-order returns 0 because arguments in function is applied when is needed.
