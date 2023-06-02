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

declare -A PKGS
PKGS[os]="b032"
PKGS[fmt]="b002"
PKGS[main]="b001"

cd /Users/DQNEO/src/github.com/DQNEO/go-samples
git status --porcelain
cd /Users/DQNEO/src/github.com/DQNEO/go-samples
git -c log.showsignature=false show -s --format=%H:%ct




mkdir -p $WORK/b012/
mkdir -p $WORK/b006/
mkdir -p $WORK/b005/
cat >$WORK/b012/importcfg << EOF # internal
# import config
EOF
mkdir -p $WORK/b014/
cat >$WORK/b006/importcfg << EOF # internal
# import config
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b006/_pkg_.a -trimpath "$WORK/b006=>" -p internal/unsafeheader   -std    -complete -buildid P7qFpguryEe_9bufASvc/P7qFpguryEe_9bufASvc -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b006/importcfg -pack $GORT/src/internal/unsafeheader/unsafeheader.go
$TOOL_DIR/compile -o $WORK/b012/_pkg_.a -trimpath "$WORK/b012=>" -p internal/coverage/rtcov -std -+ -complete -buildid Gk43QGhY-y2T4KaecSdc/Gk43QGhY-y2T4KaecSdc -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b012/importcfg -pack $GORT/src/internal/coverage/rtcov/rtcov.go
cat >$WORK/b005/importcfg << EOF # internal
# import config
EOF
cat >$WORK/b014/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b005/_pkg_.a -trimpath "$WORK/b005=>" -p internal/goarch -std -+ -complete -buildid IeHgz3mN0XMxQJyLQgHG/IeHgz3mN0XMxQJyLQgHG -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b005/importcfg -pack $GORT/src/internal/goarch/goarch.go $GORT/src/internal/goarch/goarch_amd64.go $GORT/src/internal/goarch/zgoarch_amd64.go
$TOOL_DIR/compile -o $WORK/b014/_pkg_.a -trimpath "$WORK/b014=>" -p internal/goos -std -+ -complete -buildid yhVHvx5gAuhGe0etJIbA/yhVHvx5gAuhGe0etJIbA -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b014/importcfg -pack $GORT/src/internal/goos/goos.go $GORT/src/internal/goos/unix.go $GORT/src/internal/goos/zgoos_linux.go
mkdir -p $WORK/b013/
cat >$WORK/b013/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b013/_pkg_.a -trimpath "$WORK/b013=>" -p internal/goexperiment -std -complete -buildid yMFIFNsS8SAX_RrWD2i8/yMFIFNsS8SAX_RrWD2i8 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b013/importcfg -pack $GORT/src/internal/goexperiment/exp_arenas_off.go $GORT/src/internal/goexperiment/exp_boringcrypto_off.go $GORT/src/internal/goexperiment/exp_coverageredesign_on.go $GORT/src/internal/goexperiment/exp_fieldtrack_off.go $GORT/src/internal/goexperiment/exp_heapminimum512kib_off.go $GORT/src/internal/goexperiment/exp_pagetrace_off.go $GORT/src/internal/goexperiment/exp_preemptibleloops_off.go $GORT/src/internal/goexperiment/exp_regabiargs_on.go $GORT/src/internal/goexperiment/exp_regabiwrappers_on.go $GORT/src/internal/goexperiment/exp_staticlockranking_off.go $GORT/src/internal/goexperiment/exp_unified_on.go $GORT/src/internal/goexperiment/flags.go
mkdir -p $WORK/b018/
mkdir -p $WORK/b011/
cat >$WORK/b018/go_asm.h << EOF # internal
EOF
mkdir -p $WORK/b015/
cat >$WORK/b011/go_asm.h << EOF # internal
EOF
cd $GORT/src/runtime/internal/syscall
$TOOL_DIR/asm -p runtime/internal/syscall -trimpath "$WORK/b018=>" -I $WORK/b018/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b018/symabis ./asm_linux_amd64.s
cd $GORT/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b011/symabis ./cpu.s ./cpu_x86.s
cat >$WORK/b015/go_asm.h << EOF # internal
EOF
cd $GORT/src/runtime/internal/atomic
$TOOL_DIR/asm -p runtime/internal/atomic -trimpath "$WORK/b015=>" -I $WORK/b015/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b015/symabis ./atomic_amd64.s
$TOOL_DIR/buildid -w $WORK/b013/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b014/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b006/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b005/_pkg_.a # internal



mkdir -p $WORK/b021/

mkdir -p $WORK/b025/
cat >$WORK/b021/importcfg << EOF # internal
# import config
EOF
cat >$WORK/b025/importcfg << EOF # internal
# import config
EOF
mkdir -p $WORK/b023/
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b025/_pkg_.a -trimpath "$WORK/b025=>" -p unicode/utf8 -std -complete -buildid cSCUZ94vs3WynnuPq7bO/cSCUZ94vs3WynnuPq7bO -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b025/importcfg -pack $GORT/src/unicode/utf8/utf8.go
$TOOL_DIR/compile -o $WORK/b021/_pkg_.a -trimpath "$WORK/b021=>" -p internal/itoa -std -complete -buildid KywV8ckBASs47DioyK2u/KywV8ckBASs47DioyK2u -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b021/importcfg -pack $GORT/src/internal/itoa/itoa.go
mkdir -p $WORK/b009/
cat >$WORK/b023/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b023/_pkg_.a -trimpath "$WORK/b023=>" -p math/bits -std -complete -buildid dCrtqElNlXZukOS2aC7Q/dCrtqElNlXZukOS2aC7Q -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b023/importcfg -pack $GORT/src/math/bits/bits.go $GORT/src/math/bits/bits_errors.go $GORT/src/math/bits/bits_tables.go
cat >$WORK/b009/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/abi
$TOOL_DIR/asm -p internal/abi -trimpath "$WORK/b009=>" -I $WORK/b009/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b009/symabis ./abi_test.s
cat >$WORK/b011/importcfg << EOF # internal
# import config
EOF
cat >$WORK/b018/importcfg << EOF # internal
# import config
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b011/_pkg_.a -trimpath "$WORK/b011=>" -p internal/cpu -std -+ -buildid j9mgjw9q7aHUtebwQoGa/j9mgjw9q7aHUtebwQoGa -goversion go1.20.4 -symabis $WORK/b011/symabis -c=4 -nolocalimports -importcfg $WORK/b011/importcfg -pack -asmhdr $WORK/b011/go_asm.h $GORT/src/internal/cpu/cpu.go $GORT/src/internal/cpu/cpu_x86.go
$TOOL_DIR/compile -o $WORK/b018/_pkg_.a -trimpath "$WORK/b018=>" -p runtime/internal/syscall -std -+ -buildid gZLMb57b8-GCtAQAQvdR/gZLMb57b8-GCtAQAQvdR -goversion go1.20.4 -symabis $WORK/b018/symabis -c=4 -nolocalimports -importcfg $WORK/b018/importcfg -pack -asmhdr $WORK/b018/go_asm.h $GORT/src/runtime/internal/syscall/defs_linux.go $GORT/src/runtime/internal/syscall/defs_linux_amd64.go $GORT/src/runtime/internal/syscall/syscall_linux.go
cat >$WORK/b015/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b015/_pkg_.a -trimpath "$WORK/b015=>" -p runtime/internal/atomic -std -+ -buildid IgGysWgqntnGBJ3sVB-f/IgGysWgqntnGBJ3sVB-f -goversion go1.20.4 -symabis $WORK/b015/symabis -c=4 -nolocalimports -importcfg $WORK/b015/importcfg -pack -asmhdr $WORK/b015/go_asm.h $GORT/src/runtime/internal/atomic/atomic_amd64.go $GORT/src/runtime/internal/atomic/doc.go $GORT/src/runtime/internal/atomic/stubs.go $GORT/src/runtime/internal/atomic/types.go $GORT/src/runtime/internal/atomic/types_64bit.go $GORT/src/runtime/internal/atomic/unaligned.go
$TOOL_DIR/buildid -w $WORK/b012/_pkg_.a # internal

