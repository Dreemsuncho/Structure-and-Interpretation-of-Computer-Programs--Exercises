(require sicp)
(require (lib "27.ss" "srfi"))


(define (next divisor)
  (if (= divisor 2)
      3
      (+ divisor 2)))

(define (square x)
  (* x x))


(define (fast-expt b n)
  (cond ((= n 0) 
         1)
        ((even? n) 
         (square (fast-expt b (/ n 2))))
        (else 
         (* b (fast-expt b (- n 1))))))


(define (expmod-new base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (* (expmod base (/ exp 2) m)
             (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base 
             (expmod base (- exp 1) m))
          m))))

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
  (if (fast-prime? n 100)
      (report-prime (- (runtime) 
                       start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))




(timed-prime-test 1999)
(timed-prime-test 10007)
(timed-prime-test 100003)

(set! expmod expmod-new)


(newline)
(timed-prime-test 1999)
(timed-prime-test 10007)
(timed-prime-test 100003)

