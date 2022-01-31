#lang racket


(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        0
        (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (identity n) n)
(define (inc n) (+ n 1))
(define (cube n) (* n n *))
(define (square n) (* n n))


(let ((x 2))
  (let ((x 3)
        (y (+ x 2)))
    (* x y)
    (println x)
    (println y)
    (println (* x y))
    )

    (println x)

  (+ (let ((x 3))
       (+ x (* x 10)))
     x)
  )


