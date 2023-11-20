## Copyright (C) 2023  Roel Janssen <roel@gnu.org>

## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.

## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.

## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

set.seed (123456789)
numbers_1 <- runif(1000000) * 100
numbers_2 <- numbers_1

object.size(numbers_2)

## ------------------------------------------------------------------------
## Our test functions
## ------------------------------------------------------------------------

simple_call_1 <- function (number) { return (number * number) }
sapply(numbers_1, simple_call_1)

simple_call_2 <- function (numbers) {
    for (index in 1:length(numbers)) {
        numbers[index] <- numbers[index] * numbers[index]
    }
    return (numbers)
}

## ------------------------------------------------------------------------
## Space and time analysis
## ------------------------------------------------------------------------


library(bench)
res_sapply <- bench::mark(numbers_3 <- sapply(numbers_1, simple_call_1))
res_for <- bench::mark(numbers_4 <- simple_call_2 (numbers_2))

res_sapply
res_for


## ------------------------------------------------------------------------
## Statistical function profiler
## ------------------------------------------------------------------------

Rprof("simple_call_1.out")
numbers_3 <- sapply(numbers_1, simple_call_1)
Rprof("simple_call_2.out")
numbers_4 <- simple_call_2 (numbers_2)
Rprof(NULL)

head(summaryRprof("simple_call_1.out")[["by.total"]])
head(summaryRprof("simple_call_2.out")[["by.total"]])


## ------------------------------------------------------------------------
## Memory profiling
## ------------------------------------------------------------------------

library(profmem)
capabilities("profmem") # Check if your R can do memory profiling

options(profmem.threshold = 0)
mem_details_sapply <- profmem({ numbers_3 <- sapply(numbers_1, simple_call_1) })
mem_details_for    <- profmem({ numbers_4 <- simple_call_2 (numbers_2) })

mem_details_sapply
mem_details_for

object.size(numbers_3)

## ------------------------------------------------------------------------
## Proof / debug
## ------------------------------------------------------------------------

numbers_1[1:10]
numbers_2[1:10]
numbers_3[1:10]
numbers_4[1:10]
