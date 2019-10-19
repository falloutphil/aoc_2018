#!emacs --script
(require 'seq)

(with-temp-buffer
  (insert-file-contents "input.txt")
  (let ((freqs (mapcar
                'string-to-number
                (split-string (buffer-string) "\n" t))))
    (print (apply '+ freqs))

    ))
