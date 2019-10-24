#!/bin/bash

cd ../Matiere
find "$(pwd)" -name "*.pdf" | awk -f ../linux/filter_subjects_no_duplicate.awk | ./../linux/generate_subject_webpages.py
cd ../linux
echo "Done !!"
