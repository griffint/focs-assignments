#lang racket

;;; Student Name: Griffin Tschurwald[change to your name]
;;;
;;; Check one:
;;; [x] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___


;; calculator code from previous homework

(define (my-assq key assqlist)
  (if (null? assqlist)
      #f
      (if (eq? key (first (first assqlist)))
          (first assqlist)
          (my-assq key (rest assqlist))
          )
      )
  )

(define operator-list ;; list of operators for assq to find
  (list (list 'ADD +)
        (list 'SUB -)
        (list 'MUL *)
        (list 'DIV /)
        (list 'GT >)
        (list 'LT <)
        (list 'GE >=)
        (list 'LE <=)
        (list 'EQ =)
        (list 'NEQ (lambda (x y) (not (= x y))))
        (list 'ANND (lambda (x y) (and x y)))
        (list 'ORR (lambda (x y) (or x y)))
        (list 'NOTT not))
)

            
(define (calculate x lookup-list) ;; we're assuming the input is properly formatted
  (cond ((number? x) x) ;;if x is a number just return it, this is for recursion
      ((assq x lookup-list) (second (assq x lookup-list))) ;; look up our x in our list right off the bat
      ((eq? (first x) 'IPH) (if (calculate (second x)) (calculate (third x)) (calculate (fourth x)))) ;; check if first symbol is IPH for special case
      ((eq? (first x) 'evaluate) (assq (second x) (third x))) ;; lookup whatever's in the list with this keyword
      ((eq? (first x) 'lambda) (lambda (second x) (third x)))
      ((eq? (first x) 'define) (repl (cons (list (second x) (third x)) lookup-list)))
      ((assq (first x) operator-list) ;; if first element of x is in our operator list
        ((second (assq (first x) operator-list)) ;; we're going to find that val, which is an oeprator
         (calculate (second x) lookup-list) ;; and run calculate on the second....
         (calculate (third x) lookup-list) ;; and third values
         )
        )
      ((list? (first x))  ;; this means we have one of those weird lambda thingys
       ;; need to assign the lambda args to the values, then evaluate lambda body
       (calculate '(define (first (second (first x)))) lookup-list)
       (calculate '(define (second (second (first x)))) lookup-list)
       (calculate (third (first x)) lookup-list)
       )
      (else  (display "error please fix ur inputs"))
    )
  )
      
;; need run-repl to call (calculate x)
(define (run-repl)
  (display "welcome to my repl.  type some scheme-ish")
  (repl operator-list)
  )

(define (repl lookup-list)
  (display "> ")
  (display (calculate (read) lookup-list))
  (newline)
  (repl lookup-list))

(define (myeval sexpr)
  sexpr)