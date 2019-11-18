# Structure and Interpretation of Computer Programs(SICP) Second Edition - Exercises

 ### The Elements of Programming
  * __Exercise 1.1.__ Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented:
    ```scheme
    10 
    (+ 5 3 4) 
    (- 9 1) 
    (/ 6 2) 
    (+ (* 2 4) (- 4 6)) 
    (define a 3) 
    (define b (+ a 1)) 
    (+ a b (* a b)) 
    (= a b) 
    (if (and (> b a) (< b (* a b)))
    	b    
        a) 
    (cond ((= a 4) 6)
    	  ((= b 4) (+ 6 7 a))      
          (else 25)) 
    (+ 2 (if (> b a) b a)) 
    (* (cond ((> a b) a)
    		 ((< a b) b)         
             (else -1))   
       (+ a 1)
    ```
    * __Solution__
      ```scheme
      10                     ;10 
      (+ 5 3 4)              ;12 
      (- 9 1)                ;8 
      (/ 6 2)                ;3 
      (+ (* 2 4) (- 4 6))    ;6
      (define a 3)           ;a=3
      (define b (+ a 1))     ;b=4
      (+ a b (* a b))        ;19
      (= a b)                ;#false
      (if (and (> b a) (< b (* a b)))
          b
          a)                 ;4
      (cond ((= a 4) 6)
            ((= b 4) (+ 6 7 a))
            (else 25))       ;16
      (+ 2 (if (> b a) b a)) ;6
      (* (cond ((> a b) a)
              ((< a b) b)
              (else -1))
        (+ a 1))            ;16
      ```

  * __Exercise 1.2.__ Translate the following expression into prefix form:
    ```
    (5 + 4 + (2 - (3 - (6 + (4 / 5))))) / (3 * (6 - 2) * (2 - 7))
    ```
      * __Solution__
        ```scheme
        ( /
          (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
          (* 3 (- 6 2) (- 2 7)))
        ```

  * __Exercise 1.3.__  Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
    * __Solution__
      ```scheme
      (define (square x) (* x x))

      (define (sum-of-squares x y)
        (+ (square x) (square y)))

      (define (two-largest-sum-of-square x y z)
        (cond ((and (<= x y) (<= y z)) (sum-of-squares y z))
              ((and (<= y x) (<= x z)) (sum-of-squares x z))
              (else (sum-of-squares x y))))
      ```     

  * __Exercise 1.4.__  Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:
    ```scheme
    (define (a-plus-abs-b a b)  
    ((if (> b 0) + -) a b))
    ```
    * __Solution__ if `b > 0` then the procedure will return `+` otherwise `-`
    

  * __Exercise 1.5.__  Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:
    ```scheme
    (define (p) (p))
    (define (test x y)
      (if (= x 0) 
      	  0
          y))
    ```
  	Then he evaluates the expression 
    ```scheme
    (test 0 (p))
    ```
    What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.) 
    * __Solution__ In applicative-order of evaluation such in scheme the arguments in the function must be resolved before function proceed, then get in recursive loop because the `p` function call itself and program never stop.
    Conversely normal-order returns `0` because arguments in function is applied when is needed.
    
  * __Exercise 1.6.__  Alyssa P. Hacker doesn’t see why if needs to be provided as a special form. ‘‘Why can’t I just define it as an ordinary procedure in terms of cond?’’ she asks. Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if 
	```scheme
    (define (new-if predicate then-clause else-clause)  
      (cond (predicate then-clause)        
      (else else-clause)))
	```
    Eva demonstrates the program for Alyssa:
    ```scheme
    (new-if (= 2 3) 0 5) 
    5 
    (new-if (= 1 1) 0 5) 
    0
    ```
    Delighted, Alyssa uses new-if to rewrite the square-root program:
    ```scheme
    (define (sqrt-iter guess x)  
      (new-if (good-enough? guess x)          
            guess          
              (sqrt-iter (improve guess x)                    
                      x)))
    ```
    What happens when Alyssa attempts to use this to compute square roots? Explain. 
    * __Solution__ The `if` is special form that evaluates result after predicate or consequent alternative, but this is not true for applicative-order evaluation (like procedures in scheme), they resolve all formal parameters before is applied, thus call itself in last expression that cause infinite loop.

    
  * __Exercise 1.7.__  The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?
    * __Solution__
      ```scheme
      (define (sqrt-iter guess old-guess x)
        (if (good-enough? guess old-guess)
            guess
            (sqrt-iter (improve-guess guess x)
                      guess
                      x)))

      (define (good-enough? guess old-guess)
        (< (abs (- guess old-guess))
          (* guess 0.001)))

      (define (improve-guess guess x)
        (average guess (/ x guess)))

      (define (average x y)
        (/ (+ x y) 2))

      (define (sqrt x)
        (sqrt-iter 1.0 0 x))
      ```

  * __Exercise 1.8.__  Newton’s method for cube roots is based on the fact that if y is an approximation to the cube root of x, then a better approximation is given by the value
    ```
    x / y² + 2y
    ———————————
         3
    ```
	Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In section 1.3.4 we will see how to implement Newton’s method in general as an abstraction of these square-root and cube-root procedures.)
    * __Solution__
      ```scheme
      (define (square x)
        (* x x))

      (define (cube x)
        (* x x x))

      (define (improve x guess)
        (/ (+ (/ x (square guess))
        (* 2 guess))
          3))

      (define (good-enough? x guess)
        (< (abs (- (cube guess) x))
          (* x 0.00001)))

      (define (cube-root-iter x guess)
        (if (good-enough? x guess)
            guess
            (cube-root-iter x (improve x guess))))

      (define (cube-root x)
        (cube-root-iter x 1.0))


      ; Another solution

      (define (cube-root x)
        (cube-root-iter 1 0 x))

      (define (cube-root-iter guess old-guess x)
        (if (good-enough?  guess old-guess)
            guess
            (cube-root-iter (improve guess x)
                      guess
                      x)))

      (define (good-enough? guess old-guess)
        (< (abs (- guess old-guess))
          (* guess 0.001)))

      (define (square x)
        (* x x))

      (define (improve guess x)
        (/ (+ (/ x (square guess))
              (* 2 guess))
          3))

      (exact->inexact (cube-root 27))
      ```

  * __Exercise 1.9.__  Each of the following two procedures defines a method for adding two positive integers in terms of the procedures inc, which increments its argument by 1, and dec, which decrements its argument by 1.
    ```scheme
    (define (+ a b)  
      (if (= a 0)      
          b      
          (inc (+ (dec a) b))))
    (define (+ a b)  
      (if (= a 0)      
          b      
          (+ (dec a) (inc b))))
    ```
    Using the substitution model, illustrate the process generated by each procedure in evaluating (+ 4 5). Are these processes iterative or recursive?
    * __Soluton__
      ```scheme
      (define (inc x)
        (+ x 1))

      (define (dec x)
        (- x 1))

      (define (+ x y)
        (if (= x 0)
            y
            (inc (+ (dec x) y))))

      ; Linear recursive process
      (+ 4 5)
      (inc (+ (dec 4) 5))
      (inc (inc (+ (dec 3) 5)))
      (inc (inc (inc (+ (dec 2) 5))))
      (inc (inc (inc (inc (+ (dec 1) 5)))))
      (inc (inc (inc (inc (+ 0 5)))))
      (inc (inc (inc (inc 5))))
      (inc (inc (inc 6)))
      (inc (inc 7))
      (inc 8)
      9

      (define (+ x y)
        (if (= x 0)
            y
            (+ (dec x) (inc y))))

      ; Iterative process
      (+ 4 5)
      (+ (dec 4) (inc 5))
      (+ 3 6)
      (+ (dec 3) (inc 6))
      (+ 2 7)
      (+ (dec 2) (inc 7))
      (+ 1 8)
      (+ (dec 1) (inc 8))
      (+ 0 9)
      9
      ```

  * __Exercise 1.10.__  The following procedure computes a mathematical function called Ackermann’s function.
    ```scheme
    (define (A x y)
      (cond ((= y 0) 0)
              ((= x 0) (* 2 y))
              ((= y 1) 2)
              (else (A (- x 1)
                      (A x (- y 1))))))
    ```
    What are the values of the following expressions?
    ```scheme
    (A 1 10) 
    (A 2 4) 
    (A 3 3)
    ```
    Consider the following procedures, where A is the procedure defined above:
    ```scheme
    (define (f n) (A 0 n))
    (define (g n) (A 1 n))
    (define (h n) (A 2 n))
    (define (k n) (* 5 n n))
    ```
    Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n. For example, (k n) computes 5n2. 
    * __Solution__
      ```scheme
      (define (A x y)
        (cond ((= y 0) 0)
              ((= x 0) (* 2 y))
              ((= y 1) 2)
              (else (A (- x 1)
                      (A x (- y 1))))))

      ;What are the values of the following expressions?

      ;x = 1, y = 10
      (A 1 10)
      (A (- 1 1) (A 1 (- 10 1)))
      (A 0 (A 1 9))
      (A 0 (A (- 1 1) (A 1 (- 9 1))))
      (A 0 (A 0 (A 1 8)))
      (A 0 (A 0 (A (- 1 1) (A 1 (- 8 1)))))
      (A 0 (A 0 (A 0 (A 1 7))))
      (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 7 1))))))
      (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
      (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 6 1)))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 5 1))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 4 1)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 3 1))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A (- 1 1) (A 1 (- 2 1)))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 2)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 4))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 8)))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 16))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 32)))))
      (A 0 (A 0 (A 0 (A 0 (* 2 32)))))
      (A 0 (A 0 (A 0 (A 0 64))))
      (A 0 (A 0 (A 0 (* 2 64))))
      (A 0 (A 0 (A 0 128)))
      (A 0 (A 0 (* 2 128)))
      (A 0 (A 0 256))
      (A 0 (* 2 256))
      (A 0 512)
      (* 2 512)
      1024

      ;x = 2, y = 4
      (A 2 4)
      (A 1 (A 2 3))
      (A 1 (A 1 (A 2 2)))
      (A 1 (A 1 (A 1 (A 2 1))))
      (A 1 (A 1 (A 1 2)))
      (A 1 (A 1 (A 0 (A 1 1))))
      (A 1 (A 1 (A 0 2)))
      (A 1 (A 1 (* 2 2)))
      (A 1 (A 1 4))
      (A 1 (A 0 (A 1 3)))
      (A 1 (A 0 (A 0 (A 1 2))))
      (A 1 (A 0 (A 0 (A 0 2))))
      (A 1 (A 0 (A 0 (* 2 2))))
      (A 1 (A 0 (A 0 4)))
      (A 1 (A 0 (* 2 4)))
      (A 1 (A 0 8))
      (A 1 (* 2 8))
      (A 1 16)
      (A 0 (A 1 15))
      (A 0 (A 0 (A 1 14)))
      (A 0 (A 0 (A 0 (A 1 13))))
      (A 0 (A 0 (A 0 (A 0 (A 1 12)))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 11))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 10)))))))
      ; See example above for our result
      ; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 9))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 8)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 7))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 6)))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 2)))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 4))))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 8)))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 16))))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 32)))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 32)))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 64))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 64))))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 128)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 128)))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 256))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 256))))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 512)))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 512)))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 1024))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 (* 2 1024))))))
      (A 0 (A 0 (A 0 (A 0 (A 0 2048)))))
      (A 0 (A 0 (A 0 (A 0 (* 2 2048)))))
      (A 0 (A 0 (A 0 (A 0 4096))))
      (A 0 (A 0 (A 0 (* 2 4096))))
      (A 0 (A 0 (A 0 8192)))
      (A 0 (A 0 (* 2 8192)))
      (A 0 (A 0 16384))
      (A 0 (* 2 16384))
      (A 0 32768)
      (* 2 32768)
      65536

      ;x = 3, y = 3
      (A 3 3)
      (A 2 (A 3 2))
      (A 2 (A 2 (A 3 1)))
      (A 2 (A 2 2))
      (A 2 (A 1 (A 2 1)))
      (A 2 (A 1 2))
      (A 2 (A 0 (A 1 1)))
      (A 2 (A 0 2))
      (A 2 (* 2 2))
      (A 2 4)
      65536
      ;Why so fast we catch the result?
      ;See example above that start with (A 2 4), accordingly the result will be the same.


      ;Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n. For example, (k n) computes 5n2.

      (define (f n) (A 0 n))
      (define (g n) (A 1 n))
      (define (h n) (A 2 n))
      (define (k n) (* 5 n n))

      (f 1) ;2n
      (g 2) ;2ⁿ when n > 0 and 0 when n = 0
      (h 3) ;ⁿ2 or 2ʰ⁽ⁿ⁻¹⁾ if n > 1 (tetration)
      ;if n = 1 then h(n) = 1, else n = 0 then h(n) = 0
      (k 4) ;5n2    
      ```

  * __Exercise 1.11.__  A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.
    * __Solution__
      ```scheme
      ; This is easy, the old fashin recursion
      (define (f n)
        (if (< n 3)
            n
            (+ (f (- n 1))
        (* 2 (f (- n 2)))
        (* 3 (f (- n 3))))))

      ; More efficient, but complex solution (iterative)
      (define (f-iter n)
        (define (iter a b c count)
          (if (= count 0)
        a
        (iter b
              c
              (+ c (* 2 b) (* 3 a))
              (- count 1))))
        (iter 0 1 2 n))
      ```

  * __Exercise 1.12.__  The following pattern of numbers is called Pascal’s triangle.
    ```
        1
       1 1
      1 2 1
     1 3 3 1
    1 4 6 4 1
    ```
    The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it.35 Write a procedure that computes elements of Pascal’s triangle by means of a recursive process. 
    * __Soluton__
      ```scheme
      (define (pascal row col)
        (if (or (= col 0) (= row col)) 1
            (+ (pascal (- row 1) col)
        (pascal (- row 1) (- col 1)))))
      ```

  * __Exercise 1.13.__   Prove that ```Fib(n)``` is the closest integer to ```ϕⁿ/√5```, where   ```ϕ = (1 + √5)/2```. Hint: Let ```ψ = (1 − √5)/2```. Use induction and the deﬁnition of the Fibonacci numbers (see Section 1.2.2) to prove that ```Fib(n) = (ϕⁿ − ψⁿ)/√5```.
    * __Solution__ The first thing that we have to do is to prove ```Fib(n) = (ϕⁿ − ψⁿ)/√5``` so let's start with the base cases where ```n = 0```
      ```
      ϕ⁰ − ψ⁰   1 - 1     0 
      ——————— = ————— = ————— = 0
        √5       √5      √5
      ```
      and ```n = 1```
      ```
      ϕ¹ − ψ¹   ϕ - ψ  
      ——————— = ————— =
        √5       √5    

      ((1 + √5)/2) - ((1 − √5)/2) 
      ——————————————————————————— =
                √5               

      ((1 + √5) - (1 − √5))/2
      ——————————————————————— =
                √5

      (1 + √5) - (1 − √5)   
      ——————————————————— = 
              2√5           

      1 + √5 - 1 + √5   
      ——————————————— = 
            2√5         

      2√5
      ——— = 1
      2√5              
      ```
      it's not necessary but we can also prove for ```n = 2```.
      ```
      ϕ² − ψ²   
      ——————— = 
        √5      

      ((1 + √5)/2)² - ((1 − √5)/2)²  
      ————————————————————————————— =
                  √5                
                  
      ((1 + √5)/2 - (1 − √5)/2)²  
      —————————————————————————— =
                √5                

      (((1 + √5) - (1 − √5))/2)²  
      —————————————————————————— =
                √5                
                
      ((1 + √5) - (1 − √5))²/4  
      —————————————————————————— =
                √5                

      (1 + √5)² - (1 − √5)²   
      ————————————————————— = 
                4√5           

      (1 + √5)(1 + √5) - (1 − √5)(1 − √5)
      ——————————————————————————————————— = 
                      4√5                              

      (1 + √5 + √5 + 5) - (1 - √5 - √5 + 5)   
      ————————————————————————————————————— = 
                      4√5                    

      1 + √5 + √5 + 5 - 1 + √5 + √5 - 5   
      —————————————————————————————————— =
                    4√5                  
      4√5
      ——— = 1
      4√5                                        
      ```
      Let's finally prove the equation for the recursive case
      ```
      ϕⁿ − ψⁿ   ϕⁿ⁻¹ − ψⁿ⁻¹   ϕⁿ⁻² − ψⁿ⁻²
      ——————— = ——————————— + ——————————— =>
        √5           √5            √5    

      ϕⁿ − ψⁿ = ϕⁿ⁻¹ − ψⁿ⁻¹ + ϕⁿ⁻² − ψⁿ⁻² =>

      from here by induction

      ϕⁿ⁻¹ − ψⁿ⁻¹ + ϕⁿ⁻² − ψⁿ⁻² =

      ϕⁿ   ψⁿ   ϕⁿ   ψⁿ  
      —— - —— + —— - —— =
      ϕ    ψ    ϕ²   ψ²  

        1       1        1       1             
      ϕⁿ(—) + ϕⁿ(——) - ψⁿ(—) - ψⁿ(——) =
        ϕ       ϕ²       ψ       ψ²    

        1   1        1   1             
      ϕⁿ(— + ——) - ψⁿ(— + ——) =
        ϕ   ϕ²       ψ   ψ²    

      we can substitute the denominators with corresponding definitions of ϕ and ψ

              1             1                  1             1             
      ϕⁿ(—————————— + —————————————) - ψⁿ(—————————— + —————————————) =
        (1 + √5)/2   ((1 + √5)/2)²       (1 - √5)/2   ((1 - √5)/2)²    

            1             1                  1           1             
      ϕⁿ(—————————— + ———————————) - ψⁿ(—————————— + ———————————) =
        (1 + √5)/2   (1 + √5)²/4       (1 - √5)/2   (1 - √5)²/4    

            2           4              2           4             
      ϕⁿ(———————— + —————————) - ψⁿ(———————— + —————————) =
        (1 + √5)   (1 + √5)²       (1 - √5)   (1 - √5)²    

        2(1 + √5)       4           2(1 - √5)       4             
      ϕⁿ(————————— + —————————) - ψⁿ(————————— + —————————) =
        (1 + √5)²   (1 + √5)²       (1 - √5)²   (1 - √5)²

        2(1 + √5) + 4       2(1 - √5) + 4             
      ϕⁿ(—————————————) - ψⁿ(—————————————) =
          (1 + √5)²          (1 - √5)²

        2 + 2√5 + 4       2 - 2√5 + 4
      ϕⁿ(———————————) - ψⁿ(———————————) =
          (1 + √5)²         (1 - √5)²      

          6 + 2√5         6 - 2√5 
      ϕⁿ(—————————) - ψⁿ(—————————) =
        (1 + √5)²       (1 - √5)²      

              6 + 2√5                6 - 2√5 
      ϕⁿ(————————————————) - ψⁿ(————————————————) =
        (1 + √5)(1 + √5)       (1 - √5)(1 - √5)

            6 + 2√5                  6 - 2√5 
      ϕⁿ(—————————————————) - ψⁿ(——————————————————) =
        1 + √5 + √5 + √5²        1 - √5 - √5 - √5²

            6 + 2√5               6 - 2√5 
      ϕⁿ(———————————————) - ψⁿ(———————————————) =
        1 + √5 + √5 + 5       1 - √5 - √5 + 5

        6 + 2√5       6 - 2√5 
      ϕⁿ(———————) - ψⁿ(———————) =
        6 + 2√5       6 - 2√5

      ϕⁿ1 - ψⁿ1 =

      ϕⁿ - ψⁿ
      ```
      With this, we prove that ```Fib(n) = (ϕⁿ − ψⁿ)/√5``` by Fibonacci definition.

      Next, we have to prove that ```Fib(n)``` is the closest integer to ```ϕⁿ/√5```. And so
      ```
              ϕⁿ − ψⁿ
      Fib(n) = ——————— =>
                  √5  

              ϕⁿ   ψⁿ
      Fib(n) = —— − —— =>
              √5   √5  

              ψⁿ   ϕⁿ 
      Fib(n) + —— = ——
              √5   √5   
      ```
      if ```Fib(n)``` is the closest integer to ```ϕⁿ/√5``` we can say ```ψⁿ/√5 < 1/2``` which leads to
      ```
      ψⁿ   1
      —— < — =>
      √5   2

      ((1 - √5)/2)ⁿ   1
      ————————————— < — =>
            √5        2

      ≈(-0.618)ⁿ   1
      —————————— < —
          √5       2
      ```
      if ```n``` is number ```abs(n)``` function will return absolute value of ```n```
      ```
      abs(≈(-0.618)ⁿ) < abs(1)   1
      ———————————————————————— < — =>
              √5 > 2            2

      1-   1
      —— < —
      2+   2
      ```
      which leads to the final proof that ```Fib(n)``` is the closest integer to ```ϕⁿ/√5```.
