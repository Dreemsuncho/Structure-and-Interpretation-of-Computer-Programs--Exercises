;;f(n) = n if n<3
;;f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n>=3.

; Recursive solution
(define (func n)
  (if (< n 3)
      n
      (+ (func (- n 1))
	 (* 2 (func (- n 2)))
	 (* 3 (func (- n 3))))))

; Iterative solution
(define (ifunc n)
  (define (inner-ifunc fn1 fn2 fn3 n)
    (if (< n 3)
        fn1
        (inner-ifunc (+ (* 1 fn1)
                        (* 2 fn2)
                        (* 3 fn3))
                     fn1
                     fn2
                     (- n 1))))
  (inner-ifunc 2 1 0 n))
