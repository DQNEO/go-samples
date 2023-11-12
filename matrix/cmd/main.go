package main

import (
	"fmt"

	"github.com/DQNEO/go-samples/matrix"
)

func main() {
	numbers := []int{1, 2, 3, 4}
	permGroup := matrix.GenPermGroup(numbers)
	fmt.Printf("numbers=%d\nlen=%d\n", numbers, len(permGroup))
	fmt.Printf("symmetric group:\n")
	for _, pg := range permGroup {
		fmt.Printf("%d : %d\n", pg.List, pg.NReplacement)
	}
	for _, pg := range permGroup {
		fmt.Printf("%s\n", matrix.ToDeterminantExpr(pg))
	}

	return
	fmt.Println("----- enshu 2.2")
	doEnshu2_2()
	fmt.Println("----- enshu 2.4")
	doEnshu2_4()
	fmt.Println("----- enshu 2.5")
	doEnshu2_5()
	return
	fmt.Println("----- enshu 1.1")
	doEnshu1_1()
	fmt.Println("----- enshu 1.2")
	doEnshu1_2()
	fmt.Println("----- enshu 1.3")
	doEnshu1_3()
	fmt.Println("----- enshu 1.4")
	doEnshu1_4()
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

func doRowReduction1() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, 3, 2,
		3, 4, 5, 6,
		7, 8, 6, 11,
	})
	fmt.Printf("a = \n%s", a)

	b := a.DoRowReduction()
	fmt.Printf("b = \n%s", b)
}

func doRowReduction2() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, 3, -1,
		3, 4, 5, 1,
		6, 7, 8, 4,
	})
	fmt.Printf("a = \n%s", a)

	b := a.DoRowReduction()
	fmt.Printf("b = \n%s", b)
}

func doRowReduction3() {
	a := matrix.NewMatrix(3, 6, []float64{
		1, 1, -1, 2, 1, 0,
		0, 1, 1, 1, -3, 1,
		0, 0, 0, 1, -1, 2,
	})
	fmt.Printf("a = \n%s", a)

	b := a.DoRowReduction()
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

	b := a.DoRowReduction()
	fmt.Printf("b = \n%s", b)
}

func doEnshu1_2() {
	a := matrix.NewMatrix(3, 4, []float64{
		1, 2, -1, 1,
		1, 2, 1, 5,
		1, 2, 2, 7,
	})
	fmt.Printf("a = \n%s", a)

	b := a.DoRowReduction()
	fmt.Printf("b = \n%s", b)
}

func doEnshu1_3() {
	a := matrix.NewMatrix(4, 5, []float64{
		1, 0, 3, 0, 2,
		2, 1, 2, 1, 3,
		2, 2, -2, 2, 2,
		3, 2, 1, 2, 4,
	})
	fmt.Printf("a = \n%s", a)

	b := a.DoRowReduction()
	fmt.Printf("b = \n%s", b)
}

func doEnshu1_4() {
	a := matrix.NewMatrix(2, 7, []float64{
		0, 0, 1, 2, 2, 2, 4,
		2, 2, 3, 3, 6, 6, 6,
	})
	fmt.Printf("a = \n%s", a)

	b := a.DoRowReduction()
	fmt.Printf("b = \n%s", b)
}

func doEnshu2_2() {
	a := matrix.NewMatrix(3, 3, []float64{
		0, 2, 6,
		-1, -3, -6,
		0.5, 1, 2,
	})
	fmt.Printf("a = \n%s", a)
	c := matrix.Inv(a)
	fmt.Printf("inversion:\n%s", c)
}

func doEnshu2_4() {
	a := matrix.NewMatrix(3, 3, []float64{
		0, 2, 1,
		2, 0, 0,
		0, 3, 2,
	})
	fmt.Printf("a = \n%s", a)
	c := matrix.Inv(a)
	fmt.Printf("inversion:\n%s", c)
}

func doEnshu2_5() {
	a := matrix.NewMatrix(3, 3, []float64{
		2, 0, 4,
		0, 1, 2,
		0, 2, 5,
	})
	fmt.Printf("a = \n%s", a)
	c := matrix.Inv(a)
	fmt.Printf("inversion:\n%s", c)
}
