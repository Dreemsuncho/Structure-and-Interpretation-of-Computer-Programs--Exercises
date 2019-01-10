

;; 1.22
(require sicp)



(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (square x)
  (* x x))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  (increase-total elapsed-time))

(define (start-prime-test n start-time)
  (cond ((prime? n)
	 (newline)
	 (display n)
	 (report-prime (- (runtime) 
			  start-time)))))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (search-for-primes start end)
  (cond ((even? start)
	 (search-for-primes (+ start 1) end))
	((<= start end)
	 (timed-prime-test start)
	 (search-for-primes (+ start 2) end)))
  )

  (define (test min max tests-count)
    (define (run times)
      (cond ((> times 0)
	     (newline)
	     (search-for-primes min max)
	     (run (- times 1)))))
    
    (run tests-count)    
    )


(define current-total 0)

(define (increase-total elapsed-time)
  (set! current-total (+ current-total elapsed-time)))



(define (reset-current-total)
  (set! current-total 0))

(define (calc-average per-test-count)
  (define total 0)
  (define r1 0)
  (define r2 0)
  (define r3 0)
  
  (reset-current-total)
  (test 100000000000 100000000057 per-test-count)

  (set! total (+ total current-total))
  (set! r1 current-total)

  (reset-current-total)
  (test 1000000000000 1000000000063 per-test-count)

  (set! total (+ total current-total))
  (set! r2 current-total)

  (reset-current-total)  
  (test 10000000000000 10000000000099 per-test-count)

  (set! total (+ total current-total))
  (set! r3 current-total)

  (newline)
  (newline)

  
  (display "R1: ")
  (display r1)
  (newline)
  (display "Prediction next: ")
  (display (* r1 (sqrt 10)))
  (newline)
  (display "             R2: ")
  (display r2)
  (newline)
  (display "Prediction next: ")
  (display (* r2 (sqrt 10)))
  (newline)
  (display "             R3: ")
  (display r3)
  ;;(display "Prediction: ")
  ;;(display (square r3))
  (newline)
  (newline)
  (display "Total: ")
  (display total)
  )

(calc-average 20)

  ;; (test 10000000000000 10000000000100 1)
  ;; (test 100000000000000 100000000000098 1)
  ;; (test 1000000000000000 1000000000000160 1)
;; (test 10000000000000000 10000000000000080 1)





