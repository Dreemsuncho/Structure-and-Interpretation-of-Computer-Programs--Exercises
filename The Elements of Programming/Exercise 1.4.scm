(define (function x y)
  ((if (< x y) - +) x y))
 
; If x < y then procedure returns '-' otherwise '+' and vice versa.