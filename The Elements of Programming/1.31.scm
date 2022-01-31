#lang racket

(define (inc n) (+ n 1))

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

(define (factorial-iter n)
  (define (iter product counter max-count)
    (if (> counter max-count)
        product
        (iter (* counter product)
              (+ counter 1)
              max-count)))
  (iter 1 1 n))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a acc)
    (if (> a b)
        acc
        (iter (next a) (* acc (term a)))))
  (iter a 1))



(product-iter factorial 1 inc 7)
(product factorial 1 inc 7)
