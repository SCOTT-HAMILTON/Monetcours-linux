#!/bin/bash


function help(){
	echo "Usage : "
	echo "	monetbuild <project directory>"
	echo ""
	echo "The <project directory> option is the directory" 
	echo "	where you have your subject directories."
	echo ""
	echo "Example : "
	echo "	monetbuild ~/Document/MySchoolWork/subjects"
}

if [ "$#" -lt 1 ]; then 
	echo "Monetbuild bad usage : 0 arguments given but one is needed." 
	echo ""
	help
	exit 0
fi

if [ "$1" = "--help" ];then
	help
	exit 0
fi

run_current_dir=$PWD


if [ ! -d "$1" ] ; then
	echo "The first argument given is : '$1'."
	echo "This isn't a valid directory"
	echo ""
	help
	exit 0
fi

cd "$1"
echo "Building ..."

function build(){
	./clean_names.sh && 
	./generate_darkmode_pdfs.sh &&
	./make_subject_webpages.sh &&
	./make_zip_of_all_pdfs.sh
}

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m' 

time build

if [ "$?" -eq 0 ];then 
	printf "\n${GREEN}Done !${NC}\n"
else
	printf "\n${RED}Failed with return value [$?].${NC}\n"
fi
cd "$run_current_dir"