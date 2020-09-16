push!(LOAD_PATH,"../src/")
using Documenter
using CBSOData4

makedocs(
    sitename = "CBSOData4",
    format = Documenter.HTML(),
    modules = [CBSOData4]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/HenricoWitvliet/CBSOData4.jl"
)
