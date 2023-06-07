#!/usr/local/bin/bash
set -eux

export GOOS=linux
export GOARCH=amd64
WORK=/tmp/go-build1234567
OUT_FILE=birudo2
SRC_DIR=/Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
GORT=`go env GOROOT`
TOOL_DIR=$GORT/pkg/tool/darwin_amd64
BLDID=abcdefghijklmnopqrst/abcdefghijklmnopqrst
B="-buildid $BLDID -goversion go1.20.4"

declare -A PKGS=(
[main]="b001"
[fmt]="b002"
[errors]="b003"
[internal/reflectlite]="b004"
[internal/goarch]="b005"
[internal/unsafeheader]="b006"
[runtime]="b008"
[internal/abi]="b009"
[internal/bytealg]="b010"
[internal/cpu]="b011"
[internal/coverage/rtcov]="b012"
[internal/goexperiment]="b013"
[internal/goos]="b014"
[runtime/internal/atomic]="b015"
[runtime/internal/math]="b016"
[runtime/internal/sys]="b017"
[runtime/internal/syscall]="b018"
[internal/fmtsort]="b019"
[reflect]="b020"
[internal/itoa]="b021"
[math]="b022"
[math/bits]="b023"
[strconv]="b024"
[unicode/utf8]="b025"
[sync]="b026"
[internal/race]="b027"
[sync/atomic]="b028"
[unicode]="b029"
[sort]="b030"
[io]="b031"
[os]="b032"
[internal/poll]="b033"
[internal/syscall/unix]="b034"
[syscall]="b035"
[internal/oserror]="b036"
[time]="b037"
[internal/safefilepath]="b038"
[internal/syscall/execenv]="b039"
[internal/testlog]="b040"
[io/fs]="b041"
[path]="b042"

)

declare -A DEPENDS=(
[main]="fmt runtime"
[fmt]="errors internal/fmtsort io math os reflect sort strconv sync unicode/utf8 "
[os]="errors internal/itoa internal/poll internal/safefilepath internal/syscall/execenv internal/syscall/unix internal/testlog io io/fs runtime sort sync sync/atomic syscall time"
[internal/fmtsort]="reflect sort"
[sync]="internal/race runtime sync/atomic"
[internal/reflectlite]="internal/goarch internal/unsafeheader runtime"
[internal/testlog]="sync sync/atomic"
[errors]="internal/reflectlite"
[sort]="internal/reflectlite math/bits"
[internal/abi]="internal/goarch"
[runtime/internal/math]="internal/goarch"
[runtime/internal/sys]="internal/goarch internal/goos"
[internal/bytealg]="internal/cpu"
[math]="internal/cpu math/bits"
[runtime]="internal/abi internal/bytealg internal/coverage/rtcov internal/cpu internal/goarch internal/goexperiment internal/goos runtime/internal/atomic runtime/internal/math runtime/internal/sys runtime/internal/syscall"
[internal/safefilepath]="errors runtime"
[internal/oserror]="errors"
[path]="errors internal/bytealg unicode/utf8"
[io]="errors sync"
[strconv]="errors internal/bytealg math math/bits unicode/utf8 "
[syscall]="errors internal/bytealg internal/itoa internal/oserror internal/race runtime sync sync/atomic "
[reflect]="errors internal/abi internal/bytealg internal/goarch internal/itoa internal/unsafeheader math runtime strconv sync unicode unicode/utf8 "
[internal/syscall/execenv]="syscall"
[internal/syscall/unix]="sync/atomic syscall"
[time]="errors runtime sync syscall "
[io/fs]="errors internal/oserror io path sort time unicode/utf8 "
[internal/poll]="errors internal/syscall/unix io runtime sync sync/atomic syscall time "

[internal/coverage/rtcov]=""
[internal/unsafeheader]=""
[internal/goarch]=""
[internal/goos]=""
[internal/goexperiment]=""
[runtime/internal/syscall]=""
[internal/itoa]=""
[unicode/utf8]=""
[math/bits]=""
[internal/cpu]=""
[runtime/internal/atomic]=""
[internal/race]=""
[unicode]=""
[sync/atomic]=""
)

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

$TOOL_DIR/compile -c=4 -nolocalimports -pack $pkgopts $otheropts $gofiles
if [[ -n $afiles ]]; then
  append_asm $pkg $afiles
fi
$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal

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
rm -r $wdir/
}

# main procedure

rm -f $OUT_FILE

std_pkgs="
 internal/coverage/rtcov
 internal/unsafeheader
 internal/goarch
 internal/goos
 internal/goexperiment
 runtime/internal/syscall
 internal/cpu
 internal/itoa
 unicode/utf8
 math/bits
 runtime/internal/math
 runtime/internal/sys
 internal/race
 internal/abi
 sync/atomic
 unicode
 internal/bytealg
 math
 runtime
 sync
 internal/reflectlite
 internal/testlog
 errors
 sort
 internal/safefilepath
 internal/oserror
 path
 io
 strconv
 syscall
 reflect
 internal/syscall/execenv
 runtime/internal/atomic
 internal/syscall/unix
 time
 io/fs
 internal/poll
 internal/fmtsort
 os
 fmt
"

for pkg in $std_pkgs
do
  dir=$GOROOT/src/$pkg
  build_pkg 1 $pkg $(./find_files.sh $dir)
done

cd $SRC_DIR
build_pkg 0 "main" $(./find_files.sh .)
do_link
