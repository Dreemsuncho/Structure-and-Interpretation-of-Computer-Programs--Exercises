#lang racket

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (identity n) n)
(define (inc n) (+ n 1))
(define (square n) (* n n))
(define (cube n) (* n n n))

(print "Sum iter")
(sum-iter identity 1 inc 100000000)
(print "Sum")
(sum identity 1 inc 100000000)