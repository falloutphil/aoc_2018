#!emacs --script

;; Runs in ~0.03 secs

(require 'cl)

(defun combinations (l)
  (cl-mapcon (lambda (x)
               (mapcar (lambda (y) (cons (car x) y)) (cdr x))) l))

(with-temp-buffer
  (insert-file-contents "input.txt")
  (let ((lines (split-string (buffer-string) "\n" t))
        (myhash #s(hash-table
                  size 26
                  test equal
                  data ()))
        (twos 0)
        (threes 0))
    (dolist (line lines)
      (mapc (lambda (key) (puthash key (+ (gethash key myhash 0) 1) myhash)) line)
      (let ((vals '()))
        (maphash (lambda (_ v) (push v vals)) myhash)
        (when (member 2 vals) (setq twos (+ twos 1)))
        (when (member 3 vals) (setq threes (+ threes 1)))
        (clrhash myhash)))
    (print (* twos threes))
    (let ((result (catch 'break
                    (dolist (c (combinations lines))
                      (let ((c1 (car c))
                            (c2 (cdr c)))
                        ;; 'and' is a macro so use 'every'
                        (if (every #'identity
                                   (cdr (memq nil (mapcar* #'equal c1 c2)))) ; exactly one nil symbol
                            (throw 'break c)))))))
      (print result))))
