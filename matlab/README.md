# MATLAB Interface to Leiden

This submodule is a `MATLAB` interface to a software library, in C++
implementation, of algorithm Leiden for community detection, also
known as graph clustering.

## Prerequisites

You need to install `Julia` in order to run this wrapper. You can
download the latest version of `Julia` from [this link](https://julialang.org/downloads/).

## One-time setup

We will install the `Julia` packages first, through `Julia`, and then
we will use them via `MATLAB`.

Once in `Julia`, activate this directory

``` julia
julia> using Pkg
julia> Pkg.activate( "<PATH-TO-THIS-DIRECTORY-ON-YOUR-MACHINE>" )
```

Then, install the required packages

``` julia
julia> Pkg.add( ["SparseArrays", "LinearAlgebra"] )
julia> Pkg.add( url = "https://github.com/fcdimitr/igraph_jll.jl" )
julia> Pkg.add( url = "https://github.com/fcdimitr/leiden_jll.jl" )
julia> Pkg.add( url = "https://github.com/pitsianis/Leiden.jl" )
```

Once this is done, exit `Julia`.

## MATLAB interface

From within `MATLAB`, navigate to this directory and issue

``` matlab
juliaInit()
```

*You need to do this once everytime you start MATLAB*

Then you call `Leiden`, for example:

``` matlab
A = sprand( 10, 10, 0.2 );
cid = leiden( A );
```

The result `cid` is the vector of membership IDs for each vertex.
