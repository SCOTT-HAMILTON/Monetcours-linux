#!/bin/bash

tmp_pdfs_path="/tmp/pdfs"

rm -rf $tmp_pdfs_path
mkdir $tmp_pdfs_path

filter_subjects_no_duplicate_path=$(command -v filter_subjects_no_duplicate.awk)
if [ ! -f "$filter_subjects_no_duplicate_path" ]; then
		echo "filter_subjects_no_duplicate.awk isn't in path."
		echo "Can't generate subject-web-pages."
		exit 1
fi

echo $filter_subjects_no_duplicate_path

find "$(pwd)" -name "*.pdf" | awk -f "$filter_subjects_no_duplicate_path" | awk -v path=$tmp_pdfs_path '{print path"/"$0;printf("%s/%s/images\n",path,$0)}' | xargs -r -t -n1 -L1 mkdir
find "$(pwd)" -name "*.pdf" | awk -v path=$tmp_pdfs_path '{split($0, tab, "/");l=length(tab);print "\""$0"\" \""path"/"tab[l-1]"/"tab[l]"\""}'| xargs -r -n2 -t cp
find "$(pwd)" -regextype sed -regex ".*\/images.*[\.jpg|\.jpeg]" | awk -F'/' -v path=$tmp_pdfs_path '{split($0,paths,"/");printf("\"%s\" \"%s/%s/images/%s\"\n",$0, path,paths[length(paths)-2],paths[length(paths)]);}' | xargs -r -n2 cp

_curren_dir=$(pwd)
cd /tmp
zip -r all_pdfs.zip pdfs
cd "$_curren_dir"
mv /tmp/all_pdfs.zip .
rm -rf $tmp_pdfs_path

