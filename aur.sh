#!/bin/bash

# Custom Local Package Repository Management Tool
# by PerilousBooklet

# TODO: set environment ?

# Help
Help() {
  # Display Help
  # TODO: complete options
  echo "--- --- --- --- --- --- --- --- --- "
  echo "Syntax: scriptTemplate [-h|d|b|c]"
  echo "options:"
  echo "H     Print this Help."
  echo "D     Download all PKGBUILDs from a given text file (should be used only the first time)."
  echo "B     Build all packages."
  echo "C     Create repository."
  echo "A     Add new packages to repository."
  echo "R     Remove existing packages from repository (NOTE: uninstall them first)."
  echo "U     Search for updated PKGBUILDS and show them."
  echo "--- --- --- --- --- --- --- --- --- "
}

# Get list of all installed AUR packages
# `paru -Qm | awk '{print $1}' > packages.txt`

# Download PKGBUILDs
LIST_PKGBUILDS=$(cat packages.txt | awk '{print $1}')
download_pkgbuilds() {
	mkdir -vp ./packages
	cd "./packages" || exit
	for i in $LIST_PKGBUILDS; do
		# TODO: add package existence check
		git clone "https://aur.archlinux.org/$i.git"
	done
}

# Download packages with Github repos
LIST_REPOS_GITHUB=$(cat repos_github.txt)
download_repos_github() {
	mkdir -vp ./repos_github
	cd "./repos_github" || exit
	for i in $LIST_REPOS_GITHUB; do
		# Check if package already exists
		if test -d ./"$i"; then
			echo "$i is already present."
		else
			git clone "$i"
		fi
	done
}

# Build packages
build() {
	for i in $LIST_PKGBUILDS; do
		# TODO: add clean chroot
		# TODO: enter clean chroot
		cd ./packages/"$i" || exit
		makepkg -csr
		cd .. || exit
		# TODO: exit clean chroot
		# TODO: remove clean chroot
	done
}

# Update package
update() {
	for i in $LIST_PKGBUILDS; do
		# TODO: check if package is out of date
		# TODO: get updated source files
		echo "WIP..."
	done
}

# Create repository
create_repo() {
	mkdir -vp ./repo
	for i in $LIST_PKGBUILDS; do
		cp "./packages/$i/$i.pkg.tar.zst" "./repo/"
		repo-add "./repo/myaur.db.tar.zst" "./repo/$i.pkg.tar.zst"
	done
}

# Add package
add() {
	echo
}

# Remove package
remove() {
	echo
}

# Main

# Get the options
while getopts ":h" option; do
	case $option in
		H) Help exit;;
		D) download_pkgbuilds exit;;
		B) build exit;;
		C) create_repo exit;;
		A) add exit;;
		R) remove exit;;
		U) update exit;;
		*) echo "This option doesn't exits!" ;;
	esac
done
