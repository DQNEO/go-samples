#!/usr/local/bin/bash
set -eux
rm -f birudo
export GOOS=linux
export GOARCH=amd64
WORK=/tmp/go-build1234567
SRC_DIR=/Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
GORT=/usr/local/opt/go/libexec
TOOL_DIR=$GORT/pkg/tool/darwin_amd64
CACHE_DIR=/Users/DQNEO/Library/Caches/go-build
BLDID=abcdefghijklmnopqrst/abcdefghijklmnopqrst
B="-buildid $BLDID -goversion go1.20.4"

declare -A PKGS=(
[errors]="b003"
[fmt]="b002"
[internal/abi]="b009"
[internal/bytealg]="b010"
[internal/coverage/rtcov]="b012"
[internal/cpu]="b011"
[internal/fmtsort]="b019"
[internal/goarch]="b005"
[internal/goexperiment]="b013"
[internal/goos]="b014"
[internal/itoa]="b021"
[internal/oserror]="b036"
[internal/poll]="b033"
[internal/race]="b027"
[internal/reflectlite]="b004"
[internal/safefilepath]="b038"
[internal/syscall/execenv]="b039"
[internal/syscall/unix]="b034"
[internal/testlog]="b040"
[internal/unsafeheader]="b006"
[io/fs]="b041"
[io]="b031"
[main]="b001"
[math/bits]="b023"
[math]="b022"
[os]="b032"
[path]="b042"
[reflect]="b020"
[runtime/internal/atomic]="b015"
[runtime/internal/math]="b016"
[runtime/internal/sys]="b017"
[runtime/internal/syscall]="b018"
[runtime]="b008"
[sort]="b030"
[strconv]="b024"
[sync/atomic]="b028"
[sync]="b026"
[syscall]="b035"
[time]="b037"
[unicode/utf8]="b025"
[unicode]="b029"
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
[runtime/internal/syscall]=""
[runtime/internal/atomic]=""
[internal/race]=""
[unicode]=""
[sync/atomic]=""


)

declare -A FILES=(
[fmt]="doc.go errors.go format.go print.go scan.go"
[os]="dir.go dir_unix.go dirent_linux.go endian_little.go env.go error.go error_errno.go error_posix.go exec.go exec_posix.go exec_unix.go executable.go executable_procfs.go file.go file_posix.go file_unix.go getwd.go path.go path_unix.go pipe2_unix.go proc.go rawconn.go readfrom_linux.go removeall_at.go stat.go stat_linux.go stat_unix.go sticky_notbsd.go str.go sys.go sys_linux.go sys_unix.go tempfile.go types.go types_unix.go wait_waitid.go"
[internal/fmtsort]="sort.go"
)


function build_pkg_f() {
pkgname=$1
runtime=$2
complete=$3
shift;shift;shift;
files="$@"
bdir=${PKGS[$pkgname]}
wdir=$WORK/$bdir

mkdir -p $wdir/
make_importcfg $pkgname

cmpl $pkgname $runtime $complete $files
$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal
}


function build_pkg() {
pkgname=$1
runtime=$2
complete=$3

bdir=${PKGS[$pkgname]}
wdir=$WORK/$bdir

mkdir -p $wdir/
make_importcfg $pkgname

files=""
for i in ${FILES[$pkgname]}
do
  files="$files $GORT/src/$pkgname/$i"
done

cmpl $pkgname $runtime $complete $files
$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal
}

function make_importcfg() {
pkgname=$1
bdir=${PKGS[$pkgname]}
wdir=$WORK/$bdir
(
echo '# import config'
for i in  ${DEPENDS[$pkgname]}
do
  echo "packagefile $i=$WORK/${PKGS[$i]}/_pkg_.a"
done
) >$wdir/importcfg
}

function cmpl_asm() {
pkg=$1
runtime=$2
complete=$3
shift;shift;shift;
files="$@"

local sruntime=""
if [ "$runtime" = "1" ]; then
  sruntime="-+"
fi

$TOOL_DIR/compile -o $WORK/${PKGS[$pkg]}/_pkg_.a -trimpath "$WORK/${PKGS[$pkg]}=>" -p $pkg\
 -std $sruntime $B\
 -symabis $WORK/${PKGS[$pkg]}/symabis -c=4 -nolocalimports -importcfg $WORK/${PKGS[$pkg]}/importcfg \
 -pack -asmhdr $WORK/${PKGS[$pkg]}/go_asm.h $files

}

function cmpl() {
pkg=$1
runtime=$2
complete=$3
shift;shift;shift;
files="$@"

local sruntime=""
if [ "$runtime" = "1" ]; then
  sruntime="-+"
fi
local scomplete=""
if [ "$complete" = "1" ]; then
  scomplete="-complete"
fi

$TOOL_DIR/compile -o $WORK/${PKGS[$pkg]}/_pkg_.a -trimpath "$WORK/${PKGS[$pkg]}=>"  -p $pkg \
 -std $sruntime $scomplete  $B -c=4 -nolocalimports -importcfg $WORK/${PKGS[$pkg]}/importcfg  -pack $files
}

cd /Users/DQNEO/src/github.com/DQNEO/go-samples

