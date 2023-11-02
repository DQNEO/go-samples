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
