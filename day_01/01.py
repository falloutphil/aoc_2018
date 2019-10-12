#!/usr/bin/env python3
from itertools import cycle, accumulate
from collections import Counter

freqs = [int(i) for i in open('input.txt')]
print(sum(freqs))

c = Counter()
for i in accumulate(cycle(freqs)):
    if c[i] > 0:
        print(i)
        break
    c[i] += 1
