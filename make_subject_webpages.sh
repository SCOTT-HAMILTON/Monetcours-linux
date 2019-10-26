#!/bin/bash

filter_subjects_no_duplicate_path=$(command -v filter_subjects_no_duplicate.awk)
if [ ! -f "$filter_subjects_no_duplicate_path" ]; then
		echo "filter_subjects_no_duplicate.awk isn't in path."
		echo "Can't generate subject-web-pages."
		exit 1
fi

echo $filter_subjects_no_duplicate_path

find "$(pwd)" -name "*.pdf" | awk -f "$filter_subjects_no_duplicate_path" | generate_subject_webpages.py
