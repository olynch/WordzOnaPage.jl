module WordzOnaPage
export Params, tikz, samplepw, renderpws
using Distributions

struct PositionedWord
  word::String
  position::Tuple{Float64, Float64}
  rotation::Float64
  size::Float64
end

function tikz(pw::PositionedWord)
  "\\node[rotate=$(pw.rotation), scale=$(pw.size)] at ($(pw.position[1])\\textwidth, $(pw.position[2])\\textheight) {$(pw.word)};"
end

struct Params
  wordlist::Vector{String}
  sizedev::Float64
end

function samplepw(p::Params)
  word = sample(p.wordlist)
  # Sample position uniformly in (0,1)
  position = (round(rand(); digits=4), round(rand(); digits=4))
  # sample rotation uniformly from 0 to 360
  rotation = rand(Uniform(0,360))
  # sample size with a exponential distribution with standard deviation sizedev
  size = rand(Exponential(p.sizedev))

  PositionedWord(word, position, rotation, size)
end

PREAMBLE = raw"""
\documentclass{article}
\usepackage[margin=1cm]{geometry}
\usepackage{tikz}
\begin{document}
\vspace{1cm}
\begin{tikzpicture}[scale=0.8]
"""

POSTAMBLE = raw"""
\end{tikzpicture}
\end{document}
"""

function renderpws(pws::Vector{PositionedWord}, filename)
  str = PREAMBLE * join(tikz.(pws), "\n") * POSTAMBLE
  texfn = filename * ".tex"
  write(texfn, str)
  run(`pdflatex $texfn`)
end

end # module WordzOnaPage
