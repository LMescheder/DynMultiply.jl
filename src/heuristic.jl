# Heuristic Algorithm
#

# The main part
immutable Node
    child1::Int
    child2::Int
end

type TreeMultPlan
    nodes::Array{Node, 1}
    base::Node

    TreeMultPlan(N) = new(Array{Node, 1}(N-3), Node(0, 0))
end

# State of the algorithm
type HeuristicState
    idx::Int
    N::Int
    stack::FixedSizeStack{Tuple{Int, Int}}
    nodecnt::Int
    weights::Array{Int, 1}
    baseidx::Int

    function HeuristicState(weights, idx)
        N = length(weights)
        new(idx, N, FixedSizeStack{Tuple{Int, Int}}(N), N, weights, 0)
    end
end

# Push a vertix
function push!(state::HeuristicState)
    push!(state.stack, (state.idx, state.weights[state.idx]))
    state.idx = 1 + mod(state.idx, state.N)
end

# Pop a vertix
function pop!(state::HeuristicState, plan::TreeMultPlan)
    idx1, w1 = top(state.stack)
    pop!(state.stack)
    idx2, w2 = top(state.stack)
    pop!(state.stack)

    state.nodecnt += 1
    newidx = state.nodecnt

    push!(state.stack, (newidx, w2))

    # Add node
    if idx1 == state.baseidx
        
    elseif idx2 == state.baseidx

    else
        plan.nodes[idxnew - N] =

    end
end

function addnode!(, N, idxnew, idx1, idx2, baseidx)



end

function dynmult_plan_heuristic(arrays...)
    # Number of nodes in polygon
    N = length(arrays)
    # Compute weights, minimum weight and its index
    weights = Array{Int64, 1}(N+1)
    for i=1:N
        weights[i] = size(arrays[i], 1)
    end
    weights[N+1] = size(arrays[N+1], 2)

    w1, idx = findmin(weights)

    # Initialize algorithm
    plan = TreeMultPlan(N)
    state = HeuristicState(weights, idx)
    baseidx = 0

    push!(state)
    push!(state)

    # Run algorithm
    w1 = state.minweight
    while state.idx != state.minidx
        wt = state.stack.top()[1]
        wp = state.stack.top(1)[1])
        wc = state.weights[state.idx]

        if w1 * wc * (wt + wp) < wt * wp * (w1 + wc)
            pop!(state)
            if length(state.stack) <= 2
                push!(state)
            end
        else
            push!(state)
        end
    end

    while length(state.stack) >= 3
        newidx, idx1, idx2 = pop!(state.stack)
        if idx1 ==
        plan.nodes[idx - N] = node
    end

    plan
end
