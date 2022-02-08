

(require sicp)
(require (lib "27.ss" "srfi"))

(define (smallest-divisor n)
  (find-divisor n 2))


(define (next divisor)
  (if (= divisor 2)
      3
      (+ divisor 2)))

(define test-index 0)

(define (next-function divisor)
  (if (= test-index 0)
      (+ divisor 1)
      (next divisor)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) 
         n)
        ((divides? test-divisor n) 
         test-divisor)
        (else (find-divisor 
               n 
               (next-function test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (square x)
  (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (start-prime-test n start-time)
  (if (< test-index 2)
      (if (prime? n)
	  (report-prime (- (runtime) start-time)
			n))
      (if (fast-prime? n 100)
	  (report-prime (- (runtime) start-time)
			n))))
  
  
  
  (define (report-prime elapsed-time n)
    (newline)
    (display n)
    (display " *** ")
    (display elapsed-time)
    (increase-total elapsed-time))
  
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
  (set! test-index 0)
  
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

  
  (set! test-index 1)
  
  
  (reset-current-total)
  (test 100000000000 100000000057 per-test-count)
  (define r1-new current-total)

  (reset-current-total)
  (test 1000000000000 1000000000063 per-test-count)
  (define r2-new current-total)

  (reset-current-total)  
  (test 10000000000000 10000000000099 per-test-count)
  (define r3-new current-total)

  (reset-current-total)  
  (test 100000000000000 100000000000097 per-test-count)
  (define r4-new current-total)

  (reset-current-total)  
  (test 1000000000000000 1000000000000159 per-test-count)
  (define r5-new current-total)

  (reset-current-total)
  (test 10000000000000000 10000000000000079 per-test-count)
  (define r6-new current-total)

  
  (set! test-index 2)

  
  (reset-current-total)
  (test 100000000000 100000000057 per-test-count)
  (define f1 current-total)

  (reset-current-total)
  (test 1000000000000 1000000000063 per-test-count)
  (define f2 current-total)

  (reset-current-total)  
  (test 10000000000000 10000000000099 per-test-count)
  (define f3 current-total)

  (reset-current-total)  
  (test 100000000000000 100000000000097 per-test-count)
  (define f4 current-total)

  (reset-current-total)  
  (test 1000000000000000 1000000000000159 per-test-count)
  (define f5 current-total)

  (reset-current-total)
  (test 10000000000000000 10000000000000079 per-test-count)
  (define f6 current-total)
  
  
  (newline)
  (newline)

  (define (display-ratio old new)
    (display (exact->inexact (/ old new))))

  (display "Old Ratios:")
  (newline)
  
  (display "Ratio1: ")
  (display-ratio r1 r1-new)
  
  (newline)

  (display "Ratio3: ")
  (display-ratio r2 r2-new)
  
  (newline)

  (display "Ratio3: ")
  (display-ratio r3 r3-new)
  
  (newline)

  (display "Ratio4: ")
  (display-ratio r4 r4-new)
  
  (newline)
  
  (display "Ratio5: ")
  (display-ratio r5 r5-new)

  (newline)
  
  (display "Ratio6: ")
  (display-ratio r6 r6-new)
  
  (newline)

  (display "New Ratios:")
  (newline)
  
  (display "Ratio1: ")
  (display-ratio r1-new f1)
  
  (newline)

  (display "Ratio3: ")
  (display-ratio r2-new f2)
  
  (newline)

  (display "Ratio3: ")
  (display-ratio r3-new f3)
  
  (newline)

  (display "Ratio4: ")
  (display-ratio r4-new f4)
  
  (newline)
  
  (display "Ratio5: ")
  (display-ratio r5-new f5)

  (newline)
  
  (display "Ratio6: ")
  (display-ratio r6-new f6)

  )


(calc-ratio 3)