mkdir -p $WORK/b016/
cat >$WORK/b009/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b009/_pkg_.a -trimpath "$WORK/b009=>" -p internal/abi -std -+ -buildid EVg-QcN5p97xUAw5kfuR/EVg-QcN5p97xUAw5kfuR -goversion go1.20.4 -symabis $WORK/b009/symabis -c=4 -nolocalimports -importcfg $WORK/b009/importcfg -pack -asmhdr $WORK/b009/go_asm.h $GORT/src/internal/abi/abi.go $GORT/src/internal/abi/abi_amd64.go
cat >$WORK/b016/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b016/_pkg_.a -trimpath "$WORK/b016=>" -p runtime/internal/math -std -+ -complete -buildid dKV2PXLfEa-bpWk_4jjm/dKV2PXLfEa-bpWk_4jjm -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b016/importcfg -pack $GORT/src/runtime/internal/math/math.go
$TOOL_DIR/buildid -w $WORK/b021/_pkg_.a # internal

cd $GORT/src/runtime/internal/syscall
$TOOL_DIR/asm -p runtime/internal/syscall -trimpath "$WORK/b018=>" -I $WORK/b018/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b018/asm_linux_amd64.o ./asm_linux_amd64.s
mkdir -p $WORK/b017/
cat >$WORK/b017/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/goos=$WORK/b014/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b017/_pkg_.a -trimpath "$WORK/b017=>" -p runtime/internal/sys -std -+ -complete -buildid p57uPEDCp39nHZBklMoj/p57uPEDCp39nHZBklMoj -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b017/importcfg -pack $GORT/src/runtime/internal/sys/consts.go $GORT/src/runtime/internal/sys/consts_norace.go $GORT/src/runtime/internal/sys/intrinsics.go $GORT/src/runtime/internal/sys/intrinsics_common.go $GORT/src/runtime/internal/sys/nih.go $GORT/src/runtime/internal/sys/sys.go $GORT/src/runtime/internal/sys/zversion.go
$TOOL_DIR/buildid -w $WORK/b023/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b025/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b016/_pkg_.a # internal


cd $GORT/src/internal/abi
$TOOL_DIR/asm -p internal/abi -trimpath "$WORK/b009=>" -I $WORK/b009/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b009/abi_test.o ./abi_test.s
mkdir -p $WORK/b027/
cat >$WORK/b027/importcfg << EOF # internal
# import config
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b027/_pkg_.a -trimpath "$WORK/b027=>" -p internal/race -std -complete -buildid 6k_7JN4Ro6ano3CJO236/6k_7JN4Ro6ano3CJO236 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b027/importcfg -pack $GORT/src/internal/race/doc.go $GORT/src/internal/race/norace.go
mkdir -p $WORK/b028/

cat >$WORK/b028/go_asm.h << EOF # internal
EOF
cd $GORT/src/sync/atomic
$TOOL_DIR/asm -p sync/atomic -trimpath "$WORK/b028=>" -I $WORK/b028/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b028/symabis ./asm.s
cd $GORT/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b011/cpu.o ./cpu.s
cd $GORT/src/runtime/internal/syscall
$TOOL_DIR/pack r $WORK/b018/_pkg_.a $WORK/b018/asm_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b018/_pkg_.a # internal
mkdir -p $WORK/b029/
cat >$WORK/b029/importcfg << EOF # internal
# import config
EOF
cd $GORT/src/runtime/internal/atomic
$TOOL_DIR/asm -p runtime/internal/atomic -trimpath "$WORK/b015=>" -I $WORK/b015/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b015/atomic_amd64.o ./atomic_amd64.s
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b029/_pkg_.a -trimpath "$WORK/b029=>" -p unicode -std -complete -buildid H5EVtAclvmQgmtO5OIl1/H5EVtAclvmQgmtO5OIl1 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b029/importcfg -pack $GORT/src/unicode/casetables.go $GORT/src/unicode/digit.go $GORT/src/unicode/graphic.go $GORT/src/unicode/letter.go $GORT/src/unicode/tables.go
cd $GORT/src/internal/abi
$TOOL_DIR/pack r $WORK/b009/_pkg_.a $WORK/b009/abi_test.o # internal

$TOOL_DIR/buildid -w $WORK/b009/_pkg_.a # internal

cd $GORT/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b011/cpu_x86.o ./cpu_x86.s
$TOOL_DIR/buildid -w $WORK/b017/_pkg_.a # internal
cat >$WORK/b028/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/buildid -w $WORK/b027/_pkg_.a # internal
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b028/_pkg_.a -trimpath "$WORK/b028=>" -p sync/atomic -std -buildid 8sTHEv3qeP6epKjkp86J/8sTHEv3qeP6epKjkp86J -goversion go1.20.4 -symabis $WORK/b028/symabis -c=4 -nolocalimports -importcfg $WORK/b028/importcfg -pack -asmhdr $WORK/b028/go_asm.h $GORT/src/sync/atomic/doc.go $GORT/src/sync/atomic/type.go $GORT/src/sync/atomic/value.go


