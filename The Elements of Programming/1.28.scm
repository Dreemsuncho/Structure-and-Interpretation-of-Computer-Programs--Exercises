(require (lib "27.ss" "srfi"))

(define (square-check x m)
  (if (and (not (or (= x 1)
		    (= x (- m 1))))
           (= (remainder (* x x) m) 1))
      0
      (remainder (* x x) m)))

(define (even? n)
  (= (remainder n 2) 0))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
          (square-check (expmod base (/ exp 2) m) m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

(define (miller-rabin-test n)
  (define (try-it a)
     (= (expmod a (- n 1) n) 1))
  (try-it (+ 2 (random-integer (- n 2)))))
