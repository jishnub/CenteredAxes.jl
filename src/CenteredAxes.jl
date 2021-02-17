module CenteredAxes
export Centered

"""
	Centered

Given an array axis of length `N`, return `-N÷2:N÷2-1` for even `N` and `-N÷2:N÷2` for odd `N`. 
This may be used to construct or shift an axis of an `OffsetArray`.

# Examples
```julia
julia> A = Float64.(reshape(1:9, 3, 3))
3×3 Array{Float64,2}:
 1.0  4.0  7.0
 2.0  5.0  8.0
 3.0  6.0  9.0

julia> OffsetArray(A, Centered(), Centered())
3×3 OffsetArray(::Array{Float64,2}, -1:1, -1:1) with eltype Float64 with indices -1:1×-1:1:
 1.0  4.0  7.0
 2.0  5.0  8.0
 3.0  6.0  9.0

julia> OffsetArray(A, Centered(), :)
3×3 OffsetArray(::Array{Float64,2}, -1:1, 1:3) with eltype Float64 with indices -1:1×1:3:
 1.0  4.0  7.0
 2.0  5.0  8.0
 3.0  6.0  9.0

julia> A = Float64.(reshape(1:4, 2, 2))
2×2 Array{Float64,2}:
 1.0  3.0
 2.0  4.0

julia> OffsetArray(A, Centered(), Centered())
2×2 OffsetArray(::Array{Float64,2}, -1:0, -1:0) with eltype Float64 with indices -1:0×-1:0:
 1.0  3.0
 2.0  4.0
```
"""
struct Centered end

@inline function Base.to_indices(A, ax::Tuple{Any, Vararg{Any}}, I::Tuple{Centered, Vararg{Any}})
	ax1 = first(ax)
	Lby2 = length(ax1)÷2
	axc = -Lby2:length(ax1) - Lby2 - 1
	(axc, to_indices(A, Base.tail(ax), Base.tail(I))...)
end

end
