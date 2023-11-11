package matrix

import (
	"testing"
)

func TestNewMatrix(t *testing.T) {
	m1 := NewMatrix(2, 3, []float64{
		1, 2, 3,
		4, 5, 6,
	})
	r, c := m1.GetSize()
	if r != 2 {
		t.Errorf("error")
	}
	if c != 3 {
		t.Errorf("error")
	}

	typ := m1.Type()
	if typ != "Matrix 2x3" {
		t.Errorf("error: got %s", typ)
	}
}

func TestEq(t *testing.T) {
	type args struct {
		a *Matrix
		b *Matrix
	}
	tests := []struct {
		name string
		args args
		want bool
	}{
		{
			name: "equal",
			args: args{
				a: NewMatrix(3, 2, []float64{
					1, 2,
					3, 4,
					5, 6,
				}),
				b: NewMatrixFromSlices(3, 2, [][]float64{
					{1, 3, 5}, {2, 4, 6},
				}),
			},
			want: true,
		},
		{
			name: "not equal",
			args: args{
				a: NewMatrix(3, 2, []float64{
					1, 2,
					3, 4,
					5, 6,
				}),
				b: NewMatrixFromSlices(3, 2, [][]float64{
					{1, 3, 5}, {2, 4, 999},
				}),
			},
			want: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := Eq(tt.args.a, tt.args.b); got != tt.want {
				t.Errorf("Eq() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestMatrix_Tr(t *testing.T) {
	tests := []struct {
		name  string
		input *Matrix
		want  *Matrix
	}{
		{
			name:  "1x2 -> 2x1",
			input: NewMatrix(1, 2, []float64{1, 2}),
			want:  NewMatrix(2, 1, []float64{1, 2}),
		},
		{
			name: "3x2 -> 2x3",
			input: NewMatrixFromSlices(3, 2, [][]float64{
				{1, 3, 5}, {2, 4, 6},
			}),
			want: NewMatrixFromSlices(2, 3, [][]float64{
				{1, 2}, {3, 4}, {5, 6},
			}),
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			m := tt.input
			if got := m.Tr(); !Eq(got, tt.want) {
				t.Errorf("got = %v, want %v", got, tt.want)
			}
		})
	}

	m := NewMatrixFromSlices(3, 2, [][]float64{
		{1, 3, 5}, {2, 4, 6},
	})
	ttm := m.Tr().Tr()
	if !Eq(m, ttm) {
		t.Errorf("M = ttM should holds true")
	}

}

func TestMatrixOne(t *testing.T) {
	tests := []struct {
		name string
		n    int // dimension
		want *Matrix
	}{
		{
			name: "1x1",
			n:    1,
			want: NewMatrix(1, 1, []float64{1}),
		},
		{
			name: "2x2",
			n:    2,
			want: NewMatrix(2, 2, []float64{
				1, 0,
				0, 1,
			}),
		},
		{
			name: "3x3",
			n:    3,
			want: NewMatrix(3, 3, []float64{
				1, 0, 0,
				0, 1, 0,
				0, 0, 1,
			}),
		},
		{
			name: "4x4",
			n:    4,
			want: NewMatrix(4, 4, []float64{
				1, 0, 0, 0,
				0, 1, 0, 0,
				0, 0, 1, 0,
				0, 0, 0, 1,
			}),
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := NewIdentityMatrix(tt.n); !Eq(got, tt.want) {
				t.Errorf("NewIdentityMatrix() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestMatrix_Scale(t *testing.T) {
	a := NewMatrix(3, 2, []float64{
		1, 2,
		3, 4,
		5, 6,
	})
	a3 := NewMatrix(3, 2, []float64{
		3, 6,
		9, 12,
		15, 18,
	})
	z := NewZeroMatrix(3, 2)

	tests := []struct {
		name   string
		scalar float64
		m      *Matrix
		want   *Matrix
	}{
		{
			name:   "0 x A = 0",
			scalar: 0,
			m:      a,
			want:   NewZeroMatrix(3, 2),
		},
		{
			name:   "3 x zeroMatrix = zeroMatrix",
			scalar: 3,
			m:      z,
			want:   z,
		},
		{
			name:   "3 x A = 3A",
			scalar: 3,
			m:      a,
			want:   a3,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			m := tt.m
			s := tt.scalar
			if got := Scale(s, m); !Eq(got, tt.want) {
				t.Errorf("Scale() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestMul(t *testing.T) {
	type args struct {
		left  *Matrix
		right *Matrix
	}
	tests := []struct {
		name string
		args args
		want *Matrix
	}{
		{
			name: "3x2 x 2x3 -> 3x3",
			args: args{
				left: NewMatrix(3, 2, []float64{
					1, 2,
					3, 4,
					5, 6,
				}),
				right: NewMatrix(2, 3, []float64{
					1, 2, 3,
					4, 5, 6,
				}),
			},
			want: NewMatrix(3, 3, []float64{
				9, 12, 15,
				19, 26, 33,
				29, 40, 51,
			}),
		},
		{
			name: "2x3 x 3x2 -> 2x2",
			args: args{
				left: NewMatrix(2, 3, []float64{
					1, 2, 3,
					4, 5, 6,
				}),
				right: NewMatrix(3, 2, []float64{
					1, 2,
					3, 4,
					5, 6,
				}),
			},
			want: NewMatrix(2, 2, []float64{
				22, 28,
				49, 64,
			}),
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := Mul(tt.args.left, tt.args.right); !Eq(got, tt.want) {
				t.Errorf("Mul() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestAlgebricOperations1(t *testing.T) {
	a := NewMatrix(3, 2, []float64{
		1, 2,
		3, 4,
		5, 6,
	})

	b := NewMatrix(3, 2, []float64{
		2, 4,
		6, 8,
		10, 12,
	})
	// A + B = B + A
	if !Eq(Add(a, b), Add(b, a)) {
		t.Errorf("Add is not interchangable")
	}
}

func TestSelfInversedMatrix(t *testing.T) {
	m := NewMatrix(3, 3, []float64{
		0, 2, 6,
		-1, -3, -6,
		0.5, 1, 2,
	})
	m2 := Mul(m, m)
	e := NewIdentityMatrix(3)
	if !Eq(m2, e) {
		t.Errorf("M x M should be  E")
	}
}

func TestAlgebricOperations2(t *testing.T) {
	a := NewMatrix(3, 2, []float64{
		1, 2,
		3, 4,
		5, 6,
	})

	b := NewMatrix(2, 2, []float64{
		1, 2,
		3, 4,
	})
	c := NewMatrix(2, 2, []float64{
		1, 3,
		5, 7,
	})
	// BC != CB
	if Eq(Mul(b, c), Mul(c, b)) {
		t.Errorf("BC != CB shoud hold true")
	}

	// (AB)C = A(BC)
	if !Eq(Mul(Mul(a, b), c), Mul(a, Mul(b, c))) {
		t.Errorf("(AB)C = A(BC) should hold true")
	}

	f := NewMatrix(2, 1, []float64{
		1,
		2,
	})

	// (3x2) x (2x1) = 3x1
	af := Mul(a, f)
	af_r, af_c := af.GetSize()
	if af_r != 3 {
		t.Errorf("wrong rows size")
	}
	if af_c != 1 {
		t.Errorf("wrong columns size")
	}

	// A(B+C) = AB+AC
	if !Eq(Mul(a, Add(b, c)), Add(Mul(a, b), Mul(a, c))) {
		t.Errorf("A(B+C) = AB+AC should hold true")
	}

	// (B+C)F = BF+CF
	if !Eq(Mul(Add(b, c), f), Add(Mul(b, f), Mul(c, f))) {
		t.Errorf("(B+C)F = BF+CF should hold true")
	}

	s := 10.0 // scalar
	// (sA)B = A(sB)
	if !Eq(Mul(Scale(s, a), b), Mul(a, Scale(s, b))) {
		t.Errorf("(sA)B = A(sB) should hold true")
	}

	// A(sB) = s(AB)
	if !Eq(Mul(Scale(s, a), b), Scale(s, Mul(a, b))) {
		t.Errorf("A(sB) = s(AB) should hold true")
	}

	e2x2 := NewIdentityMatrix(2)
	// A x E = A
	if !Eq(Mul(a, e2x2), a) {
		t.Errorf("A x E = A should hold true")
	}
	// E x A = A
	e3x3 := NewIdentityMatrix(3)
	if !Eq(Mul(e3x3, a), a) {
		t.Errorf("E x A = A should hold true")
	}
}
