#!/bin/bash

set -e

for i in ./tests-fixtures/*.bas; do
  filename=$(basename $i)
  filename="${filename%.*}"
  ./test.sh $filename
done

