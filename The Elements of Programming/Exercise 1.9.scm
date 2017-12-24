; This solution is recursive because it has deferred increment operations until 'a' reach 0

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
;linear recursion
(+ 4 5)
(inc (+ (dec 4) 5))
(inc (+ 3 5))
(inc (inc (+ (dec 3) 5)))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ dec 2) 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
(9)

; This is iterative process of computation, every step is memorize the next relative state of program arguments.
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
; linear iteration
(+ 4 5)
(+ (- 1 4) (+ 1 5))
(+ 3 6)
(+ (- 1 3) (+ 1 6))
(+ 2 7)
(+ (- 1 2) (+ 1 7))
(+ 1 8)
(+ (- 1 1) (+ 1 8))
(+ 0 9)
(9)



