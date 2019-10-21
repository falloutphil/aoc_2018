#!/usr/bin/env hy
(import [collections [Counter]])

; Runs in ~0.19s

(setv freqs (lfor i (open "input.txt") (int i)))
(-> freqs sum print)

(setv c (Counter))

(for [i (-> freqs cycle accumulate)]
  (if (get c i)
      (do
        (print i)
        (break)))
  (assoc c i True))
