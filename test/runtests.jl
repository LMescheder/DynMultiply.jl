using DynMultiply
using Base.Test

# first test set
A = rand(1000, 1000)
B = rand(1000, 1000)
v = rand(1000)

@test dynmultiply(A, B, v) ≈ A * B * v
@test dynmultiplystr(A, B, v) == "(A1*(A2*A3))"
@test dynmultiply_plan(A, B, v).data == [0,0,0,1,1,1]

# second test set
A = rand(1000, 1)
B = rand(1, 1000)
C = rand(1000, 50)
D = rand(50, 1)

@test dynmultiply(A, B, C, D) ≈ A * B * C * D
@test dynmultiplystr(A, B, C, D) == "(A1*((A2*A3)*A4))"
@test dynmultiply_plan(A, B, C, D).data == [0,0,0,0,1,1,1,1,2,1]