cd $GORT/src/runtime/internal/atomic
$TOOL_DIR/pack r $WORK/b015/_pkg_.a $WORK/b015/atomic_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b015/_pkg_.a # internal
cd $GORT/src/internal/cpu
$TOOL_DIR/pack r $WORK/b011/_pkg_.a $WORK/b011/cpu.o $WORK/b011/cpu_x86.o # internal
$TOOL_DIR/buildid -w $WORK/b011/_pkg_.a # internal


mkdir -p $WORK/b010/
cat >$WORK/b010/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/bytealg
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b010/symabis ./compare_amd64.s ./count_amd64.s ./equal_amd64.s ./index_amd64.s ./indexbyte_amd64.s
cat >$WORK/b010/importcfg << EOF # internal
# import config
packagefile internal/cpu=$WORK/b011/_pkg_.a
EOF
mkdir -p $WORK/b022/
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b010/_pkg_.a -trimpath "$WORK/b010=>" -p internal/bytealg -std -+ -buildid OWPwmEGblMug2ig95x_j/OWPwmEGblMug2ig95x_j -goversion go1.20.4 -symabis $WORK/b010/symabis -c=4 -nolocalimports -importcfg $WORK/b010/importcfg -pack -asmhdr $WORK/b010/go_asm.h $GORT/src/internal/bytealg/bytealg.go $GORT/src/internal/bytealg/compare_native.go $GORT/src/internal/bytealg/count_native.go $GORT/src/internal/bytealg/equal_generic.go $GORT/src/internal/bytealg/equal_native.go $GORT/src/internal/bytealg/index_amd64.go $GORT/src/internal/bytealg/index_native.go $GORT/src/internal/bytealg/indexbyte_native.go
cat >$WORK/b022/go_asm.h << EOF # internal
EOF
cd $GORT/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b022/symabis ./dim_amd64.s ./exp_amd64.s ./floor_amd64.s ./hypot_amd64.s ./log_amd64.s
cd $GORT/src/sync/atomic
$TOOL_DIR/asm -p sync/atomic -trimpath "$WORK/b028=>" -I $WORK/b028/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b028/asm.o ./asm.s
cat >$WORK/b022/importcfg << EOF # internal
# import config
packagefile internal/cpu=$WORK/b011/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b022/_pkg_.a -trimpath "$WORK/b022=>" -p math -std -buildid M2k9bU3HlBq2CeX7eecL/M2k9bU3HlBq2CeX7eecL -goversion go1.20.4 -symabis $WORK/b022/symabis -c=4 -nolocalimports -importcfg $WORK/b022/importcfg -pack -asmhdr $WORK/b022/go_asm.h $GORT/src/math/abs.go $GORT/src/math/acosh.go $GORT/src/math/asin.go $GORT/src/math/asinh.go $GORT/src/math/atan.go $GORT/src/math/atan2.go $GORT/src/math/atanh.go $GORT/src/math/bits.go $GORT/src/math/cbrt.go $GORT/src/math/const.go $GORT/src/math/copysign.go $GORT/src/math/dim.go $GORT/src/math/dim_asm.go $GORT/src/math/erf.go $GORT/src/math/erfinv.go $GORT/src/math/exp.go $GORT/src/math/exp2_noasm.go $GORT/src/math/exp_amd64.go $GORT/src/math/exp_asm.go $GORT/src/math/expm1.go $GORT/src/math/floor.go $GORT/src/math/floor_asm.go $GORT/src/math/fma.go $GORT/src/math/frexp.go $GORT/src/math/gamma.go $GORT/src/math/hypot.go $GORT/src/math/hypot_asm.go $GORT/src/math/j0.go $GORT/src/math/j1.go $GORT/src/math/jn.go $GORT/src/math/ldexp.go $GORT/src/math/lgamma.go $GORT/src/math/log.go $GORT/src/math/log10.go $GORT/src/math/log1p.go $GORT/src/math/log_asm.go $GORT/src/math/logb.go $GORT/src/math/mod.go $GORT/src/math/modf.go $GORT/src/math/modf_noasm.go $GORT/src/math/nextafter.go $GORT/src/math/pow.go $GORT/src/math/pow10.go $GORT/src/math/remainder.go $GORT/src/math/signbit.go $GORT/src/math/sin.go $GORT/src/math/sincos.go $GORT/src/math/sinh.go $GORT/src/math/sqrt.go $GORT/src/math/stubs.go $GORT/src/math/tan.go $GORT/src/math/tanh.go $GORT/src/math/trig_reduce.go $GORT/src/math/unsafe.go
cd $GORT/src/sync/atomic
$TOOL_DIR/pack r $WORK/b028/_pkg_.a $WORK/b028/asm.o # internal
$TOOL_DIR/buildid -w $WORK/b028/_pkg_.a # internal
cd $GORT/src/internal/bytealg
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/compare_amd64.o ./compare_amd64.s

$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/count_amd64.o ./count_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/equal_amd64.o ./equal_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/index_amd64.o ./index_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/indexbyte_amd64.o ./indexbyte_amd64.s
$TOOL_DIR/pack r $WORK/b010/_pkg_.a $WORK/b010/compare_amd64.o $WORK/b010/count_amd64.o $WORK/b010/equal_amd64.o $WORK/b010/index_amd64.o $WORK/b010/indexbyte_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b010/_pkg_.a # internal

