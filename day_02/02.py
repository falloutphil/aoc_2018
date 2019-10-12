#!/usr/bin/env python3
from collections import Counter
from itertools import combinations


#ids with exactly 2 repeated letters, then exactly 3 repeated letters
lines = open('input.txt').read().split('\n')
threes, twos = 0, 0
for line in lines:
    # Would be more efficient if
    # the counter short-circuits on
    # finding both 3s and 2s
    c = Counter(line)
    counts = dict(c.most_common()).values()
    if 3 in counts:
        threes +=1
    if 2 in counts:
        twos += 1

print(twos*threes)

for pair in combinations(lines, 2):
    if [c1 == c2 for c1, c2 in zip(*pair)].count(False) == 1:
        print(''.join([ c1 for c1, c2 in zip(*pair) if c1==c2 ]))
        break
