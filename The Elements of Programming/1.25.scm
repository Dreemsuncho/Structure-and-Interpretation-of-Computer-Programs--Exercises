(require sicp)
(require (lib "27.ss" "srfi"))

(define (square x)
  (* x x))

(define (expmod-fast base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define expmod expmod-fast)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random-integer (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (start-prime-test n start-time)
  (if (fast-prime? n 50)
      (report-prime (- (runtime) 
                       start-time))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))

(define (expmod-slow base exp m)
  (remainder (fast-expt base exp) m))


(define (run-test n)
  (set! expmod expmod-fast)
  
  (newline)
  (display "Old time: ")
  (timed-prime-test n)

  (newline)
  (set! expmod expmod-slow)
  
  (display "New time: ")
  (timed-prime-test n)
  )
               ;;   Old time | New time
(run-test 6133);; |    0     |   5167   |
(run-test 6997);; |    0     |  77165   |
(run-test 7901);; |    0     |  84881   |
(run-test 9719);; |    0     |  134597  |

;; When we run the tests, answers show us that, new "expmode" procedure give the right answer, but perform much slower. The reason is because old "expmode" returns not only the remainder, but also itself every time, unlike the "Alyssa P. Hacker" new "expmode" procedure, that only return the squared result from bⁿ/², instead the remainder of the result itself.