mkdir -p $WORK/b008/
cat >$WORK/b008/go_asm.h << EOF # internal
EOF
cd $GORT/src/runtime
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b008/symabis ./asm.s ./asm_amd64.s ./duff_amd64.s ./memclr_amd64.s ./memmove_amd64.s ./preempt_amd64.s ./rt0_linux_amd64.s ./sys_linux_amd64.s ./time_linux_amd64.s
cd $GORT/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/dim_amd64.o ./dim_amd64.s
cat >$WORK/b008/importcfg << EOF # internal
# import config
packagefile internal/abi=$WORK/b009/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile internal/coverage/rtcov=$WORK/b012/_pkg_.a
packagefile internal/cpu=$WORK/b011/_pkg_.a
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/goexperiment=$WORK/b013/_pkg_.a
packagefile internal/goos=$WORK/b014/_pkg_.a
packagefile runtime/internal/atomic=$WORK/b015/_pkg_.a
packagefile runtime/internal/math=$WORK/b016/_pkg_.a
packagefile runtime/internal/sys=$WORK/b017/_pkg_.a
packagefile runtime/internal/syscall=$WORK/b018/_pkg_.a
EOF
$TOOL_DIR/buildid -w $WORK/b029/_pkg_.a # internal
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b008/_pkg_.a -trimpath "$WORK/b008=>" -p runtime -std -+ -buildid Njl5lkeGSG8PAp_cny9y/Njl5lkeGSG8PAp_cny9y -goversion go1.20.4 -symabis $WORK/b008/symabis -c=4 -nolocalimports -importcfg $WORK/b008/importcfg -pack -asmhdr $WORK/b008/go_asm.h $GORT/src/runtime/alg.go $GORT/src/runtime/arena.go $GORT/src/runtime/asan0.go $GORT/src/runtime/atomic_pointer.go $GORT/src/runtime/cgo.go $GORT/src/runtime/cgo_mmap.go $GORT/src/runtime/cgo_sigaction.go $GORT/src/runtime/cgocall.go $GORT/src/runtime/cgocallback.go $GORT/src/runtime/cgocheck.go $GORT/src/runtime/chan.go $GORT/src/runtime/checkptr.go $GORT/src/runtime/compiler.go $GORT/src/runtime/complex.go $GORT/src/runtime/covercounter.go $GORT/src/runtime/covermeta.go $GORT/src/runtime/cpuflags.go $GORT/src/runtime/cpuflags_amd64.go $GORT/src/runtime/cpuprof.go $GORT/src/runtime/cputicks.go $GORT/src/runtime/create_file_unix.go $GORT/src/runtime/debug.go $GORT/src/runtime/debugcall.go $GORT/src/runtime/debuglog.go $GORT/src/runtime/debuglog_off.go $GORT/src/runtime/defs_linux_amd64.go $GORT/src/runtime/env_posix.go $GORT/src/runtime/error.go $GORT/src/runtime/exithook.go $GORT/src/runtime/extern.go $GORT/src/runtime/fastlog2.go $GORT/src/runtime/fastlog2table.go $GORT/src/runtime/float.go $GORT/src/runtime/hash64.go $GORT/src/runtime/heapdump.go $GORT/src/runtime/histogram.go $GORT/src/runtime/iface.go $GORT/src/runtime/lfstack.go $GORT/src/runtime/lfstack_64bit.go $GORT/src/runtime/lock_futex.go $GORT/src/runtime/lockrank.go $GORT/src/runtime/lockrank_off.go $GORT/src/runtime/malloc.go $GORT/src/runtime/map.go $GORT/src/runtime/map_fast32.go $GORT/src/runtime/map_fast64.go $GORT/src/runtime/map_faststr.go $GORT/src/runtime/mbarrier.go $GORT/src/runtime/mbitmap.go $GORT/src/runtime/mcache.go $GORT/src/runtime/mcentral.go $GORT/src/runtime/mcheckmark.go $GORT/src/runtime/mem.go $GORT/src/runtime/mem_linux.go $GORT/src/runtime/metrics.go $GORT/src/runtime/mfinal.go $GORT/src/runtime/mfixalloc.go $GORT/src/runtime/mgc.go $GORT/src/runtime/mgclimit.go $GORT/src/runtime/mgcmark.go $GORT/src/runtime/mgcpacer.go $GORT/src/runtime/mgcscavenge.go $GORT/src/runtime/mgcstack.go $GORT/src/runtime/mgcsweep.go $GORT/src/runtime/mgcwork.go $GORT/src/runtime/mheap.go $GORT/src/runtime/mpagealloc.go $GORT/src/runtime/mpagealloc_64bit.go $GORT/src/runtime/mpagecache.go $GORT/src/runtime/mpallocbits.go $GORT/src/runtime/mprof.go $GORT/src/runtime/mranges.go $GORT/src/runtime/msan0.go $GORT/src/runtime/msize.go $GORT/src/runtime/mspanset.go $GORT/src/runtime/mstats.go $GORT/src/runtime/mwbbuf.go $GORT/src/runtime/nbpipe_pipe2.go $GORT/src/runtime/netpoll.go $GORT/src/runtime/netpoll_epoll.go $GORT/src/runtime/os_linux.go $GORT/src/runtime/os_linux_generic.go $GORT/src/runtime/os_linux_noauxv.go $GORT/src/runtime/os_linux_x86.go $GORT/src/runtime/os_nonopenbsd.go $GORT/src/runtime/pagetrace_off.go $GORT/src/runtime/panic.go $GORT/src/runtime/plugin.go $GORT/src/runtime/preempt.go $GORT/src/runtime/preempt_nonwindows.go $GORT/src/runtime/print.go $GORT/src/runtime/proc.go $GORT/src/runtime/profbuf.go $GORT/src/runtime/proflabel.go $GORT/src/runtime/race0.go $GORT/src/runtime/rdebug.go $GORT/src/runtime/relax_stub.go $GORT/src/runtime/retry.go $GORT/src/runtime/runtime.go $GORT/src/runtime/runtime1.go $GORT/src/runtime/runtime2.go $GORT/src/runtime/runtime_boring.go $GORT/src/runtime/rwmutex.go $GORT/src/runtime/select.go $GORT/src/runtime/sema.go $GORT/src/runtime/signal_amd64.go $GORT/src/runtime/signal_linux_amd64.go $GORT/src/runtime/signal_unix.go $GORT/src/runtime/sigqueue.go $GORT/src/runtime/sigqueue_note.go $GORT/src/runtime/sigtab_linux_generic.go $GORT/src/runtime/sizeclasses.go $GORT/src/runtime/slice.go $GORT/src/runtime/softfloat64.go $GORT/src/runtime/stack.go $GORT/src/runtime/stkframe.go $GORT/src/runtime/string.go $GORT/src/runtime/stubs.go $GORT/src/runtime/stubs2.go $GORT/src/runtime/stubs3.go $GORT/src/runtime/stubs_amd64.go $GORT/src/runtime/stubs_linux.go $GORT/src/runtime/symtab.go $GORT/src/runtime/sys_nonppc64x.go $GORT/src/runtime/sys_x86.go $GORT/src/runtime/time.go $GORT/src/runtime/time_nofake.go $GORT/src/runtime/timeasm.go $GORT/src/runtime/tls_stub.go $GORT/src/runtime/trace.go $GORT/src/runtime/traceback.go $GORT/src/runtime/type.go $GORT/src/runtime/typekind.go $GORT/src/runtime/unsafe.go $GORT/src/runtime/utf8.go $GORT/src/runtime/vdso_elf64.go $GORT/src/runtime/vdso_linux.go $GORT/src/runtime/vdso_linux_amd64.go $GORT/src/runtime/write_err.go
cd $GORT/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/exp_amd64.o ./exp_amd64.s

