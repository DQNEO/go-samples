package main

import (
	"fmt"
	"runtime"
)

func main() {
	s := sum(10, 32)
	fmt.Println("hello world", s, runtime.Version())
}
