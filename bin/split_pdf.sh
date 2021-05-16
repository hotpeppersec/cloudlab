#!/bin/bash - 
# 
# Usage ./split_pdf.sh first_page last_page outputfile.pdf 
# Example: ./split_pdf.sh 10 17 ch1.pdf
# 
#        AUTHOR: Franklin (), 
#       CREATED: 02/01/2021 19:00

set -o nounset                              # Treat unset variables as an error

GS=$(which gs)

# Make sure Ghostscript is installed 
if [[ $GS = "" ]] 
then 
  echo "Ghostscript is not installed" 
  exit 
fi 

# Run the actual conversion. 
$GS -sDEVICE=pdfwrite -q -dNOPAUSE -dBATCH -sOutputFile=$3 \
	-dFirstPage=$1 -dLastPage=$2 ../book/devsecops_tactical.pdf
