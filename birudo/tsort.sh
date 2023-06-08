#!/usr/local/bin/bash
set -eu
infile=$1
workfile=/tmp/work.txt

cp $infile $workfile

while true
do
  leaves=$(cat $workfile | grep -e ': *$'| gsed -e 's/: *//g')
  if [[ -z $leaves ]]; then
    exit 0
  fi
  for l in $leaves
  do
    cat $workfile | grep -v -e "^$l:" | gsed -E "s#\"$l\"##g" > /tmp/tmp.txt
    cp /tmp/tmp.txt $workfile
    echo $l
  done
done

