#!/usr/local/bin/bash

declare -A DEPENDS=(
[fmt]="errors internal/fmtsort io math os reflect sort strconv sync unicode/utf8 "
)

for i in  ${DEPENDS[fmt]}
do
  echo $i
done