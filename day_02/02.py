#!/usr/bin/env python3
from collections import Counter
from itertools import combinations

# Runs in 0.05s

#ids with exactly 2 repeated letters, then exactly 3 repeated letters
lines = open('input.txt').read().splitlines()
threes, twos = 0, 0
for line in lines:
    # Would be more efficient if
    # the counter short-circuits on
    # finding both 3s and 2s
    counts = Counter(line).values()
    if 3 in counts:
        threes +=1
    if 2 in counts:
        twos += 1

print(twos*threes)

for pair in combinations(lines, 2):
    # compare each combination character by character
    # count mismatches and branch when exactly 1
    if [c1 == c2 for c1, c2 in zip(*pair)].count(False) == 1:
        # Print out without the mismatching char
        print(''.join([ c1 for c1, c2 in zip(*pair) if c1==c2 ]))
        break
