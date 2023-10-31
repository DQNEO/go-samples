package main

import "fmt"

type Matrix struct {
	//orig   any
	nrows  int
	ncols  int
	values [][]int // matrix[row][col]
}

func NewMatrix(r, c int, v [][]int) *Matrix {
	return &Matrix{
		values: v,
		nrows:  r,
		ncols:  c,
	}
}

func MatrixMul(a *Matrix, b *Matrix) *Matrix {
	if a.ncols != b.nrows {
		panic(fmt.Sprintf("type error: unable to multiply %s and %s", a.Type(), b.Type()))
	}
	// mxn * nxp = mxp
	nrows := a.nrows
	ncols := b.ncols
	var v [][]int = make([][]int, ncols)
	for _c, _ := range v {
		v[_c] = make([]int, nrows)
	}
	for _c, _ := range v {
		for _r, _ := range v[_c] {
			c, r := _c+1, _r+1
			var sum int
			for k := 1; k <= a.ncols; k++ {
				mul := a.Elm(r, k) * b.Elm(k, c)
				sum += mul
			}
			v[_c][_r] = sum
		}
	}
	return &Matrix{
		nrows:  nrows,
		ncols:  ncols,
		values: v,
	}
}

func (m *Matrix) String() string {
	var ret string
	for r := 1; r <= m.nrows; r++ {
		ret += "  |"
		for c := 1; c <= m.ncols; c++ {
			ret += fmt.Sprintf("%2d ", m.Elm(r, c))
		}
		ret += "|"
		ret += "\n"
	}
	return ret
}

func (m *Matrix) Elm(r, c int) int {
	return m.values[c-1][r-1]
}

func (m *Matrix) Type() string {
	return fmt.Sprintf("Matrix %dx%d", m.nrows, m.ncols)
}

func MatrixAdd(a, b *Matrix) *Matrix {
	if a.Type() != b.Type() {
		panic("type mismatch")
	}
	var v [][]int = make([][]int, a.ncols)
	for c, _ := range v {
		v[c] = make([]int, a.nrows)
	}

	for _c, _ := range v {
		for _r, _ := range v[_c] {
			c, r := _c+1, _r+1
			v[_c][_r] = a.Elm(r, c) + b.Elm(r, c)
		}
	}
	return &Matrix{
		values: v,
		nrows:  a.nrows,
		ncols:  a.ncols,
	}
}

func main() {
	a := NewMatrix(3, 2, [][]int{{1, 2, 3}, {4, 5, 6}})
	fmt.Printf("a = \n%s", a)
	fmt.Printf("type of a = %s\n", a.Type())
	fmt.Printf("a[1][2] = %d\n", a.Elm(1, 2))

	b := NewMatrix(3, 2, [][]int{{1, 1, 2}, {2, 3, 3}})
	fmt.Printf("b = \n%s", b)
	fmt.Printf("type of b = %s\n", b.Type())
	fmt.Printf("b[1][2] = %d\n", b.Elm(1, 2))

	fmt.Printf("a + b = \n%s", MatrixAdd(a, b))

	c := NewMatrix(2, 3, [][]int{{1, 3}, {2, 4}, {5, 7}})
	fmt.Printf("c = \n%s", c)
	fmt.Printf("type of c = %s\n", c.Type())
	fmt.Printf("c[2][3] = %d\n", c.Elm(2, 3))

	d := MatrixMul(a, c)
	fmt.Printf("a x c = \n%s", d)

	e := MatrixMul(c, a)
	fmt.Printf("c x a = \n%s", e)
}
