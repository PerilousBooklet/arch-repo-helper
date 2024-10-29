#!/bin/bash
LIST=$(ls -l "/home/raffaele/.cache/paru/clone" | awk '{print $9}')
cd "/home/raffaele/.cache/paru/clone" || exit
for i in $LIST; do
  cd "./$i" || exit
  grep "777" "./PKGBUILD" >> ~/output.txt
  echo "--------- $i ---------" >> ~/output.txt
  cd ..
done
