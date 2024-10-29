#!/bin/bash

# Find all dependencies of a package
paru -Si $1 | grep "Depends On" | sed 's/Depends On      : //g' > deps.txt
# TODO: format file to get one package name per line

