package matrix

import (
	"testing"
)

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
				a: NewMatrix(3, 2, []int{
					1, 2,
					3, 4,
					5, 6,
				}),
				b: NewMatrixFromSlices(3, 2, [][]int{
					{1, 3, 5}, {2, 4, 6},
				}),
			},
			want: true,
		},
		{
			name: "not equal",
			args: args{
				a: NewMatrix(3, 2, []int{
					1, 2,
					3, 4,
					5, 6,
				}),
				b: NewMatrixFromSlices(3, 2, [][]int{
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

func TestNewMatrix(t *testing.T) {
	m1 := NewMatrix(2, 3, []int{
		1, 2,
		3, 4,
		5, 6,
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

func TestMatrix_Tr(t *testing.T) {
	tests := []struct {
		name  string
		input *Matrix
		want  *Matrix
	}{
		{
			name:  "1x2 -> 2x1",
			input: NewMatrix(1, 2, []int{1, 2}),
			want:  NewMatrix(2, 1, []int{1, 2}),
		},
		{
			name: "3x2 -> 2x3",
			input: NewMatrixFromSlices(3, 2, [][]int{
				{1, 3, 5}, {2, 4, 6},
			}),
			want: NewMatrixFromSlices(2, 3, [][]int{
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
			want: NewMatrix(1, 1, []int{1}),
		},
		{
			name: "2x2",
			n:    2,
			want: NewMatrix(2, 2, []int{
				1, 0,
				0, 1,
			}),
		},
		{
			name: "3x3",
			n:    3,
			want: NewMatrix(3, 3, []int{
				1, 0, 0,
				0, 1, 0,
				0, 0, 1,
			}),
		},
		{
			name: "4x4",
			n:    4,
			want: NewMatrix(4, 4, []int{
				1, 0, 0, 0,
				0, 1, 0, 0,
				0, 0, 1, 0,
				0, 0, 0, 1,
			}),
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := MatrixOne(tt.n); !Eq(got, tt.want) {
				t.Errorf("MatrixOne() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestAlgebricOperations(t *testing.T) {
	a := NewMatrix(3, 2, []int{
		1, 2,
		3, 4,
		5, 6,
	})

	b := NewMatrix(3, 2, []int{
		2, 4,
		6, 8,
		10, 12,
	})
	// A + B = B + A
	if !Eq(Add(a, b), Add(b, a)) {
		t.Errorf("Add is not interchangable")
	}

	c := NewMatrix(2, 2, []int{
		1, 2,
		3, 4,
	})
	d := NewMatrix(2, 2, []int{
		1, 3,
		5, 7,
	})
	if Eq(Mul(c, d), Mul(d, c)) {
		t.Errorf("C x D must not equal to D x C")
	}
	e2x2 := MatrixOne(2)
	// C x E = C
	if !Eq(Mul(c, e2x2), c) {
		t.Errorf("C x E should equal to C")
	}
	// E x C = C
	if !Eq(Mul(e2x2, c), c) {
		t.Errorf("E x C should equal to C")
	}

}
