#!/usr/bin/env python3
from collections import Counter

#ids with exactly 2 repeated letters, then exactly 3 repeated letters
lines = open('input.txt').read().split('\n')
threes, twos = 0, 0
for line in lines:
    c = Counter(line)
    counts = dict(c.most_common()).values()
    if 3 in counts:
        threes +=1
    if 2 in counts:
        twos += 1

print(twos*threes)
