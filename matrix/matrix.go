package matrix

import "fmt"

const DlmOpen = "("
const DlmClose = ")"

type Matrix struct {
	r    int
	c    int
	elms []float64
}

func NewMatrix(r, c int, elms []float64) *Matrix {
	if len(elms) != (r * c) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			len(elms), r, c))
	}

	return &Matrix{
		r:    r,
		c:    c,
		elms: elms,
	}
}

func NewIdentityMatrix(n int) *Matrix {
	m := NewZeroMatrix(n, n)
	for ij := 1; ij <= n; ij++ {
		m.SetElm(ij, ij, 1)
	}
	return m
}

func NewMatrixFromSlices(r, c int, colVectors [][]float64) *Matrix {
	totalVecSize := len(colVectors) * len(colVectors[0])
	if totalVecSize != (r * c) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			totalVecSize, r, c))
	}

	m := NewZeroMatrix(r, c)

	for j := 1; j <= c; j++ {
		for i := 1; i <= r; i++ {
			val := colVectors[j-1][i-1]
			m.SetElm(i, j, val)
		}
	}

	return m
}

func NewZeroMatrix(r, c int) *Matrix {
	m := &Matrix{
		r:    r,
		c:    c,
		elms: make([]float64, r*c),
	}
	return m
}

func Eq(a *Matrix, b *Matrix) bool {
	if a.Type() != b.Type() {
		panic("error: type mismatch")
	}

	for idx, av := range a.elms {
		bv := b.elms[idx]
		if av != bv {
			return false
		}
	}
	return true
}

func (m *Matrix) ij2Index(i, j int) int {
	if m.r < i || m.c < j {
		panic("index (i,j) is out of range")
	}

	return (i-1)*m.c + (j - 1)
}

func (m *Matrix) index2ij(idx int) (i, j int) {
	if idx < 0 || m.c*m.r <= idx {
		panic("index out of range")
	}
	j = (idx % m.c) + 1
	i = (idx / m.c) + 1
	return
}

func (m *Matrix) GetElm(i, j int) float64 {
	return m.elms[m.ij2Index(i, j)]
}

func (m *Matrix) SetElm(r, c int, v float64) {
	m.elms[m.ij2Index(r, c)] = v
}

func (m *Matrix) Type() string {
	return fmt.Sprintf("Matrix %dx%d", m.r, m.c)
}

func (m *Matrix) String() string {
	var ret string
	for i := 1; i <= m.r; i++ {
		ret += "  " + DlmOpen
		for j := 1; j <= m.c; j++ {
			ret += fmt.Sprintf("%2f ", m.GetElm(i, j))
		}
		ret += DlmClose
		ret += "\n"
	}
	return ret
}

func Scale(s float64, m *Matrix) *Matrix {
	m2 := NewZeroMatrix(m.r, m.c)
	for idx := 0; idx < len(m.elms); idx++ {
		m2.elms[idx] = s * m.elms[idx]
	}
	return m2
}

func (m *Matrix) GetSize() (int, int) {
	return m.r, m.c
}

func Mul(a *Matrix, b *Matrix) *Matrix {
	if a.c != b.r {
		panic(fmt.Sprintf("type error: unable to multiply %s and %s", a.Type(), b.Type()))
	}
	// mxn * nxp = mxp
	nrows := a.r
	ncols := b.c
	m := NewZeroMatrix(nrows, ncols)

	nsum := a.c
	for i := 1; i <= m.r; i++ {
		for j := 1; j <= m.c; j++ {
			var sum float64
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
	nrows := a.r
	ncols := a.c
	m := NewZeroMatrix(nrows, ncols)
	for idx := 0; idx < len(m.elms); idx++ {
		m.elms[idx] = a.elms[idx] + b.elms[idx]
	}
	return m
}

// Tr transposes a matrix
func (m *Matrix) Tr() *Matrix {
	m2 := NewZeroMatrix(m.c, m.r)
	for idx := 0; idx < len(m.elms); idx++ {
		i, j := m.index2ij(idx)
		m2.SetElm(j, i, m.elms[idx])
	}
	return m2
}

func (m *Matrix) Clone() *Matrix {
	elms2 := make([]float64, len(m.elms))
	copy(elms2, m.elms)
	return NewMatrix(m.r, m.c, elms2)
}

func (m *Matrix) ApplyRowBasicTransformAdd(srcI int, s float64, trgtI int) *Matrix {
	var row []float64
	for j := 1; j <= m.c; j++ {
		row = append(row, m.GetElm(srcI, j)*s)
	}

	m2 := m.Clone()
	for j := 1; j <= m2.c; j++ {
		v := m2.GetElm(trgtI, j) + row[j-1]
		m2.SetElm(trgtI, j, v)
	}
	return m2
}

func (m *Matrix) ApplyRowBasicTransformDiv(trgtI int, scalar float64) *Matrix {
	m2 := m.Clone()
	for j := 1; j <= m2.c; j++ {
		oldV := m2.GetElm(trgtI, j)
		newV := oldV / scalar
		m2.SetElm(trgtI, j, newV)
	}
	return m2
}
