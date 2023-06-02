#!/bin/bash
set -eux
rm -f birudo
export GOOS=linux
export GOARCH=amd64
WORK=/tmp/go-build1234567
SRC_DIR=/Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
TOOL_DIR=/usr/local/opt/go/libexec/pkg/tool/darwin_amd64
CACHE_DIR=/Users/DQNEO/Library/Caches/go-build

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
$TOOL_DIR/compile -o $WORK/b006/_pkg_.a -trimpath "$WORK/b006=>" -p internal/unsafeheader -std -complete -buildid P7qFpguryEe_9bufASvc/P7qFpguryEe_9bufASvc -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b006/importcfg -pack /usr/local/opt/go/libexec/src/internal/unsafeheader/unsafeheader.go
$TOOL_DIR/compile -o $WORK/b012/_pkg_.a -trimpath "$WORK/b012=>" -p internal/coverage/rtcov -std -+ -complete -buildid Gk43QGhY-y2T4KaecSdc/Gk43QGhY-y2T4KaecSdc -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b012/importcfg -pack /usr/local/opt/go/libexec/src/internal/coverage/rtcov/rtcov.go
cat >$WORK/b005/importcfg << EOF # internal
# import config
EOF
cat >$WORK/b014/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b005/_pkg_.a -trimpath "$WORK/b005=>" -p internal/goarch -std -+ -complete -buildid IeHgz3mN0XMxQJyLQgHG/IeHgz3mN0XMxQJyLQgHG -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b005/importcfg -pack /usr/local/opt/go/libexec/src/internal/goarch/goarch.go /usr/local/opt/go/libexec/src/internal/goarch/goarch_amd64.go /usr/local/opt/go/libexec/src/internal/goarch/zgoarch_amd64.go
$TOOL_DIR/compile -o $WORK/b014/_pkg_.a -trimpath "$WORK/b014=>" -p internal/goos -std -+ -complete -buildid yhVHvx5gAuhGe0etJIbA/yhVHvx5gAuhGe0etJIbA -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b014/importcfg -pack /usr/local/opt/go/libexec/src/internal/goos/goos.go /usr/local/opt/go/libexec/src/internal/goos/unix.go /usr/local/opt/go/libexec/src/internal/goos/zgoos_linux.go
mkdir -p $WORK/b013/
cat >$WORK/b013/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b013/_pkg_.a -trimpath "$WORK/b013=>" -p internal/goexperiment -std -complete -buildid yMFIFNsS8SAX_RrWD2i8/yMFIFNsS8SAX_RrWD2i8 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b013/importcfg -pack /usr/local/opt/go/libexec/src/internal/goexperiment/exp_arenas_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_boringcrypto_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_coverageredesign_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_fieldtrack_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_heapminimum512kib_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_pagetrace_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_preemptibleloops_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_regabiargs_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_regabiwrappers_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_staticlockranking_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_unified_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/flags.go
mkdir -p $WORK/b018/
mkdir -p $WORK/b011/
cat >$WORK/b018/go_asm.h << EOF # internal
EOF
mkdir -p $WORK/b015/
cat >$WORK/b011/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/runtime/internal/syscall
$TOOL_DIR/asm -p runtime/internal/syscall -trimpath "$WORK/b018=>" -I $WORK/b018/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b018/symabis ./asm_linux_amd64.s
cd /usr/local/opt/go/libexec/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b011/symabis ./cpu.s ./cpu_x86.s
cat >$WORK/b015/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/runtime/internal/atomic
$TOOL_DIR/asm -p runtime/internal/atomic -trimpath "$WORK/b015=>" -I $WORK/b015/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b015/symabis ./atomic_amd64.s
$TOOL_DIR/buildid -w $WORK/b013/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b014/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b006/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b005/_pkg_.a # internal
cp $WORK/b013/_pkg_.a $CACHE_DIR/8d/8de78bf1ef63a81cea0842fb8c763a9242c3cb58755f22415c152ba39d813fbf-d # internal
cp $WORK/b006/_pkg_.a $CACHE_DIR/c5/c5b46fe40f7e8de2493764975e120119586accdba6937c78b1d5361bf99bc5b9-d # internal
cp $WORK/b014/_pkg_.a $CACHE_DIR/fc/fc2639e7d82ded59f6db84cb817dd44e79b4ce07bf385d940b6a585ea2251d8d-d # internal
mkdir -p $WORK/b021/
cp $WORK/b005/_pkg_.a $CACHE_DIR/46/466361bf073f0514935abe900921ffaa557283dbec238ae7b237bf94e134e05e-d # internal
mkdir -p $WORK/b025/
cat >$WORK/b021/importcfg << EOF # internal
# import config
EOF
cat >$WORK/b025/importcfg << EOF # internal
# import config
EOF
mkdir -p $WORK/b023/
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b025/_pkg_.a -trimpath "$WORK/b025=>" -p unicode/utf8 -std -complete -buildid cSCUZ94vs3WynnuPq7bO/cSCUZ94vs3WynnuPq7bO -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b025/importcfg -pack /usr/local/opt/go/libexec/src/unicode/utf8/utf8.go
$TOOL_DIR/compile -o $WORK/b021/_pkg_.a -trimpath "$WORK/b021=>" -p internal/itoa -std -complete -buildid KywV8ckBASs47DioyK2u/KywV8ckBASs47DioyK2u -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b021/importcfg -pack /usr/local/opt/go/libexec/src/internal/itoa/itoa.go
mkdir -p $WORK/b009/
cat >$WORK/b023/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b023/_pkg_.a -trimpath "$WORK/b023=>" -p math/bits -std -complete -buildid dCrtqElNlXZukOS2aC7Q/dCrtqElNlXZukOS2aC7Q -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b023/importcfg -pack /usr/local/opt/go/libexec/src/math/bits/bits.go /usr/local/opt/go/libexec/src/math/bits/bits_errors.go /usr/local/opt/go/libexec/src/math/bits/bits_tables.go
cat >$WORK/b009/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/abi
$TOOL_DIR/asm -p internal/abi -trimpath "$WORK/b009=>" -I $WORK/b009/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b009/symabis ./abi_test.s
cat >$WORK/b011/importcfg << EOF # internal
# import config
EOF
cat >$WORK/b018/importcfg << EOF # internal
# import config
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b011/_pkg_.a -trimpath "$WORK/b011=>" -p internal/cpu -std -+ -buildid j9mgjw9q7aHUtebwQoGa/j9mgjw9q7aHUtebwQoGa -goversion go1.20.4 -symabis $WORK/b011/symabis -c=4 -nolocalimports -importcfg $WORK/b011/importcfg -pack -asmhdr $WORK/b011/go_asm.h /usr/local/opt/go/libexec/src/internal/cpu/cpu.go /usr/local/opt/go/libexec/src/internal/cpu/cpu_x86.go
$TOOL_DIR/compile -o $WORK/b018/_pkg_.a -trimpath "$WORK/b018=>" -p runtime/internal/syscall -std -+ -buildid gZLMb57b8-GCtAQAQvdR/gZLMb57b8-GCtAQAQvdR -goversion go1.20.4 -symabis $WORK/b018/symabis -c=4 -nolocalimports -importcfg $WORK/b018/importcfg -pack -asmhdr $WORK/b018/go_asm.h /usr/local/opt/go/libexec/src/runtime/internal/syscall/defs_linux.go /usr/local/opt/go/libexec/src/runtime/internal/syscall/defs_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/internal/syscall/syscall_linux.go
cat >$WORK/b015/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/compile -o $WORK/b015/_pkg_.a -trimpath "$WORK/b015=>" -p runtime/internal/atomic -std -+ -buildid IgGysWgqntnGBJ3sVB-f/IgGysWgqntnGBJ3sVB-f -goversion go1.20.4 -symabis $WORK/b015/symabis -c=4 -nolocalimports -importcfg $WORK/b015/importcfg -pack -asmhdr $WORK/b015/go_asm.h /usr/local/opt/go/libexec/src/runtime/internal/atomic/atomic_amd64.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/doc.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/stubs.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/types.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/types_64bit.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/unaligned.go
$TOOL_DIR/buildid -w $WORK/b012/_pkg_.a # internal
cp $WORK/b012/_pkg_.a $CACHE_DIR/92/926df4eb753eaf2114a466757f34e7afdfba1cf6ec04f1f2f34c85063d90e024-d # internal
mkdir -p $WORK/b016/
cat >$WORK/b009/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b009/_pkg_.a -trimpath "$WORK/b009=>" -p internal/abi -std -+ -buildid EVg-QcN5p97xUAw5kfuR/EVg-QcN5p97xUAw5kfuR -goversion go1.20.4 -symabis $WORK/b009/symabis -c=4 -nolocalimports -importcfg $WORK/b009/importcfg -pack -asmhdr $WORK/b009/go_asm.h /usr/local/opt/go/libexec/src/internal/abi/abi.go /usr/local/opt/go/libexec/src/internal/abi/abi_amd64.go
cat >$WORK/b016/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b016/_pkg_.a -trimpath "$WORK/b016=>" -p runtime/internal/math -std -+ -complete -buildid dKV2PXLfEa-bpWk_4jjm/dKV2PXLfEa-bpWk_4jjm -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b016/importcfg -pack /usr/local/opt/go/libexec/src/runtime/internal/math/math.go
$TOOL_DIR/buildid -w $WORK/b021/_pkg_.a # internal
cp $WORK/b021/_pkg_.a $CACHE_DIR/bf/bf12a0a0c4af776c027cff856238e7151c065ea070c1d8648374631c254efca2-d # internal
cd /usr/local/opt/go/libexec/src/runtime/internal/syscall
$TOOL_DIR/asm -p runtime/internal/syscall -trimpath "$WORK/b018=>" -I $WORK/b018/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b018/asm_linux_amd64.o ./asm_linux_amd64.s
mkdir -p $WORK/b017/
cat >$WORK/b017/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/goos=$WORK/b014/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b017/_pkg_.a -trimpath "$WORK/b017=>" -p runtime/internal/sys -std -+ -complete -buildid p57uPEDCp39nHZBklMoj/p57uPEDCp39nHZBklMoj -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b017/importcfg -pack /usr/local/opt/go/libexec/src/runtime/internal/sys/consts.go /usr/local/opt/go/libexec/src/runtime/internal/sys/consts_norace.go /usr/local/opt/go/libexec/src/runtime/internal/sys/intrinsics.go /usr/local/opt/go/libexec/src/runtime/internal/sys/intrinsics_common.go /usr/local/opt/go/libexec/src/runtime/internal/sys/nih.go /usr/local/opt/go/libexec/src/runtime/internal/sys/sys.go /usr/local/opt/go/libexec/src/runtime/internal/sys/zversion.go
$TOOL_DIR/buildid -w $WORK/b023/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b025/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b016/_pkg_.a # internal
cp $WORK/b025/_pkg_.a $CACHE_DIR/3f/3f60081ee412ab78743d2744ee4e8db7b1a927b3480e8a0d74f175a6da78f2b4-d # internal
cp $WORK/b016/_pkg_.a $CACHE_DIR/9f/9fdba1d4b52db1d9a6b1ef33709218afb9736e725ac2ed5b2d67732092133118-d # internal
cd /usr/local/opt/go/libexec/src/internal/abi
$TOOL_DIR/asm -p internal/abi -trimpath "$WORK/b009=>" -I $WORK/b009/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b009/abi_test.o ./abi_test.s
mkdir -p $WORK/b027/
cat >$WORK/b027/importcfg << EOF # internal
# import config
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b027/_pkg_.a -trimpath "$WORK/b027=>" -p internal/race -std -complete -buildid 6k_7JN4Ro6ano3CJO236/6k_7JN4Ro6ano3CJO236 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b027/importcfg -pack /usr/local/opt/go/libexec/src/internal/race/doc.go /usr/local/opt/go/libexec/src/internal/race/norace.go
mkdir -p $WORK/b028/
cp $WORK/b023/_pkg_.a $CACHE_DIR/8a/8a8af225f53e3267a0e84e9236afd493febe04b00f6a1ebca9a385425ec5eb8b-d # internal
cat >$WORK/b028/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/sync/atomic
$TOOL_DIR/asm -p sync/atomic -trimpath "$WORK/b028=>" -I $WORK/b028/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b028/symabis ./asm.s
cd /usr/local/opt/go/libexec/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b011/cpu.o ./cpu.s
cd /usr/local/opt/go/libexec/src/runtime/internal/syscall
$TOOL_DIR/pack r $WORK/b018/_pkg_.a $WORK/b018/asm_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b018/_pkg_.a # internal
mkdir -p $WORK/b029/
cat >$WORK/b029/importcfg << EOF # internal
# import config
EOF
cd /usr/local/opt/go/libexec/src/runtime/internal/atomic
$TOOL_DIR/asm -p runtime/internal/atomic -trimpath "$WORK/b015=>" -I $WORK/b015/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b015/atomic_amd64.o ./atomic_amd64.s
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b029/_pkg_.a -trimpath "$WORK/b029=>" -p unicode -std -complete -buildid H5EVtAclvmQgmtO5OIl1/H5EVtAclvmQgmtO5OIl1 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b029/importcfg -pack /usr/local/opt/go/libexec/src/unicode/casetables.go /usr/local/opt/go/libexec/src/unicode/digit.go /usr/local/opt/go/libexec/src/unicode/graphic.go /usr/local/opt/go/libexec/src/unicode/letter.go /usr/local/opt/go/libexec/src/unicode/tables.go
cd /usr/local/opt/go/libexec/src/internal/abi
$TOOL_DIR/pack r $WORK/b009/_pkg_.a $WORK/b009/abi_test.o # internal
cp $WORK/b018/_pkg_.a $CACHE_DIR/1d/1d8e21f62bbc5b5ae39b82f62d2103f987588ed752533b349b007897e395d080-d # internal
$TOOL_DIR/buildid -w $WORK/b009/_pkg_.a # internal
cp $WORK/b009/_pkg_.a $CACHE_DIR/97/97e46b4de6600d66a48c41890d9b418b13b20b22bb9116831e53bb277d3cc219-d # internal
cd /usr/local/opt/go/libexec/src/internal/cpu
$TOOL_DIR/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b011/cpu_x86.o ./cpu_x86.s
$TOOL_DIR/buildid -w $WORK/b017/_pkg_.a # internal
cat >$WORK/b028/importcfg << EOF # internal
# import config
EOF
$TOOL_DIR/buildid -w $WORK/b027/_pkg_.a # internal
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b028/_pkg_.a -trimpath "$WORK/b028=>" -p sync/atomic -std -buildid 8sTHEv3qeP6epKjkp86J/8sTHEv3qeP6epKjkp86J -goversion go1.20.4 -symabis $WORK/b028/symabis -c=4 -nolocalimports -importcfg $WORK/b028/importcfg -pack -asmhdr $WORK/b028/go_asm.h /usr/local/opt/go/libexec/src/sync/atomic/doc.go /usr/local/opt/go/libexec/src/sync/atomic/type.go /usr/local/opt/go/libexec/src/sync/atomic/value.go
cp $WORK/b027/_pkg_.a $CACHE_DIR/8d/8d8748d628c00b0e17ec37c3b489e3f71aa648f54ebd42850107185a25c9c5d0-d # internal
cp $WORK/b017/_pkg_.a $CACHE_DIR/89/894fd9e5b3ec676bfc6db7792d9a73a660cab83b1469ee8b0ec1c7ab471453f3-d # internal
cd /usr/local/opt/go/libexec/src/runtime/internal/atomic
$TOOL_DIR/pack r $WORK/b015/_pkg_.a $WORK/b015/atomic_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b015/_pkg_.a # internal
cd /usr/local/opt/go/libexec/src/internal/cpu
$TOOL_DIR/pack r $WORK/b011/_pkg_.a $WORK/b011/cpu.o $WORK/b011/cpu_x86.o # internal
$TOOL_DIR/buildid -w $WORK/b011/_pkg_.a # internal
cp $WORK/b015/_pkg_.a $CACHE_DIR/9b/9b27352913aac753062d263539a28267204689b4f2b07b08874edc157621a704-d # internal
cp $WORK/b011/_pkg_.a $CACHE_DIR/06/0621a8c86a0f8a0475a63e05793305315e8701bc4b5d35227f39367f20a85bf7-d # internal
mkdir -p $WORK/b010/
cat >$WORK/b010/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/bytealg
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b010/symabis ./compare_amd64.s ./count_amd64.s ./equal_amd64.s ./index_amd64.s ./indexbyte_amd64.s
cat >$WORK/b010/importcfg << EOF # internal
# import config
packagefile internal/cpu=$WORK/b011/_pkg_.a
EOF
mkdir -p $WORK/b022/
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b010/_pkg_.a -trimpath "$WORK/b010=>" -p internal/bytealg -std -+ -buildid OWPwmEGblMug2ig95x_j/OWPwmEGblMug2ig95x_j -goversion go1.20.4 -symabis $WORK/b010/symabis -c=4 -nolocalimports -importcfg $WORK/b010/importcfg -pack -asmhdr $WORK/b010/go_asm.h /usr/local/opt/go/libexec/src/internal/bytealg/bytealg.go /usr/local/opt/go/libexec/src/internal/bytealg/compare_native.go /usr/local/opt/go/libexec/src/internal/bytealg/count_native.go /usr/local/opt/go/libexec/src/internal/bytealg/equal_generic.go /usr/local/opt/go/libexec/src/internal/bytealg/equal_native.go /usr/local/opt/go/libexec/src/internal/bytealg/index_amd64.go /usr/local/opt/go/libexec/src/internal/bytealg/index_native.go /usr/local/opt/go/libexec/src/internal/bytealg/indexbyte_native.go
cat >$WORK/b022/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b022/symabis ./dim_amd64.s ./exp_amd64.s ./floor_amd64.s ./hypot_amd64.s ./log_amd64.s
cd /usr/local/opt/go/libexec/src/sync/atomic
$TOOL_DIR/asm -p sync/atomic -trimpath "$WORK/b028=>" -I $WORK/b028/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b028/asm.o ./asm.s
cat >$WORK/b022/importcfg << EOF # internal
# import config
packagefile internal/cpu=$WORK/b011/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b022/_pkg_.a -trimpath "$WORK/b022=>" -p math -std -buildid M2k9bU3HlBq2CeX7eecL/M2k9bU3HlBq2CeX7eecL -goversion go1.20.4 -symabis $WORK/b022/symabis -c=4 -nolocalimports -importcfg $WORK/b022/importcfg -pack -asmhdr $WORK/b022/go_asm.h /usr/local/opt/go/libexec/src/math/abs.go /usr/local/opt/go/libexec/src/math/acosh.go /usr/local/opt/go/libexec/src/math/asin.go /usr/local/opt/go/libexec/src/math/asinh.go /usr/local/opt/go/libexec/src/math/atan.go /usr/local/opt/go/libexec/src/math/atan2.go /usr/local/opt/go/libexec/src/math/atanh.go /usr/local/opt/go/libexec/src/math/bits.go /usr/local/opt/go/libexec/src/math/cbrt.go /usr/local/opt/go/libexec/src/math/const.go /usr/local/opt/go/libexec/src/math/copysign.go /usr/local/opt/go/libexec/src/math/dim.go /usr/local/opt/go/libexec/src/math/dim_asm.go /usr/local/opt/go/libexec/src/math/erf.go /usr/local/opt/go/libexec/src/math/erfinv.go /usr/local/opt/go/libexec/src/math/exp.go /usr/local/opt/go/libexec/src/math/exp2_noasm.go /usr/local/opt/go/libexec/src/math/exp_amd64.go /usr/local/opt/go/libexec/src/math/exp_asm.go /usr/local/opt/go/libexec/src/math/expm1.go /usr/local/opt/go/libexec/src/math/floor.go /usr/local/opt/go/libexec/src/math/floor_asm.go /usr/local/opt/go/libexec/src/math/fma.go /usr/local/opt/go/libexec/src/math/frexp.go /usr/local/opt/go/libexec/src/math/gamma.go /usr/local/opt/go/libexec/src/math/hypot.go /usr/local/opt/go/libexec/src/math/hypot_asm.go /usr/local/opt/go/libexec/src/math/j0.go /usr/local/opt/go/libexec/src/math/j1.go /usr/local/opt/go/libexec/src/math/jn.go /usr/local/opt/go/libexec/src/math/ldexp.go /usr/local/opt/go/libexec/src/math/lgamma.go /usr/local/opt/go/libexec/src/math/log.go /usr/local/opt/go/libexec/src/math/log10.go /usr/local/opt/go/libexec/src/math/log1p.go /usr/local/opt/go/libexec/src/math/log_asm.go /usr/local/opt/go/libexec/src/math/logb.go /usr/local/opt/go/libexec/src/math/mod.go /usr/local/opt/go/libexec/src/math/modf.go /usr/local/opt/go/libexec/src/math/modf_noasm.go /usr/local/opt/go/libexec/src/math/nextafter.go /usr/local/opt/go/libexec/src/math/pow.go /usr/local/opt/go/libexec/src/math/pow10.go /usr/local/opt/go/libexec/src/math/remainder.go /usr/local/opt/go/libexec/src/math/signbit.go /usr/local/opt/go/libexec/src/math/sin.go /usr/local/opt/go/libexec/src/math/sincos.go /usr/local/opt/go/libexec/src/math/sinh.go /usr/local/opt/go/libexec/src/math/sqrt.go /usr/local/opt/go/libexec/src/math/stubs.go /usr/local/opt/go/libexec/src/math/tan.go /usr/local/opt/go/libexec/src/math/tanh.go /usr/local/opt/go/libexec/src/math/trig_reduce.go /usr/local/opt/go/libexec/src/math/unsafe.go
cd /usr/local/opt/go/libexec/src/sync/atomic
$TOOL_DIR/pack r $WORK/b028/_pkg_.a $WORK/b028/asm.o # internal
$TOOL_DIR/buildid -w $WORK/b028/_pkg_.a # internal
cd /usr/local/opt/go/libexec/src/internal/bytealg
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/compare_amd64.o ./compare_amd64.s
cp $WORK/b028/_pkg_.a $CACHE_DIR/60/607d046547a61f90e414bc462b44559534605a2b3331d30e80987de78eccec02-d # internal
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/count_amd64.o ./count_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/equal_amd64.o ./equal_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/index_amd64.o ./index_amd64.s
$TOOL_DIR/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/indexbyte_amd64.o ./indexbyte_amd64.s
$TOOL_DIR/pack r $WORK/b010/_pkg_.a $WORK/b010/compare_amd64.o $WORK/b010/count_amd64.o $WORK/b010/equal_amd64.o $WORK/b010/index_amd64.o $WORK/b010/indexbyte_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b010/_pkg_.a # internal
cp $WORK/b010/_pkg_.a $CACHE_DIR/3d/3d8c80401513467afb4c0ae8bfb06d098f84d53f83c67e867a73d5a9bd52c621-d # internal
mkdir -p $WORK/b008/
cat >$WORK/b008/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/runtime
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b008/symabis ./asm.s ./asm_amd64.s ./duff_amd64.s ./memclr_amd64.s ./memmove_amd64.s ./preempt_amd64.s ./rt0_linux_amd64.s ./sys_linux_amd64.s ./time_linux_amd64.s
cd /usr/local/opt/go/libexec/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/dim_amd64.o ./dim_amd64.s
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
$TOOL_DIR/compile -o $WORK/b008/_pkg_.a -trimpath "$WORK/b008=>" -p runtime -std -+ -buildid Njl5lkeGSG8PAp_cny9y/Njl5lkeGSG8PAp_cny9y -goversion go1.20.4 -symabis $WORK/b008/symabis -c=4 -nolocalimports -importcfg $WORK/b008/importcfg -pack -asmhdr $WORK/b008/go_asm.h /usr/local/opt/go/libexec/src/runtime/alg.go /usr/local/opt/go/libexec/src/runtime/arena.go /usr/local/opt/go/libexec/src/runtime/asan0.go /usr/local/opt/go/libexec/src/runtime/atomic_pointer.go /usr/local/opt/go/libexec/src/runtime/cgo.go /usr/local/opt/go/libexec/src/runtime/cgo_mmap.go /usr/local/opt/go/libexec/src/runtime/cgo_sigaction.go /usr/local/opt/go/libexec/src/runtime/cgocall.go /usr/local/opt/go/libexec/src/runtime/cgocallback.go /usr/local/opt/go/libexec/src/runtime/cgocheck.go /usr/local/opt/go/libexec/src/runtime/chan.go /usr/local/opt/go/libexec/src/runtime/checkptr.go /usr/local/opt/go/libexec/src/runtime/compiler.go /usr/local/opt/go/libexec/src/runtime/complex.go /usr/local/opt/go/libexec/src/runtime/covercounter.go /usr/local/opt/go/libexec/src/runtime/covermeta.go /usr/local/opt/go/libexec/src/runtime/cpuflags.go /usr/local/opt/go/libexec/src/runtime/cpuflags_amd64.go /usr/local/opt/go/libexec/src/runtime/cpuprof.go /usr/local/opt/go/libexec/src/runtime/cputicks.go /usr/local/opt/go/libexec/src/runtime/create_file_unix.go /usr/local/opt/go/libexec/src/runtime/debug.go /usr/local/opt/go/libexec/src/runtime/debugcall.go /usr/local/opt/go/libexec/src/runtime/debuglog.go /usr/local/opt/go/libexec/src/runtime/debuglog_off.go /usr/local/opt/go/libexec/src/runtime/defs_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/env_posix.go /usr/local/opt/go/libexec/src/runtime/error.go /usr/local/opt/go/libexec/src/runtime/exithook.go /usr/local/opt/go/libexec/src/runtime/extern.go /usr/local/opt/go/libexec/src/runtime/fastlog2.go /usr/local/opt/go/libexec/src/runtime/fastlog2table.go /usr/local/opt/go/libexec/src/runtime/float.go /usr/local/opt/go/libexec/src/runtime/hash64.go /usr/local/opt/go/libexec/src/runtime/heapdump.go /usr/local/opt/go/libexec/src/runtime/histogram.go /usr/local/opt/go/libexec/src/runtime/iface.go /usr/local/opt/go/libexec/src/runtime/lfstack.go /usr/local/opt/go/libexec/src/runtime/lfstack_64bit.go /usr/local/opt/go/libexec/src/runtime/lock_futex.go /usr/local/opt/go/libexec/src/runtime/lockrank.go /usr/local/opt/go/libexec/src/runtime/lockrank_off.go /usr/local/opt/go/libexec/src/runtime/malloc.go /usr/local/opt/go/libexec/src/runtime/map.go /usr/local/opt/go/libexec/src/runtime/map_fast32.go /usr/local/opt/go/libexec/src/runtime/map_fast64.go /usr/local/opt/go/libexec/src/runtime/map_faststr.go /usr/local/opt/go/libexec/src/runtime/mbarrier.go /usr/local/opt/go/libexec/src/runtime/mbitmap.go /usr/local/opt/go/libexec/src/runtime/mcache.go /usr/local/opt/go/libexec/src/runtime/mcentral.go /usr/local/opt/go/libexec/src/runtime/mcheckmark.go /usr/local/opt/go/libexec/src/runtime/mem.go /usr/local/opt/go/libexec/src/runtime/mem_linux.go /usr/local/opt/go/libexec/src/runtime/metrics.go /usr/local/opt/go/libexec/src/runtime/mfinal.go /usr/local/opt/go/libexec/src/runtime/mfixalloc.go /usr/local/opt/go/libexec/src/runtime/mgc.go /usr/local/opt/go/libexec/src/runtime/mgclimit.go /usr/local/opt/go/libexec/src/runtime/mgcmark.go /usr/local/opt/go/libexec/src/runtime/mgcpacer.go /usr/local/opt/go/libexec/src/runtime/mgcscavenge.go /usr/local/opt/go/libexec/src/runtime/mgcstack.go /usr/local/opt/go/libexec/src/runtime/mgcsweep.go /usr/local/opt/go/libexec/src/runtime/mgcwork.go /usr/local/opt/go/libexec/src/runtime/mheap.go /usr/local/opt/go/libexec/src/runtime/mpagealloc.go /usr/local/opt/go/libexec/src/runtime/mpagealloc_64bit.go /usr/local/opt/go/libexec/src/runtime/mpagecache.go /usr/local/opt/go/libexec/src/runtime/mpallocbits.go /usr/local/opt/go/libexec/src/runtime/mprof.go /usr/local/opt/go/libexec/src/runtime/mranges.go /usr/local/opt/go/libexec/src/runtime/msan0.go /usr/local/opt/go/libexec/src/runtime/msize.go /usr/local/opt/go/libexec/src/runtime/mspanset.go /usr/local/opt/go/libexec/src/runtime/mstats.go /usr/local/opt/go/libexec/src/runtime/mwbbuf.go /usr/local/opt/go/libexec/src/runtime/nbpipe_pipe2.go /usr/local/opt/go/libexec/src/runtime/netpoll.go /usr/local/opt/go/libexec/src/runtime/netpoll_epoll.go /usr/local/opt/go/libexec/src/runtime/os_linux.go /usr/local/opt/go/libexec/src/runtime/os_linux_generic.go /usr/local/opt/go/libexec/src/runtime/os_linux_noauxv.go /usr/local/opt/go/libexec/src/runtime/os_linux_x86.go /usr/local/opt/go/libexec/src/runtime/os_nonopenbsd.go /usr/local/opt/go/libexec/src/runtime/pagetrace_off.go /usr/local/opt/go/libexec/src/runtime/panic.go /usr/local/opt/go/libexec/src/runtime/plugin.go /usr/local/opt/go/libexec/src/runtime/preempt.go /usr/local/opt/go/libexec/src/runtime/preempt_nonwindows.go /usr/local/opt/go/libexec/src/runtime/print.go /usr/local/opt/go/libexec/src/runtime/proc.go /usr/local/opt/go/libexec/src/runtime/profbuf.go /usr/local/opt/go/libexec/src/runtime/proflabel.go /usr/local/opt/go/libexec/src/runtime/race0.go /usr/local/opt/go/libexec/src/runtime/rdebug.go /usr/local/opt/go/libexec/src/runtime/relax_stub.go /usr/local/opt/go/libexec/src/runtime/retry.go /usr/local/opt/go/libexec/src/runtime/runtime.go /usr/local/opt/go/libexec/src/runtime/runtime1.go /usr/local/opt/go/libexec/src/runtime/runtime2.go /usr/local/opt/go/libexec/src/runtime/runtime_boring.go /usr/local/opt/go/libexec/src/runtime/rwmutex.go /usr/local/opt/go/libexec/src/runtime/select.go /usr/local/opt/go/libexec/src/runtime/sema.go /usr/local/opt/go/libexec/src/runtime/signal_amd64.go /usr/local/opt/go/libexec/src/runtime/signal_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/signal_unix.go /usr/local/opt/go/libexec/src/runtime/sigqueue.go /usr/local/opt/go/libexec/src/runtime/sigqueue_note.go /usr/local/opt/go/libexec/src/runtime/sigtab_linux_generic.go /usr/local/opt/go/libexec/src/runtime/sizeclasses.go /usr/local/opt/go/libexec/src/runtime/slice.go /usr/local/opt/go/libexec/src/runtime/softfloat64.go /usr/local/opt/go/libexec/src/runtime/stack.go /usr/local/opt/go/libexec/src/runtime/stkframe.go /usr/local/opt/go/libexec/src/runtime/string.go /usr/local/opt/go/libexec/src/runtime/stubs.go /usr/local/opt/go/libexec/src/runtime/stubs2.go /usr/local/opt/go/libexec/src/runtime/stubs3.go /usr/local/opt/go/libexec/src/runtime/stubs_amd64.go /usr/local/opt/go/libexec/src/runtime/stubs_linux.go /usr/local/opt/go/libexec/src/runtime/symtab.go /usr/local/opt/go/libexec/src/runtime/sys_nonppc64x.go /usr/local/opt/go/libexec/src/runtime/sys_x86.go /usr/local/opt/go/libexec/src/runtime/time.go /usr/local/opt/go/libexec/src/runtime/time_nofake.go /usr/local/opt/go/libexec/src/runtime/timeasm.go /usr/local/opt/go/libexec/src/runtime/tls_stub.go /usr/local/opt/go/libexec/src/runtime/trace.go /usr/local/opt/go/libexec/src/runtime/traceback.go /usr/local/opt/go/libexec/src/runtime/type.go /usr/local/opt/go/libexec/src/runtime/typekind.go /usr/local/opt/go/libexec/src/runtime/unsafe.go /usr/local/opt/go/libexec/src/runtime/utf8.go /usr/local/opt/go/libexec/src/runtime/vdso_elf64.go /usr/local/opt/go/libexec/src/runtime/vdso_linux.go /usr/local/opt/go/libexec/src/runtime/vdso_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/write_err.go
cd /usr/local/opt/go/libexec/src/math
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/exp_amd64.o ./exp_amd64.s
cp $WORK/b029/_pkg_.a $CACHE_DIR/30/308aea17052e8d51adf8f3285ffddca41cb8097847ac43ecee40818df8954816-d # internal
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/floor_amd64.o ./floor_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/hypot_amd64.o ./hypot_amd64.s
$TOOL_DIR/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/log_amd64.o ./log_amd64.s
$TOOL_DIR/pack r $WORK/b022/_pkg_.a $WORK/b022/dim_amd64.o $WORK/b022/exp_amd64.o $WORK/b022/floor_amd64.o $WORK/b022/hypot_amd64.o $WORK/b022/log_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b022/_pkg_.a # internal
cp $WORK/b022/_pkg_.a $CACHE_DIR/90/90e33f0d8f79c7585c1559728930cf6936e8721a38d6c2b25ab179c8cce393d3-d # internal
cp /usr/local/opt/go/libexec/src/runtime/asm_amd64.h $WORK/b008/asm_GOARCH.h
cd /usr/local/opt/go/libexec/src/runtime
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/asm.o ./asm.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/asm_amd64.o ./asm_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/duff_amd64.o ./duff_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/memclr_amd64.o ./memclr_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/memmove_amd64.o ./memmove_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/preempt_amd64.o ./preempt_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/rt0_linux_amd64.o ./rt0_linux_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/sys_linux_amd64.o ./sys_linux_amd64.s
$TOOL_DIR/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/time_linux_amd64.o ./time_linux_amd64.s
$TOOL_DIR/pack r $WORK/b008/_pkg_.a $WORK/b008/asm.o $WORK/b008/asm_amd64.o $WORK/b008/duff_amd64.o $WORK/b008/memclr_amd64.o $WORK/b008/memmove_amd64.o $WORK/b008/preempt_amd64.o $WORK/b008/rt0_linux_amd64.o $WORK/b008/sys_linux_amd64.o $WORK/b008/time_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b008/_pkg_.a # internal
cp $WORK/b008/_pkg_.a $CACHE_DIR/f5/f5eae97d918371c7c83fe2a88e9dbb2fec09960c36aeb1d26b1c2f09d89305f9-d # internal
mkdir -p $WORK/b004/
cat >$WORK/b004/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/reflectlite
$TOOL_DIR/asm -p internal/reflectlite -trimpath "$WORK/b004=>" -I $WORK/b004/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b004/symabis ./asm.s
mkdir -p $WORK/b026/
cat >$WORK/b026/importcfg << EOF # internal
# import config
packagefile internal/race=$WORK/b027/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b026/_pkg_.a -trimpath "$WORK/b026=>" -p sync -std -buildid awcGvD6YFJooe2gt9uJS/awcGvD6YFJooe2gt9uJS -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b026/importcfg -pack /usr/local/opt/go/libexec/src/sync/cond.go /usr/local/opt/go/libexec/src/sync/map.go /usr/local/opt/go/libexec/src/sync/mutex.go /usr/local/opt/go/libexec/src/sync/once.go /usr/local/opt/go/libexec/src/sync/pool.go /usr/local/opt/go/libexec/src/sync/poolqueue.go /usr/local/opt/go/libexec/src/sync/runtime.go /usr/local/opt/go/libexec/src/sync/runtime2.go /usr/local/opt/go/libexec/src/sync/rwmutex.go /usr/local/opt/go/libexec/src/sync/waitgroup.go
cat >$WORK/b004/importcfg << EOF # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/unsafeheader=$WORK/b006/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b004/_pkg_.a -trimpath "$WORK/b004=>" -p internal/reflectlite -std -buildid 8f99mKJg6-OCUXX8caR3/8f99mKJg6-OCUXX8caR3 -goversion go1.20.4 -symabis $WORK/b004/symabis -c=4 -nolocalimports -importcfg $WORK/b004/importcfg -pack -asmhdr $WORK/b004/go_asm.h /usr/local/opt/go/libexec/src/internal/reflectlite/swapper.go /usr/local/opt/go/libexec/src/internal/reflectlite/type.go /usr/local/opt/go/libexec/src/internal/reflectlite/value.go
$TOOL_DIR/buildid -w $WORK/b026/_pkg_.a # internal
cp $WORK/b026/_pkg_.a $CACHE_DIR/8c/8ca5cd7b10f028bde0add0570182855542c74dd7b0f3f185d05d55cfb2761225-d # internal
mkdir -p $WORK/b040/
cat >$WORK/b040/importcfg << EOF # internal
# import config
packagefile sync=$WORK/b026/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b040/_pkg_.a -trimpath "$WORK/b040=>" -p internal/testlog -std -complete -buildid B423dGniR5COkyvnWNiY/B423dGniR5COkyvnWNiY -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b040/importcfg -pack /usr/local/opt/go/libexec/src/internal/testlog/exit.go /usr/local/opt/go/libexec/src/internal/testlog/log.go
$TOOL_DIR/buildid -w $WORK/b040/_pkg_.a # internal
cp $WORK/b040/_pkg_.a $CACHE_DIR/cd/cde97acef886e8f87e5610349ed4489b23a91ea2a610ba3fc6155f73d540d8a1-d # internal
cd /usr/local/opt/go/libexec/src/internal/reflectlite
$TOOL_DIR/asm -p internal/reflectlite -trimpath "$WORK/b004=>" -I $WORK/b004/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b004/asm.o ./asm.s
$TOOL_DIR/pack r $WORK/b004/_pkg_.a $WORK/b004/asm.o # internal
$TOOL_DIR/buildid -w $WORK/b004/_pkg_.a # internal
cp $WORK/b004/_pkg_.a $CACHE_DIR/68/68e93efe874f570ec44808ba740ec9e7f85ae99517fc1aa4d7d47a25f1ba0dd5-d # internal
mkdir -p $WORK/b003/
mkdir -p $WORK/b030/
cat >$WORK/b003/importcfg << EOF # internal
# import config
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b003/_pkg_.a -trimpath "$WORK/b003=>" -p errors -std -complete -buildid F_mcCqBziAv01tav5M2I/F_mcCqBziAv01tav5M2I -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b003/importcfg -pack /usr/local/opt/go/libexec/src/errors/errors.go /usr/local/opt/go/libexec/src/errors/join.go /usr/local/opt/go/libexec/src/errors/wrap.go
cat >$WORK/b030/importcfg << EOF # internal
# import config
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b030/_pkg_.a -trimpath "$WORK/b030=>" -p sort -std -complete -buildid RPytz-InhRnbWmq4E73g/RPytz-InhRnbWmq4E73g -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b030/importcfg -pack /usr/local/opt/go/libexec/src/sort/search.go /usr/local/opt/go/libexec/src/sort/slice.go /usr/local/opt/go/libexec/src/sort/sort.go /usr/local/opt/go/libexec/src/sort/zsortfunc.go /usr/local/opt/go/libexec/src/sort/zsortinterface.go
$TOOL_DIR/buildid -w $WORK/b003/_pkg_.a # internal
cp $WORK/b003/_pkg_.a $CACHE_DIR/c3/c3ca51b3dbf02d375ed334068291399ab9045e70f116b083e81befc8b32073f9-d # internal
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
$TOOL_DIR/compile -o $WORK/b038/_pkg_.a -trimpath "$WORK/b038=>" -p internal/safefilepath -std -complete -buildid hm1QrtEgJmcNx15tya8Y/hm1QrtEgJmcNx15tya8Y -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b038/importcfg -pack /usr/local/opt/go/libexec/src/internal/safefilepath/path.go /usr/local/opt/go/libexec/src/internal/safefilepath/path_other.go
$TOOL_DIR/compile -o $WORK/b036/_pkg_.a -trimpath "$WORK/b036=>" -p internal/oserror -std -complete -buildid ZyMHKeNnjmaHsZb3SqbR/ZyMHKeNnjmaHsZb3SqbR -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b036/importcfg -pack /usr/local/opt/go/libexec/src/internal/oserror/errors.go
$TOOL_DIR/compile -o $WORK/b042/_pkg_.a -trimpath "$WORK/b042=>" -p path -std -complete -buildid oyZvoNp0jsV46ZkzhwtB/oyZvoNp0jsV46ZkzhwtB -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b042/importcfg -pack /usr/local/opt/go/libexec/src/path/match.go /usr/local/opt/go/libexec/src/path/path.go
cat >$WORK/b031/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b031/_pkg_.a -trimpath "$WORK/b031=>" -p io -std -complete -buildid UXfIU_f9dqciElRShcLJ/UXfIU_f9dqciElRShcLJ -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b031/importcfg -pack /usr/local/opt/go/libexec/src/io/io.go /usr/local/opt/go/libexec/src/io/multi.go /usr/local/opt/go/libexec/src/io/pipe.go
mkdir -p $WORK/b024/
cat >$WORK/b024/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b024/_pkg_.a -trimpath "$WORK/b024=>" -p strconv -std -complete -buildid tsZ-5FuCj28fNWLKgaGw/tsZ-5FuCj28fNWLKgaGw -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b024/importcfg -pack /usr/local/opt/go/libexec/src/strconv/atob.go /usr/local/opt/go/libexec/src/strconv/atoc.go /usr/local/opt/go/libexec/src/strconv/atof.go /usr/local/opt/go/libexec/src/strconv/atoi.go /usr/local/opt/go/libexec/src/strconv/bytealg.go /usr/local/opt/go/libexec/src/strconv/ctoa.go /usr/local/opt/go/libexec/src/strconv/decimal.go /usr/local/opt/go/libexec/src/strconv/doc.go /usr/local/opt/go/libexec/src/strconv/eisel_lemire.go /usr/local/opt/go/libexec/src/strconv/ftoa.go /usr/local/opt/go/libexec/src/strconv/ftoaryu.go /usr/local/opt/go/libexec/src/strconv/isprint.go /usr/local/opt/go/libexec/src/strconv/itoa.go /usr/local/opt/go/libexec/src/strconv/quote.go
$TOOL_DIR/buildid -w $WORK/b038/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b036/_pkg_.a # internal
cp $WORK/b038/_pkg_.a $CACHE_DIR/7f/7f19737cdc4b7a80fe6c79a5773771840937e0649edced18bda637085f3eb5a7-d # internal
cp $WORK/b036/_pkg_.a $CACHE_DIR/6b/6bfc832c097aa830784db2380ca2fbeb0c5bbe680d0ce64ceda4afd925e21407-d # internal
$TOOL_DIR/buildid -w $WORK/b042/_pkg_.a # internal
cp $WORK/b042/_pkg_.a $CACHE_DIR/e3/e3566d6415cf10d62a5e496f409fab9922ec7c27417ea8ce5fe5a5a331f9b7f5-d # internal
$TOOL_DIR/buildid -w $WORK/b030/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b031/_pkg_.a # internal
cp $WORK/b030/_pkg_.a $CACHE_DIR/15/15c97b460afc045139634ffdd726154b4fce1651774ecd3a8a04434096da3516-d # internal
mkdir -p $WORK/b035/
cp $WORK/b031/_pkg_.a $CACHE_DIR/3f/3f47dbb23d8a725a8add0ccee53d305b53d47438adf59f282afb4e58c957e946-d # internal
cat >$WORK/b035/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/syscall
$TOOL_DIR/asm -p syscall -trimpath "$WORK/b035=>" -I $WORK/b035/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b035/symabis ./asm_linux_amd64.s
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
$TOOL_DIR/compile -o $WORK/b035/_pkg_.a -trimpath "$WORK/b035=>" -p syscall -std -buildid Gf1emYuyeATzm8AHyHFR/Gf1emYuyeATzm8AHyHFR -goversion go1.20.4 -symabis $WORK/b035/symabis -c=4 -nolocalimports -importcfg $WORK/b035/importcfg -pack -asmhdr $WORK/b035/go_asm.h /usr/local/opt/go/libexec/src/syscall/asan0.go /usr/local/opt/go/libexec/src/syscall/dirent.go /usr/local/opt/go/libexec/src/syscall/endian_little.go /usr/local/opt/go/libexec/src/syscall/env_unix.go /usr/local/opt/go/libexec/src/syscall/exec_linux.go /usr/local/opt/go/libexec/src/syscall/exec_unix.go /usr/local/opt/go/libexec/src/syscall/flock.go /usr/local/opt/go/libexec/src/syscall/lsf_linux.go /usr/local/opt/go/libexec/src/syscall/msan0.go /usr/local/opt/go/libexec/src/syscall/net.go /usr/local/opt/go/libexec/src/syscall/netlink_linux.go /usr/local/opt/go/libexec/src/syscall/rlimit.go /usr/local/opt/go/libexec/src/syscall/rlimit_stub.go /usr/local/opt/go/libexec/src/syscall/setuidgid_linux.go /usr/local/opt/go/libexec/src/syscall/sockcmsg_linux.go /usr/local/opt/go/libexec/src/syscall/sockcmsg_unix.go /usr/local/opt/go/libexec/src/syscall/sockcmsg_unix_other.go /usr/local/opt/go/libexec/src/syscall/syscall.go /usr/local/opt/go/libexec/src/syscall/syscall_linux.go /usr/local/opt/go/libexec/src/syscall/syscall_linux_accept4.go /usr/local/opt/go/libexec/src/syscall/syscall_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/syscall_unix.go /usr/local/opt/go/libexec/src/syscall/time_nofake.go /usr/local/opt/go/libexec/src/syscall/timestruct.go /usr/local/opt/go/libexec/src/syscall/zerrors_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/zsyscall_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/zsysnum_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/ztypes_linux_amd64.go
$TOOL_DIR/buildid -w $WORK/b024/_pkg_.a # internal
cp $WORK/b024/_pkg_.a $CACHE_DIR/1a/1ad0a4bf26d6a401443abecef2c0d58a39aa53cee9a04b799ed3b380005d7b6a-d # internal
mkdir -p $WORK/b020/
cat >$WORK/b020/go_asm.h << EOF # internal
EOF
cd /usr/local/opt/go/libexec/src/reflect
$TOOL_DIR/asm -p reflect -trimpath "$WORK/b020=>" -I $WORK/b020/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b020/symabis ./asm_amd64.s
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
$TOOL_DIR/compile -o $WORK/b020/_pkg_.a -trimpath "$WORK/b020=>" -p reflect -std -buildid nIapndKG10ZTabsNBtM3/nIapndKG10ZTabsNBtM3 -goversion go1.20.4 -symabis $WORK/b020/symabis -c=4 -nolocalimports -importcfg $WORK/b020/importcfg -pack -asmhdr $WORK/b020/go_asm.h /usr/local/opt/go/libexec/src/reflect/abi.go /usr/local/opt/go/libexec/src/reflect/deepequal.go /usr/local/opt/go/libexec/src/reflect/float32reg_generic.go /usr/local/opt/go/libexec/src/reflect/makefunc.go /usr/local/opt/go/libexec/src/reflect/swapper.go /usr/local/opt/go/libexec/src/reflect/type.go /usr/local/opt/go/libexec/src/reflect/value.go /usr/local/opt/go/libexec/src/reflect/visiblefields.go
cd /usr/local/opt/go/libexec/src/syscall
$TOOL_DIR/asm -p syscall -trimpath "$WORK/b035=>" -I $WORK/b035/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b035/asm_linux_amd64.o ./asm_linux_amd64.s
$TOOL_DIR/pack r $WORK/b035/_pkg_.a $WORK/b035/asm_linux_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b035/_pkg_.a # internal
cp $WORK/b035/_pkg_.a $CACHE_DIR/90/90c34d05dac34b8a71d3fe8c56629372bbf8c526cb99cd62209ee723971848f7-d # internal
mkdir -p $WORK/b039/
cat >$WORK/b039/importcfg << EOF # internal
# import config
packagefile syscall=$WORK/b035/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b039/_pkg_.a -trimpath "$WORK/b039=>" -p internal/syscall/execenv -std -complete -buildid 9v4cH9-eclFZmCPdzfl0/9v4cH9-eclFZmCPdzfl0 -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b039/importcfg -pack /usr/local/opt/go/libexec/src/internal/syscall/execenv/execenv_default.go
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
$TOOL_DIR/compile -o $WORK/b034/_pkg_.a -trimpath "$WORK/b034=>" -p internal/syscall/unix -std -complete -buildid y7B9w1xvVOcllLe1UHTw/y7B9w1xvVOcllLe1UHTw -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b034/importcfg -pack /usr/local/opt/go/libexec/src/internal/syscall/unix/at.go /usr/local/opt/go/libexec/src/internal/syscall/unix/at_fstatat.go /usr/local/opt/go/libexec/src/internal/syscall/unix/at_sysnum_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/at_sysnum_newfstatat_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/constants.go /usr/local/opt/go/libexec/src/internal/syscall/unix/copy_file_range_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/eaccess_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/getrandom.go /usr/local/opt/go/libexec/src/internal/syscall/unix/getrandom_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/kernel_version_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/net.go /usr/local/opt/go/libexec/src/internal/syscall/unix/nonblocking.go /usr/local/opt/go/libexec/src/internal/syscall/unix/sysnum_linux_amd64.go
$TOOL_DIR/compile -o $WORK/b037/_pkg_.a -trimpath "$WORK/b037=>" -p time -std -buildid JPr4o2PkKYQpYoXGOl8u/JPr4o2PkKYQpYoXGOl8u -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b037/importcfg -pack /usr/local/opt/go/libexec/src/time/format.go /usr/local/opt/go/libexec/src/time/format_rfc3339.go /usr/local/opt/go/libexec/src/time/sleep.go /usr/local/opt/go/libexec/src/time/sys_unix.go /usr/local/opt/go/libexec/src/time/tick.go /usr/local/opt/go/libexec/src/time/time.go /usr/local/opt/go/libexec/src/time/zoneinfo.go /usr/local/opt/go/libexec/src/time/zoneinfo_goroot.go /usr/local/opt/go/libexec/src/time/zoneinfo_read.go /usr/local/opt/go/libexec/src/time/zoneinfo_unix.go
$TOOL_DIR/buildid -w $WORK/b039/_pkg_.a # internal
cp $WORK/b039/_pkg_.a $CACHE_DIR/5a/5a5ad223fd7e129835d0f9a6c6ccecc70c2b50f40b78a6d4d20b06fafd51821b-d # internal
$TOOL_DIR/buildid -w $WORK/b034/_pkg_.a # internal
cp $WORK/b034/_pkg_.a $CACHE_DIR/42/426f444477d471f5cd570f0597420b970c802a8fbf1ca0ad38ac3b30f8bc3f0a-d # internal
$TOOL_DIR/buildid -w $WORK/b037/_pkg_.a # internal
cp $WORK/b037/_pkg_.a $CACHE_DIR/2d/2d930289955ec68431cef7e8d9bb7b5b2d6dccd93e45f68f63868cf7045146af-d # internal
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
$TOOL_DIR/compile -o $WORK/b041/_pkg_.a -trimpath "$WORK/b041=>" -p io/fs -std -complete -buildid EvJOhnLtLuHzGX4dFlcg/EvJOhnLtLuHzGX4dFlcg -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b041/importcfg -pack /usr/local/opt/go/libexec/src/io/fs/fs.go /usr/local/opt/go/libexec/src/io/fs/glob.go /usr/local/opt/go/libexec/src/io/fs/readdir.go /usr/local/opt/go/libexec/src/io/fs/readfile.go /usr/local/opt/go/libexec/src/io/fs/stat.go /usr/local/opt/go/libexec/src/io/fs/sub.go /usr/local/opt/go/libexec/src/io/fs/walk.go
cd /usr/local/opt/go/libexec/src/reflect
$TOOL_DIR/asm -p reflect -trimpath "$WORK/b020=>" -I $WORK/b020/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b020/asm_amd64.o ./asm_amd64.s
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
$TOOL_DIR/compile -o $WORK/b033/_pkg_.a -trimpath "$WORK/b033=>" -p internal/poll -std -buildid z1T_88ivNUFrGnA9-Iwx/z1T_88ivNUFrGnA9-Iwx -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b033/importcfg -pack /usr/local/opt/go/libexec/src/internal/poll/copy_file_range_linux.go /usr/local/opt/go/libexec/src/internal/poll/errno_unix.go /usr/local/opt/go/libexec/src/internal/poll/fcntl_syscall.go /usr/local/opt/go/libexec/src/internal/poll/fd.go /usr/local/opt/go/libexec/src/internal/poll/fd_fsync_posix.go /usr/local/opt/go/libexec/src/internal/poll/fd_mutex.go /usr/local/opt/go/libexec/src/internal/poll/fd_poll_runtime.go /usr/local/opt/go/libexec/src/internal/poll/fd_posix.go /usr/local/opt/go/libexec/src/internal/poll/fd_unix.go /usr/local/opt/go/libexec/src/internal/poll/fd_writev_unix.go /usr/local/opt/go/libexec/src/internal/poll/hook_cloexec.go /usr/local/opt/go/libexec/src/internal/poll/hook_unix.go /usr/local/opt/go/libexec/src/internal/poll/iovec_unix.go /usr/local/opt/go/libexec/src/internal/poll/sendfile_linux.go /usr/local/opt/go/libexec/src/internal/poll/sock_cloexec.go /usr/local/opt/go/libexec/src/internal/poll/sockopt.go /usr/local/opt/go/libexec/src/internal/poll/sockopt_linux.go /usr/local/opt/go/libexec/src/internal/poll/sockopt_unix.go /usr/local/opt/go/libexec/src/internal/poll/sockoptip.go /usr/local/opt/go/libexec/src/internal/poll/splice_linux.go /usr/local/opt/go/libexec/src/internal/poll/writev.go
cd /usr/local/opt/go/libexec/src/reflect
$TOOL_DIR/pack r $WORK/b020/_pkg_.a $WORK/b020/asm_amd64.o # internal
$TOOL_DIR/buildid -w $WORK/b020/_pkg_.a # internal
$TOOL_DIR/buildid -w $WORK/b041/_pkg_.a # internal
cp $WORK/b020/_pkg_.a $CACHE_DIR/d5/d5fd69d99da4bee5f1ec02b332f5f903af8e9e36df61950ce58553ec3f55b3a3-d # internal
mkdir -p $WORK/b019/
cat >$WORK/b019/importcfg << EOF # internal
# import config
packagefile reflect=$WORK/b020/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
EOF
cd $SRC_DIR
$TOOL_DIR/compile -o $WORK/b019/_pkg_.a -trimpath "$WORK/b019=>" -p internal/fmtsort -std -complete -buildid sCxpPvJyA5xP8dZYIW2S/sCxpPvJyA5xP8dZYIW2S -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b019/importcfg -pack /usr/local/opt/go/libexec/src/internal/fmtsort/sort.go
cp $WORK/b041/_pkg_.a $CACHE_DIR/2c/2c2609c66a19a399f3dab8b33bd4da54655aefd1e62414acfe3fe7ffda6e7770-d # internal
$TOOL_DIR/buildid -w $WORK/b019/_pkg_.a # internal
cp $WORK/b019/_pkg_.a $CACHE_DIR/60/60db98208e085d1cb81f8849168369dd6dffaa75a2a8817537ff9840e544def8-d # internal
$TOOL_DIR/buildid -w $WORK/b033/_pkg_.a # internal
cp $WORK/b033/_pkg_.a $CACHE_DIR/8a/8a23e35e436231c957d53722575f693b9876e4444db8b34bddfa4b3af0d1a960-d # internal
mkdir -p $WORK/b032/
cat >$WORK/b032/importcfg << EOF # internal
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
$TOOL_DIR/compile -o $WORK/b032/_pkg_.a -trimpath "$WORK/b032=>" -p os -std -buildid 8kTY3IGtc09hvOwTK2Gg/8kTY3IGtc09hvOwTK2Gg -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b032/importcfg -pack /usr/local/opt/go/libexec/src/os/dir.go /usr/local/opt/go/libexec/src/os/dir_unix.go /usr/local/opt/go/libexec/src/os/dirent_linux.go /usr/local/opt/go/libexec/src/os/endian_little.go /usr/local/opt/go/libexec/src/os/env.go /usr/local/opt/go/libexec/src/os/error.go /usr/local/opt/go/libexec/src/os/error_errno.go /usr/local/opt/go/libexec/src/os/error_posix.go /usr/local/opt/go/libexec/src/os/exec.go /usr/local/opt/go/libexec/src/os/exec_posix.go /usr/local/opt/go/libexec/src/os/exec_unix.go /usr/local/opt/go/libexec/src/os/executable.go /usr/local/opt/go/libexec/src/os/executable_procfs.go /usr/local/opt/go/libexec/src/os/file.go /usr/local/opt/go/libexec/src/os/file_posix.go /usr/local/opt/go/libexec/src/os/file_unix.go /usr/local/opt/go/libexec/src/os/getwd.go /usr/local/opt/go/libexec/src/os/path.go /usr/local/opt/go/libexec/src/os/path_unix.go /usr/local/opt/go/libexec/src/os/pipe2_unix.go /usr/local/opt/go/libexec/src/os/proc.go /usr/local/opt/go/libexec/src/os/rawconn.go /usr/local/opt/go/libexec/src/os/readfrom_linux.go /usr/local/opt/go/libexec/src/os/removeall_at.go /usr/local/opt/go/libexec/src/os/stat.go /usr/local/opt/go/libexec/src/os/stat_linux.go /usr/local/opt/go/libexec/src/os/stat_unix.go /usr/local/opt/go/libexec/src/os/sticky_notbsd.go /usr/local/opt/go/libexec/src/os/str.go /usr/local/opt/go/libexec/src/os/sys.go /usr/local/opt/go/libexec/src/os/sys_linux.go /usr/local/opt/go/libexec/src/os/sys_unix.go /usr/local/opt/go/libexec/src/os/tempfile.go /usr/local/opt/go/libexec/src/os/types.go /usr/local/opt/go/libexec/src/os/types_unix.go /usr/local/opt/go/libexec/src/os/wait_waitid.go
$TOOL_DIR/buildid -w $WORK/b032/_pkg_.a # internal
cp $WORK/b032/_pkg_.a $CACHE_DIR/9f/9f4f9105c37b2865b130bc5f783edf18bd1066b6d71eee53c8f53f2da3e87710-d # internal
mkdir -p $WORK/b002/
cat >$WORK/b002/importcfg << EOF # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/fmtsort=$WORK/b019/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile os=$WORK/b032/_pkg_.a
packagefile reflect=$WORK/b020/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
packagefile strconv=$WORK/b024/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b002/_pkg_.a -trimpath "$WORK/b002=>" -p fmt -std -complete -buildid ISNWJORYgVMWtTTWVw3z/ISNWJORYgVMWtTTWVw3z -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b002/importcfg -pack /usr/local/opt/go/libexec/src/fmt/doc.go /usr/local/opt/go/libexec/src/fmt/errors.go /usr/local/opt/go/libexec/src/fmt/format.go /usr/local/opt/go/libexec/src/fmt/print.go /usr/local/opt/go/libexec/src/fmt/scan.go
$TOOL_DIR/buildid -w $WORK/b002/_pkg_.a # internal
cp $WORK/b002/_pkg_.a $CACHE_DIR/cf/cff345f70671e508776e8b231b79e372c4676ffe417a1a3806c5caf95e9bd7cf-d # internal
mkdir -p $WORK/b001/
cat >$WORK/b001/importcfg << EOF # internal
# import config
packagefile fmt=$WORK/b002/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
$TOOL_DIR/compile -o $WORK/b001/_pkg_.a -trimpath "$WORK/b001=>" -p main -lang=go1.20 -complete -buildid aHxht5d7JGm1qJULUhhT/aHxht5d7JGm1qJULUhhT -goversion go1.20.4 -c=4 -nolocalimports -importcfg $WORK/b001/importcfg -pack ./main.go ./sum.go
$TOOL_DIR/buildid -w $WORK/b001/_pkg_.a # internal
cp $WORK/b001/_pkg_.a $CACHE_DIR/7a/7a314cdb7644f75ade9e29b91291f7f6635c9ddf4a7ab138f3a0578465a22a40-d # internal
cat >$WORK/b001/importcfg.link << EOF # internal
packagefile github.com/DQNEO/go-samples/birudo=$WORK/b001/_pkg_.a
packagefile fmt=$WORK/b002/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/fmtsort=$WORK/b019/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile os=$WORK/b032/_pkg_.a
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
mkdir -p $WORK/b001/exe/
cd .
$TOOL_DIR/link -o $WORK/b001/exe/a.out -importcfg $WORK/b001/importcfg.link -buildmode=exe -buildid=yekYyg_HZMgX517VPpiO/aHxht5d7JGm1qJULUhhT/ct0PU8-vieH10gtMxGeC/yekYyg_HZMgX517VPpiO -extld=cc $WORK/b001/_pkg_.a
$TOOL_DIR/buildid -w $WORK/b001/exe/a.out # internal
mv $WORK/b001/exe/a.out birudo
rm -r $WORK/b001/
