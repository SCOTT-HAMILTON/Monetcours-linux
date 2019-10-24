#!/bin/bash

rm -rf /tmp/pdfs
mkdir /tmp/pdfs

cd ../Matiere
find "$(pwd)" -name "*.pdf" | awk -f ../linux/filter_subjects_no_duplicate.awk | awk '{print "/tmp/pdfs/"$0;printf("/tmp/pdfs/%s/images\n",$0)}' | xargs -r -t -n1 -L1 mkdir
find "$(pwd)" -name "*.pdf" | awk -F'/' '{split($0,paths,"/");printf("\"%s\" \"/tmp/pdfs/%s\"\n",$0,paths[length(paths)]);}' | xargs -r -n2 -t cp
find "$(pwd)" -regextype sed -regex ".*\/images.*[\.jpg|\.jpeg]" | awk -F'/' '{split($0,paths,"/");printf("\"%s\" \"/tmp/pdfs/%s/images/%s\"\n",$0,paths[length(paths)-2],paths[length(paths)]);}' | xargs -r -n2 cp

cdir=$PWD
cd /tmp
zip -r all_pdfs.zip pdfs
cd "$cdir"
mv /tmp/all_pdfs.zip .
rm -rf /tmp/pdfs

cd ../linux
