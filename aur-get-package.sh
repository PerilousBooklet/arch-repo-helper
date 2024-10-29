#!/bin/bash
LIST=$(cat repos_github.txt)
mkdir -vp ./repos_github
cd "./repos_github" || exit
for i in $LIST; do
	if test -d ./"$i"; then
		echo "$i is already present."
	else
		git clone "$i"
	fi
done
