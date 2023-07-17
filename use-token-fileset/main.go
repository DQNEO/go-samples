package main

import (
	"fmt"
	"go/token"
)

func main() {
	test1()
}

// Trying this article
// https://abhinavg.net/2019/03/28/understanding-token-pos/
func test1() {
	fset := token.NewFileSet()
	fset.AddFile("1.go", -1, 10)      // base => 12
	fset.AddFile("2.go", -1, 15)      // base => 28
	fset.AddFile("3.go", -1, 5)       // base => 34
	fset.AddFile("4.go", -1, 16)      // base => 51
	fmt.Println("basse", fset.Base()) // 51
}
