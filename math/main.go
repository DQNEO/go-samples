package main

import (
	"fmt"
)

func main() {
	for i := 0.0; i <= 2.01; i += 0.01 {
		f := sin(Pi * i)
		fmt.Printf("%02f\t%03f\n", i, f)
	}
}

const (
	Pi   = 3.14159265358979323846264338327950288419716939937510582097494459
	PI4A = 7.85398125648498535156e-1  // 0x3fe921fb40000000, Pi/4 split into three parts
	PI4B = 3.77489470793079817668e-8  // 0x3e64442d00000000,
	PI4C = 2.69515142907905952645e-15 // 0x3ce8469898cc5170,
)

func sin(x float64) float64 {
	if x == 0 {
		return 0 // return ±0 || NaN()
	}

	// make argument positive but save the sign
	negative := false
	var j0, j1, j2 uint64
	j := uint64(x * (4 / Pi)) // integer part of x/(Pi/4), as integer for tests on the phase angle
	j0 = j
	y := float64(j) // integer part of x/(Pi/4), as float
	var ret float64
	// map zeros to origin
	if j&1 == 1 { // isOdd
		j++
		y++
	}
	j &= 7                      // j = j & 0b00000...111    => {0,2,4,6}                           // octant modulo 2Pi radians (360 degrees)
	z := x - y*(PI4A+PI4B+PI4C) // Extended precision modular arithmetic
	j1 = j
	// reflect in x axis
	if j >= 4 { // j == 4 or j == 6
		negative = true
		j -= 4 // j == 0 or j == 2
	}
	j2 = j
	zz := z * z
	if j == 2 { // j == 0 or 2
		ret = 1.0 - 0.5*zz + zz*zz*((((((_cos[0]*zz)+_cos[1])*zz+_cos[2])*zz+_cos[3])*zz+_cos[4])*zz+_cos[5])
	} else {
		ret = z + z*zz*((((((_sin[0]*zz)+_sin[1])*zz+_sin[2])*zz+_sin[3])*zz+_sin[4])*zz+_sin[5])
	}
	if negative {
		ret = -ret
	}
	//fmt.Fprintf(os.Stderr, "x, j0, j1, j2, ret = %3f, %d, %d, %d, %3f\n", x, j0, j1, j2, ret)
	_, _, _ = j0, j1, j2
	return ret
}

// sin coefficients
var _sin = [...]float64{
	1.58962301576546568060e-10, // 0x3de5d8fd1fd19ccd
	-2.50507477628578072866e-8, // 0xbe5ae5e5a9291f5d
	2.75573136213857245213e-6,  // 0x3ec71de3567d48a1
	-1.98412698295895385996e-4, // 0xbf2a01a019bfdf03
	8.33333333332211858878e-3,  // 0x3f8111111110f7d0
	-1.66666666666666307295e-1, // 0xbfc5555555555548
}

// cos coefficients
var _cos = [...]float64{
	-1.13585365213876817300e-11, // 0xbda8fa49a0861a9b
	2.08757008419747316778e-9,   // 0x3e21ee9d7b4e3f05
	-2.75573141792967388112e-7,  // 0xbe927e4f7eac4bc6
	2.48015872888517045348e-5,   // 0x3efa01a019c844f5
	-1.38888888888730564116e-3,  // 0xbf56c16c16c14f91
	4.16666666666665929218e-2,   // 0x3fa555555555554b
}
