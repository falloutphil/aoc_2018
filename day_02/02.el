#!emacs --script

;; Runs in ~0.05 secs

(require 'seq)

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
      (seq-map (lambda (key) (puthash key (+ (gethash key myhash 0) 1) myhash)) line)
      (let ((vals '()))
        (maphash (lambda (_k v) (push v vals)) myhash)
        (when (member 2 vals) (setq twos (+ twos 1)))
        (when (member 3 vals) (setq threes (+ threes 1)))
        (clrhash myhash)))
    (print (* twos threes))))
