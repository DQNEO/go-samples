package main

import "fmt"

type Vertex struct {
    X int
    Y int
}

func main() {
    v := Vertex{1,2}
    p := &v
    p.Y = 3
    fmt.Println(v)
}
