#!/bin/bash
git pull
cp fonts/* styles/* ./
go run ./resume.go > resume.tex
lualatex resume.tex
mv resume.pdf $1/Resume.pdf
git checkout resume.tex
rm *.otf *.sty