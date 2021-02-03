#!/bin/sh
# Arguments:
# $1: file name without extension e.g. myfile if editing myfile.tex
# $2: boolean 0/1 controlling pdflatex or latexmk compile
#      0 for latexmk
#      1 for pdflatex (anything other than 0 also works)
# $3: boolean 0/1 controlling shell escape compile
#      0 for shell-escape enabled
#      1 for shell-escape disabled (anything other than 0 also works)


# Example group 1: ./myfile.tex:11: Extra }, or forgotten \endgroup.
# Example group 2: l.11 \endcenter}
err_regex="(\./$1\.tex:[0-9]+|^l\.[0-9]+)"
filter_regex="==> Fatal error occurred, no output PDF file produced"


if [ ${2} -eq 0 ] 2>/dev/null  # USE LATEXMK
then
  command="latexmk -pdf -synctex=1"
  echo "Compiling with latexmk..."
else  # USE PDFTEX
  command="pdflatex -file-line-error -interaction=nonstopmode -halt-on-error -synctex=1"
  echo "Compiling with pdflatex..."
fi

[ ${3} -eq 0 ] && command="${command} -shell-escape"  # add shell escape option

# This reads: latexmk/pdflatex [options] myfile.tex &> myfile-log.tex
if ${command} "${1}.tex" &> "${1}-log.txt"
then
  echo "Success!"
else
  echo "Compilation failed with errors:"
  # Use the err_regex string to grep the file myfile-log.txt
  # The first grep's output is then filtered through filter_regex
  grep -P "$err_regex" "${1}-log.txt" | grep -v "$filter_regex"
fi
