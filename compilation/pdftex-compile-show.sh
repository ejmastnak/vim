#!/bin/sh
# Arguments:
# $1: file name without extension e.g. myfile if editing myfile.tex
# $2: line number of tex file to show in PDF

# Regex structure below is "(group1|group2)"
# Example group 1: "./myfile.tex:11: Extra }, or forgotten \endgroup."
# Example group 2: "l.11 \endcenter}"
err_regex="(\./${1}\.tex:[0-9]+|^l\.[0-9]+)"
filter_regex="==> Fatal error occurred, no output PDF file produced"

# This reads: pdflatex [options] myfile.tex > myfile-log.tex
if pdflatex -file-line-error -interaction=nonstopmode -halt-on-error -shell-escape -synctex=1 "${1}.tex" > "${1}-log.txt"
then
  echo "Success!"
  # Forward show to the line number in argument $2
  /Applications/Skim.app/Contents/SharedSupport/displayline -b -g $2 "${1}.pdf" "${1}.tex" 
else
  echo "Compilation failed with errors:"
  # Uses the err_regex string to grep the file myfile-log.txt
  # The first grep's output is then filtered through filter_regex
  grep -P "$err_regex" "${1}-log.txt" | grep -v "$filter_regex"
fi
