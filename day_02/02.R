#!/usr/bin/env Rscript

# Runs in 0.24s

# lines split into vector of chars
lines <- strsplit(read.table("input.txt", stringsAsFactors = FALSE)$V1, "")

# table will automatically tally, as.vector will get only the counts
counts <- lapply(lines, function(line) as.vector(table(unlist(line, use.names=FALSE))))
twos <- lapply(counts, function(c) 2 %in% c)
threes <- lapply(counts, function(c) 3 %in% c)

# unlist nested counts and count the TRUEs
sum(unlist(threes)) * sum(unlist(twos))
