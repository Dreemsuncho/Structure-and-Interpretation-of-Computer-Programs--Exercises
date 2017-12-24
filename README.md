# Structure-and-Interpretation-of-Computer-Programs-SICP-Second-Edition-Exercises
This repository contains entire set (in future should fill all missing submissions) of exercises from SCIP MIT book:


### Building Abstractions with Procedures
 #### The Elements of Programming
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
    
  * __Exercise 1.2.__ Translate the following expression into prefix form:
    ```
  	(5 + 4 + (2 - (3 - (6 + (4 / 5))))) / (3 * (6 - 2) * (2 - 7))
    ```
    
  * __Exercise 1.3.__  Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
     
  * __Exercise 1.4.__  Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:
    ```scheme
    (define (a-plus-abs-b a b)  
    ((if (> b 0) + -) a b))
    ```
    
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
  
  * __Exercise 1.6.__  Alyssa P. Hacker doesn’t see why if needs to be provided as a special form. ‘‘Why can’t I just define it as an ordinary procedure in terms of cond?’’ she asks. Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if:
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
    
  * __Exercise 1.7.__  The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?
    
  * __Exercise 1.8.__  Newton’s method for cube roots is based on the fact that if y is an approximation to the cube root of x, then a better approximation is given by the value
    ```
    x / y² + 2y
    ———————————
         3
    ```
	Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In section 1.3.4 we will see how to implement Newton’s method in general as an abstraction of these square-root and cube-root procedures.)

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
  
  * __Exercise 1.11.__  A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a procedure that computes f by means of a recursive process. Write a procedure that computes f by means of an iterative process.

  * __Exercise 1.12.__  The following pattern of numbers is called Pascal’s triangle.
    ```
        1
       1 1
      1 2 1
     1 3 3 1
    1 4 6 4 1
    ```
    The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it.35 Write a procedure that computes elements of Pascal’s triangle by means of a recursive process. 

