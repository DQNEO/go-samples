#include "textflag.h"

// Stack layout
// -- top --
// [0]  caller's return address [+8]
// [8]  a int64   [+8]
// [16] b int64   [+8]
// [24] r int64   [+8=32]
// size = 32 - 8 = 24
TEXT	 main·sum64(SB), NOSPLIT,$0-24
	MOVQ	$0, r+24(SP)
	MOVQ	a+8(SP), AX
	ADDQ	b+16(SP), AX
	MOVQ	AX, r+24(SP)
    RET

// Stack layout
// -- top --
// [0]  caller's return address [+8]
// [8]  a int32   [+4]
// [12] b int32   [+4]
// [16] r int32   [+4]
// [20] space     [+4=24]
// size = 24 - 8 = 16
TEXT	 main·sum32(SB), NOSPLIT,$0-16
	MOVL	$0, r+16(SP)
	MOVL	a+8(SP), AX
	ADDL	b+12(SP), AX
	MOVL	AX, r+16(SP)
    RET

// Stack layout
// -- top --
// [0]  caller's return address [+8]
// [8]  a int16   [+2]
// [10] b int16   [+2]
// [12] space     [+4]
// [16] r int16   [+2]
// [18] space     [+6=24]
// size = 24 - 8 = 16
TEXT	 main·sum16(SB), NOSPLIT,$0-16
	MOVW	$0, r+16(SP)
	MOVW	a+8(SP), AX
	ADDW	b+10(SP), AX
	MOVW	AX, r+16(SP)
    RET

// Stack layout
// -- top --
// [0]  caller's return address [+8]
// [8]  a int16   [+1]
// [9]  b int16   [+1]
// [10] space     [+6]
// [16] r int16   [+1]
// [17] space     [+7=24]
// size = 24 - 8 = 16
TEXT	 main·sum8(SB), NOSPLIT,$0-16
	MOVB	$0, r+16(SP)
	MOVB	a+8(SP), AX
	ADDB	b+9(SP), AX
	MOVB	AX, r+16(SP)
    RET
