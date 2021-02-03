#!/bin/sh
# This script detects if a tex file contains the string
#  "minted" somewhere in the metadata (i.e. before reaching \begin{document})
# 
# Goal: Determine if the tex document uses the minted package and should thus 
#  be compiled using the -shell-escape option
# 
# Arguments:
#  $1: the tex file to search
sed '/\\begin{document}/q' "$1" | grep "minted" > /dev/null
