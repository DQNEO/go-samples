#include "textflag.h"

// Stack layout
// -- top --
// [0]  caller's return address [+8]
// [8] r int64   [+8]
// size = 8
TEXT	 main·myfunc(SB), NOSPLIT,$0-8
	MOVQ	$7, r+8(SP)
	NOP
	RET
