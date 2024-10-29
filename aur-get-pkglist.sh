#!/bin/bash

# Get list of all installed arch packages
pacman -Qq | awk '{print $1}' > packages_arch.txt

# Get list of all installed AUR packages
paru -Qm | awk '{print $1}' > packages_aur.txt
