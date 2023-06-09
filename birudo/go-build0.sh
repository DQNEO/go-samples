
#
# internal/goarch
#

mkdir -p $WORK/b005/
cat >$WORK/b005/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b005/_pkg_.a -trimpath "$WORK/b005=>" -p internal/goarch -std -+ -complete -buildid IeHgz3mN0XMxQJyLQgHG/IeHgz3mN0XMxQJyLQgHG -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b005/importcfg -pack /usr/local/opt/go/libexec/src/internal/goarch/goarch.go /usr/local/opt/go/libexec/src/internal/goarch/goarch_amd64.go /usr/local/opt/go/libexec/src/internal/goarch/zgoarch_amd64.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b005/_pkg_.a # internal

#
# internal/unsafeheader
#

mkdir -p $WORK/b006/
cat >$WORK/b006/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b006/_pkg_.a -trimpath "$WORK/b006=>" -p internal/unsafeheader -std -complete -buildid P7qFpguryEe_9bufASvc/P7qFpguryEe_9bufASvc -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b006/importcfg -pack /usr/local/opt/go/libexec/src/internal/unsafeheader/unsafeheader.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b006/_pkg_.a # internal

#
# internal/abi
#

mkdir -p $WORK/b009/
cat >$WORK/b009/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/abi
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/abi -trimpath "$WORK/b009=>" -I $WORK/b009/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b009/symabis ./abi_test.s
cat >$WORK/b009/importcfg << 'EOF' # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b009/_pkg_.a -trimpath "$WORK/b009=>" -p internal/abi -std -+ -buildid oULlro_TintWAkR4_Ij6/oULlro_TintWAkR4_Ij6 -goversion go1.20.4 -symabis $WORK/b009/symabis -c=8 -nolocalimports -importcfg $WORK/b009/importcfg -pack -asmhdr $WORK/b009/go_asm.h /usr/local/opt/go/libexec/src/internal/abi/abi.go /usr/local/opt/go/libexec/src/internal/abi/abi_amd64.go
cd /usr/local/opt/go/libexec/src/internal/abi
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/abi -trimpath "$WORK/b009=>" -I $WORK/b009/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b009/abi_test.o ./abi_test.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b009/_pkg_.a $WORK/b009/abi_test.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b009/_pkg_.a # internal

#
# internal/cpu
#

mkdir -p $WORK/b011/
cat >$WORK/b011/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/cpu
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b011/symabis ./cpu.s ./cpu_x86.s
cat >$WORK/b011/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b011/_pkg_.a -trimpath "$WORK/b011=>" -p internal/cpu -std -+ -buildid j9mgjw9q7aHUtebwQoGa/j9mgjw9q7aHUtebwQoGa -goversion go1.20.4 -symabis $WORK/b011/symabis -c=8 -nolocalimports -importcfg $WORK/b011/importcfg -pack -asmhdr $WORK/b011/go_asm.h /usr/local/opt/go/libexec/src/internal/cpu/cpu.go /usr/local/opt/go/libexec/src/internal/cpu/cpu_x86.go
cd /usr/local/opt/go/libexec/src/internal/cpu
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b011/cpu.o ./cpu.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/cpu -trimpath "$WORK/b011=>" -I $WORK/b011/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b011/cpu_x86.o ./cpu_x86.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b011/_pkg_.a $WORK/b011/cpu.o $WORK/b011/cpu_x86.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b011/_pkg_.a # internal

#
# internal/bytealg
#

mkdir -p $WORK/b010/
cat >$WORK/b010/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/bytealg
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b010/symabis ./compare_amd64.s ./count_amd64.s ./equal_amd64.s ./index_amd64.s ./indexbyte_amd64.s
cat >$WORK/b010/importcfg << 'EOF' # internal
# import config
packagefile internal/cpu=$WORK/b011/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b010/_pkg_.a -trimpath "$WORK/b010=>" -p internal/bytealg -std -+ -buildid HagWzm-w_SQPL2DvyGXH/HagWzm-w_SQPL2DvyGXH -goversion go1.20.4 -symabis $WORK/b010/symabis -c=8 -nolocalimports -importcfg $WORK/b010/importcfg -pack -asmhdr $WORK/b010/go_asm.h /usr/local/opt/go/libexec/src/internal/bytealg/bytealg.go /usr/local/opt/go/libexec/src/internal/bytealg/compare_native.go /usr/local/opt/go/libexec/src/internal/bytealg/count_native.go /usr/local/opt/go/libexec/src/internal/bytealg/equal_generic.go /usr/local/opt/go/libexec/src/internal/bytealg/equal_native.go /usr/local/opt/go/libexec/src/internal/bytealg/index_amd64.go /usr/local/opt/go/libexec/src/internal/bytealg/index_native.go /usr/local/opt/go/libexec/src/internal/bytealg/indexbyte_native.go
cd /usr/local/opt/go/libexec/src/internal/bytealg
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/compare_amd64.o ./compare_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/count_amd64.o ./count_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/equal_amd64.o ./equal_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/index_amd64.o ./index_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/bytealg -trimpath "$WORK/b010=>" -I $WORK/b010/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b010/indexbyte_amd64.o ./indexbyte_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b010/_pkg_.a $WORK/b010/compare_amd64.o $WORK/b010/count_amd64.o $WORK/b010/equal_amd64.o $WORK/b010/index_amd64.o $WORK/b010/indexbyte_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b010/_pkg_.a # internal

#
# internal/coverage/rtcov
#

mkdir -p $WORK/b012/
cat >$WORK/b012/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b012/_pkg_.a -trimpath "$WORK/b012=>" -p internal/coverage/rtcov -std -+ -complete -buildid Gk43QGhY-y2T4KaecSdc/Gk43QGhY-y2T4KaecSdc -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b012/importcfg -pack /usr/local/opt/go/libexec/src/internal/coverage/rtcov/rtcov.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b012/_pkg_.a # internal

#
# internal/goexperiment
#

mkdir -p $WORK/b013/
cat >$WORK/b013/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b013/_pkg_.a -trimpath "$WORK/b013=>" -p internal/goexperiment -std -complete -buildid yMFIFNsS8SAX_RrWD2i8/yMFIFNsS8SAX_RrWD2i8 -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b013/importcfg -pack /usr/local/opt/go/libexec/src/internal/goexperiment/exp_arenas_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_boringcrypto_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_coverageredesign_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_fieldtrack_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_heapminimum512kib_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_pagetrace_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_preemptibleloops_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_regabiargs_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_regabiwrappers_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_staticlockranking_off.go /usr/local/opt/go/libexec/src/internal/goexperiment/exp_unified_on.go /usr/local/opt/go/libexec/src/internal/goexperiment/flags.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b013/_pkg_.a # internal

#
# internal/goos
#

