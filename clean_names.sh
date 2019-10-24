#!/bin/bash
cd ../Matiere
find "$(pwd)" -regextype egrep -regex ".*\.pdf|.*images/.*\.((j|J)(p|P)(g|G)|(j|J)(p|P)(e|E)(g|G))"| awk -f ../linux/remove_diacritics.awk | awk -F"<sep>" '{if ($1!=$2){print $1" "$2} }' | xargs -n2 -L1 -r -t mv
find "$(pwd)" -name "*.md*.pdf" | awk '{printf("\"%s\" ",$0);str = $0;sub(/\.md/, "", str);printf("\"%s\"",str)}' | xargs -n2 -r -t mv
find "$(pwd)" -name "*.md*.yaml" | awk '{printf("\"%s\" ",$0);str = $0;sub(/\.md/, "", str);printf("\"%s\"",str)}' | xargs -n2 -r -t mv
cd ../linux
