package main

import "fmt"

type Matrix struct {
	v any
}

func NewMatrix(v any) *Matrix {
	return &Matrix{}
}

func MatrixMul(a *Matrix, b *Matrix) *Matrix {
	return &Matrix{}
}

func main() {
	a := NewMatrix([2][3]int{{1, 2, 3}, {4, 5, 6}})
	b := NewMatrix([3][2]int{{1, 1}, {2, 2}, {3, 3}})
	c := MatrixMul(a, b)
	fmt.Println(a, b, c)
}
