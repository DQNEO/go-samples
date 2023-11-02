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
	a := matrix.NewMatrixFromSlice(3, 2, []int{
		1, 2,
		3, 4,
		5, 6,
	})
	fmt.Printf("a = \n%s", a)
	fmt.Printf("type of a = %s\n", a.Type())
	fmt.Printf("a[1][2] = %d\n", a.Elm(1, 2))

	b := matrix.NewMatrixFromSlices(3, 2, [][]int{{1, 1, 2}, {2, 3, 3}})
	fmt.Printf("b = \n%s", b)
	fmt.Printf("type of b = %s\n", b.Type())
	fmt.Printf("b[1][2] = %d\n", b.Elm(1, 2))

	fmt.Printf("a + b = \n%s", matrix.MatrixAdd(a, b))

	c := matrix.NewMatrixFromSlices(2, 3, [][]int{{1, 4}, {2, 5}, {3, 6}})
	fmt.Printf("c = \n%s", c)
	fmt.Printf("type of c = %s\n", c.Type())
	fmt.Printf("c[2][3] = %d\n", c.Elm(2, 3))

	d := a.Apply(c) // d = a * c
	fmt.Printf("a x c = \n%s", d)

	e := c.Apply(a) // e = c * a
	fmt.Printf("c x a = \n%s", e)
	if e.Elm(2, 1) != 49 {
		panic("ERROR")
	}

	fmt.Printf("2 x a = \n%s", a.Scale(2))
}
func doEnshu2() {
	fmt.Println("=== Enshu 2.1")
	fmt.Println("-- (1)")
	a := matrix.NewMatrixFromSlices(1, 2, [][]int{{1}, {2}})
	b := matrix.NewMatrixFromSlices(2, 1, [][]int{{3, 4}})
	c := matrix.MatrixMul(a, b)
	fmt.Printf("a x b = \n%s", c)

	fmt.Println("-- (2)")
	a = matrix.NewMatrixFromSlices(2, 1, [][]int{{3, 4}})
	b = matrix.NewMatrixFromSlices(1, 2, [][]int{{1}, {2}})
	c = matrix.MatrixMul(a, b)
	fmt.Printf("a x b = \n%s", c)
}