build_pkg_f internal/coverage/rtcov 1 1 $GORT/src/internal/coverage/rtcov/rtcov.go
build_pkg_f internal/unsafeheader 0 1 $GORT/src/internal/unsafeheader/unsafeheader.go
build_pkg_f internal/goarch 1 1 $GORT/src/internal/goarch/goarch.go $GORT/src/internal/goarch/goarch_amd64.go $GORT/src/internal/goarch/zgoarch_amd64.go
build_pkg_f internal/goos 1 1 $GORT/src/internal/goos/goos.go $GORT/src/internal/goos/unix.go $GORT/src/internal/goos/zgoos_linux.go
build_pkg_f internal/goexperiment 0 1 $GORT/src/internal/goexperiment/exp_arenas_off.go $GORT/src/internal/goexperiment/exp_boringcrypto_off.go $GORT/src/internal/goexperiment/exp_coverageredesign_on.go $GORT/src/internal/goexperiment/exp_fieldtrack_off.go $GORT/src/internal/goexperiment/exp_heapminimum512kib_off.go $GORT/src/internal/goexperiment/exp_pagetrace_off.go $GORT/src/internal/goexperiment/exp_preemptibleloops_off.go $GORT/src/internal/goexperiment/exp_regabiargs_on.go $GORT/src/internal/goexperiment/exp_regabiwrappers_on.go $GORT/src/internal/goexperiment/exp_staticlockranking_off.go $GORT/src/internal/goexperiment/exp_unified_on.go $GORT/src/internal/goexperiment/flags.go

# internal/syscall
mkdir -p $WORK/${PKGS[runtime/internal/syscall]}/
make_importcfg runtime/internal/syscall
cd $GORT/src/runtime/internal/syscall
$TOOL_DIR/asm -p runtime/internal/syscall -trimpath "$WORK/${PKGS[runtime/internal/syscall]}=>" -I $WORK/${PKGS[runtime/internal/syscall]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[runtime/internal/syscall]}/symabis ./asm_linux_amd64.s
make_importcfg runtime/internal/syscall
cmpl_asm runtime/internal/syscall 1 0 $GORT/src/runtime/internal/syscall/defs_linux.go $GORT/src/runtime/internal/syscall/defs_linux_amd64.go $GORT/src/runtime/internal/syscall/syscall_linux.go
cd $GORT/src/runtime/internal/syscall
$TOOL_DIR/asm -p runtime/internal/syscall -trimpath "$WORK/${PKGS[runtime/internal/syscall]}=>" -I $WORK/${PKGS[runtime/internal/syscall]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime/internal/syscall]}/asm_linux_amd64.o ./asm_linux_amd64.s
cd $GORT/src/runtime/internal/syscall
$TOOL_DIR/pack r $WORK/${PKGS[runtime/internal/syscall]}/_pkg_.a $WORK/${PKGS[runtime/internal/syscall]}/asm_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[runtime/internal/syscall]}/_pkg_.a # internal

# internal/cpu
mkdir -p $WORK/${PKGS[internal/cpu]}/
cat >$WORK/${PKGS[internal/cpu]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/${PKGS[internal/cpu]}=>" -I $WORK/${PKGS[internal/cpu]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[internal/cpu]}/symabis ./cpu.s ./cpu_x86.s
make_importcfg internal/cpu
cmpl_asm internal/cpu 1 0 $GORT/src/internal/cpu/cpu.go $GORT/src/internal/cpu/cpu_x86.go
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/${PKGS[internal/cpu]}=>" -I $WORK/${PKGS[internal/cpu]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[internal/cpu]}/cpu.o ./cpu.s
cd $GORT/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/${PKGS[internal/cpu]}=>" -I $WORK/${PKGS[internal/cpu]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[internal/cpu]}/cpu_x86.o ./cpu_x86.s
cd $GORT/src/internal/cpu
$TOOL_DIR/pack r $WORK/${PKGS[internal/cpu]}/_pkg_.a $WORK/${PKGS[internal/cpu]}/cpu.o $WORK/${PKGS[internal/cpu]}/cpu_x86.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/cpu]}/_pkg_.a # internal

# internal/atomic
mkdir -p $WORK/${PKGS[runtime/internal/atomic]}/
cat >$WORK/${PKGS[runtime/internal/atomic]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/runtime/internal/atomic
$TOOL_DIR/asm -p runtime/internal/atomic -trimpath "$WORK/${PKGS[runtime/internal/atomic]}=>" -I $WORK/${PKGS[runtime/internal/atomic]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[runtime/internal/atomic]}/symabis ./atomic_amd64.s
make_importcfg runtime/internal/atomic
cmpl_asm runtime/internal/atomic 1 0 $GORT/src/runtime/internal/atomic/atomic_amd64.go $GORT/src/runtime/internal/atomic/doc.go $GORT/src/runtime/internal/atomic/stubs.go $GORT/src/runtime/internal/atomic/types.go $GORT/src/runtime/internal/atomic/types_64bit.go $GORT/src/runtime/internal/atomic/unaligned.go
cd $GORT/src/runtime/internal/atomic
$TOOL_DIR/asm -p runtime/internal/atomic -trimpath "$WORK/${PKGS[runtime/internal/atomic]}=>" -I $WORK/${PKGS[runtime/internal/atomic]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime/internal/atomic]}/atomic_amd64.o ./atomic_amd64.s
cd $SRC_DIR
cd $GORT/src/runtime/internal/atomic
$TOOL_DIR/pack r $WORK/${PKGS[runtime/internal/atomic]}/_pkg_.a $WORK/${PKGS[runtime/internal/atomic]}/atomic_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[runtime/internal/atomic]}/_pkg_.a # internal

