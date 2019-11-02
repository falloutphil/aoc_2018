#!emacs --script

;; Runs in ~0.09 secs

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
    ;; 2a
    (dolist (line lines)
      (mapc (lambda (key) (puthash key (+ (gethash key myhash 0) 1) myhash)) line)
      (let ((vals '()))
        (maphash (lambda (_ v) (push v vals)) myhash)
        (when (member 2 vals) (setq twos (+ twos 1)))
        (when (member 3 vals) (setq threes (+ threes 1)))
        (clrhash myhash)))
    (print (* twos threes))
    ;; 2b
    (let ((result (catch 'break
                    (dolist (line (combinations lines))
                      (let ((l1 (car line))
                            (l2 (cdr line)))
                        ;; 'and' is a macro so use 'every'
                        (if (every 'identity ; check for no further mismatches in chop
                                   (cdr (memq nil (mapcar* 'eq l1 l2)))) ; chop at first mismatch
                            (throw 'break line))))))) ; found it! break out and return 2 lines
      (print (cl-loop for l1 across (car result)
                      for l2 across (cdr result)
                      when (eq l1 l2)
                      concat (string l1))))))
