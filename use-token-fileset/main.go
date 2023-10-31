package main

import (
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"
)

func main() {
	test1()
	test2()
}

func test2() {
	fmt.Println("===== test2")
	fset := token.NewFileSet()

	files := []string{"./testdata/hello.go", "./testdata/foo.go"}
	for _, fname := range files {
		astFile, err := parser.ParseFile(fset, fname, nil, 0)
		if err != nil {
			panic(err)
		}
		fmt.Println("----")
		fmt.Printf("astFile.Package:%d (position=%s)\n", astFile.Package, fset.Position(astFile.Package))
		fmt.Printf("Scope:%#v\n", astFile.Scope.Objects["main"])
		fmt.Println("Decls ---")
		for _, decl := range astFile.Decls {
			fmt.Printf("  %#v\n", decl)
			funcDecl, isFunc := decl.(*ast.FuncDecl)
			if isFunc {
				for _, stmt := range funcDecl.Body.List {
					fmt.Printf("  stmt:%#v (%s)\n", stmt, fset.Position(stmt.Pos()))
				}
			}
		}
	}

}

// Trying this article
// https://abhinavg.net/2019/03/28/understanding-token-pos/
func test1() {
	fmt.Println("===== test1")
	fset := token.NewFileSet()
	fset.AddFile("1.go", -1, 10)      // base => 12
	fset.AddFile("2.go", -1, 15)      // base => 28
	fset.AddFile("3.go", -1, 5)       // base => 34
	fset.AddFile("4.go", -1, 16)      // base => 51
	fmt.Println("basse", fset.Base()) // 51
}
