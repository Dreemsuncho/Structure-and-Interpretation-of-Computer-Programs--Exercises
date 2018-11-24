



(define (fib n)
  (if (< n 2) n
      (+ (fib (- n 1))
	 (fib (- n 2)))))


;; (quote ("Amount=" amount "Kinds-Of-Coins=" kinds-of-coins))
(print "2131231" + "asdsad")

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
	((or (< amount 0) 
             (= kinds-of-coins 0)) 
	 0)
	(else 
	 (+ (cc amount (- kinds-of-coins 1))
	    (cc (- amount (first-denomination-new kinds-of-coins))
		kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1) ;half-dollars - $0.50
        ((= kinds-of-coins 2) 5) ;quarters - $0.25
        ((= kinds-of-coins 3) 10) ;dimes - $0.10
        ((= kinds-of-coins 4) 25) ;nickels - $0.05
        ((= kinds-of-coins 5) 50))) ;pennies - $0.01

(define (first-denomination-new kinds-of-coins)
  (cond ((= kinds-of-coins 1) 25) ;nickels - $0.05
	((= kinds-of-coins 2) 50))) ;pennies - $0.01


(cc 6 2)


                            ________(cc 11 2)________
           _________(cc 11 1)________                0
________(cc 11 0)                     0
0                       

(count-change 100)

(cc 5 5)
(+ (cc 5 4) (cc -45 5))
(+ (+ (cc 5 3) 0 0))
(+ (+ (+ (cc 5 2) 0 0 0)))
(+ (+ (+ (+ (cc 5 1) (cc 3 2)) 0 0 0)))
(+ (+ (+ (+ (+ (cc 5 0) (cc 4 1)) (+ (cc 3 1) 0) 0 0 0))))
(+ (+ (+ (+ (+ 0 (+ 0 (cc 3 1)) (+ (+ 0 (cc 2 1) 0) 0 0 0))))))
(+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (cc 2 1))) (+ (+ 0 (+ 0 (cc 1 1)) 0) 0 0 0))))))
(+ (+ (+ (+ (+ 0 (+ 0 (+ 0 (+ 0 (cc 1 1)))) 1)))))
(+ 2)

;; count change



Exercise 1.11:

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* 2 (f (- n 2)))
	 (* 3 (f (- n 3))))))



(define (f-iter n)
  (define (helper x y z count)
    (if (= count 0)
	x
	(helper (+ x (* 2 y) (* 3 z)) z y (- count 1))))
  (helper 2 1 0 n))

(f-iter 1)
