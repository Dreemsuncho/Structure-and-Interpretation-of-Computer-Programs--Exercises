(define (cube-iter guess old-guess x)
  (if (good-enough? guess old-guess)
      guess
      (cube-iter (improve-guess guess x)
                 guess
                 x)))

(define (good-enough? guess old-guess)
  (< (abs (- old-guess guess))
     (* guess 0.001)))

(define (improve-guess guess x)
  (/ (+ (/ x (* guess guess))
        (* 2 guess))
     3))

(define (cbr x)
  (cube-iter 1.0 0 x))