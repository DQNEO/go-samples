package main

import "fmt"

func foo() {
	x := 1 + 2
	y := &x
	*y++
	fmt.Println(*y)
}