build_pkg_f internal/itoa 0 1 $GORT/src/internal/itoa/itoa.go
build_pkg_f unicode/utf8 0 1 $GORT/src/unicode/utf8/utf8.go
build_pkg_f math/bits 0 1 $GORT/src/math/bits/bits.go $GORT/src/math/bits/bits_errors.go $GORT/src/math/bits/bits_tables.go
build_pkg_f runtime/internal/math 1 1 $GORT/src/runtime/internal/math/math.go
build_pkg_f runtime/internal/sys 1 1 $GORT/src/runtime/internal/sys/consts.go $GORT/src/runtime/internal/sys/consts_norace.go $GORT/src/runtime/internal/sys/intrinsics.go $GORT/src/runtime/internal/sys/intrinsics_common.go $GORT/src/runtime/internal/sys/nih.go $GORT/src/runtime/internal/sys/sys.go $GORT/src/runtime/internal/sys/zversion.go
build_pkg_f internal/race 0 1 $GORT/src/internal/race/doc.go $GORT/src/internal/race/norace.go

# internal/abi
mkdir -p $WORK/${PKGS[internal/abi]}/
cat >$WORK/${PKGS[internal/abi]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/abi
$TOOL_DIR/asm -p internal/abi -trimpath "$WORK/${PKGS[internal/abi]}=>" -I $WORK/${PKGS[internal/abi]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[internal/abi]}/symabis ./abi_test.s
cd $GORT/src/internal/abi
$TOOL_DIR/asm -p internal/abi -trimpath "$WORK/${PKGS[internal/abi]}=>" -I $WORK/${PKGS[internal/abi]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[internal/abi]}/abi_test.o ./abi_test.s
make_importcfg internal/abi
cmpl_asm internal/abi 1 0 $GORT/src/internal/abi/abi.go $GORT/src/internal/abi/abi_amd64.go
cd $GORT/src/internal/abi
$TOOL_DIR/pack r $WORK/${PKGS[internal/abi]}/_pkg_.a $WORK/${PKGS[internal/abi]}/abi_test.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/abi]}/_pkg_.a # internal

# sync/atomic
mkdir -p $WORK/${PKGS[sync/atomic]}/
cat >$WORK/${PKGS[sync/atomic]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/sync/atomic
$TOOL_DIR/asm -p sync/atomic -trimpath "$WORK/${PKGS[sync/atomic]}=>" -I $WORK/${PKGS[sync/atomic]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[sync/atomic]}/symabis ./asm.s
make_importcfg sync/atomic
cd $SRC_DIR
cmpl_asm sync/atomic 0 0 $GORT/src/sync/atomic/doc.go $GORT/src/sync/atomic/type.go $GORT/src/sync/atomic/value.go
cd $GORT/src/sync/atomic
$TOOL_DIR/asm -p sync/atomic -trimpath "$WORK/${PKGS[sync/atomic]}=>" -I $WORK/${PKGS[sync/atomic]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[sync/atomic]}/asm.o ./asm.s
cd $GORT/src/sync/atomic
$TOOL_DIR/pack r $WORK/${PKGS[sync/atomic]}/_pkg_.a $WORK/${PKGS[sync/atomic]}/asm.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[sync/atomic]}/_pkg_.a # internal


mkdir -p $WORK/${PKGS[unicode]}/
make_importcfg unicode
cmpl unicode 0 1 $GORT/src/unicode/casetables.go $GORT/src/unicode/digit.go $GORT/src/unicode/graphic.go $GORT/src/unicode/letter.go $GORT/src/unicode/tables.go
$TOOL_DIR/buildid -w $WORK/${PKGS[unicode]}/_pkg_.a # internal


