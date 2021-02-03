#!/bin/sh
# Arguments:
# $1: file name without extension, including relative path
#     e.g. "./myfile" if editing myfile.tex
# $2: line number of tex file to show in PDF
# $3: boolean 0/1 controlling pdflatex or latexmk compile
#     0 for latexmk
#     1 for pdflatex (anything other than 0 also works)
# $4: boolean 0/1 controlling shell escape compile
#     0 for shell-escape enabled
#     1 for shell-escape disabled (anything other than 0 also works)


# Regex structure below is "(group1|group2)"
# Example group 1: "./myfile.tex:11: Extra }, or forgotten \endgroup."
# Example group 2: "l.11 \endcenter}"
# filter_regex is used to remove a (IMO) redundant error message
err_regex="(${1}\.tex:[0-9]+|^l\.[0-9]+)"
filter_regex="==> Fatal error occurred, no output PDF file produced"


if [ ${3} -eq 0 ] 2>/dev/null  # USE LATEXMK
then
  command="latexmk -pdf -synctex=1"
  echo "Compiling with latexmk..."
else  # USE PDFTEX
  command="pdflatex -file-line-error -interaction=nonstopmode -halt-on-error -synctex=1"
  echo "Compiling with pdflatex..."
fi

[ ${4} -eq 0 ] && command="${command} -shell-escape"  # add shell escape option


if ${command} "${1}.tex" &> "${1}-log.txt"
then
  echo "Success!"
  # Forward show to the line number in argument $2
  /Applications/Skim.app/Contents/SharedSupport/displayline -b -g $2 "${1}.pdf" "${1}.tex" 
else
  echo "Compilation failed with errors:"
  # Use the err_regex string to grep the file myfile-log.txt
  # The first grep's output is then filtered through filter_regex
  grep -P "$err_regex" "${1}-log.txt" | grep -v "$filter_regex"
fi
