#lang racket

;;; Student Name: Griffin Tshcurwald [change to your name]
;;;
;;; Check one:
;;; [x] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;;     NOTE:  You need not worry about error checking in the programs below.

;; 1.  WRITE SQUARE:  given n, returns n^2.  Hint:  use *
(define (square x)
  (* x x))
  
(display (square 2)) (newline)  ;; -> 4

;; 2.  WRITE is-right-triangle:  given three numbers, returns true iff the third
;;     could be the hypotenuse of a right triangle with the specified three side lengths
;;     Hint:  use = to compare numeric values

(define (is-right-triangle a b c)
  (= (+ (* a a) (* b b)) (* c c)))
      
  
(display (is-right-triangle 3 4 5)) (newline)  ;; -> #t
(display (is-right-triangle 4 5 6)) (newline)  ;; -> #f

;; 3.  WRITE FACTORIAL:  given n, returns n!
;;     Hint:  recursion is your friend
(define (fact n)
  (if (= n 1)
      n
      (* n (fact (- n 1)))
      )
  )

(display (fact 1)) (newline) ;; -> 1
(display (fact 2)) (newline) ;; -> 1

;; 4.  WRITE FIBONACCI:  given n, returns the nth fibonacci number as shown below
;;     Hint:  don't run this on really big numbers!
(define (fib n)
  (if (<= n 2)
      1
      (+ (fib (- n 1)) (fib (- n 2))))
   )

(display (fib 1)) (newline) ;; -> 1
(display (fib 2)) (newline) ;; -> 1
(display (fib 3)) (newline) ;; -> 2
(display (fib 4)) (newline) ;; -> 3
(display (fib 5)) (newline) ;; -> 5
(display (fib 6)) (newline) ;; -> 8

;; 5.  WRITE a procedure that takes a list of numbers and returns the sum of those numbers
;;     Hint:  first, rest, cons
(define (sum lst)
  (if
   (null? lst)
   0
   (+ (first lst) (sum (rest lst))))
  )

(display (sum '(1 2 3 4))) (newline) ;; -> 10
(display (sum '(1 20 300))) (newline) ;; -> 321

;; 6.  WRITE a procedure that takes a list of numbers and returns the largest one.
;;     While there are solutions using scheme's built-in max, we were actually hoping you'd do something else...
(define (my-max lst) ;; weird scheme version of bubble sort
  (if (null? (rest lst)) ;; if only one element, we have our max
      (first lst)
      (my-max (if (< (first lst) (first (rest lst))) ;;if the first element is less than the second
          (rest lst) ;;keep going with everything but that first element
          (append (list (first lst)) (rest (rest lst)));; otherwise append the first to the rest of the rest, get rid of 2nd
      ))
   )
  )

(display (my-max '(1 10 2 20 3))) (newline) ;; -> 20
