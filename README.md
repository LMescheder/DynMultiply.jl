# DynMultiply

[![Build Status](https://travis-ci.org/LMescheder/DynMultiply.jl.svg?branch=master)](https://travis-ci.org/LMescheder/DynMultiply.jl)
[![Coverage Status](https://coveralls.io/repos/github/LMescheder/DynMultiply.jl/badge.svg?branch=master)](https://coveralls.io/github/LMescheder/DynMultiply.jl?branch=master)

## Introduction
This package includes a simple algorithm that selects the best multiplication order of matrices depending on their shape.

## Usage
```julia
using DynMultiply, Benchmarks
A = rand(1000, 100)
B = rand(100, 10)
C = rand(10, 10000)
D = rand(10000, 100)

# Standard multiplication
M1 = A * B * C * D;

# Dynamic method
M2 = dynmultiply(A, B, C, D);

println("Relative error: ", maximum(abs(M2 - M1))/maximum(abs(M1)))
println("Multiplication order: ", dynmultiplystr(A, B, C, D))
```
Output:
```
Relative error: 9.402683663711557e-16
Multiplication order: ((A1*A2)*(A3*A4))
```
Benchmarking the two methods, we get
```julia
test_standard(Ms...) = *(Ms...)
test_dynamic(Ms...) = dynmultiply(Ms...)
julia> @benchmark test_standard(A,B,C,D)
================ Benchmark Results ========================
     Time per evaluation: 99.43 ms [96.03 ms, 102.83 ms]
Proportion of time in GC: 1.10% [1.04%, 1.16%]
        Memory allocated: 77.13 mb
   Number of allocations: 9 allocations
       Number of samples: 90
   Number of evaluations: 90
 Time spent benchmarking: 9.36 s


julia> @benchmark test_dynamic(A,B,C,D)
================ Benchmark Results ========================
     Time per evaluation: 4.91 ms [4.34 ms, 5.48 ms]
Proportion of time in GC: 0.35% [0.00%, 1.57%]
        Memory allocated: 867.98 kb
   Number of allocations: 13 allocations
       Number of samples: 100
   Number of evaluations: 100
 Time spent benchmarking: 0.78 s

```

With an example where all dimensions are the same, we see that `dynmultiply` is
not cursed by overhead.

```julia
E = rand(100, 100)
F = rand(100, 100)
G = rand(100, 100)
H = rand(100, 100)

julia> @benchmark test_standard(E, F, G, H)
================ Benchmark Results ========================
     Time per evaluation: 247.50 μs [186.76 μs, 308.23 μs]
Proportion of time in GC: 0.80% [0.00%, 5.59%]
        Memory allocated: 234.70 kb
   Number of allocations: 9 allocations
       Number of samples: 100
   Number of evaluations: 100
 Time spent benchmarking: 0.29 s

julia> @benchmark test_dynamic(E, F, G, H)
================ Benchmark Results ========================
     Time per evaluation: 239.13 μs [172.40 μs, 305.86 μs]
Proportion of time in GC: 0.79% [0.00%, 5.50%]
        Memory allocated: 235.13 kb
   Number of allocations: 14 allocations
       Number of samples: 100
   Number of evaluations: 100
 Time spent benchmarking: 0.29 s
```