mkdir -p $WORK/b014/
cat >$WORK/b014/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b014/_pkg_.a -trimpath "$WORK/b014=>" -p internal/goos -std -+ -complete -buildid yhVHvx5gAuhGe0etJIbA/yhVHvx5gAuhGe0etJIbA -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b014/importcfg -pack /usr/local/opt/go/libexec/src/internal/goos/goos.go /usr/local/opt/go/libexec/src/internal/goos/unix.go /usr/local/opt/go/libexec/src/internal/goos/zgoos_linux.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b014/_pkg_.a # internal

#
# runtime/internal/atomic
#

mkdir -p $WORK/b015/
cat >$WORK/b015/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/runtime/internal/atomic
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime/internal/atomic -trimpath "$WORK/b015=>" -I $WORK/b015/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b015/symabis ./atomic_amd64.s
cat >$WORK/b015/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b015/_pkg_.a -trimpath "$WORK/b015=>" -p runtime/internal/atomic -std -+ -buildid IgGysWgqntnGBJ3sVB-f/IgGysWgqntnGBJ3sVB-f -goversion go1.20.4 -symabis $WORK/b015/symabis -c=8 -nolocalimports -importcfg $WORK/b015/importcfg -pack -asmhdr $WORK/b015/go_asm.h /usr/local/opt/go/libexec/src/runtime/internal/atomic/atomic_amd64.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/doc.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/stubs.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/types.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/types_64bit.go /usr/local/opt/go/libexec/src/runtime/internal/atomic/unaligned.go
cd /usr/local/opt/go/libexec/src/runtime/internal/atomic
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime/internal/atomic -trimpath "$WORK/b015=>" -I $WORK/b015/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b015/atomic_amd64.o ./atomic_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b015/_pkg_.a $WORK/b015/atomic_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b015/_pkg_.a # internal

#
# runtime/internal/math
#

mkdir -p $WORK/b016/
cat >$WORK/b016/importcfg << 'EOF' # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b016/_pkg_.a -trimpath "$WORK/b016=>" -p runtime/internal/math -std -+ -complete -buildid BZYhvx48WkKFYP4o254T/BZYhvx48WkKFYP4o254T -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b016/importcfg -pack /usr/local/opt/go/libexec/src/runtime/internal/math/math.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b016/_pkg_.a # internal

#
# runtime/internal/sys
#

mkdir -p $WORK/b017/
cat >$WORK/b017/importcfg << 'EOF' # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/goos=$WORK/b014/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b017/_pkg_.a -trimpath "$WORK/b017=>" -p runtime/internal/sys -std -+ -complete -buildid j5ce3PvbGjebYHAe5W3V/j5ce3PvbGjebYHAe5W3V -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b017/importcfg -pack /usr/local/opt/go/libexec/src/runtime/internal/sys/consts.go /usr/local/opt/go/libexec/src/runtime/internal/sys/consts_norace.go /usr/local/opt/go/libexec/src/runtime/internal/sys/intrinsics.go /usr/local/opt/go/libexec/src/runtime/internal/sys/intrinsics_common.go /usr/local/opt/go/libexec/src/runtime/internal/sys/nih.go /usr/local/opt/go/libexec/src/runtime/internal/sys/sys.go /usr/local/opt/go/libexec/src/runtime/internal/sys/zversion.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b017/_pkg_.a # internal

#
# runtime/internal/syscall
#

mkdir -p $WORK/b018/
cat >$WORK/b018/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/runtime/internal/syscall
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime/internal/syscall -trimpath "$WORK/b018=>" -I $WORK/b018/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b018/symabis ./asm_linux_amd64.s
cat >$WORK/b018/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b018/_pkg_.a -trimpath "$WORK/b018=>" -p runtime/internal/syscall -std -+ -buildid gZLMb57b8-GCtAQAQvdR/gZLMb57b8-GCtAQAQvdR -goversion go1.20.4 -symabis $WORK/b018/symabis -c=8 -nolocalimports -importcfg $WORK/b018/importcfg -pack -asmhdr $WORK/b018/go_asm.h /usr/local/opt/go/libexec/src/runtime/internal/syscall/defs_linux.go /usr/local/opt/go/libexec/src/runtime/internal/syscall/defs_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/internal/syscall/syscall_linux.go
cd /usr/local/opt/go/libexec/src/runtime/internal/syscall
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime/internal/syscall -trimpath "$WORK/b018=>" -I $WORK/b018/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b018/asm_linux_amd64.o ./asm_linux_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b018/_pkg_.a $WORK/b018/asm_linux_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b018/_pkg_.a # internal

#
# runtime
#

