package main

import "fmt"

func main() {

mylabel:
	fmt.Print("hello\n")
	goto mylabel
}
