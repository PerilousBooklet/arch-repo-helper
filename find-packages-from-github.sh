#!/bin/bash

touch packages.csv
pacman -Qq > packages.txt
# ?
packages=$(cat packages.txt)
# ?
for i in $packages;
do
  # ?
  url=$(pacman -Qi "$i" | grep "https://github.com/" | awk "{print $3}")
  # ?
  size=$(curl "https://api.github.com/$(echo $url | cut -c 20-$ncc")
  # ?
  if [ $(pacman -Qi "$i" | grep -q "https://github.com/") ]; then
    echo -e "$i, $url, $size" >> "packages.csv"
  fi
done