mkdir -p $WORK/${PKGS[internal/bytealg]}/
cat >$WORK/${PKGS[internal/bytealg]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/bytealg
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/${PKGS[internal/bytealg]}=>" -I $WORK/${PKGS[internal/bytealg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[internal/bytealg]}/symabis ./compare_amd64.s ./count_amd64.s ./equal_amd64.s ./index_amd64.s ./indexbyte_amd64.s
make_importcfg internal/bytealg
cd $SRC_DIR
cmpl_asm  internal/bytealg 1 0 $GORT/src/internal/bytealg/bytealg.go $GORT/src/internal/bytealg/compare_native.go $GORT/src/internal/bytealg/count_native.go $GORT/src/internal/bytealg/equal_generic.go $GORT/src/internal/bytealg/equal_native.go $GORT/src/internal/bytealg/index_amd64.go $GORT/src/internal/bytealg/index_native.go $GORT/src/internal/bytealg/indexbyte_native.go
cd $GORT/src/internal/bytealg
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/${PKGS[internal/bytealg]}=>" -I $WORK/${PKGS[internal/bytealg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[internal/bytealg]}/compare_amd64.o ./compare_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/${PKGS[internal/bytealg]}=>" -I $WORK/${PKGS[internal/bytealg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[internal/bytealg]}/count_amd64.o ./count_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/${PKGS[internal/bytealg]}=>" -I $WORK/${PKGS[internal/bytealg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[internal/bytealg]}/equal_amd64.o ./equal_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/${PKGS[internal/bytealg]}=>" -I $WORK/${PKGS[internal/bytealg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[internal/bytealg]}/index_amd64.o ./index_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/${PKGS[internal/bytealg]}=>" -I $WORK/${PKGS[internal/bytealg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[internal/bytealg]}/indexbyte_amd64.o ./indexbyte_amd64.s
$TOOL_DIR/pack r $WORK/${PKGS[internal/bytealg]}/_pkg_.a $WORK/${PKGS[internal/bytealg]}/compare_amd64.o $WORK/${PKGS[internal/bytealg]}/count_amd64.o $WORK/${PKGS[internal/bytealg]}/equal_amd64.o $WORK/${PKGS[internal/bytealg]}/index_amd64.o $WORK/${PKGS[internal/bytealg]}/indexbyte_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/bytealg]}/_pkg_.a # internal


mkdir -p $WORK/${PKGS[math]}/
cat >$WORK/${PKGS[math]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/${PKGS[math]}=>" -I $WORK/${PKGS[math]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[math]}/symabis ./dim_amd64.s ./exp_amd64.s ./floor_amd64.s ./hypot_amd64.s ./log_amd64.s
make_importcfg math
cd $SRC_DIR
cmpl_asm math 0 0 $GORT/src/math/abs.go $GORT/src/math/acosh.go $GORT/src/math/asin.go $GORT/src/math/asinh.go $GORT/src/math/atan.go $GORT/src/math/atan2.go $GORT/src/math/atanh.go $GORT/src/math/bits.go $GORT/src/math/cbrt.go $GORT/src/math/const.go $GORT/src/math/copysign.go $GORT/src/math/dim.go $GORT/src/math/dim_asm.go $GORT/src/math/erf.go $GORT/src/math/erfinv.go $GORT/src/math/exp.go $GORT/src/math/exp2_noasm.go $GORT/src/math/exp_amd64.go $GORT/src/math/exp_asm.go $GORT/src/math/expm1.go $GORT/src/math/floor.go $GORT/src/math/floor_asm.go $GORT/src/math/fma.go $GORT/src/math/frexp.go $GORT/src/math/gamma.go $GORT/src/math/hypot.go $GORT/src/math/hypot_asm.go $GORT/src/math/j0.go $GORT/src/math/j1.go $GORT/src/math/jn.go $GORT/src/math/ldexp.go $GORT/src/math/lgamma.go $GORT/src/math/log.go $GORT/src/math/log10.go $GORT/src/math/log1p.go $GORT/src/math/log_asm.go $GORT/src/math/logb.go $GORT/src/math/mod.go $GORT/src/math/modf.go $GORT/src/math/modf_noasm.go $GORT/src/math/nextafter.go $GORT/src/math/pow.go $GORT/src/math/pow10.go $GORT/src/math/remainder.go $GORT/src/math/signbit.go $GORT/src/math/sin.go $GORT/src/math/sincos.go $GORT/src/math/sinh.go $GORT/src/math/sqrt.go $GORT/src/math/stubs.go $GORT/src/math/tan.go $GORT/src/math/tanh.go $GORT/src/math/trig_reduce.go $GORT/src/math/unsafe.go
cd $GORT/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/${PKGS[math]}=>" -I $WORK/${PKGS[math]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[math]}/dim_amd64.o ./dim_amd64.s
cd $GORT/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/${PKGS[math]}=>" -I $WORK/${PKGS[math]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[math]}/exp_amd64.o ./exp_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/${PKGS[math]}=>" -I $WORK/${PKGS[math]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[math]}/floor_amd64.o ./floor_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/${PKGS[math]}=>" -I $WORK/${PKGS[math]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[math]}/hypot_amd64.o ./hypot_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/${PKGS[math]}=>" -I $WORK/${PKGS[math]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[math]}/log_amd64.o ./log_amd64.s
$TOOL_DIR/pack r $WORK/${PKGS[math]}/_pkg_.a $WORK/${PKGS[math]}/dim_amd64.o $WORK/${PKGS[math]}/exp_amd64.o $WORK/${PKGS[math]}/floor_amd64.o $WORK/${PKGS[math]}/hypot_amd64.o $WORK/${PKGS[math]}/log_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[math]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[runtime]}/
cat >$WORK/${PKGS[runtime]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/runtime
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[runtime]}/symabis ./asm.s ./asm_amd64.s ./duff_amd64.s ./memclr_amd64.s ./memmove_amd64.s ./preempt_amd64.s ./rt0_linux_amd64.s ./sys_linux_amd64.s ./time_linux_amd64.s
make_importcfg runtime
cd $SRC_DIR
cmpl_asm runtime 1 0 $GORT/src/runtime/alg.go $GORT/src/runtime/arena.go $GORT/src/runtime/asan0.go $GORT/src/runtime/atomic_pointer.go $GORT/src/runtime/cgo.go $GORT/src/runtime/cgo_mmap.go $GORT/src/runtime/cgo_sigaction.go $GORT/src/runtime/cgocall.go $GORT/src/runtime/cgocallback.go $GORT/src/runtime/cgocheck.go $GORT/src/runtime/chan.go $GORT/src/runtime/checkptr.go $GORT/src/runtime/compiler.go $GORT/src/runtime/complex.go $GORT/src/runtime/covercounter.go $GORT/src/runtime/covermeta.go $GORT/src/runtime/cpuflags.go $GORT/src/runtime/cpuflags_amd64.go $GORT/src/runtime/cpuprof.go $GORT/src/runtime/cputicks.go $GORT/src/runtime/create_file_unix.go $GORT/src/runtime/debug.go $GORT/src/runtime/debugcall.go $GORT/src/runtime/debuglog.go $GORT/src/runtime/debuglog_off.go $GORT/src/runtime/defs_linux_amd64.go $GORT/src/runtime/env_posix.go $GORT/src/runtime/error.go $GORT/src/runtime/exithook.go $GORT/src/runtime/extern.go $GORT/src/runtime/fastlog2.go $GORT/src/runtime/fastlog2table.go $GORT/src/runtime/float.go $GORT/src/runtime/hash64.go $GORT/src/runtime/heapdump.go $GORT/src/runtime/histogram.go $GORT/src/runtime/iface.go $GORT/src/runtime/lfstack.go $GORT/src/runtime/lfstack_64bit.go $GORT/src/runtime/lock_futex.go $GORT/src/runtime/lockrank.go $GORT/src/runtime/lockrank_off.go $GORT/src/runtime/malloc.go $GORT/src/runtime/map.go $GORT/src/runtime/map_fast32.go $GORT/src/runtime/map_fast64.go $GORT/src/runtime/map_faststr.go $GORT/src/runtime/mbarrier.go $GORT/src/runtime/mbitmap.go $GORT/src/runtime/mcache.go $GORT/src/runtime/mcentral.go $GORT/src/runtime/mcheckmark.go $GORT/src/runtime/mem.go $GORT/src/runtime/mem_linux.go $GORT/src/runtime/metrics.go $GORT/src/runtime/mfinal.go $GORT/src/runtime/mfixalloc.go $GORT/src/runtime/mgc.go $GORT/src/runtime/mgclimit.go $GORT/src/runtime/mgcmark.go $GORT/src/runtime/mgcpacer.go $GORT/src/runtime/mgcscavenge.go $GORT/src/runtime/mgcstack.go $GORT/src/runtime/mgcsweep.go $GORT/src/runtime/mgcwork.go $GORT/src/runtime/mheap.go $GORT/src/runtime/mpagealloc.go $GORT/src/runtime/mpagealloc_64bit.go $GORT/src/runtime/mpagecache.go $GORT/src/runtime/mpallocbits.go $GORT/src/runtime/mprof.go $GORT/src/runtime/mranges.go $GORT/src/runtime/msan0.go $GORT/src/runtime/msize.go $GORT/src/runtime/mspanset.go $GORT/src/runtime/mstats.go $GORT/src/runtime/mwbbuf.go $GORT/src/runtime/nbpipe_pipe2.go $GORT/src/runtime/netpoll.go $GORT/src/runtime/netpoll_epoll.go $GORT/src/runtime/os_linux.go $GORT/src/runtime/os_linux_generic.go $GORT/src/runtime/os_linux_noauxv.go $GORT/src/runtime/os_linux_x86.go $GORT/src/runtime/os_nonopenbsd.go $GORT/src/runtime/pagetrace_off.go $GORT/src/runtime/panic.go $GORT/src/runtime/plugin.go $GORT/src/runtime/preempt.go $GORT/src/runtime/preempt_nonwindows.go $GORT/src/runtime/print.go $GORT/src/runtime/proc.go $GORT/src/runtime/profbuf.go $GORT/src/runtime/proflabel.go $GORT/src/runtime/race0.go $GORT/src/runtime/rdebug.go $GORT/src/runtime/relax_stub.go $GORT/src/runtime/retry.go $GORT/src/runtime/runtime.go $GORT/src/runtime/runtime1.go $GORT/src/runtime/runtime2.go $GORT/src/runtime/runtime_boring.go $GORT/src/runtime/rwmutex.go $GORT/src/runtime/select.go $GORT/src/runtime/sema.go $GORT/src/runtime/signal_amd64.go $GORT/src/runtime/signal_linux_amd64.go $GORT/src/runtime/signal_unix.go $GORT/src/runtime/sigqueue.go $GORT/src/runtime/sigqueue_note.go $GORT/src/runtime/sigtab_linux_generic.go $GORT/src/runtime/sizeclasses.go $GORT/src/runtime/slice.go $GORT/src/runtime/softfloat64.go $GORT/src/runtime/stack.go $GORT/src/runtime/stkframe.go $GORT/src/runtime/string.go $GORT/src/runtime/stubs.go $GORT/src/runtime/stubs2.go $GORT/src/runtime/stubs3.go $GORT/src/runtime/stubs_amd64.go $GORT/src/runtime/stubs_linux.go $GORT/src/runtime/symtab.go $GORT/src/runtime/sys_nonppc64x.go $GORT/src/runtime/sys_x86.go $GORT/src/runtime/time.go $GORT/src/runtime/time_nofake.go $GORT/src/runtime/timeasm.go $GORT/src/runtime/tls_stub.go $GORT/src/runtime/trace.go $GORT/src/runtime/traceback.go $GORT/src/runtime/type.go $GORT/src/runtime/typekind.go $GORT/src/runtime/unsafe.go $GORT/src/runtime/utf8.go $GORT/src/runtime/vdso_elf64.go $GORT/src/runtime/vdso_linux.go $GORT/src/runtime/vdso_linux_amd64.go $GORT/src/runtime/write_err.go
cd $GORT/src/runtime
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/asm.o ./asm.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/asm_amd64.o ./asm_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/duff_amd64.o ./duff_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/memclr_amd64.o ./memclr_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/memmove_amd64.o ./memmove_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/preempt_amd64.o ./preempt_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/rt0_linux_amd64.o ./rt0_linux_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/sys_linux_amd64.o ./sys_linux_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/${PKGS[runtime]}=>" -I $WORK/${PKGS[runtime]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[runtime]}/time_linux_amd64.o ./time_linux_amd64.s
$TOOL_DIR/pack r $WORK/${PKGS[runtime]}/_pkg_.a $WORK/${PKGS[runtime]}/asm.o $WORK/${PKGS[runtime]}/asm_amd64.o $WORK/${PKGS[runtime]}/duff_amd64.o $WORK/${PKGS[runtime]}/memclr_amd64.o $WORK/${PKGS[runtime]}/memmove_amd64.o $WORK/${PKGS[runtime]}/preempt_amd64.o $WORK/${PKGS[runtime]}/rt0_linux_amd64.o $WORK/${PKGS[runtime]}/sys_linux_amd64.o $WORK/${PKGS[runtime]}/time_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[runtime]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[sync]}/
make_importcfg sync
cd $SRC_DIR
cmpl sync 0 0 $GORT/src/sync/cond.go $GORT/src/sync/map.go $GORT/src/sync/mutex.go $GORT/src/sync/once.go $GORT/src/sync/pool.go $GORT/src/sync/poolqueue.go $GORT/src/sync/runtime.go $GORT/src/sync/runtime2.go $GORT/src/sync/rwmutex.go $GORT/src/sync/waitgroup.go
$TOOL_DIR/buildid -w $WORK/${PKGS[sync]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[internal/reflectlite]}/
cat >$WORK/${PKGS[internal/reflectlite]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/reflectlite
$TOOL_DIR/asm -p internal/reflectlite -trimpath "$WORK/${PKGS[internal/reflectlite]}=>" -I $WORK/${PKGS[internal/reflectlite]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[internal/reflectlite]}/symabis ./asm.s
make_importcfg internal/reflectlite
cmpl_asm internal/reflectlite 0 0 $GORT/src/internal/reflectlite/swapper.go $GORT/src/internal/reflectlite/type.go $GORT/src/internal/reflectlite/value.go
cmpl internal/reflectlite 0 0 $GORT/src/internal/reflectlite/swapper.go $GORT/src/internal/reflectlite/type.go $GORT/src/internal/reflectlite/value.go
cd $GORT/src/internal/reflectlite
$TOOL_DIR/asm -p internal/reflectlite -trimpath "$WORK/${PKGS[internal/reflectlite]}=>" -I $WORK/${PKGS[internal/reflectlite]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/${PKGS[internal/reflectlite]}/asm.o ./asm.s
$TOOL_DIR/pack r $WORK/${PKGS[internal/reflectlite]}/_pkg_.a $WORK/${PKGS[internal/reflectlite]}/asm.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/reflectlite]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[internal/testlog]}/
make_importcfg internal/testlog
cmpl internal/testlog 0 1 $GORT/src/internal/testlog/exit.go $GORT/src/internal/testlog/log.go
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/testlog]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[errors]}/
make_importcfg errors
cd $SRC_DIR
cmpl errors 0 1  $GORT/src/errors/errors.go $GORT/src/errors/join.go $GORT/src/errors/wrap.go
$TOOL_DIR/buildid -w $WORK/${PKGS[errors]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[sort]}/
make_importcfg sort
cmpl sort 0 1  $GORT/src/sort/search.go $GORT/src/sort/slice.go $GORT/src/sort/sort.go $GORT/src/sort/zsortfunc.go $GORT/src/sort/zsortinterface.go
$TOOL_DIR/buildid -w $WORK/${PKGS[sort]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[internal/safefilepath]}/
make_importcfg internal/safefilepath
cmpl internal/safefilepath 0 1  $GORT/src/internal/safefilepath/path.go $GORT/src/internal/safefilepath/path_other.go
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/safefilepath]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[internal/oserror]}/
make_importcfg internal/oserror
cmpl internal/oserror 0 1 $GORT/src/internal/oserror/errors.go
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/oserror]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[path]}/
make_importcfg path
cmpl path 0 1 $GORT/src/path/match.go $GORT/src/path/path.go
$TOOL_DIR/buildid -w $WORK/${PKGS[path]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[io]}/
make_importcfg io
cmpl io 0 1 $GORT/src/io/io.go $GORT/src/io/multi.go $GORT/src/io/pipe.go
$TOOL_DIR/buildid -w $WORK/${PKGS[io]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[strconv]}/
make_importcfg strconv
cmpl strconv 0 1 $GORT/src/strconv/atob.go $GORT/src/strconv/atoc.go $GORT/src/strconv/atof.go $GORT/src/strconv/atoi.go $GORT/src/strconv/bytealg.go $GORT/src/strconv/ctoa.go $GORT/src/strconv/decimal.go $GORT/src/strconv/doc.go $GORT/src/strconv/eisel_lemire.go $GORT/src/strconv/ftoa.go $GORT/src/strconv/ftoaryu.go $GORT/src/strconv/isprint.go $GORT/src/strconv/itoa.go $GORT/src/strconv/quote.go
$TOOL_DIR/buildid -w $WORK/${PKGS[strconv]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[syscall]}/
cat >$WORK/${PKGS[syscall]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/syscall
$TOOL_DIR/asm -p syscall -trimpath "$WORK/${PKGS[syscall]}=>" -I $WORK/${PKGS[syscall]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[syscall]}/symabis ./asm_linux_amd64.s
make_importcfg syscall
cd $SRC_DIR
cmpl_asm syscall 0 0 $GORT/src/syscall/asan0.go $GORT/src/syscall/dirent.go $GORT/src/syscall/endian_little.go $GORT/src/syscall/env_unix.go $GORT/src/syscall/exec_linux.go $GORT/src/syscall/exec_unix.go $GORT/src/syscall/flock.go $GORT/src/syscall/lsf_linux.go $GORT/src/syscall/msan0.go $GORT/src/syscall/net.go $GORT/src/syscall/netlink_linux.go $GORT/src/syscall/rlimit.go $GORT/src/syscall/rlimit_stub.go $GORT/src/syscall/setuidgid_linux.go $GORT/src/syscall/sockcmsg_linux.go $GORT/src/syscall/sockcmsg_unix.go $GORT/src/syscall/sockcmsg_unix_other.go $GORT/src/syscall/syscall.go $GORT/src/syscall/syscall_linux.go $GORT/src/syscall/syscall_linux_accept4.go $GORT/src/syscall/syscall_linux_amd64.go $GORT/src/syscall/syscall_unix.go $GORT/src/syscall/time_nofake.go $GORT/src/syscall/timestruct.go $GORT/src/syscall/zerrors_linux_amd64.go $GORT/src/syscall/zsyscall_linux_amd64.go $GORT/src/syscall/zsysnum_linux_amd64.go $GORT/src/syscall/ztypes_linux_amd64.go
cd $GORT/src/syscall
$TOOL_DIR/asm -p syscall -trimpath "$WORK/${PKGS[syscall]}=>" -I $WORK/${PKGS[syscall]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[syscall]}/asm_linux_amd64.o ./asm_linux_amd64.s
$TOOL_DIR/pack r $WORK/${PKGS[syscall]}/_pkg_.a $WORK/${PKGS[syscall]}/asm_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[syscall]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[reflect]}/
cat >$WORK/${PKGS[reflect]}/go_asm.h << EOF # internal
EOF
cd $GORT/src/reflect
$TOOL_DIR/asm -p reflect -trimpath "$WORK/${PKGS[reflect]}=>" -I $WORK/${PKGS[reflect]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[reflect]}/symabis ./asm_amd64.s
make_importcfg reflect
cd $SRC_DIR
cmpl_asm reflect 0 0 $GORT/src/reflect/abi.go $GORT/src/reflect/deepequal.go $GORT/src/reflect/float32reg_generic.go $GORT/src/reflect/makefunc.go $GORT/src/reflect/swapper.go $GORT/src/reflect/type.go $GORT/src/reflect/value.go $GORT/src/reflect/visiblefields.go
cd $GORT/src/reflect
$TOOL_DIR/asm -p reflect -trimpath "$WORK/${PKGS[reflect]}=>" -I $WORK/${PKGS[reflect]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/${PKGS[reflect]}/asm_amd64.o ./asm_amd64.s
cd $GORT/src/reflect
$TOOL_DIR/pack r $WORK/${PKGS[reflect]}/_pkg_.a $WORK/${PKGS[reflect]}/asm_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/${PKGS[reflect]}/_pkg_.a # internal


mkdir -p $WORK/${PKGS[internal/syscall/execenv]}/
make_importcfg internal/syscall/execenv
cd $SRC_DIR
cmpl internal/syscall/execenv 0 1  $GORT/src/internal/syscall/execenv/execenv_default.go
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/syscall/execenv]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[internal/syscall/unix]}/
make_importcfg internal/syscall/unix
cmpl internal/syscall/unix 0 1 $GORT/src/internal/syscall/unix/at.go $GORT/src/internal/syscall/unix/at_fstatat.go $GORT/src/internal/syscall/unix/at_sysnum_linux.go $GORT/src/internal/syscall/unix/at_sysnum_newfstatat_linux.go $GORT/src/internal/syscall/unix/constants.go $GORT/src/internal/syscall/unix/copy_file_range_linux.go $GORT/src/internal/syscall/unix/eaccess_linux.go $GORT/src/internal/syscall/unix/getrandom.go $GORT/src/internal/syscall/unix/getrandom_linux.go $GORT/src/internal/syscall/unix/kernel_version_linux.go $GORT/src/internal/syscall/unix/net.go $GORT/src/internal/syscall/unix/nonblocking.go $GORT/src/internal/syscall/unix/sysnum_linux_amd64.go
$TOOL_DIR/buildid -w $WORK/${PKGS[internal/syscall/unix]}/_pkg_.a # internal

