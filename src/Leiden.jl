module Leiden

using SparseArrays, LinearAlgebra, Libdl

export leiden

# Write your package code here.
const PROJECT_ROOT = pkgdir(@__MODULE__)
leiden_lib = joinpath(PROJECT_ROOT, "libleiden.$(Libdl.dlext)")

include("libleiden.jl")

end
