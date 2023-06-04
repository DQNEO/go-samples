#!/usr/local/bin/bash
set -eux

export GOOS=linux
export GOARCH=amd64
WORK=/tmp/go-build1234567
SRC_DIR=/Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
GORT=/usr/local/opt/go/libexec
TOOL_DIR=$GORT/pkg/tool/darwin_amd64
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
[runtime/internal/atomic]=""
[internal/race]=""
[unicode]=""
[sync/atomic]=""
)

function build_pkg() {
pkgname=$1
runtime=$2
complete=$3
shift;shift;shift;
filenames="$@"
bdir=${PKGS[$pkgname]}
wdir=$WORK/$bdir

local gofiles=""
local afiles=""
  for f in $filenames
  do
    if [[ $f == *.go ]] ; then
      gofiles="$gofiles $GORT/src/$pkgname/$f"
    elif [[ $f == *.s ]]; then
       afiles="$afiles $GORT/src/$pkgname/$f"
    else
       echo "ERROR" >/dev/stderr
       exit 1
    fi
  done

mkdir -p $wdir/
make_importcfg $pkgname

if [[ -n $afiles ]]; then
  gen_symabis $pkgname $afiles
  compile $pkgname 1 $runtime 0 $gofiles
  append_asm $pkgname $afiles
else
  compile $pkgname 0 $runtime $complete $gofiles
fi

$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal
}

function make_importcfg() {
pkgname=$1
bdir=${PKGS[$pkgname]}
wdir=$WORK/$bdir
(
echo '# import config'
for f in  ${DEPENDS[$pkgname]}
do
  echo "packagefile $f=$WORK/${PKGS[$f]}/_pkg_.a"
done
) >$wdir/importcfg
}

