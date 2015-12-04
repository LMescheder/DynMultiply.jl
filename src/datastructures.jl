# Stack
type{T} FixedSizeStack
    data::Array{T, 1} # entries of the stack
    tos:Int           # top of the stack

    FixedSizedStack(size::Int) = new(Array{T, 1}(size), 0)
end

function push!{T}(stack::FixedSizeStack{T}, element::T)
    stack.tos += 1
    stack.data[stack.tos] = element
end

function pop!(stack::FixedSizeStack)
    stack.tos -= 1
end

top(stack::FixedSizeStack) = top(stack, 0)

function top(stack::FixedSizeStack, offset::Int64)
    stack.data[stack.tos - offset]
end

length(stack::FixedSizeStack) = stack.tos
