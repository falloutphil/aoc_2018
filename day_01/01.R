#!/usr/bin/env Rscript

freqs <-read.table("input.txt")$V1
print(sum(freqs))

first_digit <- freqs[1]
freqs_len <- length(freqs)
hash = new.env(hash = TRUE, parent = emptyenv())
i <- 1
cs <- freqs[1]
repeat {
    k <- as.character(cs)
    if (!is.null(hash[[k]])) {
        print(cs)
        break
    }
    hash[[k]] <- TRUE
    i <- i + 1
    if (i > freqs_len)
        i <- 1
    cs <- cs + freqs[i]
}
