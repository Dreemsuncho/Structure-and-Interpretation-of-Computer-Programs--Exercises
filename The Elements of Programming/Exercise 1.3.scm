
(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (two-largest-sum-of-square x y z)
  (cond ((and (<= x y) (<= y z)) (sum-of-squares y z))
        ((and (<= y x) (<= x z)) (sum-of-squares x z))
        (else (sum-of-squares x y))))
