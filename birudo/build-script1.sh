#!/usr/local/bin/bash
set -eu

export GOOS=linux
export GOARCH=amd64
WORK=/tmp/go-build/0607-1531
OUT_FILE=birudo2
SRC_DIR=/Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
GORT=`go env GOROOT`
TOOL_DIR=$GORT/pkg/tool/darwin_amd64
BLDID=abcdefghijklmnopqrst/abcdefghijklmnopqrst
B="-buildid $BLDID -goversion go1.20.4"

declare -A PKGS=()
declare -A DEPENDS=()

function dump_depend_tree() {
  for p in "${!DEPENDS[@]}"
  do
    echo -n "$p:"
    for v in ${DEPENDS[$p]}
    do
      for w in $v
      do
      echo -n "\"$w\" "
      done
    done
    echo ""
  done
}

function build_pkg() {
std=$1
pkg=$2
shift;shift;
filenames="$@"

local gofiles=""
local afiles=""

for f in $filenames
do
  local file
  if [[ $std == "1" ]]; then
    file=$GORT/src/$pkg/$f
  else
    file=$f
  fi
  if [[ $f == *.go ]] ; then
    gofiles="$gofiles $file"
  elif [[ $f == *.s ]]; then
     afiles="$afiles $file"
  else
     echo "ERROR" >/dev/stderr
     exit 1
  fi
done

local wdir=$WORK/${PKGS[$pkg]}
mkdir -p $wdir/
make_importcfg $pkg

local asmopts=""
local sruntime=""
local scomplete=""
local sstd=""
local slang=""

if [[ -n $afiles ]]; then
  if [[ "$std" = "1" ]]; then
    touch $wdir/go_asm.h
  fi
  gen_symabis $pkg $afiles
  asmopts="-symabis $wdir/symabis -asmhdr $wdir/go_asm.h"
fi

if [[ $pkg = "runtime" ]]; then
  sruntime="-+"
fi

complete="1"
if [[ -n $afiles ]]; then
  complete="0"
fi
if [[ "$std" = "1" ]]; then
  # see /usr/local/opt/go/libexec/src/cmd/go/internal/work/gc.go:119
  if [[ $pkg = "os"  ]] || [[ $pkg = "sync" ]] || [[ $pkg = "syscall" ]] \
   || [[ $pkg = "internal/poll" ]] || [[ $pkg = "time" ]]; then
    complete="0"
  fi
fi

if [ "$complete" = "1" ]; then
  scomplete="-complete"
fi
if [ "$std" = "1" ]; then
  sstd="-std"
fi
if [ "$pkg" = "main" ]; then
  slang="-lang=go1.20"
fi

local otheropts=" $slang $sstd $sruntime $scomplete $asmopts "
local pkgopts=$(get_package_opts $pkg)

set -x
$TOOL_DIR/compile -c=4 -nolocalimports -pack $pkgopts $otheropts $gofiles
if [[ -n $afiles ]]; then
  append_asm $pkg $afiles
fi
$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal
set +x
}

function make_importcfg() {
pkg=$1
wdir=$WORK/${PKGS[$pkg]}
(
echo '# import config'
for f in  ${DEPENDS[$pkg]}
do
  echo "packagefile $f=$WORK/${PKGS[$f]}/_pkg_.a"
done
) >$wdir/importcfg
}

function gen_symabis() {
pkg=$1
shift
files="$@"
wdir=$WORK/${PKGS[$pkg]}

$TOOL_DIR/asm -p $pkg -trimpath "$wdir=>" -I $wdir/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $wdir/symabis  $files
}

