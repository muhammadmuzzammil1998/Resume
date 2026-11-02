PDF := build/resume.pdf
LATEXMK := latexmk

.PHONY: all build check clean

all: check

build: $(PDF)

$(PDF): resume.tex styles/resume.sty $(wildcard sections/*.tex)
	mkdir -p build
	$(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
	  -outdir=build resume.tex

check: build
	bash scripts/check-pdf.sh $(PDF)

clean:
	$(LATEXMK) -C -outdir=build resume.tex
	rm -rf build
