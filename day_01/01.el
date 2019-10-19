#!emacs --script
(require 'seq)

(with-temp-buffer
  (insert-file-contents "input.txt")
  (print (seq-reduce
          (lambda (x y) (+ x (string-to-number y)))
          (split-string (buffer-string) "\n" t) 0)))
