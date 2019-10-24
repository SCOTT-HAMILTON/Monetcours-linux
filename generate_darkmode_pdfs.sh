#!/bin/bash
cd ../Matiere
echo "Generating dark pdfs..."
find . -iname "*-dark*.pdf" | xargs -r -n1 rm
find "$(pwd)" -name "*.pdf" | awk '{print "\""$0"\"\n\""substr($0,0,length($0)-4)"-dark.pdf\""}'  | parallel --xargs -l 2 './../linux/invert_pdf_colors.pl {}'
cd ../linux