mkdir -p $WORK/${PKGS[time]}/
make_importcfg time
cmpl time 0 0  $GORT/src/time/format.go $GORT/src/time/format_rfc3339.go $GORT/src/time/sleep.go $GORT/src/time/sys_unix.go $GORT/src/time/tick.go $GORT/src/time/time.go $GORT/src/time/zoneinfo.go $GORT/src/time/zoneinfo_goroot.go $GORT/src/time/zoneinfo_read.go $GORT/src/time/zoneinfo_unix.go
$TOOL_DIR/buildid -w $WORK/${PKGS[time]}/_pkg_.a # internal


mkdir -p $WORK/${PKGS[io/fs]}/
make_importcfg io/fs
cmpl io/fs 0 1 $GORT/src/io/fs/fs.go $GORT/src/io/fs/glob.go $GORT/src/io/fs/readdir.go $GORT/src/io/fs/readfile.go $GORT/src/io/fs/stat.go $GORT/src/io/fs/sub.go $GORT/src/io/fs/walk.go
$TOOL_DIR/buildid -w $WORK/${PKGS[io/fs]}/_pkg_.a # internal

build_pkg_f internal/poll 0 0 $GORT/src/internal/poll/copy_file_range_linux.go $GORT/src/internal/poll/errno_unix.go $GORT/src/internal/poll/fcntl_syscall.go $GORT/src/internal/poll/fd.go $GORT/src/internal/poll/fd_fsync_posix.go $GORT/src/internal/poll/fd_mutex.go $GORT/src/internal/poll/fd_poll_runtime.go $GORT/src/internal/poll/fd_posix.go $GORT/src/internal/poll/fd_unix.go $GORT/src/internal/poll/fd_writev_unix.go $GORT/src/internal/poll/hook_cloexec.go $GORT/src/internal/poll/hook_unix.go $GORT/src/internal/poll/iovec_unix.go $GORT/src/internal/poll/sendfile_linux.go $GORT/src/internal/poll/sock_cloexec.go $GORT/src/internal/poll/sockopt.go $GORT/src/internal/poll/sockopt_linux.go $GORT/src/internal/poll/sockopt_unix.go $GORT/src/internal/poll/sockoptip.go $GORT/src/internal/poll/splice_linux.go $GORT/src/internal/poll/writev.go
build_pkg internal/fmtsort 0 1