$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/floor_amd64.o ./floor_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/hypot_amd64.o ./hypot_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/log_amd64.o ./log_amd64.s
$TOOL_DIR/pack r $WORK/b022/_pkg_.a $WORK/b022/dim_amd64.o $WORK/b022/exp_amd64.o $WORK/b022/floor_amd64.o $WORK/b022/hypot_amd64.o $WORK/b022/log_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b022/_pkg_.a # internal


cd $GORT/src/runtime
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/asm.o ./asm.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/asm_amd64.o ./asm_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/duff_amd64.o ./duff_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/memclr_amd64.o ./memclr_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/memmove_amd64.o ./memmove_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/preempt_amd64.o ./preempt_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/rt0_linux_amd64.o ./rt0_linux_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/sys_linux_amd64.o ./sys_linux_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/time_linux_amd64.o ./time_linux_amd64.s
$TOOL_DIR/pack r $WORK/b008/_pkg_.a $WORK/b008/asm.o $WORK/b008/asm_amd64.o $WORK/b008/duff_amd64.o $WORK/b008/memclr_amd64.o $WORK/b008/memmove_amd64.o $WORK/b008/preempt_amd64.o $WORK/b008/rt0_linux_amd64.o $WORK/b008/sys_linux_amd64.o $WORK/b008/time_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b008/_pkg_.a # internal

mkdir -p $WORK/b004/
cat >$WORK/b004/go_asm.h << EOF # internal
EOF
cd $GORT/src/internal/reflectlite
$TOOL_DIR/asm -p internal/reflectlite -trimpath "$WORK/b004=>" -I $WORK/b004/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b004/symabis ./asm.s
mkdir -p $WORK/b026/
cat >$WORK/b026/importcfg << EOF # internal
# import config
packagefile internal/race=$WORK/b027/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b026/_pkg_.a -trimpath "$WORK/b026=>" -p sync -std -buildid awcGvD6YFJooe2gt9uJS/awcGvD6YFJooe2gt9uJS -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b026/importcfg -pack $GORT/src/sync/cond.go $GORT/src/sync/map.go $GORT/src/sync/mutex.go $GORT/src/sync/once.go $GORT/src/sync/pool.go $GORT/src/sync/poolqueue.go $GORT/src/sync/runtime.go $GORT/src/sync/runtime2.go $GORT/src/sync/rwmutex.go $GORT/src/sync/waitgroup.go
cat >$WORK/b004/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/unsafeheader=$WORK/b006/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b004/_pkg_.a -trimpath "$WORK/b004=>" -p internal/reflectlite -std -buildid 8f99mKJg6-OCUXX8caR3/8f99mKJg6-OCUXX8caR3 -goversion go1.20.4 -symabis $WORK/b004/symabis -c=4 -nolocalimports -importcfg $WORK/b004/importcfg -pack -asmhdr $WORK/b004/go_asm.h $GORT/src/internal/reflectlite/swapper.go $GORT/src/internal/reflectlite/type.go $GORT/src/internal/reflectlite/value.go
$TOOL_DIR/buildid -w $WORK/b026/_pkg_.a # internal

mkdir -p $WORK/b040/
cat >$WORK/b040/importcfg << EOF # internal
# import config
packagefile sync=$WORK/b026/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b040/_pkg_.a -trimpath "$WORK/b040=>" -p internal/testlog -std -complete -buildid B423dGniR5COkyvnWNiY/B423dGniR5COkyvnWNiY -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b040/importcfg -pack $GORT/src/internal/testlog/exit.go $GORT/src/internal/testlog/log.go
$TOOL_DIR/buildid -w $WORK/b040/_pkg_.a # internal

cd $GORT/src/internal/reflectlite
$TOOL_DIR/asm -p internal/reflectlite -trimpath "$WORK/b004=>" -I $WORK/b004/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b004/asm.o ./asm.s
$TOOL_DIR/pack r $WORK/b004/_pkg_.a $WORK/b004/asm.o # internal
$TOOL_DIR/buildid -w $WORK/b004/_pkg_.a # internal

mkdir -p $WORK/b003/
mkdir -p $WORK/b030/
cat >$WORK/b003/importcfg << EOF # internal
# import config
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b003/_pkg_.a -trimpath "$WORK/b003=>" -p errors -std -complete -buildid F_mcCqBziAv01tav5M2I/F_mcCqBziAv01tav5M2I -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b003/importcfg -pack $GORT/src/errors/errors.go $GORT/src/errors/join.go $GORT/src/errors/wrap.go
cat >$WORK/b030/importcfg << EOF # internal
# import config
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b030/_pkg_.a -trimpath "$WORK/b030=>" -p sort -std -complete -buildid RPytz-InhRnbWmq4E73g/RPytz-InhRnbWmq4E73g -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b030/importcfg -pack $GORT/src/sort/search.go $GORT/src/sort/slice.go $GORT/src/sort/sort.go $GORT/src/sort/zsortfunc.go $GORT/src/sort/zsortinterface.go
$TOOL_DIR/buildid -w $WORK/b003/_pkg_.a # internal

