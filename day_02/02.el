#!emacs --script

;; Runs in ~0.03 secs

(defun permutations (bag)
  "Return a list of all the permutations of the input."
  (if (null bag) '(())
    ;; Otherwise, take an element, e, out of the bag.
    ;; Generate all permutations of the remaining elements,
    ;; And add e to the front of each of these.
    ;; Do this for all possible e to generate all permutations.
    (mapcan #'(lambda (e)
                (mapcar (lambda (p) (cons e p))
                        (permutations
                         (remove e bag))))
            bag)))


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
      (mapcar (lambda (key) (puthash key (+ (gethash key myhash 0) 1) myhash)) line)
      (let ((vals '()))
        (maphash (lambda (_ v) (push v vals)) myhash)
        (when (member 2 vals) (setq twos (+ twos 1)))
        (when (member 3 vals) (setq threes (+ threes 1)))
        (clrhash myhash)))
    (print (* twos threes))))


;;(print (permutations '(a b c)))