cd $SRC_DIR
build_pkg os 0 0
build_pkg fmt 0 1



## Final output
function doLink() {
wdir=$WORK/${PKGS[main]}
mkdir -p $wdir/
make_importcfg main

$TOOL_DIR/compile -o $wdir/_pkg_.a -trimpath "$wdir=>" -p main -lang=go1.20 -complete $B -c=4 -nolocalimports -importcfg $wdir/importcfg -pack ./main.go ./sum.go
$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal

cat >$wdir/importcfg.link << EOF # internal
packagefile github.com/DQNEO/go-samples/birudo=$wdir/_pkg_.a
packagefile fmt=$WORK/${PKGS[fmt]}/_pkg_.a
packagefile runtime=$WORK/${PKGS[runtime]}/_pkg_.a
packagefile errors=$WORK/${PKGS[errors]}/_pkg_.a
packagefile internal/fmtsort=$WORK/${PKGS[internal/fmtsort]}/_pkg_.a
packagefile io=$WORK/${PKGS[io]}/_pkg_.a
packagefile math=$WORK/${PKGS[math]}/_pkg_.a
packagefile os=$WORK/${PKGS[os]}/_pkg_.a
packagefile reflect=$WORK/${PKGS[reflect]}/_pkg_.a
packagefile sort=$WORK/${PKGS[sort]}/_pkg_.a
packagefile strconv=$WORK/${PKGS[strconv]}/_pkg_.a
packagefile sync=$WORK/${PKGS[sync]}/_pkg_.a
packagefile unicode/utf8=$WORK/${PKGS[unicode/utf8]}/_pkg_.a
packagefile internal/abi=$WORK/${PKGS[internal/abi]}/_pkg_.a
packagefile internal/bytealg=$WORK/${PKGS[internal/bytealg]}/_pkg_.a
packagefile internal/coverage/rtcov=$WORK/${PKGS[internal/coverage/rtcov]}/_pkg_.a
packagefile internal/cpu=$WORK/${PKGS[internal/cpu]}/_pkg_.a
packagefile internal/goarch=$WORK/${PKGS[internal/goarch]}/_pkg_.a
packagefile internal/goexperiment=$WORK/${PKGS[internal/goexperiment]}/_pkg_.a
packagefile internal/goos=$WORK/${PKGS[internal/goos]}/_pkg_.a
packagefile runtime/internal/atomic=$WORK/${PKGS[runtime/internal/atomic]}/_pkg_.a
packagefile runtime/internal/math=$WORK/${PKGS[runtime/internal/math]}/_pkg_.a
packagefile runtime/internal/sys=$WORK/${PKGS[runtime/internal/sys]}/_pkg_.a
packagefile runtime/internal/syscall=$WORK/${PKGS[runtime/internal/syscall]}/_pkg_.a
packagefile internal/reflectlite=$WORK/${PKGS[internal/reflectlite]}/_pkg_.a
packagefile math/bits=$WORK/${PKGS[math/bits]}/_pkg_.a
packagefile internal/itoa=$WORK/${PKGS[internal/itoa]}/_pkg_.a
packagefile internal/poll=$WORK/${PKGS[internal/poll]}/_pkg_.a
packagefile internal/safefilepath=$WORK/${PKGS[internal/safefilepath]}/_pkg_.a
packagefile internal/syscall/execenv=$WORK/${PKGS[internal/syscall/execenv]}/_pkg_.a
packagefile internal/syscall/unix=$WORK/${PKGS[internal/syscall/unix]}/_pkg_.a
packagefile internal/testlog=$WORK/${PKGS[internal/testlog]}/_pkg_.a
packagefile io/fs=$WORK/${PKGS[io/fs]}/_pkg_.a
packagefile sync/atomic=$WORK/${PKGS[sync/atomic]}/_pkg_.a
packagefile syscall=$WORK/${PKGS[syscall]}/_pkg_.a
packagefile time=$WORK/${PKGS[time]}/_pkg_.a
packagefile internal/unsafeheader=$WORK/${PKGS[internal/unsafeheader]}/_pkg_.a
packagefile unicode=$WORK/${PKGS[unicode]}/_pkg_.a
packagefile internal/race=$WORK/${PKGS[internal/race]}/_pkg_.a
packagefile internal/oserror=$WORK/${PKGS[internal/oserror]}/_pkg_.a
packagefile path=$WORK/${PKGS[path]}/_pkg_.a
modinfo "0w\xaf\f\x92t\b\x02A\xe1\xc1\a\xe6\xd6\x18\xe6path\tgithub.com/DQNEO/go-samples/birudo\nmod\tgithub.com/DQNEO/go-samples/birudo\t(devel)\t\nbuild\t-buildmode=exe\nbuild\t-compiler=gc\nbuild\tCGO_ENABLED=0\nbuild\tGOARCH=amd64\nbuild\tGOOS=linux\nbuild\tGOAMD64=v1\nbuild\tvcs=git\nbuild\tvcs.revision=a721858f4c22cb178c3f3853f9c55aa3773afc2c\nbuild\tvcs.time=2023-06-02T12:08:04Z\nbuild\tvcs.modified=true\n\xf92C1\x86\x18 r\x00\x82B\x10A\x16\xd8\xf2"
EOF
mkdir -p $wdir/exe/
cd .
$TOOL_DIR/link -o $wdir/exe/a.out -importcfg $wdir/importcfg.link -buildmode=exe -buildid=yekYyg_HZMgX517VPpiO/aHxht5d7JGm1qJULUhhT/ct0PU8-vieH10gtMxGeC/yekYyg_HZMgX517VPpiO -extld=cc $wdir/_pkg_.a
$TOOL_DIR/buildid -w $wdir/exe/a.out # internal
mv $wdir/exe/a.out birudo
rm -r $wdir/
}

doLink
