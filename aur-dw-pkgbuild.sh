#!/bin/bash

# Download PKGBUILDS from text list
#LIST=$(cat packages.txt | awk '{print $1}')
LIST=$1
mkdir -vp ./packages
cd "./packages" || exit
for i in $LIST; do
	git clone "https://aur.archlinux.org/$i.git"
done
