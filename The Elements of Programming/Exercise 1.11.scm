
; f(n) = n if n < 3
; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n >= 3


; This is easy, the old fashin recursion
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* 2 (f (- n 2)))
	 (* 3 (f (- n 3))))))


; More efficient, but complex solution (iterative)
(define (fi-helper x y z count)
  (if (= count 0) x
      (fi-helper y z (+ z
			(* 2 y)
			(* 3 x))
		 (- count 1))))

(define (f-iter n)
  (if (< n 3) n
      (fi-helper 0 1 2 n)))

