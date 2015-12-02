module DynMultiply

export dynmultiply, dynmultiply_plan, dynmultiplystr

import Base.getindex, Base.setindex!

type DynMultTable
    data::Array{Int64, 1}
    N::Int64
    DynMultTable(N) = new(zeros(Int64, div(N*(N+1), 2)), N)
end

function getdataindex(table::DynMultTable, s::Int64, l::Int64)
    return (l-1)*table.N - div((l-1)*(l-2), 2) + s
end

function getindex(table::DynMultTable, s::Int64, l::Int64)
    return table.data[getdataindex(table, s, l)]
end

function setindex!(table::DynMultTable, val::Int64, s::Int64, l::Int64)
    table.data[getdataindex(table, s, l)] = val
end

function multiplycost(arrays, s::Int64, j::Int64, f::Int64)
    size(arrays[s], 1) * size(arrays[j], 1) * size(arrays[f-1], 2)
end

function dynmultiply_plan(arrays...)
    N = length(arrays)
    costs = DynMultTable(N)
    plan = DynMultTable(N)
    for s=1:N
        costs[s, 1] = 0
    end

    # calculate costs and subsequence lengths
    for l= 2:N # sequence length
        for s=1:N-l+1 # start index
            mincost = typemax(Int64)
            l1opt = 0
            for l1=1:l-1    # first sequence length
                multcost = multiplycost(arrays, s, s+l1, s+l)
                cost = costs[s, l1] + costs[s+l1, l-l1] + multcost

                if cost < mincost
                    mincost = cost
                    l1opt = l1
                end
            end

            costs[s, l] = mincost
            plan[s, l] = l1opt
        end
    end

    return plan
end

function dynmultiply(arrays...)
    plan = dynmultiply_plan(arrays...)
    N = length(arrays)
    return dynmultiply_part(arrays, 1, N, plan)
end

function dynmultiply_part(arrays, s::Int64, l::Int64, plan)
    if l == 1
        return arrays[s]
    else
        l1 = plan[s, l]
        return dynmultiply_part(arrays, s, l1, plan) * dynmultiply_part(arrays, s+l1, l-l1, plan)
    end
end

function dynmultiplystr(arrays...)
    plan = dynmultiply_plan(arrays...)
    N = length(arrays)
    return dynmultiplystr_part(1, N, plan)
end

function dynmultiplystr_part(s::Int64, l::Int64, plan)
    if l == 1
        return "A$s"
    else
        l1 = plan[s, l]
        return "(" * dynmultiplystr_part(s, l1, plan) * "*" * dynmultiplystr_part(s+l1, l-l1, plan) * ")"
    end
end

end
