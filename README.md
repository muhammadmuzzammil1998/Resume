# Resume

My resume

Generated by Go, built using LuaLatex.

Steps:

1. Getting repository

```bash
$ git clone https://github.com/muhammadmuzzammil1998/Resume.git; cd Resume
```

2. Composing Resume

```bash
$ ./compose.sh $public
```

OR

```bash
$ git pull                            # Pull repository
$ cp fonts/* styles/* ./              # Load fonts and styles into main directory
$ go run ./resume.go > resume.tex     # Generate LaTeX file
$ lualatex resume.tex                 # Run lualatex
$ mv resume.pdf $public/Resume.pdf    # Move fresh resume to public directory
$ git checkout resume.tex             # Revert resume.tex to previous state
$ rm *.otf *.sty                      # Cleaning up
```
