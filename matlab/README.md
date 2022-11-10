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

1. From within `MATLAB`, navigate to this directory,

``` matlab
cd <LOCAL-PATH-TO-THIS-DIRECTORY>
```

2. Then, start `Julia` and connect to it via `MATLAB`,

``` matlab
setenv('PATH', getenv('PATH')+"<PATH-TO-JULIA-INSTALLATION>")
juliaInit()
```

The `<PATH-TO-JULIA-INSTALLATION>` should point to the `bin` directory
in the `Julia` installation folder. For example, on `macOS`, the default
installation directory is

``` matlab
setenv('PATH', getenv('PATH')+"/Applications/Julia-1.8.app/Contents/Resources/julia/bin/")
```

*You need to do steps 1-2 everytime you start MATLAB*


3. Then you can call `Leiden` to communities, for example:

``` matlab
A = sprand( 10, 10, 0.2 );
cid = leiden( A );
```

The result `cid` is the vector of membership IDs for each vertex.