function append_asm() {
pkg=$1
shift
files="$@"

wdir=$WORK/${PKGS[$pkg]}
local ofiles=""
for f in $files
do
  local basename=${f##*/}
  local baseo=${basename%.s}.o
  local ofile=$wdir/$baseo
  $TOOL_DIR/asm -p $pkg -trimpath "$wdir=>" -I $wdir/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1  -o $ofile $f
  ofiles="$ofiles $ofile"
done

$TOOL_DIR/pack r $wdir/_pkg_.a $ofiles

}

function get_package_opts() {
  pkg=$1
  wdir=$WORK/${PKGS[$pkg]}
  local pkgopts=" \
    -p $pkg \
    -o $wdir/_pkg_.a \
    -trimpath \"$wdir=>\" \
    $B \
    -importcfg $wdir/importcfg \
  "
  echo $pkgopts
}

## Final output
function do_link() {
local pkg=main
local wdir=$WORK/${PKGS[$pkg]}
local pkgsfiles=""
for p in "${!PKGS[@]}"
do
  pkgsfiles="${pkgsfiles}packagefile ${p}=$WORK/${PKGS[$p]}/_pkg_.a
"
done
cat >$wdir/importcfg.link << EOF # internal
packagefile github.com/DQNEO/go-samples/birudo=$wdir/_pkg_.a
$pkgsfiles
modinfo "0w\xaf\f\x92t\b\x02A\xe1\xc1\a\xe6\xd6\x18\xe6path\tgithub.com/DQNEO/go-samples/birudo\nmod\tgithub.com/DQNEO/go-samples/birudo\t(devel)\t\nbuild\t-buildmode=exe\nbuild\t-compiler=gc\nbuild\tCGO_ENABLED=0\nbuild\tGOARCH=amd64\nbuild\tGOOS=linux\nbuild\tGOAMD64=v1\nbuild\tvcs=git\nbuild\tvcs.revision=a721858f4c22cb178c3f3853f9c55aa3773afc2c\nbuild\tvcs.time=2023-06-02T12:08:04Z\nbuild\tvcs.modified=true\n\xf92C1\x86\x18 r\x00\x82B\x10A\x16\xd8\xf2"
EOF

mkdir -p $wdir/exe/
cd .
$TOOL_DIR/link -o $wdir/exe/a.out -importcfg $wdir/importcfg.link -buildmode=exe -buildid=yekYyg_HZMgX517VPpiO/aHxht5d7JGm1qJULUhhT/ct0PU8-vieH10gtMxGeC/yekYyg_HZMgX517VPpiO -extld=cc $wdir/_pkg_.a
$TOOL_DIR/buildid -w $wdir/exe/a.out # internal
mv $wdir/exe/a.out $OUT_FILE
}

function find_depends() {
  local pkg=$1
  if [ -v 'DEPENDS[$pkg]' ]; then
    return
  fi
  local dir=$(get_std_pkg_dir $pkg)
  local files=$(./find_files.sh $dir)
  local _pkgs=$(./parse_imports.sh $dir $files )
  local pkgs=""
  for _pkg in $_pkgs
  do
    if [[ $_pkg != "unsafe" ]]; then
      if [[ -z $pkgs ]]; then
        pkgs=$_pkg
      else
        pkgs="$pkgs $_pkg"
      fi
    fi
  done

  #echo "[$pkg]=\"$pkgs\""
  DEPENDS[$pkg]=$pkgs

  for _pkg in $pkgs
  do
    find_depends $_pkg
  done
}

function resolve_dep_tree() {
    local files="$@" # main files
    local pkgs=$( ./parse_imports.sh . $files )
    DEPENDS[main]=$pkgs

    for pkg in $pkgs
    do
      find_depends $pkg
    done
}

function get_std_pkg_dir() {
  local pkg=$1
  echo $GOROOT/src/$pkg
}
# main procedure

rm -f $OUT_FILE



PKGS[main]=1
id=2

resolve_dep_tree $(./find_files.sh .)
mkdir -p $WORK
dump_depend_tree > $WORK/depends.txt
./tsort.sh  $WORK/depends.txt > $WORK/sorted.txt

std_pkgs=`cat $WORK/sorted.txt | grep -v -e '^main$'`
for pkg in $std_pkgs
do
  PKGS[$pkg]=$id
  id=$((id + 1))
done

for pkg in $std_pkgs
do
  dir=$(get_std_pkg_dir $pkg)
  build_pkg 1 $pkg $(./find_files.sh $dir)
done

cd $SRC_DIR
build_pkg 0 "main" $(./find_files.sh .)
do_link
