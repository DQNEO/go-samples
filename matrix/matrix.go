package matrix

import "fmt"

const DlmOpen = "("
const DlmClose = ")"

type Matrix struct {
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

func NewIdentityMatrix(n int) *Matrix {
	m := NewZeroMatrix(n, n)
	for ij := 1; ij <= n; ij++ {
		m.SetElm(ij, ij, 1)
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

	for j := 1; j <= nc; j++ {
		for i := 1; i <= nr; i++ {
			val := colVectors[j-1][i-1]
			m.SetElm(i, j, val)
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

func (m *Matrix) getIndex(i, j int) int {
	if m.nrows < i || m.ncols < j {
		panic("index (i,j) is out of range")
	}

	return (i-1)*m.ncols + (j - 1)
}

func (m *Matrix) GetElm(i, j int) int {
	idx := m.getIndex(i, j)
	return m.elms[idx]
}

func (m *Matrix) SetElm(r, c int, v int) {
	idx := m.getIndex(r, c)
	m.elms[idx] = v
}

func (m *Matrix) Type() string {
	return fmt.Sprintf("Matrix %dx%d", m.nrows, m.ncols)
}

func (m *Matrix) String() string {
	var ret string
	for i := 1; i <= m.nrows; i++ {
		ret += "  " + DlmOpen
		for j := 1; j <= m.ncols; j++ {
			ret += fmt.Sprintf("%2d ", m.GetElm(i, j))
		}
		ret += DlmClose
		ret += "\n"
	}
	return ret
}

func Scale(s int, m *Matrix) *Matrix {
	m2 := NewZeroMatrix(m.nrows, m.ncols)
	for idx := 0; idx < len(m.elms); idx++ {
		m2.elms[idx] = s * m.elms[idx]
	}
	return m2
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
	for i := 1; i <= m.nrows; i++ {
		for j := 1; j <= m.ncols; j++ {
			var sum int
			for k := 1; k <= nsum; k++ {
				mul := a.GetElm(i, k) * b.GetElm(k, j)
				sum += mul
			}
			m.SetElm(i, j, sum)
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
	for idx := 0; idx < len(m.elms); idx++ {
		m.elms[idx] = a.elms[idx] + b.elms[idx]
	}
	return m
}

func (m *Matrix) indexToRC(idx int) (i, j int) {
	j = (idx % m.ncols) + 1
	i = (idx / m.ncols) + 1
	return
}

// Tr transposes a matrix
func (m *Matrix) Tr() *Matrix {
	m2 := NewZeroMatrix(m.ncols, m.nrows)
	for idx := 0; idx < len(m.elms); idx++ {
		i, j := m.indexToRC(idx)
		m2.SetElm(j, i, m.elms[idx])
	}
	return m2
}

func (m *Matrix) Clone() *Matrix {
	elms2 := make([]int, len(m.elms))
	copy(elms2, m.elms)
	return NewMatrix(m.nrows, m.ncols, elms2)
}

func (m *Matrix) ApplyRowBasicTransformAdd(srcI int, s int, trgtI int) *Matrix {
	var row []int
	for j := 1; j <= m.ncols; j++ {
		row = append(row, m.GetElm(srcI, j)*s)
	}

	m2 := m.Clone()
	for j := 1; j <= m2.ncols; j++ {
		v := m2.GetElm(trgtI, j) + row[j-1]
		m2.SetElm(trgtI, j, v)
	}
	return m2
}

func (m *Matrix) ApplyRowBasicTransformMul(trgtI int, invs int) *Matrix {
	m2 := m.Clone()
	for j := 1; j <= m2.ncols; j++ {
		v := m2.GetElm(trgtI, j) / invs
		m2.SetElm(trgtI, j, v)
	}
	return m2
}
