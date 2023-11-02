package matrix

import "fmt"

const DlmOpen = "("
const DlmClose = ")"

type Matrix struct {
	//orig   any
	nrows int
	ncols int
	elms  []int
}

func NewMatrix(r, c int, elms []int) *Matrix {
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

func NewIdentyMatrix(n int) *Matrix {
	m := NewZeroMatrix(n, n)
	for rc := 1; rc <= n; rc++ {
		m.SetElm(rc, rc, 1)
	}
	return m
}

func NewMatrixFromSlices(nr, nc int, colVectors [][]int) *Matrix {
	totalVecSize := len(colVectors) * len(colVectors[0])
	if totalVecSize != (nr * nc) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			totalVecSize, nr, nc))
	}

	m := NewZeroMatrix(nr, nc)

	for c := 1; c <= nc; c++ {
		for r := 1; r <= nr; r++ {
			val := colVectors[c-1][r-1]
			m.SetElm(r, c, val)
		}
	}

	return m
}

func NewZeroMatrix(r, c int) *Matrix {
	m := &Matrix{
		nrows: r,
		ncols: c,
		elms:  make([]int, r*c),
	}
	return m
}

func Eq(a *Matrix, b *Matrix) bool {
	if a.Type() != b.Type() {
		panic("error: type mismatch")
	}

	for i, av := range a.elms {
		bv := b.elms[i]
		if av != bv {
			return false
		}
	}
	return true
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
		ret += "  " + DlmOpen
		for c := 1; c <= m.ncols; c++ {
			ret += fmt.Sprintf("%2d ", m.Elm(r, c))
		}
		ret += DlmClose
		ret += "\n"
	}
	return ret
}

func (m *Matrix) Scale(s int) *Matrix {
	m2 := NewZeroMatrix(m.nrows, m.ncols)
	for i := 0; i < len(m.elms); i++ {
		m2.elms[i] = s * m.elms[i]
	}
	return m2
}

// A*B
func (m *Matrix) Apply(n *Matrix) *Matrix {
	return Mul(m, n)
}

func (m *Matrix) GetSize() (int, int) {
	return m.nrows, m.ncols
}

func Mul(a *Matrix, b *Matrix) *Matrix {
	if a.ncols != b.nrows {
		panic(fmt.Sprintf("type error: unable to multiply %s and %s", a.Type(), b.Type()))
	}
	// mxn * nxp = mxp
	nrows := a.nrows
	ncols := b.ncols
	m := NewZeroMatrix(nrows, ncols)

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

func Add(a, b *Matrix) *Matrix {
	if a.Type() != b.Type() {
		panic("type mismatch")
	}
	if len(a.elms) != len(b.elms) {
		panic("internal error: length mismatch")
	}
	nrows := a.nrows
	ncols := a.ncols
	m := NewZeroMatrix(nrows, ncols)
	for i := 0; i < len(m.elms); i++ {
		m.elms[i] = a.elms[i] + b.elms[i]
	}
	return m
}

func (m *Matrix) indexToRC(i int) (r, c int) {
	c = (i % m.ncols) + 1
	r = (i / m.ncols) + 1
	return
}

// Tr transposes a matrix
func (m *Matrix) Tr() *Matrix {
	m2 := NewZeroMatrix(m.ncols, m.nrows)
	for i := 0; i < len(m.elms); i++ {
		r, c := m.indexToRC(i)
		c2, r2 := r, c
		m2.SetElm(r2, c2, m.elms[i])
	}
	return m2
}
