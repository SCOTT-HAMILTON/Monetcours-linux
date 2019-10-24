@include "join"
{
	# printf("%s ",$0)
	split ($0, a, "/");
	filename=a[length(a)]
	printf("\"%s\"<sep>",$0)
	printf("\"%s",join(a,1,length(a)-1, "/")"/")
	system("printf "filename" | iconv -f utf8 -t ascii//TRANSLIT//IGNORE")
	print "\""
}
