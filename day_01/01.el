#!emacs --script

;; Runs in ~0.12 secs

(require 'seq)

(with-temp-buffer
  (insert-file-contents "input.txt")
  (let ((freqs (mapcar
                'string-to-number
                (split-string (buffer-string) "\n" t)))
        (myhash #s(hash-table
                 size 150000
                 test eq ;; keys are ints
                 data ())))
    (print (apply '+ freqs))
    ;; Wrap list back on itself
    (setcdr (last freqs) freqs)
    (setq cs (pop freqs))
    (while (not(gethash cs myhash))
      (puthash cs t myhash)
      (setq cs (+ cs (pop freqs))))
    (print cs)))