mkdir -p $WORK/b038/
mkdir -p $WORK/b036/
mkdir -p $WORK/b042/
cat >$WORK/b038/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
cat >$WORK/b036/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
EOF
mkdir -p $WORK/b031/
cat >$WORK/b042/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b038/_pkg_.a -trimpath "$WORK/b038=>" -p internal/safefilepath -std -complete -buildid hm1QrtEgJmcNx15tya8Y/hm1QrtEgJmcNx15tya8Y -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b038/importcfg -pack $GORT/src/internal/safefilepath/path.go $GORT/src/internal/safefilepath/path_other.go
$TOOL_DIR/compile -o $WORK/b036/_pkg_.a -trimpath "$WORK/b036=>" -p internal/oserror -std -complete -buildid ZyMHKeNnjmaHsZb3SqbR/ZyMHKeNnjmaHsZb3SqbR -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b036/importcfg -pack $GORT/src/internal/oserror/errors.go
$TOOL_DIR/compile -o $WORK/b042/_pkg_.a -trimpath "$WORK/b042=>" -p path -std -complete -buildid oyZvoNp0jsV46ZkzhwtB/oyZvoNp0jsV46ZkzhwtB -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b042/importcfg -pack $GORT/src/path/match.go $GORT/src/path/path.go
cat >$WORK/b031/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b031/_pkg_.a -trimpath "$WORK/b031=>" -p io -std -complete -buildid UXfIU_f9dqciElRShcLJ/UXfIU_f9dqciElRShcLJ -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b031/importcfg -pack $GORT/src/io/io.go $GORT/src/io/multi.go $GORT/src/io/pipe.go
mkdir -p $WORK/b024/
cat >$WORK/b024/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b024/_pkg_.a -trimpath "$WORK/b024=>" -p strconv -std -complete -buildid tsZ-5FuCj28fNWLKgaGw/tsZ-5FuCj28fNWLKgaGw -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b024/importcfg -pack $GORT/src/strconv/atob.go $GORT/src/strconv/atoc.go $GORT/src/strconv/atof.go $GORT/src/strconv/atoi.go $GORT/src/strconv/bytealg.go $GORT/src/strconv/ctoa.go $GORT/src/strconv/decimal.go $GORT/src/strconv/doc.go $GORT/src/strconv/eisel_lemire.go $GORT/src/strconv/ftoa.go $GORT/src/strconv/ftoaryu.go $GORT/src/strconv/isprint.go $GORT/src/strconv/itoa.go $GORT/src/strconv/quote.go
$TOOL_DIR/buildid -w $WORK/b038/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b036/_pkg_.a # internal


$TOOL_DIR/buildid -w $WORK/b042/_pkg_.a # internal

$TOOL_DIR/buildid -w $WORK/b030/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b031/_pkg_.a # internal

mkdir -p $WORK/b035/

cat >$WORK/b035/go_asm.h << EOF # internal
EOF
cd $GORT/src/syscall
$TOOL_DIR/asm -p syscall -trimpath "$WORK/b035=>" -I $WORK/b035/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b035/symabis ./asm_linux_amd64.s
cat >$WORK/b035/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile internal/itoa=$WORK/b021/_pkg_.a
packagefile internal/oserror=$WORK/b036/_pkg_.a
packagefile internal/race=$WORK/b027/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b035/_pkg_.a -trimpath "$WORK/b035=>" -p syscall -std -buildid Gf1emYuyeATzm8AHyHFR/Gf1emYuyeATzm8AHyHFR -goversion go1.20.4 -symabis $WORK/b035/symabis -c=4 -nolocalimports -importcfg $WORK/b035/importcfg -pack -asmhdr $WORK/b035/go_asm.h $GORT/src/syscall/asan0.go $GORT/src/syscall/dirent.go $GORT/src/syscall/endian_little.go $GORT/src/syscall/env_unix.go $GORT/src/syscall/exec_linux.go $GORT/src/syscall/exec_unix.go $GORT/src/syscall/flock.go $GORT/src/syscall/lsf_linux.go $GORT/src/syscall/msan0.go $GORT/src/syscall/net.go $GORT/src/syscall/netlink_linux.go $GORT/src/syscall/rlimit.go $GORT/src/syscall/rlimit_stub.go $GORT/src/syscall/setuidgid_linux.go $GORT/src/syscall/sockcmsg_linux.go $GORT/src/syscall/sockcmsg_unix.go $GORT/src/syscall/sockcmsg_unix_other.go $GORT/src/syscall/syscall.go $GORT/src/syscall/syscall_linux.go $GORT/src/syscall/syscall_linux_accept4.go $GORT/src/syscall/syscall_linux_amd64.go $GORT/src/syscall/syscall_unix.go $GORT/src/syscall/time_nofake.go $GORT/src/syscall/timestruct.go $GORT/src/syscall/zerrors_linux_amd64.go $GORT/src/syscall/zsyscall_linux_amd64.go $GORT/src/syscall/zsysnum_linux_amd64.go $GORT/src/syscall/ztypes_linux_amd64.go
$TOOL_DIR/buildid -w $WORK/b024/_pkg_.a # internal

mkdir -p $WORK/b020/
cat >$WORK/b020/go_asm.h << EOF # internal
EOF
cd $GORT/src/reflect
$TOOL_DIR/asm -p reflect -trimpath "$WORK/b020=>" -I $WORK/b020/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b020/symabis ./asm_amd64.s
cat >$WORK/b020/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/abi=$WORK/b009/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/itoa=$WORK/b021/_pkg_.a
packagefile internal/unsafeheader=$WORK/b006/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile strconv=$WORK/b024/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile unicode=$WORK/b029/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b020/_pkg_.a -trimpath "$WORK/b020=>" -p reflect -std -buildid nIapndKG10ZTabsNBtM3/nIapndKG10ZTabsNBtM3 -goversion go1.20.4 -symabis $WORK/b020/symabis -c=4 -nolocalimports -importcfg $WORK/b020/importcfg -pack -asmhdr $WORK/b020/go_asm.h $GORT/src/reflect/abi.go $GORT/src/reflect/deepequal.go $GORT/src/reflect/float32reg_generic.go $GORT/src/reflect/makefunc.go $GORT/src/reflect/swapper.go $GORT/src/reflect/type.go $GORT/src/reflect/value.go $GORT/src/reflect/visiblefields.go
cd $GORT/src/syscall
$TOOL_DIR/asm -p syscall -trimpath "$WORK/b035=>" -I $WORK/b035/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b035/asm_linux_amd64.o ./asm_linux_amd64.s
$TOOL_DIR/pack r $WORK/b035/_pkg_.a $WORK/b035/asm_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b035/_pkg_.a # internal

