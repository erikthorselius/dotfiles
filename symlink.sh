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

FILES="$( find . -type f -not -path '*/\.*' -not -path './oh-my-bash/*' -not -path .)"
for FILE in $FILES
do
  TARGET="$HOME/.${FILE#*/}"
  if should_ignore "${FILE##*/}"; then continue; fi 
  if ! [ "$(readlink $TARGET)" = "$FILE" ]; then rm $TARGET; fi
  if [ -L "$TARGET" ]; then continue; fi
  ln -vs $(realpath $FILE) $TARGET
done

ln -s $(realpath ./oh-my-bash) $HOME/.oh-my-bash
