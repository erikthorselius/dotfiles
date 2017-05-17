#!/usr/bin/env bash
formulas=("coreutils" "vim" "bash")
for formula in "${formulas[@]}"
do
  brew install ${formula}
done