mkdir -p $WORK/b008/
cat >$WORK/b008/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/runtime
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b008/symabis ./asm.s ./asm_amd64.s ./duff_amd64.s ./memclr_amd64.s ./memmove_amd64.s ./preempt_amd64.s ./rt0_linux_amd64.s ./sys_linux_amd64.s ./time_linux_amd64.s
cat >$WORK/b008/importcfg << 'EOF' # internal
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
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b008/_pkg_.a -trimpath "$WORK/b008=>" -p runtime -std -+ -buildid lnjXvgf4lglxQxP2Nt6v/lnjXvgf4lglxQxP2Nt6v -goversion go1.20.4 -symabis $WORK/b008/symabis -c=8 -nolocalimports -importcfg $WORK/b008/importcfg -pack -asmhdr $WORK/b008/go_asm.h /usr/local/opt/go/libexec/src/runtime/alg.go /usr/local/opt/go/libexec/src/runtime/arena.go /usr/local/opt/go/libexec/src/runtime/asan0.go /usr/local/opt/go/libexec/src/runtime/atomic_pointer.go /usr/local/opt/go/libexec/src/runtime/cgo.go /usr/local/opt/go/libexec/src/runtime/cgo_mmap.go /usr/local/opt/go/libexec/src/runtime/cgo_sigaction.go /usr/local/opt/go/libexec/src/runtime/cgocall.go /usr/local/opt/go/libexec/src/runtime/cgocallback.go /usr/local/opt/go/libexec/src/runtime/cgocheck.go /usr/local/opt/go/libexec/src/runtime/chan.go /usr/local/opt/go/libexec/src/runtime/checkptr.go /usr/local/opt/go/libexec/src/runtime/compiler.go /usr/local/opt/go/libexec/src/runtime/complex.go /usr/local/opt/go/libexec/src/runtime/covercounter.go /usr/local/opt/go/libexec/src/runtime/covermeta.go /usr/local/opt/go/libexec/src/runtime/cpuflags.go /usr/local/opt/go/libexec/src/runtime/cpuflags_amd64.go /usr/local/opt/go/libexec/src/runtime/cpuprof.go /usr/local/opt/go/libexec/src/runtime/cputicks.go /usr/local/opt/go/libexec/src/runtime/create_file_unix.go /usr/local/opt/go/libexec/src/runtime/debug.go /usr/local/opt/go/libexec/src/runtime/debugcall.go /usr/local/opt/go/libexec/src/runtime/debuglog.go /usr/local/opt/go/libexec/src/runtime/debuglog_off.go /usr/local/opt/go/libexec/src/runtime/defs_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/env_posix.go /usr/local/opt/go/libexec/src/runtime/error.go /usr/local/opt/go/libexec/src/runtime/exithook.go /usr/local/opt/go/libexec/src/runtime/extern.go /usr/local/opt/go/libexec/src/runtime/fastlog2.go /usr/local/opt/go/libexec/src/runtime/fastlog2table.go /usr/local/opt/go/libexec/src/runtime/float.go /usr/local/opt/go/libexec/src/runtime/hash64.go /usr/local/opt/go/libexec/src/runtime/heapdump.go /usr/local/opt/go/libexec/src/runtime/histogram.go /usr/local/opt/go/libexec/src/runtime/iface.go /usr/local/opt/go/libexec/src/runtime/lfstack.go /usr/local/opt/go/libexec/src/runtime/lfstack_64bit.go /usr/local/opt/go/libexec/src/runtime/lock_futex.go /usr/local/opt/go/libexec/src/runtime/lockrank.go /usr/local/opt/go/libexec/src/runtime/lockrank_off.go /usr/local/opt/go/libexec/src/runtime/malloc.go /usr/local/opt/go/libexec/src/runtime/map.go /usr/local/opt/go/libexec/src/runtime/map_fast32.go /usr/local/opt/go/libexec/src/runtime/map_fast64.go /usr/local/opt/go/libexec/src/runtime/map_faststr.go /usr/local/opt/go/libexec/src/runtime/mbarrier.go /usr/local/opt/go/libexec/src/runtime/mbitmap.go /usr/local/opt/go/libexec/src/runtime/mcache.go /usr/local/opt/go/libexec/src/runtime/mcentral.go /usr/local/opt/go/libexec/src/runtime/mcheckmark.go /usr/local/opt/go/libexec/src/runtime/mem.go /usr/local/opt/go/libexec/src/runtime/mem_linux.go /usr/local/opt/go/libexec/src/runtime/metrics.go /usr/local/opt/go/libexec/src/runtime/mfinal.go /usr/local/opt/go/libexec/src/runtime/mfixalloc.go /usr/local/opt/go/libexec/src/runtime/mgc.go /usr/local/opt/go/libexec/src/runtime/mgclimit.go /usr/local/opt/go/libexec/src/runtime/mgcmark.go /usr/local/opt/go/libexec/src/runtime/mgcpacer.go /usr/local/opt/go/libexec/src/runtime/mgcscavenge.go /usr/local/opt/go/libexec/src/runtime/mgcstack.go /usr/local/opt/go/libexec/src/runtime/mgcsweep.go /usr/local/opt/go/libexec/src/runtime/mgcwork.go /usr/local/opt/go/libexec/src/runtime/mheap.go /usr/local/opt/go/libexec/src/runtime/mpagealloc.go /usr/local/opt/go/libexec/src/runtime/mpagealloc_64bit.go /usr/local/opt/go/libexec/src/runtime/mpagecache.go /usr/local/opt/go/libexec/src/runtime/mpallocbits.go /usr/local/opt/go/libexec/src/runtime/mprof.go /usr/local/opt/go/libexec/src/runtime/mranges.go /usr/local/opt/go/libexec/src/runtime/msan0.go /usr/local/opt/go/libexec/src/runtime/msize.go /usr/local/opt/go/libexec/src/runtime/mspanset.go /usr/local/opt/go/libexec/src/runtime/mstats.go /usr/local/opt/go/libexec/src/runtime/mwbbuf.go /usr/local/opt/go/libexec/src/runtime/nbpipe_pipe2.go /usr/local/opt/go/libexec/src/runtime/netpoll.go /usr/local/opt/go/libexec/src/runtime/netpoll_epoll.go /usr/local/opt/go/libexec/src/runtime/os_linux.go /usr/local/opt/go/libexec/src/runtime/os_linux_generic.go /usr/local/opt/go/libexec/src/runtime/os_linux_noauxv.go /usr/local/opt/go/libexec/src/runtime/os_linux_x86.go /usr/local/opt/go/libexec/src/runtime/os_nonopenbsd.go /usr/local/opt/go/libexec/src/runtime/pagetrace_off.go /usr/local/opt/go/libexec/src/runtime/panic.go /usr/local/opt/go/libexec/src/runtime/plugin.go /usr/local/opt/go/libexec/src/runtime/preempt.go /usr/local/opt/go/libexec/src/runtime/preempt_nonwindows.go /usr/local/opt/go/libexec/src/runtime/print.go /usr/local/opt/go/libexec/src/runtime/proc.go /usr/local/opt/go/libexec/src/runtime/profbuf.go /usr/local/opt/go/libexec/src/runtime/proflabel.go /usr/local/opt/go/libexec/src/runtime/race0.go /usr/local/opt/go/libexec/src/runtime/rdebug.go /usr/local/opt/go/libexec/src/runtime/relax_stub.go /usr/local/opt/go/libexec/src/runtime/retry.go /usr/local/opt/go/libexec/src/runtime/runtime.go /usr/local/opt/go/libexec/src/runtime/runtime1.go /usr/local/opt/go/libexec/src/runtime/runtime2.go /usr/local/opt/go/libexec/src/runtime/runtime_boring.go /usr/local/opt/go/libexec/src/runtime/rwmutex.go /usr/local/opt/go/libexec/src/runtime/select.go /usr/local/opt/go/libexec/src/runtime/sema.go /usr/local/opt/go/libexec/src/runtime/signal_amd64.go /usr/local/opt/go/libexec/src/runtime/signal_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/signal_unix.go /usr/local/opt/go/libexec/src/runtime/sigqueue.go /usr/local/opt/go/libexec/src/runtime/sigqueue_note.go /usr/local/opt/go/libexec/src/runtime/sigtab_linux_generic.go /usr/local/opt/go/libexec/src/runtime/sizeclasses.go /usr/local/opt/go/libexec/src/runtime/slice.go /usr/local/opt/go/libexec/src/runtime/softfloat64.go /usr/local/opt/go/libexec/src/runtime/stack.go /usr/local/opt/go/libexec/src/runtime/stkframe.go /usr/local/opt/go/libexec/src/runtime/string.go /usr/local/opt/go/libexec/src/runtime/stubs.go /usr/local/opt/go/libexec/src/runtime/stubs2.go /usr/local/opt/go/libexec/src/runtime/stubs3.go /usr/local/opt/go/libexec/src/runtime/stubs_amd64.go /usr/local/opt/go/libexec/src/runtime/stubs_linux.go /usr/local/opt/go/libexec/src/runtime/symtab.go /usr/local/opt/go/libexec/src/runtime/sys_nonppc64x.go /usr/local/opt/go/libexec/src/runtime/sys_x86.go /usr/local/opt/go/libexec/src/runtime/time.go /usr/local/opt/go/libexec/src/runtime/time_nofake.go /usr/local/opt/go/libexec/src/runtime/timeasm.go /usr/local/opt/go/libexec/src/runtime/tls_stub.go /usr/local/opt/go/libexec/src/runtime/trace.go /usr/local/opt/go/libexec/src/runtime/traceback.go /usr/local/opt/go/libexec/src/runtime/type.go /usr/local/opt/go/libexec/src/runtime/typekind.go /usr/local/opt/go/libexec/src/runtime/unsafe.go /usr/local/opt/go/libexec/src/runtime/utf8.go /usr/local/opt/go/libexec/src/runtime/vdso_elf64.go /usr/local/opt/go/libexec/src/runtime/vdso_linux.go /usr/local/opt/go/libexec/src/runtime/vdso_linux_amd64.go /usr/local/opt/go/libexec/src/runtime/write_err.go
cp /usr/local/opt/go/libexec/src/runtime/asm_amd64.h $WORK/b008/asm_GOARCH.h
cd /usr/local/opt/go/libexec/src/runtime
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/asm.o ./asm.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/asm_amd64.o ./asm_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/duff_amd64.o ./duff_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/memclr_amd64.o ./memclr_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/memmove_amd64.o ./memmove_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/preempt_amd64.o ./preempt_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/rt0_linux_amd64.o ./rt0_linux_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/sys_linux_amd64.o ./sys_linux_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p runtime -trimpath "$WORK/b008=>" -I $WORK/b008/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b008/time_linux_amd64.o ./time_linux_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b008/_pkg_.a $WORK/b008/asm.o $WORK/b008/asm_amd64.o $WORK/b008/duff_amd64.o $WORK/b008/memclr_amd64.o $WORK/b008/memmove_amd64.o $WORK/b008/preempt_amd64.o $WORK/b008/rt0_linux_amd64.o $WORK/b008/sys_linux_amd64.o $WORK/b008/time_linux_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b008/_pkg_.a # internal

