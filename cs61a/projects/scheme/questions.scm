(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

;; Problem 15
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 15
  (define (helper x)
    (if (null? x) 
        () 
        (append (cons(cons (- (length s) (length x)) (cons (car x) nil)) nil) 
                (helper (cdr x)))))
    (helper s)
  )
  ; END PROBLEM 15

;; Problem 16

;; Merge two lists LIST1 and LIST2 according to ORDERED? and return
;; the merged lists.
(define (merge ordered? list1 list2)
  ; BEGIN PROBLEM 16
  (Cond
      ((or (null? list1 ) 
           (null? list2)) 
      (if (null? list1) list2 list1))
      ((ordered? (car list1) (car list2)) (append (cons (car list1) nil) (merge ordered? (cdr list1) list2)))
      ((= (car list1) (car list2)) 
          (append (cons (car list1) nil) (merge ordered? (cdr list1) (cdr list2))))
      (else (append (cons (car list2) nil) (merge ordered? (cdr list2) list1))))
  )
  ; END PROBLEM 16

;; Optional Problem 2

;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN OPTIONAL PROBLEM 2
         expr
         ; END OPTIONAL PROBLEM 2
         )
        ((quoted? expr)
         ; BEGIN OPTIONAL PROBLEM 2
         expr
         ; END OPTIONAL PROBLEM 2
         )
        ((or (lambda? expr)     
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM 2
           (cons form
                (cons params (let-to-lambda body)) )
           ; END OPTIONAL PROBLEM 2
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN OPTIONAL PROBLEM 2
           (cons (cons 'lambda (cons (car (zip values)) (cons(let-to-lambda (car body)) nil))) (map let-to-lambda (cadr (zip values))))
           ; END OPTIONAL PROBLEM 2
           ))
        (else
         ; BEGIN OPTIONAL PROBLEM 2
         (cons (car expr) (map let-to-lambda (cdr expr)))
         ; END OPTIONAL PROBLEM 2
         )))

; Some utility functions that you may find useful to implement for let-to-lambda

(define (zip pairs)
    (cond
        ((null? pairs) '(() ()))
        ((null? (cdr pairs)) (map (lambda (x) (cons x nil)) (car pairs)))
        ((null? (cdar pairs)) (cons (map car pairs) nil))
        (else (cons (map car pairs) (zip (map cdr pairs))))
    )
 )

