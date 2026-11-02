#!/usr/bin/env bash
set -euo pipefail

pdf=${1:-build/resume.pdf}
if [[ ! -s "$pdf" ]]; then
  echo "PDF is missing or empty: $pdf" >&2
  exit 1
fi

qpdf --check "$pdf"
pages=$(pdfinfo "$pdf" | awk -F: '$1 == "Pages" {gsub(/[[:space:]]/, "", $2); print $2}')
if [[ ! "$pages" =~ ^[0-9]+$ ]] || (( pages < 1 || pages > 2 )); then
  echo "Expected a one- or two-page résumé, found: ${pages:-unknown}" >&2
  exit 1
fi

text_file=$(mktemp)
trap 'rm -f "$text_file"' EXIT
pdftotext -layout "$pdf" "$text_file"
for expected in \
  "Mohammad Muzammil Khan" \
  "Professional Summary" \
  "Technical Skills" \
  "Professional Experience" \
  "Education" \
  "mohammadmuzammil.cs@gmail.com"; do
  if ! grep -Fq "$expected" "$text_file"; then
    echo "Expected searchable text was not found: $expected" >&2
    exit 1
  fi
done

font_report=$(pdffonts "$pdf")
if ! awk 'NR > 2 { count++ } END { exit (count > 0 ? 0 : 1) }' <<<"$font_report"; then
  echo "The PDF does not contain any recognized fonts" >&2
  exit 1
fi
if ! awk 'NR > 2 && $(NF - 4) != "yes" { missing = 1 } END { exit missing }' <<<"$font_report"; then
  echo "The PDF contains a font that is not embedded:" >&2
  printf '%s\n' "$font_report" >&2
  exit 1
fi

if [[ -f build/resume.log ]] &&
  grep -E 'Missing character:|Font .* not found' build/resume.log; then
  echo "The LaTeX log reports missing characters or fonts" >&2
  exit 1
fi

echo "Validated $pdf ($pages page(s), searchable text, embedded fonts)"