mkdir -p $WORK/b039/
cat >$WORK/b039/importcfg << EOF # internal
# import config
packagefile syscall=$WORK/b035/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b039/_pkg_.a -trimpath "$WORK/b039=>" -p internal/syscall/execenv -std -complete -buildid 9v4cH9-eclFZmCPdzfl0/9v4cH9-eclFZmCPdzfl0 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b039/importcfg -pack $GORT/src/internal/syscall/execenv/execenv_default.go
mkdir -p $WORK/b034/
mkdir -p $WORK/b037/
cat >$WORK/b034/importcfg << EOF # internal
# import config
packagefile sync/atomic=$WORK/b028/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
EOF
cat >$WORK/b037/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b034/_pkg_.a -trimpath "$WORK/b034=>" -p internal/syscall/unix -std -complete -buildid y7B9w1xvVOcllLe1UHTw/y7B9w1xvVOcllLe1UHTw -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b034/importcfg -pack $GORT/src/internal/syscall/unix/at.go $GORT/src/internal/syscall/unix/at_fstatat.go $GORT/src/internal/syscall/unix/at_sysnum_linux.go $GORT/src/internal/syscall/unix/at_sysnum_newfstatat_linux.go $GORT/src/internal/syscall/unix/constants.go $GORT/src/internal/syscall/unix/copy_file_range_linux.go $GORT/src/internal/syscall/unix/eaccess_linux.go $GORT/src/internal/syscall/unix/getrandom.go $GORT/src/internal/syscall/unix/getrandom_linux.go $GORT/src/internal/syscall/unix/kernel_version_linux.go $GORT/src/internal/syscall/unix/net.go $GORT/src/internal/syscall/unix/nonblocking.go $GORT/src/internal/syscall/unix/sysnum_linux_amd64.go
$TOOL_DIR/compile -o $WORK/b037/_pkg_.a -trimpath "$WORK/b037=>" -p time -std -buildid JPr4o2PkKYQpYoXGOl8u/JPr4o2PkKYQpYoXGOl8u -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b037/importcfg -pack $GORT/src/time/format.go $GORT/src/time/format_rfc3339.go $GORT/src/time/sleep.go $GORT/src/time/sys_unix.go $GORT/src/time/tick.go $GORT/src/time/time.go $GORT/src/time/zoneinfo.go $GORT/src/time/zoneinfo_goroot.go $GORT/src/time/zoneinfo_read.go $GORT/src/time/zoneinfo_unix.go
$TOOL_DIR/buildid -w $WORK/b039/_pkg_.a # internal

$TOOL_DIR/buildid -w $WORK/b034/_pkg_.a # internal

$TOOL_DIR/buildid -w $WORK/b037/_pkg_.a # internal

mkdir -p $WORK/b041/
cat >$WORK/b041/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/oserror=$WORK/b036/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile path=$WORK/b042/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
packagefile time=$WORK/b037/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b041/_pkg_.a -trimpath "$WORK/b041=>" -p io/fs -std -complete -buildid EvJOhnLtLuHzGX4dFlcg/EvJOhnLtLuHzGX4dFlcg -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b041/importcfg -pack $GORT/src/io/fs/fs.go $GORT/src/io/fs/glob.go $GORT/src/io/fs/readdir.go $GORT/src/io/fs/readfile.go $GORT/src/io/fs/stat.go $GORT/src/io/fs/sub.go $GORT/src/io/fs/walk.go
cd $GORT/src/reflect
$TOOL_DIR/asm -p reflect -trimpath "$WORK/b020=>" -I $WORK/b020/ -I $GORT/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b020/asm_amd64.o ./asm_amd64.s
mkdir -p $WORK/b033/
cat >$WORK/b033/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/syscall/unix=$WORK/b034/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
packagefile time=$WORK/b037/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b033/_pkg_.a -trimpath "$WORK/b033=>" -p internal/poll -std -buildid z1T_88ivNUFrGnA9-Iwx/z1T_88ivNUFrGnA9-Iwx -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b033/importcfg -pack $GORT/src/internal/poll/copy_file_range_linux.go $GORT/src/internal/poll/errno_unix.go $GORT/src/internal/poll/fcntl_syscall.go $GORT/src/internal/poll/fd.go $GORT/src/internal/poll/fd_fsync_posix.go $GORT/src/internal/poll/fd_mutex.go $GORT/src/internal/poll/fd_poll_runtime.go $GORT/src/internal/poll/fd_posix.go $GORT/src/internal/poll/fd_unix.go $GORT/src/internal/poll/fd_writev_unix.go $GORT/src/internal/poll/hook_cloexec.go $GORT/src/internal/poll/hook_unix.go $GORT/src/internal/poll/iovec_unix.go $GORT/src/internal/poll/sendfile_linux.go $GORT/src/internal/poll/sock_cloexec.go $GORT/src/internal/poll/sockopt.go $GORT/src/internal/poll/sockopt_linux.go $GORT/src/internal/poll/sockopt_unix.go $GORT/src/internal/poll/sockoptip.go $GORT/src/internal/poll/splice_linux.go $GORT/src/internal/poll/writev.go
cd $GORT/src/reflect
$TOOL_DIR/pack r $WORK/b020/_pkg_.a $WORK/b020/asm_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b020/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b041/_pkg_.a # internal

mkdir -p $WORK/b019/
cat >$WORK/b019/importcfg << EOF # internal
# import config
packagefile reflect=$WORK/b020/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b019/_pkg_.a -trimpath "$WORK/b019=>" -p internal/fmtsort -std -complete -buildid sCxpPvJyA5xP8dZYIW2S/sCxpPvJyA5xP8dZYIW2S -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b019/importcfg -pack $GORT/src/internal/fmtsort/sort.go

$TOOL_DIR/buildid -w $WORK/b019/_pkg_.a # internal

$TOOL_DIR/buildid -w $WORK/b033/_pkg_.a # internal


