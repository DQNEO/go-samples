package main

import (
	"fmt"
	"go/parser"
	"go/token"
)

func main() {
	ts := token.FileSet{}
	astFile, err := parser.ParseFile(&ts, "./hello.go", nil, parser.Trace)
	if err != nil {
		panic(err)
	}
	fmt.Println("---------")
	fmt.Printf("%v", astFile)
}
