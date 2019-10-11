#!/usr/bin/env python3

freqs = [int(i) for i in open('input.txt')]
print(sum(freqs))

from itertools import cycle, accumulate
from collections import Counter
c = Counter()
for i in accumulate(cycle(freqs)):
    if c[i] > 0:
        print(i)
        break
    c[i] += 1
