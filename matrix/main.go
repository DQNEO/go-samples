package main

import "fmt"

type Matrix struct {
	//orig   any
	nrows      int
	ncols      int
	colVectors [][]int // list of column vectors
}

func NewMatrix(r, c int, v [][]int) *Matrix {
	totalCount := len(v) * len(v[0])
	if totalCount != (r * c) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			totalCount, r, c))
	}
	return &Matrix{
		colVectors: v,
		nrows:      r,
		ncols:      c,
	}
}

func NewBlankMatrix(r, c int) *Matrix {
	var v [][]int = make([][]int, c)
	for c, _ := range v {
		v[c] = make([]int, r)
	}
	m := &Matrix{
		nrows:      r,
		ncols:      c,
		colVectors: v,
	}
	return m
}

func (m *Matrix) Elm(r, c int) int {
	return m.colVectors[c-1][r-1]
}

func (m *Matrix) SetElm(r, c int, v int) {
	m.colVectors[c-1][r-1] = v
}

func (m *Matrix) Type() string {
	return fmt.Sprintf("Matrix %dx%d", m.nrows, m.ncols)
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

func (m *Matrix) Scale(s int) *Matrix {
	m2 := NewBlankMatrix(m.nrows, m.ncols)
	for r := 1; r <= m.nrows; r++ {
		for c := 1; c <= m.ncols; c++ {
			v := m.Elm(r, c)
			m2.SetElm(r, c, s*v)
		}
	}
	return m2
}

// A*B
func (m *Matrix) Apply(n *Matrix) *Matrix {
	return MatrixMul(m, n)
}

func MatrixMul(a *Matrix, b *Matrix) *Matrix {
	if a.ncols != b.nrows {
		panic(fmt.Sprintf("type error: unable to multiply %s and %s", a.Type(), b.Type()))
	}
	// mxn * nxp = mxp
	nrows := a.nrows
	ncols := b.ncols
	m := NewBlankMatrix(nrows, ncols)

	nsum := a.ncols
	for r := 1; r <= m.nrows; r++ {
		for c := 1; c <= m.ncols; c++ {
			var sum int
			for k := 1; k <= nsum; k++ {
				mul := a.Elm(r, k) * b.Elm(k, c)
				sum += mul
			}
			m.SetElm(r, c, sum)
		}
	}
	return m
}

func MatrixAdd(a, b *Matrix) *Matrix {
	if a.Type() != b.Type() {
		panic("type mismatch")
	}

	nrows := a.nrows
	ncols := a.ncols
	m := NewBlankMatrix(nrows, ncols)
	for r := 1; r <= m.nrows; r++ {
		for c := 1; c <= m.ncols; c++ {
			elm := a.Elm(r, c) + b.Elm(r, c)
			m.SetElm(r, c, elm)
		}
	}
	return m
}

func main() {
	test()
	doEnshu2()
}

func test() {
	a := NewMatrix(3, 2, [][]int{{1, 3, 5}, {2, 4, 6}})
	fmt.Printf("a = \n%s", a)
	fmt.Printf("type of a = %s\n", a.Type())
	fmt.Printf("a[1][2] = %d\n", a.Elm(1, 2))

	b := NewMatrix(3, 2, [][]int{{1, 1, 2}, {2, 3, 3}})
	fmt.Printf("b = \n%s", b)
	fmt.Printf("type of b = %s\n", b.Type())
	fmt.Printf("b[1][2] = %d\n", b.Elm(1, 2))

	fmt.Printf("a + b = \n%s", MatrixAdd(a, b))

	c := NewMatrix(2, 3, [][]int{{1, 4}, {2, 5}, {3, 6}})
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
	a := NewMatrix(1, 2, [][]int{{1}, {2}})
	b := NewMatrix(2, 1, [][]int{{3, 4}})
	c := MatrixMul(a, b)
	fmt.Printf("a x b = \n%s", c)

	fmt.Println("-- (2)")
	a = NewMatrix(2, 1, [][]int{{3, 4}})
	b = NewMatrix(1, 2, [][]int{{1}, {2}})
	c = MatrixMul(a, b)
	fmt.Printf("a x b = \n%s", c)
}
