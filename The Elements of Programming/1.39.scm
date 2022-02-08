
; (define (tan-cf x k)
;   (count-frac (λ (i) (- (square i)))
;               (λ (i) (+ i 2))
;               x))





#lang racket
(require "lib.scm")

(define (count-frac n d k)
  (define (loop result k-term)
    (if (= k-term 0)
        result
        (loop (/ (n k) (+ (d k) result))
              (- k-term 1))))
  (loop 0 k))

(define (tan-cf x k)
  (count-frac (lambda (i)
                (if (= i 1) x (- (* x x))))
              (lambda (i)
                (- (* i 2) 1))
              k))
(log-info "tan-cf" (tan-cf 1 5))