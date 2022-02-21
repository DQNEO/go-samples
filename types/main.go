package main

import (
	"fmt"
	"go/ast"
	"go/importer"
	"go/parser"
	"go/token"
	"go/types"
	"log"
)

const hello = `package main

import "fmt"

type MyInt int
type MyMyInt MyInt
var i MyMyInt = 1
var x = 123
var s = "abc"

func main() {
        fmt.Println(i)
}`

func main() {
	fset := token.NewFileSet()

	// Parse the input string, []byte, or io.Reader,
	// recording position information in fset.
	// ParseFile returns an *ast.File, a syntax tree.
	f, err := parser.ParseFile(fset, "hello.go", hello, 0)
	if err != nil {
		log.Fatal(err) // parse error
	}

	// A Config controls various options of the type checker.
	// The defaults work fine except for one setting:
	// we must specify how to deal with imports.
	conf := types.Config{Importer: importer.Default()}

	// Type-check the package containing only file f.
	// Check returns a *types.Package.
	pkg, err := conf.Check("cmd/hello", fset, []*ast.File{f}, nil)
	if err != nil {
		log.Fatal(err) // type error
	}

	fmt.Printf("Package.Path()  %q\n", pkg.Path())
	fmt.Printf("Package.Name():    %s\n", pkg.Name())
	fmt.Printf("Package.Imports(): %s\n", pkg.Imports())
	fmt.Printf("Package,Scope():   %s\n", pkg.Scope())

	fmt.Println("[Iterating Names]")
	for i, name := range pkg.Scope().Names() {
		fmt.Printf("  %d:  name=%s\n", i, name)
		obj := pkg.Scope().Lookup(name)
		objType := obj.Type()
		fmt.Printf("    obj: kind=%T, name=%s, String()='%s' type=%s, Underlying=%s\n",
			obj, obj.Name(), obj.String(), objType.String(), objType.Underlying().String())
	}
}
