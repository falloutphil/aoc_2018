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
                    (dolist (c (combinations lines))
                      (let ((c1 (car c))
                            (c2 (cdr c)))
                        ;; 'and' is a macro so use 'every'
                        (if (every #'identity ; check for no further mismatches in chop
                                   (cdr (memq nil (mapcar* #'equal c1 c2)))) ; chop at first mismatch
                            (throw 'break c))))))) ; found it! break out and return 2 lines
      (print (concat (mapcar #'car (cl-remove-if-not ; chars go to list of ascii ints, concat returns to string
              (lambda (r) (equal (car r) (cdr r))) ; drop any (one) mismatches between c1 and c2
              (mapcar* #'cons (car result) (cdr result)))))) ; turn (abc.def) to ((a.d) (b.e) (c.f))
      )))
