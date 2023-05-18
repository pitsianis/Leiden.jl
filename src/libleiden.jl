@doc raw"""
```julia
    leiden(A::SparseMatrixCSC, method[;
           γ = 1.0, kth_root = 1, gr_function = 0,
           δa = 1.0, δr = 1.0, Ω_star = nothing,
           Ω_0 = C_NULL, list_seed = 0:9, n_iter = 2])
```

Run γ-specific search using Leiden. It returns a configuration.

# Optional parameters and their default values:

- `γ = 1.0` : The value of γ

- `gr_function = 0` : The function used in case "imod" method is
  selected. See [`leiden_func_code`](@ref) for more information.

- `δa=1.0, δr=1.0` : Used when γ is normalized to get un-normalized
  value.

- `Ω_star` = nothing : Best configuration found so far, do not return any 
  configuration with worse objective???

- `Ω_0 = C_NULL` : Initial configuration equivalent to Ω_v where every node is a cluster.

- `list_seed = 0:9` : List of random number seeds to be used, one per run.

- `n_iter = 2` : Number of successive iterations to be used per seed.

"""
function leiden( args...; kwargs... )

  Ω, q = leiden_multiple( args...; kwargs... )

  # pick-up the best configuration
  i_best = argmin( q )
  Ω[i_best]

end

@doc raw"""
```julia
    leiden_multiple(A::SparseMatrixCSC, method[;
           γ = 1.0, kth_root = 1, gr_function = 0,
           δa = 1.0, δr = 1.0, Ω_star = nothing,
           Ω_0 = C_NULL, list_seed = 0:9, n_iter = 2,
           scheme = :parallel, max_improv = Inf])
```

Run γ-specific search using Leiden. It returns a configuration.

# Optional parameters and their default values:

- `γ = 1.0` : The value of γ

- `gr_function = 0` : The function used in case "imod" method is
  selected. See [`leiden_func_code`](@ref) for more information.

- `δa=1.0, δr=1.0` : Used when γ is normalized to get un-normalized
  value.

- `Ω_star` = nothing : Best configuration found so far, do not return any 
  configuration with worse objective???

- `Ω_0 = C_NULL` : Initial configuration equivalent to Ω_v where every node is a cluster.

- `list_seed = 0:9` : List of random number seeds to be used, one per run.

- `n_iter = 2` : Number of successive iterations to be used per seed.

- `scheme = :parallel` : Strategy for selecting the starting configuration. 
  With `:parallel`, the run with each seed starts from the same initial configuration `Ω_0`.
  With `:sequential`, the run with each seed starts from the configuration reached by the previous seed.

- `max_improv = Inf` : when Δh has reached this value, terminate the search process.

"""
function leiden_multiple(
  A::SparseMatrixCSC, method;
  γ = 1.0, gr_function = 0,
  δa = 1.0, δr = 1.0, Ω_star = nothing,
  Ω_0 = C_NULL, list_seed = [0], n_iter = 1, scheme = :parallel,
  max_improv = Inf )

  # list of configurations for different seeds
  Ω = Vector{Vector{Int64}}()
  q = Vector{Float64}()

  # make sure γ is non-standardized
  γ *= ( δa / δr )

  # work from best
  if !isnothing( Ω_star )
    Ω_tmp, q_tmp = _do_leiden(
      A, method; γ, gr_function,
      cid_0 = Ω_star, seed = list_seed[1],
      max_improv )
    push!( Ω, Ω_tmp )
    push!( q, q_tmp )
  end

  if scheme == :successive
    Ω_tmp = isnothing( Ω_0 ) ? C_NULL : Ω_0
  end

  for (i_seed, seed) ∈ enumerate( list_seed )
    if scheme == :parallel
      Ω_tmp = isnothing( Ω_0 ) ? C_NULL : Ω_0
    end
    q_tmp = Inf

    for j_iter = 1:n_iter
      Ω_prev = Ω_tmp
      Ω_tmp, q_tmp = _do_leiden(
        A, method;
        γ, gr_function,
        cid_0 = Ω_prev, seed,
        max_improv )
      if Ω_prev == Ω_tmp
        @debug "Leiden stabilized after $j_iter iterations."
        break;
      end
    end

    push!( Ω, Ω_tmp )
    push!( q, q_tmp )

  end

  Ω, q

end


@doc raw"""
```julia
  _do_leiden(A::SparseMatrixCSC, method[;
           γ = 1.0, gr_function = 0,
           cid_0 = C_NULL, seed = 0, max_improv = Inf])
```

Run γ-specific search using Leiden. It returns a configuration.

# Optional parameters and their default values:

- `γ = 1.0` : The value of γ

- `gr_function = 0` : The function used in case "imod" method is
  selected. See [`leiden_func_code`](@ref) for more information.

- `cid_0 = C_NULL` : Initial configuration equivalent to Ω_v where every node is a cluster.

- `seed = 0` : Seed for the random number generator.

- `max_improv = Inf` : when Δh has reached this value, terminate the search process.

"""
function _do_leiden( A::SparseMatrixCSC, method;
                    γ = 1.0, gr_function = 0,
                    cid_0 = C_NULL, seed = 0, max_improv = Inf)

  isdirected = !issymmetric( A )

  i,j,v = isdirected ? findnz( A ) : findnz( tril(A) )
  E = [i';j'].-1
  v = Float64.(v)

  # check mebmership type
  cid = (cid_0 != C_NULL) ? UInt64.( cid_0 ) .- 1 : C_NULL

  method = method == "mod++" ? "ngrb" : method

  q = [Inf];
  M = ccall( (:do_leiden, libleiden),
             Ptr{Csize_t},
             (Ptr{Cdouble},
              Ptr{Csize_t},
              Ptr{Cdouble},
              Ptr{Csize_t},
              Csize_t,
              Csize_t,
              Cstring,
              Cdouble,
              Cint,
              Cint,
              Cint,
              Cint,
              Cdouble),
             q, E, v, cid,
             size(A,1), length(i), method, γ,
             1, gr_function, seed, isdirected, max_improv );

  cid = unsafe_wrap( Array, M, size(A,1); own = true ).+1, -q[1]

end


@doc raw"""
    leiden_func_code(func_code::Integer[; k = 1])

Retrieve function given an integer code (consistent with Leiden C/C++
wrapper).

"""
function leiden_func_code( func_code::Integer; k = 1 )

  if     func_code == 1
    x -> 1 / ( 1 + exp(-x) )
  elseif func_code == 2
    x -> x<0.0 ? - (-x)^(1.0/(2.0*k+1.0)) : x^(1.0/(2.0*k+1.0))
  elseif func_code == 3
    x -> 2^x
  else
    x -> x
  end

end
