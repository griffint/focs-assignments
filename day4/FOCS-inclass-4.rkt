#lang racket
;; FOCS in class 4

(define ( list-length input_list )
  (if (null? input_list)
      0
      (+ 1 (list-length (rest input_list)))
      )
  )

(display (list-length '(a b c)))

(define (count-evens input_list)
  (if (null? input_list)
      0
      (if (even? (first input_list))
          (+ 1 list-length (rest input_list))
          (list-length (rest input_list))
          )
      )
  )

(newline)
(display (count-evens '(1 2 3 4)))

(define (list-square input_list)
  