# Julia Interface to Leiden


| **Documentation**                                                               | **Build Status**                                                                                | **Contributing** |
|:-------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------:|:-----:|
| [![][docs-stable-img]][docs-stable-url] [![][docs-latest-img]][docs-latest-url] | [![CI][github-action-img]][github-action-url] [![][codecov-img]][codecov-url] | [![][issues-img]][issues-url] [![][license-img]][license-url] |


This package is a Julia interface (i.e. a wrapper) to a software
library, in C++ implementation, of Algorithm Leiden for community
detection, also known as graph clustering. 

For the Leiden algorithm, see the article [From Louvain to Leiden: guaranteeing well-connected communities](https://www.nature.com/articles/s41598-019-41695-z/), by V. A. Traag, L. Waltman &
N. J. van Eck, 2019.

For the software library of Algorithm Leiden, in C++ and python follow the [link](https://github.com/vtraag/leidenalg). 
It supports several objective functions for graph clustering, including 
Modularity, Constant Potts Model, Suprise, and Significance.


## Supported platforms

`Leiden.jl` is available for the following platforms:

* `macOS x86_64` (`x86_64-apple-darwin`)
* `Linux x86_64 {libc=glibc}` (`x86_64-linux-gnu`)


## Installation

The package is currently under development and not available through 
the package manager of `Julia`. Instead, you have to manually add the
two dependencies of this package and the package itself:

``` julia
] add https://github.com/fcdimitr/igraph_jll.jl https://github.com/fcdimitr/leiden_jll.jl https://github.com/pitsianis/Leiden.jl 
```

<!-- The package can be added using the Julia package manager. From the -->
<!-- Julia REPL, type `]` to enter the Pkg REPL mode and execute the -->
<!-- following command -->

<!-- ``` julia -->
<!-- pkg> add Leiden -->
<!-- ``` -->

## Documentation

- [**STABLE**][docs-stable-url] &mdash; **most recently tagged version of the documentation.**
- [**LATEST**][docs-latest-url] &mdash; *in-development version of the documentation.*

## Contributing and Questions

Contributions are very welcome, as are feature requests and
suggestions. Please open an [issue][issues-url] if you encounter any
problems.

## References

[1] V. A. Traag, L. Waltman and
N. J. van Eck, [From Louvain to Leiden: guaranteeing well-connected communities](https://www.nature.com/articles/s41598-019-41695-z/), Scientific Reports volume 9, 2019



## Contributors of the Julia interface

*Design and development*:  
Nikos Pitsianis<sup>1,2</sup>, Dimitris Floros<sup>1</sup>, Xiaobai Sun<sup>2</sup>

<sup>1</sup> Department of Electrical and Computer Engineering,
Aristotle University of Thessaloniki, Thessaloniki 54124, Greece  
<sup>2</sup> Department of Computer Science, Duke University, Durham, NC
27708, USA



[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://pitsianis.github.io/Leiden.jl/dev

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://pitsianis.github.io/Leiden.jl/stable

[github-action-img]: https://github.com/pitsianis/Leiden.jl/actions/workflows/CI.yml/badge.svg?branch=main
[github-action-url]: https://github.com/pitsianis/Leiden.jl/actions/workflows/CI.yml?query=branch%3Amain

[codecov-img]: https://codecov.io/gh/pitsianis/Leiden.jl/branch/main/graph/badge.svg
[codecov-url]: https://codecov.io/gh/pitsianis/Leiden.jl

[license-img]: https://img.shields.io/github/license/pitsianis/Leiden.jl.svg
[license-url]: https://github.com/pitsianis/Leiden.jl/blob/main/LICENSE

[issues-img]: https://img.shields.io/github/issues/pitsianis/Leiden.jl.svg
[issues-url]: https://github.com/pitsianis/Leiden.jl/issues
