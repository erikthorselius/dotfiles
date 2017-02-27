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
for FILE in $FILES
do
  TARGET="$HOME/.${FILE##*/}"
  if should_ignore "${FILE##*/}"; then continue; fi 
  if ! [ "$(readlink $TARGET)" = "$FILE" ]; then rm $TARGET; fi
  if [ -L "$TARGET" ]; then continue; fi
  ln -s $FILE $TARGET
done
