# DynMultiply

[![Build Status](https://travis-ci.org/LMescheder/DynMultiply.jl.svg?branch=master)](https://travis-ci.org/LMescheder/DynMultiply.jl)

## Introduction
This package includes a simple algorithm that selects the best multiplication order of matrices depending on their shape.

## Usage
```
using DynMultiply
A = rand(1000, 100)
B = rand(100, 10)
C = rand(10, 10000)
D = rand(10000, 100)

println("Standard multiplication:")
@time M1 = A * B * C * D;

println("Dynamic method:")
@time M2 = dynmultiply(A, B, C, D);

println("Relative error: ", maximum(abs(M2 - M1))/maximum(abs(M1)))
println("Multiplication order: ", dynmultiplystr(arrays...))
```
Output:
```
Dynamic method:
  0.005726 seconds (15 allocations: 867.906 KB)
Standard multiplication:
  0.145828 seconds (13 allocations: 77.134 MB, 33.59% gc time)
Relative error: 9.402683663711557e-16
Multiplication order: ((A1*A2)*(A3*A4))
```