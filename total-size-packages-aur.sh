#!/bin/bash

# Check local repo size:
# git count-objects -v -H

# List all arch linux official packages
pkgnum=$(pacman -Q | wc -l)

# Check every package source code archive size + arch package size
packages_size=()
for i in 1..$pkgnum..1;
do
  remaining_url=$()
  repo_size=$(curl -H "Accept: application/vnd.github.v3+json" -s https://api.github.com/repos/"$remaining_url" | jq '.size' | numfmt --to=iec --from-unit=1024)
  # For private repos pass a token as a header:
  # -H "Authorization: token GITHUB_TOKEN"
  
done

# Output total size of source code archives and official packages
echo "$packages_size"

