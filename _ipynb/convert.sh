#!/bin/bash

# example use:
# [~/gitrepos/dkmehrmann.github.io/_ipynb]$ ../scripts/convert.sh google_maps.ipynb 
# 

BUILD_DIR="/home/camilo/Development/c-milo.github.io/_ipynb/"
POST_DIR="/home/camilo/Development/c-milo.github.io/_posts/"

# use nbconvert on the file
jupyter-nbconvert --to markdown $1

# copies the file to a newly named file
ipynb_fname="$1"
md_fname="${ipynb_fname/ipynb/md}"
dt=`date +%Y-%m-%d`
fname="$dt-$md_fname"
mv $BUILD_DIR$md_fname $BUILD_DIR$fname
echo "file name changed from $1 to $fname"

# adds the date to the file
dt2=`date +"%b %d, %Y"`
sed -i "1i ---" $BUILD_DIR$fname
sed -i "2i date: $dt2" $BUILD_DIR$fname
echo "added date $dt2 to line 2"

# Gets the title of the post
echo "What's the title of this post going to be?"
read ttl
sed -i "3i title: \"$ttl\"" $BUILD_DIR$fname
echo "added title $ttl in line 3"

# Adding other yaml info
sed -i "4i author: Camilo Acosta" $BUILD_DIR$fname
sed -i "5i categories: []" $BUILD_DIR$fname
sed -i "6i tags: []" $BUILD_DIR$fname
sed -i "7i ---" $BUILD_DIR$fname


# if the current version is newer than the version in _posts
if [[ $1 -nt $POST_DIR$fname ]]; then
  mv $BUILD_DIR$fname $POST_DIR$fname
  echo "moved $fname from $BUILD_DIR to $POST_DIR"
  echo -e "\e[32m Process Completed Successfully \e[0m"
else
  echo -e "\e[31m $1 older than the version in $POST_DIR, not overwriting $POST_DIR$fname \e[0m"
fi