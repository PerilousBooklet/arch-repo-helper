#!/bin/bash

# Custom Local Package Repository Management Tool
# by PerilousBooklet

# TODO: set environment vars ?

# Commands

# Get list of all installed arch packages
#pacman -Qq | awk '{print $1}' > packages_arch.txt

# Get list of all installed AUR packages
#paru -Qm | awk '{print $1}' > packages_aur.txt

# Find deps of AUR package
# paru -Si $1 | grep "Depends On" | sed 's/Depends On      : //g'

# Find 777 in pkgbuilds
#LIST=$(ls -l "/home/raffaele/.cache/paru/clone" | awk '{print $9}')
#cd "/home/raffaele/.cache/paru/clone" || exit
#for i in $LIST; do
#  cd "./$i" || exit
#  grep "777" "./PKGBUILD" >> ~/output.txt
#  echo "--------- $i ---------" >> ~/output.txt
#  cd ..
#done

# Init
paru -Qm | awk '{print $1}' > packages.txt
LIST_PKGBUILDS=$(cat packages.txt | awk '{print $1}')
LIST_REPOS_GITHUB=$(cat repos_github.txt)
# Find which AUR package sources are hosted on Github
paru -Qmi | grep URL > repos.txt
sed -i 's/URL             : //g' repos.txt
paru -Qmi | grep URL | grep "github.com" > repos_github.txt
sed -i 's/URL             : //g' repos_github.txt

# Help
Help() {
  echo "--- --- --- --- --- --- --- --- --- "
  echo "Syntax: aur [-h|d|b|c|a|r|u]"
  echo "--- --- --- --- --- --- --- --- --- "
  echo "Options:"
  echo "H     Print this Help."
  echo "D     Download all PKGBUILDs from a given text file (should be used only the first time)."
  echo "B     Build all packages."
  echo "C     Create repository."
  echo "A     Add new packages to repository."
  echo "R     Remove existing packages from repository (NOTE: uninstall them first)."
  echo "U     Search for updated PKGBUILDS and show them."
  echo "--- --- --- --- --- --- --- --- --- "
}

# Download PKGBUILDs
download_pkgbuilds() {
	mkdir -vp ./packages
	cd "./packages" || exit
	for i in $LIST_PKGBUILDS; do
		# TODO: add package existence check
		git clone "https://aur.archlinux.org/$i.git"
	done
}

# Download packages with Github repos
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
build_packages() {
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

# Create repository
create_repo() {
	mkdir -vp ./repo
	for i in $LIST_PKGBUILDS; do
		cp "./packages/$i/$i.pkg.tar.zst" "./repo/"
		repo-add "./repo/myaur.db.tar.zst" "./repo/$i.pkg.tar.zst"
	done
}

# Add package
add_package() {
	echo "WIP..."
}

# Remove package
remove_package() {
	echo "WIP..."
}

# Update package
update_package() {
	echo "WIP..."
}

# Main
while getopts ":h:d:b:c:a:r:u" option; do
	case "$option" in
		h) Help exit;;
		d) download_pkgbuilds exit;;
		b) build_packages exit;;
		c) create_repo exit;;
		a) add_package exit;;
		r) remove_package exit;;
		u) update_package exit;;
		*) echo "This option doesn't exist!" ;;
	esac
done
