#lang sicp


(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
	  guess
	  (sqrt-iter (improve guess x) x)))


; The 'if' statement is special form that evaluates result after a true predicate or consequent alternative, but this is not true for applicative-order evaluation (like scheme procedures), they resolve all formal parameters before they are applied, thus 'sqrt-iter' function call itself in last expression that cause infinite loop.
