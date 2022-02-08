#lang racket
; (require "lib.scm")

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


(+ 2 (count-frac (λ (i) 1.0)
                 (λ (i) (if (= (remainder i 3) 2)
                            (* (/ (+ i 1) 3 ) 2)
                            1))
                 13))
(count-frac (λ (i) 1.0)
                 (λ (i) (if (= (remainder i 3) 2)
                            (* (/ (+ i 1) 3 ) 2)
                            1))
                 13)

(+ 2 (count-frac-iter (λ (i) 1.0)
                 (λ (i) (if (= (remainder i 3) 2)
                            (* (/ (+ i 1) 3 ) 2)
                            1))
                 13))
(count-frac-iter (λ (i) 1.0)
                 (λ (i) (if (= (remainder i 3) 2)
                            (* (/ (+ i 1) 3 ) 2)
                            1))
                 13)