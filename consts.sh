#!/bin/bash

X="DEFC __"

#set -x

echo "; 3rd parse generated constants: " > ./consts.inc

input="main.def"
while IFS= read -r line
do
  if [[ ${line:0:11} != "DEFC CONST_" ]]; then
    continue
  fi

  exportline="${line/DEFC CONST_/$X}"

  echo $exportline >> ./consts.inc

done < "$input"

