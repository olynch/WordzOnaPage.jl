using WordzOnaPage

using ArgParse

s = ArgParseSettings()

@add_arg_table s begin
  "--words"
     help = "the filename of the file containing words, each line containing one word"
     required = true
  "--variance"
     help = "the variance of the size"
     arg_type = Float64
     default = 1.0
  "-n"
     help = "the number of words"
     arg_type = Int
     required = true
  "--out"
     help = "the name to prefix the output with; we will end up outputting to <out>.pdf"
     required = true
end

parsed_args = parse_args(ARGS, s)

wordlist = split(read(parsed_args["words"], String), "\n")

params = Params(wordlist, parsed_args["variance"])

words = [samplepw(params) for _ in 1:parsed_args["n"]]

renderpws(words, parsed_args["out"])
