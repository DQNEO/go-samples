package main

import "fmt"

type Vertex struct {
	X, Y float64
}

func (v *Vertex) Scale(f float64) {
	v.X = f * v.X
	v.Y = f * v.Y
}

func Scalefunc(v *Vertex, f float64) {
	v.X = f * v.X
	v.Y = f * v.Y
}
func main() {
	v := Vertex{2,3}
	v.Scale(2)
	Scalefunc(&v, 3)

	fmt.Println(v)

	p := &Vertex{2,3}
	p.Scale(2)
	Scalefunc(p,3)

	fmt.Println(*p)
}
