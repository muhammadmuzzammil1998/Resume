RESUME_PDF := build/resume.pdf
CV_PDF := build/cv.pdf
LATEXMK := latexmk

.PHONY: all build check clean

all: check

build: $(RESUME_PDF) $(CV_PDF)

$(RESUME_PDF): resume.tex styles/resume.sty $(wildcard sections/*.tex)
	mkdir -p build
	$(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
	  -outdir=build resume.tex

$(CV_PDF): cv.tex styles/resume.sty $(wildcard sections/cv/*.tex)
	mkdir -p build
	$(LATEXMK) -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
	  -outdir=build cv.tex

check: build
	bash scripts/check-pdf.sh $(RESUME_PDF) 2 \
	  "Mohammad Muzammil Khan" \
	  "Senior UI Engineer" \
	  "Professional Summary" \
	  "Technical Skills" \
	  "Professional Experience" \
	  "mohammadmuzammil.cs@gmail.com"
	bash scripts/check-pdf.sh $(CV_PDF) 6 \
	  "Mohammad Muzammil Khan" \
	  "Curriculum Vitae" \
	  "Technical Expertise" \
	  "Professional Experience" \
	  "Research and Publications" \
	  "Certifications and Recognition"

clean:
	$(LATEXMK) -C -outdir=build resume.tex
	$(LATEXMK) -C -outdir=build cv.tex
	rm -rf build
