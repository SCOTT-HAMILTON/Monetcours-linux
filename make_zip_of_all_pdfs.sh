#!/bin/bash

rm -rf /tmp/pdfs
mkdir /tmp/pdfs

filter_subjects_no_duplicate_path=$(command -v filter_subjects_no_duplicate.awk)
if [ ! -f "$filter_subjects_no_duplicate_path" ]; then
		echo "filter_subjects_no_duplicate.awk isn't in path."
		echo "Can't generate subject-web-pages."
		exit 1
fi

echo $filter_subjects_no_duplicate_path

find "$(pwd)" -name "*.pdf" | awk -f "$filter_subjects_no_duplicate_path" | awk '{print "/tmp/pdfs/"$0;printf("/tmp/pdfs/%s/images\n",$0)}' | xargs -r -t -n1 -L1 mkdir
find "$(pwd)" -name "*.pdf" | awk -F'/' '{split($0,paths,"/");printf("\"%s\" \"/tmp/pdfs/%s\"\n",$0,paths[length(paths)]);}' | xargs -r -n2 -t cp
find "$(pwd)" -regextype sed -regex ".*\/images.*[\.jpg|\.jpeg]" | awk -F'/' '{split($0,paths,"/");printf("\"%s\" \"/tmp/pdfs/%s/images/%s\"\n",$0,paths[length(paths)-2],paths[length(paths)]);}' | xargs -r -n2 cp

_curren_dir=$(pwd)
cd /tmp
zip -r all_pdfs.zip pdfs
cd "$_curren_dir"
mv /tmp/all_pdfs.zip .
rm -rf /tmp/pdfs
