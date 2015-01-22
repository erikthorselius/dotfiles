#!/usr/bin/env bash
formulas=("coreutils" "vim")
for formula in "${formulas[@]}"
do
  brew install ${formula}
done
