package matrix

import (
	"fmt"
)

const DlmOpen = "("
const DlmClose = ")"

type Matrix struct {
	R    int
	C    int
	elms []float64
}

func NewMatrix(r, c int, elms []float64) *Matrix {
	if len(elms) != (r * c) {
		panic(fmt.Sprintf("number of elements (%d) does not match the give type (%dx%d)",
			len(elms), r, c))
	}

	return &Matrix{
		R:    r,
		C:    c,
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
		R:    r,
		C:    c,
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
	if m.R < i {
		panic(fmt.Sprintf("index i(%d) is out of R(%d)", i, m.R))
	}
	if m.C < j {
		panic(fmt.Sprintf("index i(%d) is out of R(%d)", j, m.C))
	}

	return (i-1)*m.C + (j - 1)
}

func (m *Matrix) index2ij(idx int) (i, j int) {
	if idx < 0 || m.C*m.R <= idx {
		panic("index out of range")
	}
	j = (idx % m.C) + 1
	i = (idx / m.C) + 1
	return
}

func (m *Matrix) GetElm(i, j int) float64 {
	return m.elms[m.ij2Index(i, j)]
}

func (m *Matrix) SetElm(r, c int, v float64) {
	m.elms[m.ij2Index(r, c)] = v
}

func (m *Matrix) Type() string {
	return fmt.Sprintf("Matrix %dx%d", m.R, m.C)
}

func (m *Matrix) String() string {
	var ret string
	for i := 1; i <= m.R; i++ {
		ret += "  " + DlmOpen
		for j := 1; j <= m.C; j++ {
			f := m.GetElm(i, j)
			if f == -0 {
				f = 0
			}
			ret += fmt.Sprintf("% 3.10g ", f)
		}
		ret += DlmClose
		ret += "\n"
	}
	return ret
}

func Scale(s float64, m *Matrix) *Matrix {
	m2 := NewZeroMatrix(m.R, m.C)
	for idx := 0; idx < len(m.elms); idx++ {
		m2.elms[idx] = s * m.elms[idx]
	}
	return m2
}

func (m *Matrix) GetSize() (int, int) {
	return m.R, m.C
}

func Mul(a *Matrix, b *Matrix) *Matrix {
	if a.C != b.R {
		panic(fmt.Sprintf("type error: unable to multiply %s and %s", a.Type(), b.Type()))
	}
	// mxn * nxp = mxp
	nrows := a.R
	ncols := b.C
	m := NewZeroMatrix(nrows, ncols)

	nsum := a.C
	for i := 1; i <= m.R; i++ {
		for j := 1; j <= m.C; j++ {
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
	nrows := a.R
	ncols := a.C
	m := NewZeroMatrix(nrows, ncols)
	for idx := 0; idx < len(m.elms); idx++ {
		m.elms[idx] = a.elms[idx] + b.elms[idx]
	}
	return m
}

// Tr transposes a matrix
func (m *Matrix) Tr() *Matrix {
	m2 := NewZeroMatrix(m.C, m.R)
	for idx := 0; idx < len(m.elms); idx++ {
		i, j := m.index2ij(idx)
		m2.SetElm(j, i, m.elms[idx])
	}
	return m2
}

func (m *Matrix) Clone() *Matrix {
	elms2 := make([]float64, len(m.elms))
	copy(elms2, m.elms)
	return NewMatrix(m.R, m.C, elms2)
}

func (m *Matrix) ApplyRowBasicTransformAdd(srcI int, s float64, trgtI int) *Matrix {
	var row []float64
	for j := 1; j <= m.C; j++ {
		row = append(row, m.GetElm(srcI, j)*s)
	}

	m2 := m.Clone()
	for j := 1; j <= m2.C; j++ {
		v := m2.GetElm(trgtI, j) + row[j-1]
		m2.SetElm(trgtI, j, v)
	}
	return m2
}

func (m *Matrix) ApplyRowBasicTransformDiv(trgtI int, scalar float64) *Matrix {
	m2 := m.Clone()
	for j := 1; j <= m2.C; j++ {
		oldV := m2.GetElm(trgtI, j)
		newV := oldV / scalar
		m2.SetElm(trgtI, j, newV)
	}
	return m2
}

func (m *Matrix) ApplyRowBasicTransFormReplaceRow(i1 int, i2 int) *Matrix {
	m2 := m.Clone()
	for j := 1; j <= m2.C; j++ {
		v1 := m2.GetElm(i1, j)
		v2 := m2.GetElm(i2, j)
		m2.SetElm(i1, j, v2)
		m2.SetElm(i2, j, v1)
	}
	return m2
}

func (m *Matrix) DoRowReduction() *Matrix {
	//fmt.Println("----- DoRowReduction start")
	a := m.Clone()
	pivotColOffset := 0

	for pivotPosition := 1; pivotPosition <= a.R && pivotPosition+pivotColOffset <= a.C; pivotPosition++ {
		// make pivot value 1
	LOOP_FIRST:
		divisor := a.GetElm(pivotPosition, pivotPosition+pivotColOffset)
		if divisor == 0 {
			// look for non zero row and replace current row by that one
			//fmt.Println("pivotPosition is 0. Looking for non zero row...")
			for searchI := pivotPosition + 1; searchI <= a.R; searchI++ {
				divisor = a.GetElm(searchI, pivotPosition+pivotColOffset)
				if divisor != 0 {
					//fmt.Println("found divisor", divisor, "at row", searchI)
					//fmt.Println("ApplyRowBasicTransFormReplaceRow")
					a = a.ApplyRowBasicTransFormReplaceRow(pivotPosition, searchI)
					//fmt.Printf("a = \n%s", a)
					goto LOOP_FIRST
				}
			}
			if divisor == 0 {
				pivotColOffset++
				if pivotPosition+pivotColOffset > a.C {
					return a
				}
				goto LOOP_FIRST
			}
		}
		//		fmt.Println("ApplyRowBasicTransformDiv", pivotPosition, divisor)
		a = a.ApplyRowBasicTransformDiv(pivotPosition, divisor)
		//fmt.Printf("a = \n%s", a)

		// fill zero below the pivot
		for i := pivotPosition + 1; i <= a.R; i++ {
			rowHead := a.GetElm(i, pivotPosition+pivotColOffset)
			//fmt.Println("ApplyRowBasicTransformAdd", -1*rowHead)
			a = a.ApplyRowBasicTransformAdd(pivotPosition, -1*rowHead, i)
			//fmt.Printf("a = \n%s", a)
		}
	}
	// Now left bottom elements should be all zero.

	// Making zero from right bottom
	//fmt.Println("Making zero from right bottom")
	for srcI := a.R; srcI >= 1; srcI-- {
		var srcJ int
		for j := 1; j <= a.C; j++ {
			if a.GetElm(srcI, j) == 1 {
				srcJ = j
				break
			}
		}
		if srcJ == 0 {
			continue
		}
		for trgtI := srcI - 1; trgtI >= 1; trgtI-- {
			scalar := -1 * a.GetElm(trgtI, srcJ)
			//fmt.Println("ApplyRowBasicTransformAdd", trgtI, srcJ, scalar)
			a = a.ApplyRowBasicTransformAdd(srcI, scalar, trgtI)
			//fmt.Printf("a = \n%s", a)
		}
	}
	return a
}

func Inv(a *Matrix) *Matrix {
	r, c := a.GetSize()
	if r != c {
		panic("Invalid type to calculate inversion")
	}
	b := a.Clone()
	ident := NewIdentityMatrix(r)
	m := JoinColVectors(b, ident)
	m2 := m.DoRowReduction()

	// Extract right half
	m3 := m2.SliceColVectors(a.C+1, m2.C)
	return m3
}

func (m *Matrix) SliceColVectors(from int, to int) *Matrix {
	m2 := NewZeroMatrix(m.R, to-from+1)
	for i := 1; i <= m.R; i++ {
		for j := from; j <= to; j++ {
			v := m.GetElm(i, j)
			m2.SetElm(i, j-from+1, v)
		}
	}
	return m2

}

func JoinColVectors(a, b *Matrix) *Matrix {
	c := NewZeroMatrix(a.R, a.C+b.C)
	for i := 1; i <= a.R; i++ {
		for j := 1; j <= c.C; j++ {
			var v float64
			if j <= a.C {
				v = a.GetElm(i, j)
			} else {
				v = b.GetElm(i, j-a.C)
			}
			c.SetElm(i, j, v)
		}
	}
	return c
}
