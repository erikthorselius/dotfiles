#!/usr/bin/env bash

# from http://errtheblog.com/posts/89-huba-huba
function should_ignore {
  ignore=("README" "symlink.rb" "symlink.sh")
  for ignore_file in "${ignore[@]}"
  do
    if [ "$ignore_file" == "$1" ]; then return 0; fi
  done
  return 1 
}

FILES="$( cd "$( dirname "$0" )" && pwd )/*"
for file in $FILES
do
  TARGET="$HOME/.${file##*/}"
  echo $TARGET
  #if should_ignore "${file##*/}"; then continue; fi 
  #if [ -L "$TARGET" ]; then continue; fi
  #ln -s $file $TARGET
done
