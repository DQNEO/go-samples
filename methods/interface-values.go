package main

import (
	"fmt"
	"math"
)


type I interface {
	M()
}

type S struct {
	s string
}

func (s *S) M() {
	fmt.Println(s)
}

type F float64

func (f F) M() {
	fmt.Println(f)
}

func main() {
	var i I
	i = &S{"hello"}
	i.M()
	describe(i)

	i = F(math.Pi)
	i.M()
	describe(i)
}

func describe(x I) {
	fmt.Printf("([%v] [%T]\n", x, x)
}
