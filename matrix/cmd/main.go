package main

import (
	"fmt"

	"github.com/DQNEO/go-samples/matrix"
)

func main() {
	fmt.Println("----- enshu 1.1")
	doEnshu1_1()
	return

	fmt.Println("----- chapter 1: 1.1")
	doRowReduction1()
	fmt.Println("----- chapter 1: 1.3")
	doRowReduction2()
	fmt.Println("----- chapter 1: 1.6")
	doRowReduction3()

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

func DoRowReduction(m *matrix.Matrix) *matrix.Matrix {
	a := m.Clone()
	for pivotPosition := 1; pivotPosition <= a.R; pivotPosition++ {
		// make pivot value 1
		divisor := a.GetElm(pivotPosition, pivotPosition)
		if divisor == 0 {
			// look for non zero row and replace current row by that one
			println("pivotPosition is 0...")
			for searchI := pivotPosition + 1; searchI <= a.R; searchI++ {
				divisor = a.GetElm(searchI, pivotPosition)
				if divisor != 0 {
					a = a.ApplyRowBasicTransFormReplaceRow(pivotPosition, searchI)
				}
			}
			if divisor == 0 {
				return a
			}
		}
		a = a.ApplyRowBasicTransformDiv(pivotPosition, divisor)
		fmt.Printf("a = \n%s", a)

		// fill zero below the pivot
		for i := pivotPosition + 1; i <= a.R; i++ {
			rowHead := a.GetElm(i, pivotPosition)
			a = a.ApplyRowBasicTransformAdd(pivotPosition, -1*rowHead, i)
			fmt.Printf("a = \n%s", a)
		}
	}
	// Now left bottom elements are all zero.

	// Making zero from right bottom
	for srcI := a.R; srcI >= 1; srcI-- {
		for trgtI := srcI - 1; trgtI >= 1; trgtI-- {
			scalar := -1 * a.GetElm(trgtI, srcI)
			a = a.ApplyRowBasicTransformAdd(srcI, scalar, trgtI)
			fmt.Printf("a = \n%s", a)
		}
	}
	return a
}
func doRowReduction1() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, 3, 2,
		3, 4, 5, 6,
		7, 8, 6, 11,
	})
	fmt.Printf("a = \n%s", a)

	b := DoRowReduction(a)
	fmt.Printf("b = \n%s", b)
}

func doRowReduction2() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, 3, -1,
		3, 4, 5, 1,
		6, 7, 8, 4,
	})
	fmt.Printf("a = \n%s", a)

	b := DoRowReduction(a)
	fmt.Printf("b = \n%s", b)
}

func doRowReduction3() {
	a := matrix.NewMatrix(3, 6, []float64{
		1, 1, -1, 2, 1, 0,
		0, 1, 1, 1, -3, 1,
		0, 0, 0, 1, -1, 2,
	})
	fmt.Printf("a = \n%s", a)

	b := DoRowReduction(a)
	fmt.Printf("b = \n%s", b)
}

func doEnshu1_1() {
	a := matrix.NewMatrix(4, 5, []float64{
		1, 1, 1, 0, 1,
		1, 1, 0, 1, 1,
		1, 0, 1, 1, 1,
		0, 1, 1, 1, 1,
	})
	fmt.Printf("a = \n%s", a)

	b := DoRowReduction(a)
	fmt.Printf("b = \n%s", b)
}
