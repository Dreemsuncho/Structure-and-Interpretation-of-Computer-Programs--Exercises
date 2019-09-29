#lang sicp
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
; If b > 0 then the procedure will return '+' otherwise '-'