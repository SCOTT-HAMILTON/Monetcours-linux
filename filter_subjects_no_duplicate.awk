BEGIN{
		isin=0
		line=0
}
{
		isin=0
		split($0,paths,"/")
		mat=paths[length(paths)-1]
		for(x in dis)
				if (dis[x] == mat)
				isin=1
		if (!isin)
				print mat
		dis[line]=mat
		line++
}
