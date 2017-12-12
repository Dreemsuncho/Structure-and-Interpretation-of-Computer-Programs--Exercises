(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

; The 'if' is special form that evaluates result after predicate or consequent alternative, but this is not true for applicative-order evaluation (like procedures in scheme lng), procedure resolve all formal parameters before is applied, thus call itself in last expression that cause infinite loop