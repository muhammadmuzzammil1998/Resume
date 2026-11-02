# Mohammad Muzammil Khan — Résumé

This repository contains the canonical, ATS-friendly LaTeX source for my
professional résumé, a static download page, and the GitHub Actions workflow
that builds and publishes the PDF.

## Project structure

```text
.
├── .github/workflows/resume.yml  # Build, validate, and publish
├── sections/                     # Résumé content by section
├── site/index.html                # GitHub Pages landing page
├── styles/resume.sty              # Shared typography and layout
├── scripts/check-pdf.sh           # PDF integrity and text checks
├── Makefile                       # Repeatable build/check/clean commands
└── resume.tex                     # Canonical document entry point
```

## Prerequisites

- GNU Make
- A TeX Live installation with `latexmk`, pdfLaTeX, and the
  `latex-recommended` and `latex-extra` collections
- Poppler (`pdfinfo`, `pdftotext`, and `pdffonts`) and `qpdf` for validation

On Ubuntu, the CI workflow installs these packages automatically. A local
installation can use:

```sh
sudo apt-get install latexmk texlive-latex-recommended texlive-latex-extra \
  texlive-fonts-recommended poppler-utils qpdf
```

## Build and validate

```sh
make build
make check
make clean
```

The generated PDF is `build/resume.pdf`. `make check` verifies that the PDF
opens, has one or two pages, contains searchable text, and embeds its fonts.
It also checks for expected résumé text. The same `make check` command runs in
GitHub Actions.

## Editing the résumé

Edit the relevant file in `sections/`; update the document metadata or contact
links in `resume.tex`. Keep factual claims supported by the source documents
and do not add confidential employer or client details. Use plain text labels
and conventional headings so PDF text remains straightforward to extract.

## Continuous integration and GitHub Pages

`.github/workflows/resume.yml` builds and validates the PDF on pushes to
`main`, pull requests targeting `main`, and manual workflow dispatches. A
successful build is uploaded as a workflow artifact. Only pushes to `main`
deploy the landing page and PDF through the supported GitHub Pages Actions
deployment mechanism; pull requests do not publish.

The repository's expected project-site URLs are:

- Website: <https://muhammadmuzzammil1998.github.io/Resume/>
- PDF: <https://muhammadmuzzammil1998.github.io/Resume/resume.pdf>

The page uses a relative `resume.pdf` link, so it works under the repository's
GitHub Pages base path. In the repository settings, set **Pages → Build and
deployment → Source** to **GitHub Actions** if it is not already configured.
The URLs above are expected destinations, not confirmation that deployment has
completed; verify the workflow and public links after publishing.

## Troubleshooting

- **Missing LaTeX package:** install the Ubuntu packages listed above, then
  rerun `make check`.
- **Compilation failure:** inspect `build/resume.log` and the workflow's
  failure diagnostic. The build intentionally stops on the first LaTeX error.
- **Text/font validation failure:** inspect `pdftotext -layout
  build/resume.pdf -` and `pdffonts build/resume.pdf`; the PDF must contain
  extractable text and embedded fonts.
- **Pages deployment failure:** confirm that Pages uses the GitHub Actions
  source and that Actions are permitted for the repository. Review the
  `deploy` job permissions and deployment logs.
- **No public PDF:** check that a push to `main` completed successfully and
  that the Pages deployment job ran. A pull request or manual dispatch builds
  and validates but does not deploy.
