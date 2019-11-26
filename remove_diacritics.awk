
function join(array, start, end, sep,    result, i)
{
		if (sep == "")
				sep = " "
		else if (sep == SUBSEP) # magic value
				sep = ""
		result = array[start]
		for (i = start + 1; i <= end; i++)
				result = result sep array[i]
		return result
}

{
		split ($0, a, "/");
		filename=a[length(a)]
		printf("\"%s\"<sep>",$0)
		printf("\"%s",join(a,1,length(a)-1, "/")"/")
		system("printf "filename" | iconv -f utf8 -t ascii//TRANSLIT//IGNORE")
		print "\""
}
