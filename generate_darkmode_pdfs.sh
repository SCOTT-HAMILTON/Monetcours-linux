#!/bin/bash

invert_pdf_colors_path=$(command -v invert_pdf_colors.pl)
if [ ! -f "$invert_pdf_colors_path" ]; then
		echo "invert_pdf_colors.pl isn't in path."
		echo "Can't generate dark modes for the pdfs."
		exit 1
fi

echo $invert_pdf_colors_path
echo "PWD : $(pwd)"
echo "Generating dark pdfs..."
find "$(pwd)" -iname "*-dark*.pdf" | xargs -r -n1 -r -t -I{} rm "{}"
find "$(pwd)" -name "*.pdf" | awk '{print "\""$0"\"\n\""substr($0,0,length($0)-4)"-dark.pdf\""}' | parallel --xargs -l 2 $invert_pdf_colors_path