function build_os() {
dir=$1
mkdir -p $WORK/$dir/
cat >$WORK/$dir/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/itoa=$WORK/b021/_pkg_.a
packagefile internal/poll=$WORK/b033/_pkg_.a
packagefile internal/safefilepath=$WORK/b038/_pkg_.a
packagefile internal/syscall/execenv=$WORK/b039/_pkg_.a
packagefile internal/syscall/unix=$WORK/b034/_pkg_.a
packagefile internal/testlog=$WORK/b040/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile io/fs=$WORK/b041/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
packagefile time=$WORK/b037/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/$dir/_pkg_.a -trimpath "$WORK/$dir=>" -p os -std -buildid 8kTY3IGtc09hvOwTK2Gg/8kTY3IGtc09hvOwTK2Gg -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/$dir/importcfg -pack $GORT/src/os/dir.go $GORT/src/os/dir_unix.go $GORT/src/os/dirent_linux.go $GORT/src/os/endian_little.go $GORT/src/os/env.go $GORT/src/os/error.go $GORT/src/os/error_errno.go $GORT/src/os/error_posix.go $GORT/src/os/exec.go $GORT/src/os/exec_posix.go $GORT/src/os/exec_unix.go $GORT/src/os/executable.go $GORT/src/os/executable_procfs.go $GORT/src/os/file.go $GORT/src/os/file_posix.go $GORT/src/os/file_unix.go $GORT/src/os/getwd.go $GORT/src/os/path.go $GORT/src/os/path_unix.go $GORT/src/os/pipe2_unix.go $GORT/src/os/proc.go $GORT/src/os/rawconn.go $GORT/src/os/readfrom_linux.go $GORT/src/os/removeall_at.go $GORT/src/os/stat.go $GORT/src/os/stat_linux.go $GORT/src/os/stat_unix.go $GORT/src/os/sticky_notbsd.go $GORT/src/os/str.go $GORT/src/os/sys.go $GORT/src/os/sys_linux.go $GORT/src/os/sys_unix.go $GORT/src/os/tempfile.go $GORT/src/os/types.go $GORT/src/os/types_unix.go $GORT/src/os/wait_waitid.go
$TOOL_DIR/buildid -w $WORK/$dir/_pkg_.a # internal

}

function build_fmt() {
dir=$1
mkdir -p $WORK/$dir/
cat >$WORK/$dir/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/fmtsort=$WORK/b019/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile os=$WORK/${PKGS[os]}/_pkg_.a
packagefile reflect=$WORK/b020/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
packagefile strconv=$WORK/b024/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/$dir/_pkg_.a -trimpath "$WORK/$dir=>" -p fmt -std -complete -buildid ISNWJORYgVMWtTTWVw3z/ISNWJORYgVMWtTTWVw3z -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/$dir/importcfg -pack $GORT/src/fmt/doc.go $GORT/src/fmt/errors.go $GORT/src/fmt/format.go $GORT/src/fmt/print.go $GORT/src/fmt/scan.go
$TOOL_DIR/buildid -w $WORK/$dir/_pkg_.a # internal

}


## Final output
function doLink() {
wdir=$WORK/${PKGS[main]}
mkdir -p $wdir/
cat >$wdir/importcfg << EOF # internal
# import config
packagefile fmt=$WORK/${PKGS[fmt]}/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
$TOOL_DIR/compile -o $wdir/_pkg_.a -trimpath "$wdir=>" -p main -lang=go1.20 -complete -buildid aHxht5d7JGm1qJULUhhT/aHxht5d7JGm1qJULUhhT -goversion go1.20.4 -c=4 -nolocalimports -importcfg $wdir/importcfg -pack ./main.go ./sum.go
$TOOL_DIR/buildid -w $wdir/_pkg_.a # internal

cat >$wdir/importcfg.link << EOF # internal
packagefile github.com/DQNEO/go-samples/birudo=$wdir/_pkg_.a
packagefile fmt=$WORK/${PKGS[fmt]}/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/fmtsort=$WORK/b019/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile os=$WORK/${PKGS[os]}/_pkg_.a
packagefile reflect=$WORK/b020/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
packagefile strconv=$WORK/b024/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
packagefile internal/abi=$WORK/b009/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile internal/coverage/rtcov=$WORK/b012/_pkg_.a
packagefile internal/cpu=$WORK/b011/_pkg_.a
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/goexperiment=$WORK/b013/_pkg_.a
packagefile internal/goos=$WORK/b014/_pkg_.a
packagefile runtime/internal/atomic=$WORK/b015/_pkg_.a
packagefile runtime/internal/math=$WORK/b016/_pkg_.a
packagefile runtime/internal/sys=$WORK/b017/_pkg_.a
packagefile runtime/internal/syscall=$WORK/b018/_pkg_.a
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
packagefile internal/itoa=$WORK/b021/_pkg_.a
packagefile internal/poll=$WORK/b033/_pkg_.a
packagefile internal/safefilepath=$WORK/b038/_pkg_.a
packagefile internal/syscall/execenv=$WORK/b039/_pkg_.a
packagefile internal/syscall/unix=$WORK/b034/_pkg_.a
packagefile internal/testlog=$WORK/b040/_pkg_.a
packagefile io/fs=$WORK/b041/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
packagefile time=$WORK/b037/_pkg_.a
packagefile internal/unsafeheader=$WORK/b006/_pkg_.a
packagefile unicode=$WORK/b029/_pkg_.a
packagefile internal/race=$WORK/b027/_pkg_.a
packagefile internal/oserror=$WORK/b036/_pkg_.a
packagefile path=$WORK/b042/_pkg_.a
modinfo "0w\xaf\f\x92t\b\x02A\xe1\xc1\a\xe6\xd6\x18\xe6path\tgithub.com/DQNEO/go-samples/birudo\nmod\tgithub.com/DQNEO/go-samples/birudo\t(devel)\t\nbuild\t-buildmode=exe\nbuild\t-compiler=gc\nbuild\tCGO_ENABLED=0\nbuild\tGOARCH=amd64\nbuild\tGOOS=linux\nbuild\tGOAMD64=v1\nbuild\tvcs=git\nbuild\tvcs.revision=a721858f4c22cb178c3f3853f9c55aa3773afc2c\nbuild\tvcs.time=2023-06-02T12:08:04Z\nbuild\tvcs.modified=true\n\xf92C1\x86\x18 r\x00\x82B\x10A\x16\xd8\xf2"
EOF
mkdir -p $wdir/exe/
cd .
$TOOL_DIR/link -o $wdir/exe/a.out -importcfg $wdir/importcfg.link -buildmode=exe -buildid=yekYyg_HZMgX517VPpiO/aHxht5d7JGm1qJULUhhT/ct0PU8-vieH10gtMxGeC/yekYyg_HZMgX517VPpiO -extld=cc $wdir/_pkg_.a
$TOOL_DIR/buildid -w $wdir/exe/a.out # internal
mv $wdir/exe/a.out birudo
rm -r $wdir/
}

build_os ${PKGS[os]}
build_fmt ${PKGS[fmt]}
doLink
