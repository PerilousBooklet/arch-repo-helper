#!/bin/bash

# list of all explicitly installed packages from the AUR
pkg_di=$(paru -Qqme)

# list of all packages installed from the AUR
pkg_did=$(paru -Qqm)

# check if package is not explicitly installed
echo "${pkg_di[@]}" "${pkg_did[@]}" | tr ' ' '\n' | sort | uniq -u

