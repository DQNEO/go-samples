package main

import (
	"fmt"
	"testing"
)

func Test_f(t *testing.T) {
	tests := []struct {
		name string
		arg  int
		want int
	}{
		{"a", 1, 1},
		{"b", 2, 2},
		{"c", 3, 3},
	}
	for _, tt := range tests {
		//tt := tt
		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()
			got := f(tt.arg)
			if got != tt.want {
				t.Errorf("f() = %v, want %v", got, tt.want)
			}
			fmt.Printf("got=%+v\n", got)
		})
	}
}
