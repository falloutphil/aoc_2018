#!/usr/bin/env hy
(import [collections [Counter]])
(import [itertools :as it])

;ids with exactly 2 repeated letters, then exactly 3 repeated letters
(setv lines (-> "input.txt" open .read .splitlines))
(setv threes 0)
(setv twos 0)

; Runs in ~0.10s
; Almost all the cost of running was implicit
; import of collections and inc from hy.core.language.
; Replacing inc with (+ x 1) and explicitly referencing combination
; via the itertools library stops the silent importing kicking in
; and removes 75% of runtime cost.
; This is only an issue because the script is so short/fast
; in the first place.

(for [line lines]
  (setv counts (-> line Counter .values))
  (if (in 3 counts) (setv threes (+ threes 1)))
  (if (in 2 counts) (setv twos (+ twos 1))))

(print (* twos threes))

(for [pair (it.combinations lines 2)]
  ; compare each combination character by character
  ; count mismatches and branch when exactly 1
  (if (= (.count (lfor (, c1 c2) (zip #* pair) (= c1 c2)) False)
         1)
      ; Print out without the mismatching char
      (as-> (lfor (, c1 c2) (zip #* pair) :if (= c1 c2) c1) it
            (.join "" it)
            (print it)
            (break))))
