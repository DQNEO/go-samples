#include "textflag.h"

TEXT	 ·sum(SB), NOSPLIT,$0-24
	MOVQ	$0, r2+24(SP)
	MOVQ	x+8(SP), AX
	ADDQ	y+16(SP), AX
	MOVQ	AX, r2+24(SP)
    RET
