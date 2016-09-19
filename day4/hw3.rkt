#lang racket

;;; Student Name: Griffin Tschurwald [change to your name]
;;;
;;; Check one:
;;; [x] I completed this assignment without assistance or external resources.
;;; [ ] I completed this assignment with assistance from ___
;;;     and/or using these external resources: ___

;;;;;;;;;;;
;; 1. assq

;; `assq` is a function that takes a key and an association list.
;;
;; It returns the corresponding key/value pair from the list
;; (*i.e.*, the pair whose key is *eq?* to the one it is given).
;;
;; If the key is not found in the list, `assq` returns `#f`.

(define (my-assq key ass-list)
  (if (null? ass-list)
      #f
      (if (eq? key (first (first ass-list)))
          (first ass-list)
          (my-assq key (rest ass-list))
          )
      )
  )

;; Test to see if it works, should return "(cat 3)"
(display(assq 'cat '((dog 1) (horse 2) (cat 3))))

;;;;;;;;;;;
;; 2. lookup-list

;; Add the ability to look up symbols to your evaluator.
;;
;; Add the `lookup-list` argument to your hw2 evaluator (or ours, from the solution set).
;; `(evaluate 'foo lookup-list)` should return whatever `'foo` is associated with in `lookup-list`.

(define (calc-find-symbol y)
  (cond ((eq? 'ADD y) +)
        ((eq? 'SUB y) -)
        ((eq? 'MUL y) *)
        ((eq? 'DIV y) /)
        ((eq? 'GT y) >)
        ((eq? 'LT y) <)
        ((eq? 'GE y) >=)
        ((eq? 'LE y) <=)
        ((eq? 'EQ y) =)
        ((eq? 'NEQ y) (lambda (x y) (not (eq? x y)))) ;;lambda functions for these, no built in symbols that i know of
        ((eq? 'AND y) (lambda (x y) (and x y)))
        ((eq? 'NOR y) (lambda (x y) (nor x y)))
        ((eq? 'NOT y) (lambda (x y) (not x y)))
        )
  )
            
(define (calculate x)
  (cond ((number? x) x) ;;if x is a number just return it, this is for recursion
      ((eq? (first x) 'IPH) (if (calculate (second x)) (calculate (third x)) (calculate (fourth x)) ) );; check if first symbol is IPH for special case
      ((eq? (first x) 'evaluate) (assq (second x) (third x)))
      (else ((calc-find-symbol (first x)) (calculate (second x)) (calculate (third x))))
  )
 )

(display (calculate '(evaluate cat ( (party 1) (cat 3)))))