#!/usr/bin/env Rscript

freqs <-read.table("input.txt")$V1
print(sum(freqs))

first_digit <- freqs[1]
cs <- cumsum(freqs)
# Inefficient - it works in chunks of size freqs
# where it should sample one-by-one
repeat {
    dups <- duplicated(cs)
    if (any(dups))
        break
    freqs[1] <- first_digit + cs[length(cs)]
    cs <- c(cs, cumsum(freqs))
}
print(cs[dups][1])
