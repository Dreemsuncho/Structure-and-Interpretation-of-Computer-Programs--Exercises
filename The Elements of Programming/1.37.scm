#lang racket
(require "lib.scm")

(define (count-frac n d k)
  (if (= k 0)
      0
      (let ((next-k (- k 1)))
        (/ (n k)
           (+ (d k) (count-frac n d next-k))))))

(log-info "     count-frac" (/ 1 (count-frac (lambda (i) 1.0)
                                             (lambda (i) 1.0)
                                             13)))


(define (count-frac-iter n d k)
  (define (loop result k-term)
    (if (= k-term 0)
        result
        (loop (/ (n k) (+ (d k) result))
              (- k-term 1))))
  (loop 0 k))

(log-info "count-frag-iter" (/ 1 (count-frac-iter (lambda (i) 1.0)
                                                  (lambda (i) 1.0)
                                                  13)))