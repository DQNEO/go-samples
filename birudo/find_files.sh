#!/usr/local/bin/bash
set -eu
GOROOT=`go env GOROOT`

function log() {
  if eval $debug ; then
    echo "$@" >/dev/stderr
  fi
}

function list_files_in_dir() {
  local dir=$1
  gfind $dir -maxdepth 1 -type f \( -name "*.go" -o -name "*.s" \) -printf "%f\n" \
   | grep -v -E '_test.go' | sort
}

function exclude_arch() {
  grep -v -E '_(android|ios|illumos|hurd|zos|darwin|plan9|windows|aix|dragonfly|freebsd|js|netbsd|openbsd|solaris)(\.|_)' \
   | grep -v -E '_(386|arm|armbe|arm64|arm64be|loong64|mips|mipsle|mips64.*|ppc64|ppc64le|riscv64|ppc|riscv|s390|s390x|sparc.*|wasm)\.(go|s)'
}

function get_build_tag() {
  local fullpath=$1
  set +e
  matched=`grep -m 1 --only-matching -E '^//go:build .+$' $fullpath`
  set -e
  matched=${matched##"//go:build "}
  echo $matched
}

function match_arch() {
  local matched=$1
      log -n "[$f: '$matched' ]"
      if [[ $matched = "ignore" ]]; then
       # ignore
       return 1
      elif [[ -z $matched ]]; then
        # empty
         return 0
      else
      converted=$(echo $matched \
      | gsed -E 's/(unix|linux|amd64)/@@@/g' \
      | gsed -E 's/goexperiment\.(coverageredesign|regabiwrappers|regabiargs|unified)/@@@/' | gsed -E 's/goexperiment\.\w+/false/g' \
      | gsed -E 's/\w+/false/g' | gsed -E 's/@@@/true/g' \
      | gsed -e 's/!true/false/g' | gsed -e 's/!false/true/g' \
      | gsed -e 's/^true ||.*/true/' | gsed -e 's/^true &&//g' | gsed -e 's/^false ||//g' | gsed -e 's/^false &&.*/false/g' \
       )
           log -n "=> '$converted'"
        if eval $converted ; then
           # do build
           return 0
        else
          return 1
       fi
      fi

}

function find_files_in_dir() {
  local dir=$1
  local debug=$2
  local files=$(list_files_in_dir $dir | exclude_arch)
  local gofiles=""
  local sfiles=""

  local buildfiles=""

  for f in $files
  do
    local fullpath="$dir/$f"
    local tag=$(get_build_tag $fullpath)
    if match_arch "$tag" ; then
         log " => ok"
         buildfiles="$buildfiles $f"
    else
         log " => ng"
    fi
  done

  for f in $buildfiles
  do
    if [[ $f == *.go ]] ; then
      gofiles="$gofiles $f"
    elif [[ $f == *.s ]] ; then
      sfiles="$sfiles $f"
    else
      log ERROR
      exit 1
    fi
  done

  for s in $gofiles
  do
    echo -n " $s"
  done

  for s in $sfiles
  do
    echo -n " $s"
  done

  echo ''

}

dir=$1
debug="false" # true or false
if [[ $# -ge 2 ]] && [[ $2 = "true" ]]; then
  debug="true"
fi

find_files_in_dir $dir $debug
