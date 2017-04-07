package main

import "fmt"

type Vertex struct {
    X,Y int
}

func main() {
    a := Vertex{1,2}
    b := Vertex{}
    c := Vertex{Y:2, X:3}
    d := Vertex{X:1}
    p := &Vertex{1,2}
    fmt.Println(a,b,c, d, p)
}