#
# internal/reflectlite
#

mkdir -p $WORK/b004/
cat >$WORK/b004/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/internal/reflectlite
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/reflectlite -trimpath "$WORK/b004=>" -I $WORK/b004/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b004/symabis ./asm.s
cat >$WORK/b004/importcfg << 'EOF' # internal
# import config
packagefile internal/goarch=$WORK/b005/_pkg_.a
packagefile internal/unsafeheader=$WORK/b006/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b004/_pkg_.a -trimpath "$WORK/b004=>" -p internal/reflectlite -std -buildid KfsGJztWLilgoO3eg7EM/KfsGJztWLilgoO3eg7EM -goversion go1.20.4 -symabis $WORK/b004/symabis -c=8 -nolocalimports -importcfg $WORK/b004/importcfg -pack -asmhdr $WORK/b004/go_asm.h /usr/local/opt/go/libexec/src/internal/reflectlite/swapper.go /usr/local/opt/go/libexec/src/internal/reflectlite/type.go /usr/local/opt/go/libexec/src/internal/reflectlite/value.go
cd /usr/local/opt/go/libexec/src/internal/reflectlite
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p internal/reflectlite -trimpath "$WORK/b004=>" -I $WORK/b004/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b004/asm.o ./asm.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b004/_pkg_.a $WORK/b004/asm.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b004/_pkg_.a # internal

#
# errors
#

mkdir -p $WORK/b003/
cat >$WORK/b003/importcfg << 'EOF' # internal
# import config
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b003/_pkg_.a -trimpath "$WORK/b003=>" -p errors -std -complete -buildid cu_8q3i_QHsOuVYL3_DH/cu_8q3i_QHsOuVYL3_DH -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b003/importcfg -pack /usr/local/opt/go/libexec/src/errors/errors.go /usr/local/opt/go/libexec/src/errors/join.go /usr/local/opt/go/libexec/src/errors/wrap.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b003/_pkg_.a # internal

#
# internal/itoa
#

mkdir -p $WORK/b021/
cat >$WORK/b021/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b021/_pkg_.a -trimpath "$WORK/b021=>" -p internal/itoa -std -complete -buildid KywV8ckBASs47DioyK2u/KywV8ckBASs47DioyK2u -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b021/importcfg -pack /usr/local/opt/go/libexec/src/internal/itoa/itoa.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b021/_pkg_.a # internal

#
# math/bits
#

mkdir -p $WORK/b023/
cat >$WORK/b023/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b023/_pkg_.a -trimpath "$WORK/b023=>" -p math/bits -std -complete -buildid dCrtqElNlXZukOS2aC7Q/dCrtqElNlXZukOS2aC7Q -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b023/importcfg -pack /usr/local/opt/go/libexec/src/math/bits/bits.go /usr/local/opt/go/libexec/src/math/bits/bits_errors.go /usr/local/opt/go/libexec/src/math/bits/bits_tables.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b023/_pkg_.a # internal

#
# math
#

mkdir -p $WORK/b022/
cat >$WORK/b022/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/math
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b022/symabis ./dim_amd64.s ./exp_amd64.s ./floor_amd64.s ./hypot_amd64.s ./log_amd64.s
cat >$WORK/b022/importcfg << 'EOF' # internal
# import config
packagefile internal/cpu=$WORK/b011/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b022/_pkg_.a -trimpath "$WORK/b022=>" -p math -std -buildid ikInzEmLdRs3qRYCK_Q8/ikInzEmLdRs3qRYCK_Q8 -goversion go1.20.4 -symabis $WORK/b022/symabis -c=8 -nolocalimports -importcfg $WORK/b022/importcfg -pack -asmhdr $WORK/b022/go_asm.h /usr/local/opt/go/libexec/src/math/abs.go /usr/local/opt/go/libexec/src/math/acosh.go /usr/local/opt/go/libexec/src/math/asin.go /usr/local/opt/go/libexec/src/math/asinh.go /usr/local/opt/go/libexec/src/math/atan.go /usr/local/opt/go/libexec/src/math/atan2.go /usr/local/opt/go/libexec/src/math/atanh.go /usr/local/opt/go/libexec/src/math/bits.go /usr/local/opt/go/libexec/src/math/cbrt.go /usr/local/opt/go/libexec/src/math/const.go /usr/local/opt/go/libexec/src/math/copysign.go /usr/local/opt/go/libexec/src/math/dim.go /usr/local/opt/go/libexec/src/math/dim_asm.go /usr/local/opt/go/libexec/src/math/erf.go /usr/local/opt/go/libexec/src/math/erfinv.go /usr/local/opt/go/libexec/src/math/exp.go /usr/local/opt/go/libexec/src/math/exp2_noasm.go /usr/local/opt/go/libexec/src/math/exp_amd64.go /usr/local/opt/go/libexec/src/math/exp_asm.go /usr/local/opt/go/libexec/src/math/expm1.go /usr/local/opt/go/libexec/src/math/floor.go /usr/local/opt/go/libexec/src/math/floor_asm.go /usr/local/opt/go/libexec/src/math/fma.go /usr/local/opt/go/libexec/src/math/frexp.go /usr/local/opt/go/libexec/src/math/gamma.go /usr/local/opt/go/libexec/src/math/hypot.go /usr/local/opt/go/libexec/src/math/hypot_asm.go /usr/local/opt/go/libexec/src/math/j0.go /usr/local/opt/go/libexec/src/math/j1.go /usr/local/opt/go/libexec/src/math/jn.go /usr/local/opt/go/libexec/src/math/ldexp.go /usr/local/opt/go/libexec/src/math/lgamma.go /usr/local/opt/go/libexec/src/math/log.go /usr/local/opt/go/libexec/src/math/log10.go /usr/local/opt/go/libexec/src/math/log1p.go /usr/local/opt/go/libexec/src/math/log_asm.go /usr/local/opt/go/libexec/src/math/logb.go /usr/local/opt/go/libexec/src/math/mod.go /usr/local/opt/go/libexec/src/math/modf.go /usr/local/opt/go/libexec/src/math/modf_noasm.go /usr/local/opt/go/libexec/src/math/nextafter.go /usr/local/opt/go/libexec/src/math/pow.go /usr/local/opt/go/libexec/src/math/pow10.go /usr/local/opt/go/libexec/src/math/remainder.go /usr/local/opt/go/libexec/src/math/signbit.go /usr/local/opt/go/libexec/src/math/sin.go /usr/local/opt/go/libexec/src/math/sincos.go /usr/local/opt/go/libexec/src/math/sinh.go /usr/local/opt/go/libexec/src/math/sqrt.go /usr/local/opt/go/libexec/src/math/stubs.go /usr/local/opt/go/libexec/src/math/tan.go /usr/local/opt/go/libexec/src/math/tanh.go /usr/local/opt/go/libexec/src/math/trig_reduce.go /usr/local/opt/go/libexec/src/math/unsafe.go
cd /usr/local/opt/go/libexec/src/math
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/dim_amd64.o ./dim_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/exp_amd64.o ./exp_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/floor_amd64.o ./floor_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/hypot_amd64.o ./hypot_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p math -trimpath "$WORK/b022=>" -I $WORK/b022/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b022/log_amd64.o ./log_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b022/_pkg_.a $WORK/b022/dim_amd64.o $WORK/b022/exp_amd64.o $WORK/b022/floor_amd64.o $WORK/b022/hypot_amd64.o $WORK/b022/log_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b022/_pkg_.a # internal

