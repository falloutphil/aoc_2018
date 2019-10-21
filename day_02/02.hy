#!/usr/bin/env hy
(import [collections [Counter]])

;ids with exactly 2 repeated letters, then exactly 3 repeated letters
(setv lines (-> "input.txt" open .read .splitlines))
(setv threes 0)
(setv twos 0)

; Runs in 0.43s

(for [line lines]
  (setv counts (-> line Counter .values))
  (if (in 3 counts) (setv threes (inc threes)))
  (if (in 2 counts) (setv twos (inc twos))))

(print (* twos threes))

(for [pair (combinations lines 2)]
  ; compare each combination character by character
  ; count mismatches and branch when exactly 1
  (if (= (.count (lfor (, c1 c2) (zip #* pair) (= c1 c2)) False)
         1)
      ; Print out without the mismatching char
      (as-> (lfor (, c1 c2) (zip #* pair) :if (= c1 c2) c1) it
            (.join "" it)
            (print it)
            (break))))
