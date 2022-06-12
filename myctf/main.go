package main

import "fmt"

var MyFlag bool = true

func fail() {
	panic("FAIL")
}

func ok() {
	fmt.Print("OK\n")
}

func main() {
	fmt.Print("hello\n")
	if MyFlag {
		fail()
	} else {
		ok()
	}
}