#
# unicode/utf8
#

mkdir -p $WORK/b025/
cat >$WORK/b025/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b025/_pkg_.a -trimpath "$WORK/b025=>" -p unicode/utf8 -std -complete -buildid cSCUZ94vs3WynnuPq7bO/cSCUZ94vs3WynnuPq7bO -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b025/importcfg -pack /usr/local/opt/go/libexec/src/unicode/utf8/utf8.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b025/_pkg_.a # internal

#
# strconv
#

mkdir -p $WORK/b024/
cat >$WORK/b024/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile math=$WORK/b022/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b024/_pkg_.a -trimpath "$WORK/b024=>" -p strconv -std -complete -buildid Yoy6wL1F6mCh5-SMMuIS/Yoy6wL1F6mCh5-SMMuIS -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b024/importcfg -pack /usr/local/opt/go/libexec/src/strconv/atob.go /usr/local/opt/go/libexec/src/strconv/atoc.go /usr/local/opt/go/libexec/src/strconv/atof.go /usr/local/opt/go/libexec/src/strconv/atoi.go /usr/local/opt/go/libexec/src/strconv/bytealg.go /usr/local/opt/go/libexec/src/strconv/ctoa.go /usr/local/opt/go/libexec/src/strconv/decimal.go /usr/local/opt/go/libexec/src/strconv/doc.go /usr/local/opt/go/libexec/src/strconv/eisel_lemire.go /usr/local/opt/go/libexec/src/strconv/ftoa.go /usr/local/opt/go/libexec/src/strconv/ftoaryu.go /usr/local/opt/go/libexec/src/strconv/isprint.go /usr/local/opt/go/libexec/src/strconv/itoa.go /usr/local/opt/go/libexec/src/strconv/quote.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b024/_pkg_.a # internal

#
# internal/race
#

mkdir -p $WORK/b027/
cat >$WORK/b027/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b027/_pkg_.a -trimpath "$WORK/b027=>" -p internal/race -std -complete -buildid 6k_7JN4Ro6ano3CJO236/6k_7JN4Ro6ano3CJO236 -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b027/importcfg -pack /usr/local/opt/go/libexec/src/internal/race/doc.go /usr/local/opt/go/libexec/src/internal/race/norace.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b027/_pkg_.a # internal

#
# sync/atomic
#

mkdir -p $WORK/b028/
cat >$WORK/b028/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/sync/atomic
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p sync/atomic -trimpath "$WORK/b028=>" -I $WORK/b028/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -gensymabis -o $WORK/b028/symabis ./asm.s
cat >$WORK/b028/importcfg << 'EOF' # internal
# import config
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b028/_pkg_.a -trimpath "$WORK/b028=>" -p sync/atomic -std -buildid 8sTHEv3qeP6epKjkp86J/8sTHEv3qeP6epKjkp86J -goversion go1.20.4 -symabis $WORK/b028/symabis -c=8 -nolocalimports -importcfg $WORK/b028/importcfg -pack -asmhdr $WORK/b028/go_asm.h /usr/local/opt/go/libexec/src/sync/atomic/doc.go /usr/local/opt/go/libexec/src/sync/atomic/type.go /usr/local/opt/go/libexec/src/sync/atomic/value.go
cd /usr/local/opt/go/libexec/src/sync/atomic
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p sync/atomic -trimpath "$WORK/b028=>" -I $WORK/b028/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -D GOAMD64_v1 -o $WORK/b028/asm.o ./asm.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b028/_pkg_.a $WORK/b028/asm.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b028/_pkg_.a # internal

#
# sync
#

mkdir -p $WORK/b026/
cat >$WORK/b026/importcfg << 'EOF' # internal
# import config
packagefile internal/race=$WORK/b027/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b026/_pkg_.a -trimpath "$WORK/b026=>" -p sync -std -buildid Y0J_IMOLnZbLCzeWsKOw/Y0J_IMOLnZbLCzeWsKOw -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b026/importcfg -pack /usr/local/opt/go/libexec/src/sync/cond.go /usr/local/opt/go/libexec/src/sync/map.go /usr/local/opt/go/libexec/src/sync/mutex.go /usr/local/opt/go/libexec/src/sync/once.go /usr/local/opt/go/libexec/src/sync/pool.go /usr/local/opt/go/libexec/src/sync/poolqueue.go /usr/local/opt/go/libexec/src/sync/runtime.go /usr/local/opt/go/libexec/src/sync/runtime2.go /usr/local/opt/go/libexec/src/sync/rwmutex.go /usr/local/opt/go/libexec/src/sync/waitgroup.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b026/_pkg_.a # internal

#
# unicode
#

