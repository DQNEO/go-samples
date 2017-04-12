package main

import "fmt"

func main() {
	var i interface{}
	v := i.(type) // this is impossible out side of switch
	fmt.Printf("%v %T\n", v,v)
}
