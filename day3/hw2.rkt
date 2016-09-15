#lang racket

;;; Student Name: Griffin Tschurwald [change to your name]
;;;
;;; Check one:
;;; [ ] I completed this assignment without assistance or external resources.
;;; [X] I completed this assignment with assistance from ___
;;;     and/or using these external resources: Racket Documentation

;;; 1.  Create a calculator that takes one argument: a list that represents an expression.

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
  (if (number? x) ;;if x is a number just return it, this is for recursion
      x
      (if (eq? (first x) 'IPH) ;; check if first symbol is IPH for special case
          (if (calculate (second x))
              (calculate (third x))
              (calculate (fourth x))
              )
          ((calc-find-symbol (first x)) (calculate (second x)) (calculate (third x)))
          )
  )
 )

(calculate '(ADD 3 4)) ;; --> 7
(calculate '(SUB 3 4)) ;; --> -1
(calculate '(MUL 3 4)) ;; --> 12
(calculate '(DIV 3 4)) ;; --> .75

;;; 2. Expand the calculator's operation to allow for arguments that are themselves well-formed arithmetic expressions.

(calculate '(ADD 3 (MUL 4 5))) ;; --> 23   ;; what is the equivalent construction using list?
(calculate '(SUB (ADD 3 4) (MUL 5 6))) ;; --> -23

;;; 3. Add comparators returning booleans (*e.g.*, greater than, less than, …).
;; Note that each of these takes numeric arguments (or expressions that evaluate to produce numeric values),
;; but returns a boolean.  We suggest operators `GT`, `LT`, `GE`, `LE`, `EQ`, `NEQ`.

	(calculate '(GT (ADD 3 4) (MUL 5 6))) ;; --> #f
	(calculate '(LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))) ;; --> #t

;;; 4. Add boolean operations ANND, ORR, NOTT


(calculate '(ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6)))))) ;; --> #f
(calculate '(NOTT (ANND (GT (ADD 3 4) (MUL 5 6)) (LE (ADD 3 (MUL 4 5)) (SUB 0 (SUB (ADD 3 4) (MUL 5 6))))))) ;; --> #t


;;; 5. Add IPH

(calculate '(IPH (GT (ADD 3 4) 7) (ADD 1 2) (ADD 1 3))) ;; -> 4
