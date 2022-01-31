#lang racket

(define (accumulate func init term a next b)
  (if (> a b)
      init
      (func (term a)
            (accumulate func init term (next a) next b))))

(define (accumulate-iter func init term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (func result (term a)))))
  (iter a init))

(define (product term a next b)
  (accumulate * 1 term a next b))
(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))
(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

(define (identity x) x)
(define (inc x) (+ x 1))


(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 2))
                 (fib (- n 1))))))

(define (run from to)
  (println 'Accumlate-Iter)
  (println (sum-iter identity from inc to))
  (println (product-iter identity from inc to))
  (println (sum-iter fib from inc to))
  (println 'Accumlate)
  (println (sum identity from inc to))
  (println (product identity from inc to))
  (println (sum fib from inc to))
  )

(run 1 42)

