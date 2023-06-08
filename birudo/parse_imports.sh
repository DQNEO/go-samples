#!/usr/local/bin/bash
# Parse imports of given go files
set -eu

#TODO: handle multi` times of import in a file
function parseImportDecls() {
  set +e
  local file=$1
  pcregrep -M --only-matching  --no-filename '^\s*import\s+\([^\)]+]*\)' $file\
   | grep -E --only-matching '\"[^\"]+\"' \
   | tr -d '"'

  pcregrep -M --only-matching  --no-filename '^\s*import.*"[^"]+"' $file\
   | grep -E --only-matching '\"[^\"]+\"' \
   | tr -d '"'
  set -e
}

function parse_imports() {
  declare dir=$1
  shift;

  declare readonly files="$@"
  {
    for file in $files
    do
      parseImportDecls "$dir/$file"
    done
  } | sort | uniq | tr '\n' ' ' | awk '{$1=$1;print}'
}

parse_imports "$@"


