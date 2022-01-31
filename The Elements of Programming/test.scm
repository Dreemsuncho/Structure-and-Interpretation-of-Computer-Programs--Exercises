

#lang racket

(require threading)
(require algorithms)

(define (exp b n)
  (~> (repeat n b)
      (foldl * 1 _)))


(exp 2 3)

(foldl (lambda (a b result)
         (and
          (println (list a b result))
          (* result (- a b))))
       1
       '(1 2 3)
       '(4 5 6))
(andmap )