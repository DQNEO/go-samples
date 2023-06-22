#include "textflag.h"

TEXT	 main·sum(SB), NOSPLIT,$0-24
	MOVQ	$0, r+24(SP)
	MOVQ	foo+8(SP), AX
	ADDQ	bar+16(SP), AX
	MOVQ	AX, r+24(SP)
    RET

TEXT	 main·sub(SB), NOSPLIT,$0-24
	MOVQ	$0, r+24(SP)
	MOVQ	foo+8(SP), AX
	SUBQ	bar+16(SP), AX
	MOVQ	AX, r+24(SP)
    RET
