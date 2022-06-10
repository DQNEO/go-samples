package main

import "fmt"

var MyFlag bool = true

func main() {
mylabel:
	fmt.Print("hello\n")
	if MyFlag {
		goto mylabel
	}
}