function gen_symabis() {
pkg=$1
shift
files="$@"
$TOOL_DIR/asm -p $pkg -trimpath "$WORK/${PKGS[$pkg]}=>" -I $WORK/${PKGS[$pkg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/${PKGS[$pkg]}/symabis  $files
}

function append_asm() {
pkg=$1
shift
files="$@"
local ofiles=""
for f in $files
do
  local basename=${f##*/}
  local baseo=${basename%.s}.o
  local ofile=$WORK/${PKGS[$pkg]}/$baseo
  $TOOL_DIR/asm -p $pkg -trimpath "$WORK/${PKGS[$pkg]}=>" -I $WORK/${PKGS[$pkg]}/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1  -o $ofile $f
  ofiles="$ofiles $ofile"
done

$TOOL_DIR/pack r $WORK/${PKGS[$pkg]}/_pkg_.a $ofiles

}

function compile() {
pkg=$1
asm=$2
runtime=$3
complete=$4
shift;shift;shift;shift;
files="$@"

local sruntime=""
if [ "$runtime" = "1" ]; then
  sruntime="-+"
fi
local scomplete=""
if [ "$complete" = "1" ]; then
  scomplete="-complete"
fi
local asmopts=""

if [[ $asm = "1" ]]; then
  scomplete=""
  asmopts="-symabis $WORK/${PKGS[$pkg]}/symabis -asmhdr $WORK/${PKGS[$pkg]}/go_asm.h"
fi

$TOOL_DIR/compile -p $pkg -o $WORK/${PKGS[$pkg]}/_pkg_.a \
 -trimpath "$WORK/${PKGS[$pkg]}=>" \
 -std $sruntime \
 $scomplete $B \
 -c=4 -nolocalimports \
 -importcfg $WORK/${PKGS[$pkg]}/importcfg \
 -pack \
 $asmopts \
 $files
}

rm -f birudo
cd /Users/DQNEO/src/github.com/DQNEO/go-samples

#         pkgname                  r c files
build_pkg internal/coverage/rtcov  1 1 rtcov.go
build_pkg internal/unsafeheader    0 1 unsafeheader.go
build_pkg internal/goarch          1 1 goarch.go goarch_amd64.go zgoarch_amd64.go
build_pkg internal/goos            1 1 goos.go unix.go zgoos_linux.go
build_pkg internal/goexperiment    0 1 exp_arenas_off.go exp_boringcrypto_off.go exp_coverageredesign_on.go exp_fieldtrack_off.go exp_heapminimum512kib_off.go exp_pagetrace_off.go exp_preemptibleloops_off.go exp_regabiargs_on.go exp_regabiwrappers_on.go exp_staticlockranking_off.go exp_unified_on.go flags.go
build_pkg runtime/internal/syscall 1 2 defs_linux.go defs_linux_amd64.go syscall_linux.go asm_linux_amd64.s
build_pkg internal/cpu             1 2 cpu.go cpu_x86.go cpu.s cpu_x86.s
build_pkg runtime/internal/atomic  1 2 atomic_amd64.go doc.go stubs.go types.go types_64bit.go unaligned.go atomic_amd64.s
build_pkg internal/itoa            0 1 itoa.go
build_pkg unicode/utf8             0 1 utf8.go
build_pkg math/bits                0 1 bits.go bits_errors.go bits_tables.go
build_pkg runtime/internal/math    1 1 math.go
build_pkg runtime/internal/sys     1 1 consts.go consts_norace.go intrinsics.go intrinsics_common.go nih.go sys.go zversion.go
build_pkg internal/race            0 1 doc.go norace.go
build_pkg internal/abi             1 2 abi.go abi_amd64.go abi_test.s
build_pkg sync/atomic              0 2 doc.go type.go value.go asm.s
build_pkg unicode                  0 1 casetables.go digit.go graphic.go letter.go tables.go
build_pkg internal/bytealg         1 2 bytealg.go compare_native.go count_native.go equal_generic.go equal_native.go index_amd64.go index_native.go indexbyte_native.go compare_amd64.s count_amd64.s equal_amd64.s index_amd64.s indexbyte_amd64.s
build_pkg math                     0 2 abs.go acosh.go asin.go asinh.go atan.go atan2.go atanh.go bits.go cbrt.go const.go copysign.go dim.go dim_asm.go erf.go erfinv.go exp.go exp2_noasm.go exp_amd64.go exp_asm.go expm1.go floor.go floor_asm.go fma.go frexp.go gamma.go hypot.go hypot_asm.go j0.go j1.go jn.go ldexp.go lgamma.go log.go log10.go log1p.go log_asm.go logb.go mod.go modf.go modf_noasm.go nextafter.go pow.go pow10.go remainder.go signbit.go sin.go sincos.go sinh.go sqrt.go stubs.go tan.go tanh.go trig_reduce.go unsafe.go dim_amd64.s exp_amd64.s floor_amd64.s hypot_amd64.s log_amd64.s
build_pkg runtime                  1 2 alg.go arena.go asan0.go atomic_pointer.go cgo.go cgo_mmap.go cgo_sigaction.go cgocall.go cgocallback.go cgocheck.go chan.go checkptr.go compiler.go complex.go covercounter.go covermeta.go cpuflags.go cpuflags_amd64.go cpuprof.go cputicks.go create_file_unix.go debug.go debugcall.go debuglog.go debuglog_off.go defs_linux_amd64.go env_posix.go error.go exithook.go extern.go fastlog2.go fastlog2table.go float.go hash64.go heapdump.go histogram.go iface.go lfstack.go lfstack_64bit.go lock_futex.go lockrank.go lockrank_off.go malloc.go map.go map_fast32.go map_fast64.go map_faststr.go mbarrier.go mbitmap.go mcache.go mcentral.go mcheckmark.go mem.go mem_linux.go metrics.go mfinal.go mfixalloc.go mgc.go mgclimit.go mgcmark.go mgcpacer.go mgcscavenge.go mgcstack.go mgcsweep.go mgcwork.go mheap.go mpagealloc.go mpagealloc_64bit.go mpagecache.go mpallocbits.go mprof.go mranges.go msan0.go msize.go mspanset.go mstats.go mwbbuf.go nbpipe_pipe2.go netpoll.go netpoll_epoll.go os_linux.go os_linux_generic.go os_linux_noauxv.go os_linux_x86.go os_nonopenbsd.go pagetrace_off.go panic.go plugin.go preempt.go preempt_nonwindows.go print.go proc.go profbuf.go proflabel.go race0.go rdebug.go relax_stub.go retry.go runtime.go runtime1.go runtime2.go runtime_boring.go rwmutex.go select.go sema.go signal_amd64.go signal_linux_amd64.go signal_unix.go sigqueue.go sigqueue_note.go sigtab_linux_generic.go sizeclasses.go slice.go softfloat64.go stack.go stkframe.go string.go stubs.go stubs2.go stubs3.go stubs_amd64.go stubs_linux.go symtab.go sys_nonppc64x.go sys_x86.go time.go time_nofake.go timeasm.go tls_stub.go trace.go traceback.go type.go typekind.go unsafe.go utf8.go vdso_elf64.go vdso_linux.go vdso_linux_amd64.go write_err.go asm.s asm_amd64.s duff_amd64.s memclr_amd64.s memmove_amd64.s preempt_amd64.s rt0_linux_amd64.s sys_linux_amd64.s time_linux_amd64.s
build_pkg sync                     0 0 cond.go map.go mutex.go once.go pool.go poolqueue.go runtime.go runtime2.go rwmutex.go waitgroup.go
build_pkg internal/reflectlite     0 2 swapper.go type.go value.go asm.s
build_pkg internal/testlog         0 1 exit.go log.go
build_pkg errors                   0 1 errors.go join.go wrap.go
build_pkg sort                     0 1 search.go slice.go sort.go zsortfunc.go zsortinterface.go
build_pkg internal/safefilepath    0 1 path.go path_other.go
build_pkg internal/oserror         0 1 errors.go
build_pkg path                     0 1 match.go path.go
build_pkg io                       0 1 io.go multi.go pipe.go
build_pkg strconv                  0 1 atob.go atoc.go atof.go atoi.go bytealg.go ctoa.go decimal.go doc.go eisel_lemire.go ftoa.go ftoaryu.go isprint.go itoa.go quote.go
build_pkg syscall                  0 2 asan0.go dirent.go endian_little.go env_unix.go exec_linux.go exec_unix.go flock.go lsf_linux.go msan0.go net.go netlink_linux.go rlimit.go rlimit_stub.go setuidgid_linux.go sockcmsg_linux.go sockcmsg_unix.go sockcmsg_unix_other.go syscall.go syscall_linux.go syscall_linux_accept4.go syscall_linux_amd64.go syscall_unix.go time_nofake.go timestruct.go zerrors_linux_amd64.go zsyscall_linux_amd64.go zsysnum_linux_amd64.go ztypes_linux_amd64.go asm_linux_amd64.s
build_pkg reflect                  0 2 abi.go deepequal.go float32reg_generic.go makefunc.go swapper.go type.go value.go visiblefields.go asm_amd64.s
build_pkg internal/syscall/execenv 0 1 execenv_default.go
build_pkg internal/syscall/unix    0 1 at.go at_fstatat.go at_sysnum_linux.go at_sysnum_newfstatat_linux.go constants.go copy_file_range_linux.go eaccess_linux.go getrandom.go getrandom_linux.go kernel_version_linux.go net.go nonblocking.go sysnum_linux_amd64.go
build_pkg time                     0 0 format.go format_rfc3339.go sleep.go sys_unix.go tick.go time.go zoneinfo.go zoneinfo_goroot.go zoneinfo_read.go zoneinfo_unix.go
build_pkg io/fs                    0 1 fs.go glob.go readdir.go readfile.go stat.go sub.go walk.go
build_pkg internal/poll            0 0 copy_file_range_linux.go errno_unix.go fcntl_syscall.go fd.go fd_fsync_posix.go fd_mutex.go fd_poll_runtime.go fd_posix.go fd_unix.go fd_writev_unix.go hook_cloexec.go hook_unix.go iovec_unix.go sendfile_linux.go sock_cloexec.go sockopt.go sockopt_linux.go sockopt_unix.go sockoptip.go splice_linux.go writev.go
build_pkg internal/fmtsort         0 1 sort.go
build_pkg os                       0 0 dir.go dir_unix.go dirent_linux.go endian_little.go env.go error.go error_errno.go error_posix.go exec.go exec_posix.go exec_unix.go executable.go executable_procfs.go file.go file_posix.go file_unix.go getwd.go path.go path_unix.go pipe2_unix.go proc.go rawconn.go readfrom_linux.go removeall_at.go stat.go stat_linux.go stat_unix.go sticky_notbsd.go str.go sys.go sys_linux.go sys_unix.go tempfile.go types.go types_unix.go wait_waitid.go
build_pkg fmt                      0 1 doc.go errors.go format.go print.go scan.go

## Final output
function doLink() {
pkgname=main
pkg=main
wdir=$WORK/${PKGS[$pkgname]}
mkdir -p $wdir/
make_importcfg $pkgname
files="./main.go ./sum.go"

$TOOL_DIR/compile  -p $pkg -o $wdir/_pkg_.a \
  -trimpath "$wdir=>" \
  -lang=go1.20 \
  -complete $B \
  -c=4 -nolocalimports \
   -importcfg $wdir/importcfg \
   -pack \
   $files

$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal

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
mv $wdir/exe/a.out birudo
rm -r $wdir/
}

cd $SRC_DIR
doLink