mkdir -p $WORK/b029/
cat >$WORK/b029/importcfg << 'EOF' # internal
# import config
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b029/_pkg_.a -trimpath "$WORK/b029=>" -p unicode -std -complete -buildid H5EVtAclvmQgmtO5OIl1/H5EVtAclvmQgmtO5OIl1 -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b029/importcfg -pack /usr/local/opt/go/libexec/src/unicode/casetables.go /usr/local/opt/go/libexec/src/unicode/digit.go /usr/local/opt/go/libexec/src/unicode/graphic.go /usr/local/opt/go/libexec/src/unicode/letter.go /usr/local/opt/go/libexec/src/unicode/tables.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b029/_pkg_.a # internal

#
# reflect
#

mkdir -p $WORK/b020/
cat >$WORK/b020/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/reflect
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p reflect -trimpath "$WORK/b020=>" -I $WORK/b020/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b020/symabis ./asm_amd64.s
cat >$WORK/b020/importcfg << 'EOF' # internal
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
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b020/_pkg_.a -trimpath "$WORK/b020=>" -p reflect -std -buildid gH_GnSLWf0EzzQr7xV81/gH_GnSLWf0EzzQr7xV81 -goversion go1.20.4 -symabis $WORK/b020/symabis -c=8 -nolocalimports -importcfg $WORK/b020/importcfg -pack -asmhdr $WORK/b020/go_asm.h /usr/local/opt/go/libexec/src/reflect/abi.go /usr/local/opt/go/libexec/src/reflect/deepequal.go /usr/local/opt/go/libexec/src/reflect/float32reg_generic.go /usr/local/opt/go/libexec/src/reflect/makefunc.go /usr/local/opt/go/libexec/src/reflect/swapper.go /usr/local/opt/go/libexec/src/reflect/type.go /usr/local/opt/go/libexec/src/reflect/value.go /usr/local/opt/go/libexec/src/reflect/visiblefields.go
cd /usr/local/opt/go/libexec/src/reflect
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p reflect -trimpath "$WORK/b020=>" -I $WORK/b020/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b020/asm_amd64.o ./asm_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b020/_pkg_.a $WORK/b020/asm_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b020/_pkg_.a # internal

#
# sort
#

mkdir -p $WORK/b030/
cat >$WORK/b030/importcfg << 'EOF' # internal
# import config
packagefile internal/reflectlite=$WORK/b004/_pkg_.a
packagefile math/bits=$WORK/b023/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b030/_pkg_.a -trimpath "$WORK/b030=>" -p sort -std -complete -buildid qN5hkdrmtfBCjWvojbFJ/qN5hkdrmtfBCjWvojbFJ -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b030/importcfg -pack /usr/local/opt/go/libexec/src/sort/search.go /usr/local/opt/go/libexec/src/sort/slice.go /usr/local/opt/go/libexec/src/sort/sort.go /usr/local/opt/go/libexec/src/sort/zsortfunc.go /usr/local/opt/go/libexec/src/sort/zsortinterface.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b030/_pkg_.a # internal

#
# internal/fmtsort
#

mkdir -p $WORK/b019/
cat >$WORK/b019/importcfg << 'EOF' # internal
# import config
packagefile reflect=$WORK/b020/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b019/_pkg_.a -trimpath "$WORK/b019=>" -p internal/fmtsort -std -complete -buildid vUtoyqL52IzeFrVYpDG3/vUtoyqL52IzeFrVYpDG3 -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b019/importcfg -pack /usr/local/opt/go/libexec/src/internal/fmtsort/sort.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b019/_pkg_.a # internal

#
# io
#

mkdir -p $WORK/b031/
cat >$WORK/b031/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b031/_pkg_.a -trimpath "$WORK/b031=>" -p io -std -complete -buildid bdFyN98ZYLc_oGEcLPKy/bdFyN98ZYLc_oGEcLPKy -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b031/importcfg -pack /usr/local/opt/go/libexec/src/io/io.go /usr/local/opt/go/libexec/src/io/multi.go /usr/local/opt/go/libexec/src/io/pipe.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b031/_pkg_.a # internal

#
# internal/oserror
#

mkdir -p $WORK/b036/
cat >$WORK/b036/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b036/_pkg_.a -trimpath "$WORK/b036=>" -p internal/oserror -std -complete -buildid TVaYy98S-iWtDAsrdCKH/TVaYy98S-iWtDAsrdCKH -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b036/importcfg -pack /usr/local/opt/go/libexec/src/internal/oserror/errors.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b036/_pkg_.a # internal

#
# syscall
#

mkdir -p $WORK/b035/
cat >$WORK/b035/go_asm.h << 'EOF' # internal
EOF
cd /usr/local/opt/go/libexec/src/syscall
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p syscall -trimpath "$WORK/b035=>" -I $WORK/b035/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -gensymabis -o $WORK/b035/symabis ./asm_linux_amd64.s
cat >$WORK/b035/importcfg << 'EOF' # internal
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
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b035/_pkg_.a -trimpath "$WORK/b035=>" -p syscall -std -buildid aaWYhrxYbX8SAb0x3gXp/aaWYhrxYbX8SAb0x3gXp -goversion go1.20.4 -symabis $WORK/b035/symabis -c=8 -nolocalimports -importcfg $WORK/b035/importcfg -pack -asmhdr $WORK/b035/go_asm.h /usr/local/opt/go/libexec/src/syscall/asan0.go /usr/local/opt/go/libexec/src/syscall/dirent.go /usr/local/opt/go/libexec/src/syscall/endian_little.go /usr/local/opt/go/libexec/src/syscall/env_unix.go /usr/local/opt/go/libexec/src/syscall/exec_linux.go /usr/local/opt/go/libexec/src/syscall/exec_unix.go /usr/local/opt/go/libexec/src/syscall/flock.go /usr/local/opt/go/libexec/src/syscall/lsf_linux.go /usr/local/opt/go/libexec/src/syscall/msan0.go /usr/local/opt/go/libexec/src/syscall/net.go /usr/local/opt/go/libexec/src/syscall/netlink_linux.go /usr/local/opt/go/libexec/src/syscall/rlimit.go /usr/local/opt/go/libexec/src/syscall/rlimit_stub.go /usr/local/opt/go/libexec/src/syscall/setuidgid_linux.go /usr/local/opt/go/libexec/src/syscall/sockcmsg_linux.go /usr/local/opt/go/libexec/src/syscall/sockcmsg_unix.go /usr/local/opt/go/libexec/src/syscall/sockcmsg_unix_other.go /usr/local/opt/go/libexec/src/syscall/syscall.go /usr/local/opt/go/libexec/src/syscall/syscall_linux.go /usr/local/opt/go/libexec/src/syscall/syscall_linux_accept4.go /usr/local/opt/go/libexec/src/syscall/syscall_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/syscall_unix.go /usr/local/opt/go/libexec/src/syscall/time_nofake.go /usr/local/opt/go/libexec/src/syscall/timestruct.go /usr/local/opt/go/libexec/src/syscall/zerrors_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/zsyscall_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/zsysnum_linux_amd64.go /usr/local/opt/go/libexec/src/syscall/ztypes_linux_amd64.go
cd /usr/local/opt/go/libexec/src/syscall
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p syscall -trimpath "$WORK/b035=>" -I $WORK/b035/ -I /usr/local/opt/go/libexec/pkg/include -D GOOS_linux -D GOARCH_amd64 -compiling-runtime -D GOAMD64_v1 -o $WORK/b035/asm_linux_amd64.o ./asm_linux_amd64.s
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/pack r $WORK/b035/_pkg_.a $WORK/b035/asm_linux_amd64.o # internal
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b035/_pkg_.a # internal

