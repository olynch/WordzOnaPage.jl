# Usage

1. [Install Julia](https://julialang.org/downloads/)
2. [Install LaTeX](https://www.tug.org/texlive/)
2. Run `julia --project -e "using Pkg; Pkg.instantiate()"` to install dependencies
3. Run `julia run.jl --words <wordlist> -n <number of samples> --out <name of output file> --variance <size variance>`
