#!/bin/bash
paru -Qmi | grep URL > repos.txt
sed -i 's/URL             : //g' repos.txt
paru -Qmi | grep URL | grep "github.com" > repos_github.txt
sed -i 's/URL             : //g' repos_github.txt
