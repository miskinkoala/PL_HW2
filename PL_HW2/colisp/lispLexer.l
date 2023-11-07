#| 
(format t "~%#################### CONST AND VAR DECS START HERE ######################~%~%")
|#


(defparameter *keywords* (list "and" "or" "not" "equal" "less" "nil" "list" "append"
                            "concat" "set" "def" "for" "if" "exit" "load" "display" "true" "false"))

(defparameter *operators* (list #\+ #\- #\/ #\* #\( #\) #\,))

(defparameter *TOKEN_keywords* (list "KW_AND" "KW_OR" "KW_ NOT" "KW_EQUAL" "KW_LESS" "KW_NIL" "KW_LIST"
                            "KW_APPEND" "KW_CONCAT" "KW_SET" "KW_DEF" "KW_FOR" "KW_IF"
                                "KW_EXIT" "KW_LOAD" "KW_DISPLAY" "KW_TRUE" "KW_FALSE"))

(defparameter *TOKEN_operator* (list "OP_PLUS" "OP_MINUS" "OP_DIV" "OP_MULT" "OP_OP" "OP_CP" "OP_COMMA"))

(defparameter *word* nil)
(defparameter *input* "")
(defvar *KEYWORD_NUM* 18)
(defvar *OPERATOR_NUM* 7)
(defvar *Flag_ID* 0)
(defparameter *LENGTH_WORD* 0) ; 
;declarations of constant variables here
#| 

(format t "~%#################### FUNCTION DECS START HERE ######################~%~%")

|#


(defun get-input-from-stream (stream);if you'd like test with a file use this function
  (let ((input (read-line stream nil)))
    (if input
        (progn
          (setf *word* input)
          (format t "You entered: ~a~%" *word*))
        (format t "End of file reached.~%"))))

(defun read-from-file (filename)
  (with-open-file (stream filename :direction :input)
    (get-input-from-stream stream)))



(defun getUserInput () ;;getting user input functions
  (format t "Enter something: ") 
  (finish-output) 
  (let ((input (read-line))) 
    (setf *word* input))
  (format t "You entered: ~a~%" *word*)) 


(defun isAlphanumericChar (char) ;; check whether character alphanumerical
  (let ((char-code (char-code char)))
    (or (and (>= char-code 65) (<= char-code 90))  ; uppercase
        (and (>= char-code 97) (<= char-code 122)) ; lowercase
        (and (>= char-code 48) (<= char-code 57))  ; numbers
        )))


(defun checkIdentifier (word)
  (let ((first-char (aref word 0)))
    (setq first-char (char-code first-char))
    (cond
      ((or (and (>= first-char 65) (<= first-char 90))  ; uppercase
           (and (>= first-char 97) (<= first-char 122))) ; lowercase
       (progn
         1)) ; return 1 for identifier
      (t
       (progn
         0))))) ; return 0 for non-identifier



(defun isKeyword (str)
  (if (member str *keywords* :test #'string=)
      (format t "KEYWORD: ~a ~a~%" str (nth (position str *keywords* :test #'string=) *TOKEN_keywords*)) ; print the keyword if it is found
    (progn
      (if (every #'digit-char-p str) ;;cheks if it is only digit INTVALUE
        (format t "integer: ~a VALUEINT ~%" str)
      (progn
        (setq *Flag_ID* (checkIdentifier str))
        (if (= *Flag_ID* 1)  
          (format t "IDENTIFIER:~a~%" str)       ; if checkIdentifier returns 1 its identifier
        (progn
          (format t "SYNTAX ERROR: ~a cannot be tokenized~%" str)      ; then if it is not identifier its syntax error
          (quit))))))))

(defun isOperator (chr);checks whether is operator
  (if (member chr *operators* :test #'string=)
      (format t "OPERATOR: ~a ~a ~%" chr (nth (position chr *operators* :test #'string=) *TOKEN_operator*)))) ; Print the keyword if it is found



;(format t "~%#################### PROGRAMM STARS HERE ######################~%~%")

#|
(defvar *filename* "input.txt") ; Specify your input file name here
(read-from-file *filename*) ; Call the function with the specified filename
|#


#| 

      (format t "KEYWORD:~a~%" (nth (position str *keywords*) *TOKEN_keywords*)) ; Print the keyword if it is found

(dotimes (i *Length_word*)
  (format t "Element at index ~a: ~a~%" i (aref *word* i)))

(format t "*words*: ~%")
(format t "The first element of the list is: ~a~%" (aref *word* 0))
(format t "The last element of the list is: ~a~%" (aref *word* (- *Length_word* 1)))


(dotimes (i *Length_word*)
  (format t "Is Element at index ~a: ~a alphanumeric ~a ~%" i (aref *word* i) 
    (isAlphanumericChar (aref *word* i))))

|#
(loop
    (getUserInput)
    (defvar *Length_word* 0)
    (setf *Length_word* (length *word*))
    (dotimes (i *Length_word*)
      (if (isAlphanumericChar (aref *word* i));if its alphanumerical concanets to empty buffer
          (progn    
          (setq *input* (concatenate 'string *input* (string (aref *word* i))))
          );else checks when complete word finds operator keyword identifier
          (progn
            (if (> (length *input*) 0)
              (progn
                (isKeyword *input*))
            )
                (if (and (< (+ i 1) *Length_word*)
                      (char= (aref *word* i) #\;)
                      (char= (aref *word* (+ i 1)) #\;))
                (progn  
                  (format t "COMMENT: ~%")
                  (quit)))
                (isOperator (aref *word* i))
            (setq *input* "")))) 

    (if (> (length *input*) 0) (isKeyword *input*))
    (setq *input* "")
)



#|
GETS WRONG WHEN YOU ENTER SPECİAL CHARATCER:

$aa

VALUEF HAVENT IMPLEMENTED:
34b65

FILE AS INPUT HAVENT IMPLEMENTED:
input.txt

COMMENT IMPLEMENTATION SHOULD BE MODIFY:
;; soner TERMINATES IMMEDTIATLY

 |#






