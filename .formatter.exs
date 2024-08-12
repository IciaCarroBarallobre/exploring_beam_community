# .formatter.exs
[
  # Specify the paths or patterns of files to format
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],

  # Optionally specify subdirectories if you want to format subdirectories
  subdirectories: ["apps/*"]
]
