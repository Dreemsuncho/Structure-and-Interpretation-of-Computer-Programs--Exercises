
#lang racket

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

(define (calc-ratio per-test-count)
  (reset-current-total)
  (test 100000000000 100000000057 per-test-count)
  (define r1 current-total)

  (reset-current-total)
  (test 1000000000000 1000000000063 per-test-count)
  (define r2 current-total)

  (reset-current-total)  
  (test 10000000000000 10000000000099 per-test-count)
  (define r3 current-total)

  (reset-current-total)  
  (test 100000000000000 100000000000097 per-test-count)
  (define r4 current-total)

  (reset-current-total)  
  (test 1000000000000000 1000000000000159 per-test-count)
  (define r5 current-total)

  (reset-current-total)  
  (test 10000000000000000 10000000000000079 per-test-count)
  (define r6 current-total)

  (newline)
  (newline)
  
  (display "             R1: ")
  (display r1)

  (newline)
  (newline)

  (define ratio (sqrt 10))
  (display "Prediction next: ")
  (display (* r1 ratio))
  (newline)
  (display "             R2: ")
  (display r2)

  (newline)
  (newline)

  (display "Prediction next: ")
  (display (* r2 ratio))
  (newline)
  (display "             R3: ")
  (display r3)
  
  (newline)
  (newline)
  
  (display "Prediction next: ")
  (display (* r3 ratio))
  (newline)
  (display "             R4: ")
  (display r4)
  
  (newline)
  (newline)
  
  (display "Prediction next: ")
  (display (* r4 ratio))
  (newline)
  (display "             R5: ")
  (display r5)

  (newline)
  (newline)
  
  (display "Prediction next: ")
  (display (* r5 ratio))
  (newline)
  (display "             R6: ")
  (display r6)
  )

(calc-ratio 2)
