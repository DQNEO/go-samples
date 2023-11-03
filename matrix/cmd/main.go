package main

import (
	"fmt"

	"github.com/DQNEO/go-samples/matrix"
)

func main() {
	test()
	doEnshu2()
}

func test() {
	a := matrix.NewMatrix(3, 2, []int{
		1, 2,
		3, 4,
		5, 6,
	})
	fmt.Printf("a = \n%s", a)
	fmt.Printf("type of a = %s\n", a.Type())
	fmt.Printf("a[1][2] = %d\n", a.GetElm(1, 2))

	b := matrix.NewMatrixFromSlices(3, 2, [][]int{{1, 1, 2}, {2, 3, 3}})
	fmt.Printf("b = \n%s", b)
	fmt.Printf("type of b = %s\n", b.Type())
	fmt.Printf("b[1][2] = %d\n", b.GetElm(1, 2))

	fmt.Printf("a + b = \n%s", matrix.Add(a, b))

	c := matrix.NewMatrixFromSlices(2, 3, [][]int{{1, 4}, {2, 5}, {3, 6}})
	fmt.Printf("c = \n%s", c)
	fmt.Printf("type of c = %s\n", c.Type())
	fmt.Printf("c[2][3] = %d\n", c.GetElm(2, 3))

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
	a := matrix.NewMatrixFromSlices(1, 2, [][]int{{1}, {2}})
	b := matrix.NewMatrixFromSlices(2, 1, [][]int{{3, 4}})
	c := matrix.Mul(a, b)
	fmt.Printf("a x b = \n%s", c)

	fmt.Println("-- (2)")
	a = matrix.NewMatrixFromSlices(2, 1, [][]int{{3, 4}})
	b = matrix.NewMatrixFromSlices(1, 2, [][]int{{1}, {2}})
	c = matrix.Mul(a, b)
	fmt.Printf("a x b = \n%s", c)
}
