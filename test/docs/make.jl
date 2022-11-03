using Leiden
using Documenter

DocMeta.setdocmeta!(Leiden, :DocTestSetup, :(using Leiden); recursive=true)

makedocs(;
    modules=[Leiden],
    authors="Dimitris Floros <pitsianis@ece.auth.gr>, Nikos Pitsianis <pitsiani@ece.auth.gr>",
    repo="https://github.com/pitsianis/Leiden.jl/blob/{commit}{path}#{line}",
    sitename="Leiden.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://pitsianis.github.io/Leiden.jl",
        assets=String[],
    ),
    pages=[
        "Introduction" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/pitsianis/Leiden.jl",
    devbranch="main",
)