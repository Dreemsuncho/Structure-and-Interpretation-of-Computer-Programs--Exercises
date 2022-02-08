#lang racket

(provide (except-out (all-defined-out)
                     test))

(define (log-info description value)
  (let ((message-result (string-append description ": " (~a value))))
    (displayln message-result)))

(define (inc x) (+ x 1))

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (average x y)
  (/ (+ x y) 2))

; todo consider
(define (test x) (+ 1 x))