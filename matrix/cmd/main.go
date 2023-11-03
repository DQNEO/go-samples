package main

import (
	"fmt"

	"github.com/DQNEO/go-samples/matrix"
)

func main() {
	doRowReductionManually1()
	fmt.Println("-----")
	doRowReductionManually2()
	return
	return
	test()
	doEnshu2()
}

func test() {
	a := matrix.NewMatrix(3, 2, []float64{
		1, 2,
		3, 4,
		5, 6,
	})
	fmt.Printf("a = \n%s", a)
	fmt.Printf("type of a = %s\n", a.Type())
	fmt.Printf("a[1][2] = %f\n", a.GetElm(1, 2))

	b := matrix.NewMatrixFromSlices(3, 2, [][]float64{{1, 1, 2}, {2, 3, 3}})
	fmt.Printf("b = \n%s", b)
	fmt.Printf("type of b = %s\n", b.Type())
	fmt.Printf("b[1][2] = %f\n", b.GetElm(1, 2))

	fmt.Printf("a + b = \n%s", matrix.Add(a, b))

	c := matrix.NewMatrixFromSlices(2, 3, [][]float64{{1, 4}, {2, 5}, {3, 6}})
	fmt.Printf("c = \n%s", c)
	fmt.Printf("type of c = %s\n", c.Type())
	fmt.Printf("c[2][3] = %f\n", c.GetElm(2, 3))

	d := matrix.Mul(a, c) // d = a * c
	fmt.Printf("a x c = \n%s", d)

	e := matrix.Mul(c, a) // e = c * a
	fmt.Printf("c x a = \n%s", e)
	if e.GetElm(2, 1) != 49 {
		panic("ERROR")
	}

	fmt.Printf("2 x a = \n%s", matrix.Scale(2, a))
}
func doEnshu2() {
	fmt.Println("=== Enshu 2.1")
	fmt.Println("-- (1)")
	a := matrix.NewMatrixFromSlices(1, 2, [][]float64{{1}, {2}})
	b := matrix.NewMatrixFromSlices(2, 1, [][]float64{{3, 4}})
	c := matrix.Mul(a, b)
	fmt.Printf("a x b = \n%s", c)

	fmt.Println("-- (2)")
	a = matrix.NewMatrixFromSlices(2, 1, [][]float64{{3, 4}})
	b = matrix.NewMatrixFromSlices(1, 2, [][]float64{{1}, {2}})
	c = matrix.Mul(a, b)
	fmt.Printf("a x b = \n%s", c)
}

func _doRowReduction(m *matrix.Matrix) *matrix.Matrix {
	a := m.Clone()
	for pivotPosition := 1; pivotPosition <= a.R; pivotPosition++ {
		// make pivot value 1
		divisor := a.GetElm(pivotPosition, pivotPosition)
		if divisor == 0 {
			break
		}
		a = a.ApplyRowBasicTransformDiv(pivotPosition, divisor)
		//fmt.Printf("a = \n%s", a)

		// fill zero below the pivot
		for i := pivotPosition + 1; i <= a.R; i++ {
			rowHead := a.GetElm(i, pivotPosition)
			a = a.ApplyRowBasicTransformAdd(pivotPosition, -1*rowHead, i)
			//fmt.Printf("a = \n%s", a)
		}
	}
	// Now left bottom elements are all zero.

	// Making zero from right bottom
	for srcI := a.R; srcI >= 1; srcI-- {
		for trgtI := srcI - 1; trgtI >= 1; trgtI-- {
			scalar := -1 * a.GetElm(trgtI, srcI)
			a = a.ApplyRowBasicTransformAdd(srcI, scalar, trgtI)
			//fmt.Printf("a = \n%s", a)
		}
	}
	return a
}
func doRowReductionManually1() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, 3, 2,
		3, 4, 5, 6,
		7, 8, 6, 11,
	})
	fmt.Printf("a = \n%s", a)

	b := _doRowReduction(a)
	fmt.Printf("b = \n%s", b)
	return
}

func doRowReductionManually2() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, 3, -1,
		3, 4, 5, 1,
		6, 7, 8, 4,
	})
	fmt.Printf("a = \n%s", a)

	b := _doRowReduction(a)
	fmt.Printf("b = \n%s", b)
}
