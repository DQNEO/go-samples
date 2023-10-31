package main

import "fmt"

type Matrix struct {
	//orig   any
	nrows int
	ncols int
	elms  []int
}

func NewMatrixFromSlice(r, c int, elms []int) *Matrix {
	if len(elms) != (r * c) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			len(elms), r, c))
	}

	return &Matrix{
		nrows: r,
		ncols: c,
		elms:  elms,
	}

}

func NewMatrixFromSlices(nr, nc int, colVectors [][]int) *Matrix {
	totalVecSize := len(colVectors) * len(colVectors[0])
	if totalVecSize != (nr * nc) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			totalVecSize, nr, nc))
	}

	m := NewBlankMatrix(nr, nc)

	for c := 1; c <= nc; c++ {
		for r := 1; r <= nr; r++ {
			val := colVectors[c-1][r-1]
			m.SetElm(r, c, val)
		}
	}

	return m
}

func NewBlankMatrix(r, c int) *Matrix {
	m := &Matrix{
		nrows: r,
		ncols: c,
		elms:  make([]int, r*c),
	}
	return m
}

func (m *Matrix) getIndex(r, c int) int {
	if m.nrows < r || m.ncols < c {
		panic("index (r,c) is out of range")
	}

	return (r-1)*m.ncols + (c - 1)
}

func (m *Matrix) Elm(r, c int) int {
	i := m.getIndex(r, c)
	return m.elms[i]
}

func (m *Matrix) SetElm(r, c int, v int) {
	i := m.getIndex(r, c)
	m.elms[i] = v
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
	for i := 0; i < len(m.elms); i++ {
		m2.elms[i] = s * m.elms[i]
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
	if len(a.elms) != len(b.elms) {
		panic("internal error: length mismatch")
	}
	nrows := a.nrows
	ncols := a.ncols
	m := NewBlankMatrix(nrows, ncols)
	for i := 0; i < len(m.elms); i++ {
		m.elms[i] = a.elms[i] + b.elms[i]
	}
	return m
}

func main() {
	test()
	doEnshu2()
}

func test() {
	a := NewMatrixFromSlice(3, 2, []int{
		1, 2,
		3, 4,
		5, 6,
	})
	fmt.Printf("a = \n%s", a)
	fmt.Printf("type of a = %s\n", a.Type())
	fmt.Printf("a[1][2] = %d\n", a.Elm(1, 2))

	b := NewMatrixFromSlices(3, 2, [][]int{{1, 1, 2}, {2, 3, 3}})
	fmt.Printf("b = \n%s", b)
	fmt.Printf("type of b = %s\n", b.Type())
	fmt.Printf("b[1][2] = %d\n", b.Elm(1, 2))

	fmt.Printf("a + b = \n%s", MatrixAdd(a, b))

	c := NewMatrixFromSlices(2, 3, [][]int{{1, 4}, {2, 5}, {3, 6}})
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
	a := NewMatrixFromSlices(1, 2, [][]int{{1}, {2}})
	b := NewMatrixFromSlices(2, 1, [][]int{{3, 4}})
	c := MatrixMul(a, b)
	fmt.Printf("a x b = \n%s", c)

	fmt.Println("-- (2)")
	a = NewMatrixFromSlices(2, 1, [][]int{{3, 4}})
	b = NewMatrixFromSlices(1, 2, [][]int{{1}, {2}})
	c = MatrixMul(a, b)
	fmt.Printf("a x b = \n%s", c)
}