#
# internal/syscall/unix
#

mkdir -p $WORK/b034/
cat >$WORK/b034/importcfg << 'EOF' # internal
# import config
packagefile sync/atomic=$WORK/b028/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
EOF
cd /Users/DQNEO/src/github.com/DQNEO/go-samples/birudo
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b034/_pkg_.a -trimpath "$WORK/b034=>" -p internal/syscall/unix -std -complete -buildid I564YXTI0sWfubirayPG/I564YXTI0sWfubirayPG -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b034/importcfg -pack /usr/local/opt/go/libexec/src/internal/syscall/unix/at.go /usr/local/opt/go/libexec/src/internal/syscall/unix/at_fstatat.go /usr/local/opt/go/libexec/src/internal/syscall/unix/at_sysnum_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/at_sysnum_newfstatat_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/constants.go /usr/local/opt/go/libexec/src/internal/syscall/unix/copy_file_range_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/eaccess_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/getrandom.go /usr/local/opt/go/libexec/src/internal/syscall/unix/getrandom_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/kernel_version_linux.go /usr/local/opt/go/libexec/src/internal/syscall/unix/net.go /usr/local/opt/go/libexec/src/internal/syscall/unix/nonblocking.go /usr/local/opt/go/libexec/src/internal/syscall/unix/sysnum_linux_amd64.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b034/_pkg_.a # internal

#
# time
#

mkdir -p $WORK/b037/
cat >$WORK/b037/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
packagefile sync=$WORK/b026/_pkg_.a
packagefile syscall=$WORK/b035/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b037/_pkg_.a -trimpath "$WORK/b037=>" -p time -std -buildid D-otu1EJURKY0cpbPQO9/D-otu1EJURKY0cpbPQO9 -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b037/importcfg -pack /usr/local/opt/go/libexec/src/time/format.go /usr/local/opt/go/libexec/src/time/format_rfc3339.go /usr/local/opt/go/libexec/src/time/sleep.go /usr/local/opt/go/libexec/src/time/sys_unix.go /usr/local/opt/go/libexec/src/time/tick.go /usr/local/opt/go/libexec/src/time/time.go /usr/local/opt/go/libexec/src/time/zoneinfo.go /usr/local/opt/go/libexec/src/time/zoneinfo_goroot.go /usr/local/opt/go/libexec/src/time/zoneinfo_read.go /usr/local/opt/go/libexec/src/time/zoneinfo_unix.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b037/_pkg_.a # internal

#
# internal/poll
#

mkdir -p $WORK/b033/
cat >$WORK/b033/importcfg << 'EOF' # internal
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
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b033/_pkg_.a -trimpath "$WORK/b033=>" -p internal/poll -std -buildid y8jVOnbcHPYq9O7-F5uG/y8jVOnbcHPYq9O7-F5uG -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b033/importcfg -pack /usr/local/opt/go/libexec/src/internal/poll/copy_file_range_linux.go /usr/local/opt/go/libexec/src/internal/poll/errno_unix.go /usr/local/opt/go/libexec/src/internal/poll/fcntl_syscall.go /usr/local/opt/go/libexec/src/internal/poll/fd.go /usr/local/opt/go/libexec/src/internal/poll/fd_fsync_posix.go /usr/local/opt/go/libexec/src/internal/poll/fd_mutex.go /usr/local/opt/go/libexec/src/internal/poll/fd_poll_runtime.go /usr/local/opt/go/libexec/src/internal/poll/fd_posix.go /usr/local/opt/go/libexec/src/internal/poll/fd_unix.go /usr/local/opt/go/libexec/src/internal/poll/fd_writev_unix.go /usr/local/opt/go/libexec/src/internal/poll/hook_cloexec.go /usr/local/opt/go/libexec/src/internal/poll/hook_unix.go /usr/local/opt/go/libexec/src/internal/poll/iovec_unix.go /usr/local/opt/go/libexec/src/internal/poll/sendfile_linux.go /usr/local/opt/go/libexec/src/internal/poll/sock_cloexec.go /usr/local/opt/go/libexec/src/internal/poll/sockopt.go /usr/local/opt/go/libexec/src/internal/poll/sockopt_linux.go /usr/local/opt/go/libexec/src/internal/poll/sockopt_unix.go /usr/local/opt/go/libexec/src/internal/poll/sockoptip.go /usr/local/opt/go/libexec/src/internal/poll/splice_linux.go /usr/local/opt/go/libexec/src/internal/poll/writev.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b033/_pkg_.a # internal

#
# internal/safefilepath
#

mkdir -p $WORK/b038/
cat >$WORK/b038/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b038/_pkg_.a -trimpath "$WORK/b038=>" -p internal/safefilepath -std -complete -buildid lHJyhf62IOE5KCYohFFs/lHJyhf62IOE5KCYohFFs -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b038/importcfg -pack /usr/local/opt/go/libexec/src/internal/safefilepath/path.go /usr/local/opt/go/libexec/src/internal/safefilepath/path_other.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b038/_pkg_.a # internal

#
# internal/syscall/execenv
#

mkdir -p $WORK/b039/
cat >$WORK/b039/importcfg << 'EOF' # internal
# import config
packagefile syscall=$WORK/b035/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b039/_pkg_.a -trimpath "$WORK/b039=>" -p internal/syscall/execenv -std -complete -buildid 8CPZtMR9a2SybW02MYIY/8CPZtMR9a2SybW02MYIY -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b039/importcfg -pack /usr/local/opt/go/libexec/src/internal/syscall/execenv/execenv_default.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b039/_pkg_.a # internal

#
# internal/testlog
#

mkdir -p $WORK/b040/
cat >$WORK/b040/importcfg << 'EOF' # internal
# import config
packagefile sync=$WORK/b026/_pkg_.a
packagefile sync/atomic=$WORK/b028/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b040/_pkg_.a -trimpath "$WORK/b040=>" -p internal/testlog -std -complete -buildid mwMqMwIdsz1Uq604JUjq/mwMqMwIdsz1Uq604JUjq -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b040/importcfg -pack /usr/local/opt/go/libexec/src/internal/testlog/exit.go /usr/local/opt/go/libexec/src/internal/testlog/log.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b040/_pkg_.a # internal

#
# path
#

mkdir -p $WORK/b042/
cat >$WORK/b042/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/bytealg=$WORK/b010/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b042/_pkg_.a -trimpath "$WORK/b042=>" -p path -std -complete -buildid D40aYRp6e9CQin1VqReb/D40aYRp6e9CQin1VqReb -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b042/importcfg -pack /usr/local/opt/go/libexec/src/path/match.go /usr/local/opt/go/libexec/src/path/path.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b042/_pkg_.a # internal

