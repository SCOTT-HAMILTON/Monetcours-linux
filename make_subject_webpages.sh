#!/bin/bash

filter_subjects_no_duplicate_path=$(command -v filter_subjects_no_duplicate.awk)
sample_subject_webpage_path=$(command -v sample_subject_webpage.html)

if [ ! -f "$filter_subjects_no_duplicate_path" ]; then
		echo "filter_subjects_no_duplicate.awk isn't in path."
		echo "Can't generate subject-web-pages."
		exit 1
fi

find "$(pwd)" -name "*.pdf" | awk -f "$filter_subjects_no_duplicate_path" | generate_subject_webpages.py --test "$sample_subject_webpage_path"
