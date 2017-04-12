package main

import "fmt"

func main() {
	var i interface{}
	describe(i)

	i = 42
	describe(i)
	i = "hello"
	describe(i)
}

func describe(x interface{}) {
	fmt.Printf("%v %T\n", x, x)
}
