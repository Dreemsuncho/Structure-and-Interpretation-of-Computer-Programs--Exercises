#lang racket

(provide (except-out (all-defined-out)
                     test))
                     
(define (square x) (* x x))
(define (test x) (* x x))