#
# io/fs
#

mkdir -p $WORK/b041/
cat >$WORK/b041/importcfg << 'EOF' # internal
# import config
packagefile errors=$WORK/b003/_pkg_.a
packagefile internal/oserror=$WORK/b036/_pkg_.a
packagefile io=$WORK/b031/_pkg_.a
packagefile path=$WORK/b042/_pkg_.a
packagefile sort=$WORK/b030/_pkg_.a
packagefile time=$WORK/b037/_pkg_.a
packagefile unicode/utf8=$WORK/b025/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b041/_pkg_.a -trimpath "$WORK/b041=>" -p io/fs -std -complete -buildid 8miTbnqAaKZ9Jo1Ojk-z/8miTbnqAaKZ9Jo1Ojk-z -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b041/importcfg -pack /usr/local/opt/go/libexec/src/io/fs/fs.go /usr/local/opt/go/libexec/src/io/fs/glob.go /usr/local/opt/go/libexec/src/io/fs/readdir.go /usr/local/opt/go/libexec/src/io/fs/readfile.go /usr/local/opt/go/libexec/src/io/fs/stat.go /usr/local/opt/go/libexec/src/io/fs/sub.go /usr/local/opt/go/libexec/src/io/fs/walk.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b041/_pkg_.a # internal

#
# os
#

mkdir -p $WORK/b032/
cat >$WORK/b032/importcfg << 'EOF' # internal
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
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b032/_pkg_.a -trimpath "$WORK/b032=>" -p os -std -buildid 4_Uar1zW0lVi8T8eHPcK/4_Uar1zW0lVi8T8eHPcK -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b032/importcfg -pack /usr/local/opt/go/libexec/src/os/dir.go /usr/local/opt/go/libexec/src/os/dir_unix.go /usr/local/opt/go/libexec/src/os/dirent_linux.go /usr/local/opt/go/libexec/src/os/endian_little.go /usr/local/opt/go/libexec/src/os/env.go /usr/local/opt/go/libexec/src/os/error.go /usr/local/opt/go/libexec/src/os/error_errno.go /usr/local/opt/go/libexec/src/os/error_posix.go /usr/local/opt/go/libexec/src/os/exec.go /usr/local/opt/go/libexec/src/os/exec_posix.go /usr/local/opt/go/libexec/src/os/exec_unix.go /usr/local/opt/go/libexec/src/os/executable.go /usr/local/opt/go/libexec/src/os/executable_procfs.go /usr/local/opt/go/libexec/src/os/file.go /usr/local/opt/go/libexec/src/os/file_posix.go /usr/local/opt/go/libexec/src/os/file_unix.go /usr/local/opt/go/libexec/src/os/getwd.go /usr/local/opt/go/libexec/src/os/path.go /usr/local/opt/go/libexec/src/os/path_unix.go /usr/local/opt/go/libexec/src/os/pipe2_unix.go /usr/local/opt/go/libexec/src/os/proc.go /usr/local/opt/go/libexec/src/os/rawconn.go /usr/local/opt/go/libexec/src/os/readfrom_linux.go /usr/local/opt/go/libexec/src/os/removeall_at.go /usr/local/opt/go/libexec/src/os/stat.go /usr/local/opt/go/libexec/src/os/stat_linux.go /usr/local/opt/go/libexec/src/os/stat_unix.go /usr/local/opt/go/libexec/src/os/sticky_notbsd.go /usr/local/opt/go/libexec/src/os/str.go /usr/local/opt/go/libexec/src/os/sys.go /usr/local/opt/go/libexec/src/os/sys_linux.go /usr/local/opt/go/libexec/src/os/sys_unix.go /usr/local/opt/go/libexec/src/os/tempfile.go /usr/local/opt/go/libexec/src/os/types.go /usr/local/opt/go/libexec/src/os/types_unix.go /usr/local/opt/go/libexec/src/os/wait_waitid.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b032/_pkg_.a # internal

#
# fmt
#

mkdir -p $WORK/b002/
cat >$WORK/b002/importcfg << 'EOF' # internal
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
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b002/_pkg_.a -trimpath "$WORK/b002=>" -p fmt -std -complete -buildid xR2SWK3XgrBGWwcH8Eyr/xR2SWK3XgrBGWwcH8Eyr -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b002/importcfg -pack /usr/local/opt/go/libexec/src/fmt/doc.go /usr/local/opt/go/libexec/src/fmt/errors.go /usr/local/opt/go/libexec/src/fmt/format.go /usr/local/opt/go/libexec/src/fmt/print.go /usr/local/opt/go/libexec/src/fmt/scan.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b002/_pkg_.a # internal

#
# github.com/DQNEO/go-samples/birudo
#

mkdir -p $WORK/b001/
cat >$WORK/b001/importcfg << 'EOF' # internal
# import config
packagefile fmt=$WORK/b002/_pkg_.a
packagefile runtime=$WORK/b008/_pkg_.a
EOF
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/compile -o $WORK/b001/_pkg_.a -trimpath "$WORK/b001=>" -p main -lang=go1.20 -complete -buildid Hn3PYV9gjlHeOz64viNt/Hn3PYV9gjlHeOz64viNt -goversion go1.20.4 -c=8 -nolocalimports -importcfg $WORK/b001/importcfg -pack ./main.go ./sum.go
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b001/_pkg_.a # internal
cat >$WORK/b001/importcfg.link << 'EOF' # internal
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
modinfo "0w\xaf\f\x92t\b\x02A\xe1\xc1\a\xe6\xd6\x18\xe6path\tgithub.com/DQNEO/go-samples/birudo\nmod\tgithub.com/DQNEO/go-samples/birudo\t(devel)\t\nbuild\t-buildmode=exe\nbuild\t-compiler=gc\nbuild\tCGO_ENABLED=0\nbuild\tGOARCH=amd64\nbuild\tGOOS=linux\nbuild\tGOAMD64=v1\nbuild\tvcs=git\nbuild\tvcs.revision=abfa41c45dd70eb75f20ecb0706d1c120fabe0d5\nbuild\tvcs.time=2023-06-09T00:26:48Z\nbuild\tvcs.modified=true\n\xf92C1\x86\x18 r\x00\x82B\x10A\x16\xd8\xf2"
EOF
mkdir -p $WORK/b001/exe/
cd .
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/link -o $WORK/b001/exe/a.out -importcfg $WORK/b001/importcfg.link -buildmode=exe -buildid=69gywrFyw4VWB6LHQJVX/Hn3PYV9gjlHeOz64viNt/Hn3PYV9gjlHeOz64viNt/69gywrFyw4VWB6LHQJVX -extld=cc $WORK/b001/_pkg_.a
/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/buildid -w $WORK/b001/exe/a.out # internal
mv $WORK/b001/exe/a.out birudo1
