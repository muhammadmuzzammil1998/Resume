# Mohammad Muzammil Khan — Résumé and CV

This repository contains an ATS-friendly résumé and a comprehensive CV, both
maintained as LaTeX, plus a static download page and the GitHub Actions
workflow that builds and publishes both PDFs.

## Project structure

```text
.
├── .github/workflows/resume.yml  # Build, validate, and publish both PDFs
├── sections/                     # Shared résumé and detailed CV content
├── site/index.html               # GitHub Pages landing page
├── styles/resume.sty             # Shared typography and layout
├── scripts/check-pdf.sh          # PDF integrity and text checks
├── Makefile                      # Repeatable build/check/clean commands
├── resume.tex                    # Concise résumé entry point
└── cv.tex                        # Comprehensive CV entry point
```

## Prerequisites

- GNU Make
- A TeX Live installation with `latexmk`, pdfLaTeX, and the
  `latex-recommended` and `latex-extra` collections
- Poppler (`pdfinfo`, `pdftotext`, and `pdffonts`) and `qpdf` for validation

On Ubuntu, the CI workflow installs these packages automatically. A local
installation can use:

```sh
sudo apt-get install latexmk lmodern texlive-latex-recommended texlive-latex-extra \
  texlive-fonts-recommended poppler-utils qpdf
```

## Build and validate

```sh
make build
make check
make clean
```

The generated files are `build/resume.pdf` and `build/cv.pdf`. The résumé is
limited to two pages; the detailed CV may use up to six. `make check` verifies
that both PDFs open, contain searchable expected text, and embed their fonts.
The same `make check` command runs in GitHub Actions.

## Editing the résumé

Edit the relevant file in `sections/` or `sections/cv/`; update the document
metadata or contact links in `resume.tex` and `cv.tex`. The résumé is the
focused application document. The CV also records earlier academic projects
and research publications. Keep factual claims supported by source documents
and do not add confidential employer or client details. Use plain text labels
and conventional headings so PDF text remains straightforward to extract.

## Continuous integration and GitHub Pages

`.github/workflows/resume.yml` builds and validates the PDF on pushes to
`main`, pull requests targeting `main`, and manual workflow dispatches. A
successful build is uploaded as a workflow artifact. Only pushes to `main`
deploy the landing page and PDF through the supported GitHub Pages Actions
deployment mechanism; pull requests do not publish.

The public page includes view and download actions for each PDF:

- Website: <https://muhammadmuzzammil1998.github.io/Resume/>
- Résumé PDF: <https://muhammadmuzzammil1998.github.io/Resume/resume.pdf>
- CV: <https://muhammadmuzzammil1998.github.io/Resume/cv.pdf>

The page uses relative PDF links, so they work under the repository's GitHub
Pages base path. In the repository settings, set **Pages → Build and
deployment → Source** to **GitHub Actions** if it is not already configured.
The workflow publishes both PDFs alongside the landing page after a successful
push to `main`.

## Troubleshooting

- **Missing LaTeX package:** install the Ubuntu packages listed above, then
  rerun `make check`.
- **Compilation failure:** inspect `build/resume.log` and the workflow's
  failure diagnostic. The build intentionally stops on the first LaTeX error.
- **Text/font validation failure:** inspect `pdftotext -layout
  build/resume.pdf -` or `build/cv.pdf` and `pdffonts`; the PDFs must contain
  extractable text and embedded fonts.
- **Pages deployment failure:** confirm that Pages uses the GitHub Actions
  source and that Actions are permitted for the repository. Review the
  `deploy` job permissions and deployment logs.
- **No public PDF:** check that a push to `main` completed successfully and
  that the Pages deployment job ran. A pull request or manual dispatch builds
  and validates but does not deploy.
