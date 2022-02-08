#lang racket
(require racket/format)
(require "lib.scm")

(define result null)

; стр.89 Finding roots of equations by the half-interval method

(define (search f neg-point pos-point)
  (define (close-enough? x y) (< (abs (- x y)) 0.001))
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else
                 midpoint))))))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else
           (error "Values are not of opposite sign" a b)))))

; (half-interval-method sin 2.0 4.0)
; (half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3))
;                       1.0
;                       2.0)


;  стр.92 Finding fixed points of functions

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(set! result (fixed-point cos 1.0))
(log-info "fixed-point: cos" result)


(set! result (fixed-point (lambda (y) (+ (sin y) (cos y)))
                          1.01))
(log-info "fixed-point: y = sin(y) + cos(y)" result)

; y² = x
; putting this equation into the equivalent form
; y = x/y,
(define value-sqrt 50)
(define (sqrt-infinite-loop x)
  (fixed-point (lambda (y) (/ x y))
               1.0))
; (displayln "sqrt: (y² = x) => (y = x/y)")
; (sqrt value-sqrt)

(define (sqrt x)
  (fixed-point (lambda (y) (/ (+ y (/ x y))
                              2))
               1.0))
(set! result (sqrt value-sqrt))
(log-info "sqrt2: (1/2) * (y + x/y)" result)

(define (sqrt-with-average x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

(set! result (sqrt-with-average value-sqrt))
(log-info "sqrt-with-average: (1/2) * (y + x/y)" result)






