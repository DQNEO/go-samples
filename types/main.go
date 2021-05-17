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

type MyInt int
type MyMyInt MyInt
var i MyMyInt = 1
func main() {
        println(i)
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

	fmt.Printf("Package  %q\n", pkg.Path())
	fmt.Printf("Name:    %s\n", pkg.Name())
	fmt.Printf("Imports: %s\n", pkg.Imports())
	fmt.Printf("Scope:   %s\n", pkg.Scope())

	scope := pkg.Scope()
	for _, name := range scope.Names() {
		fmt.Printf("  name=%s\n", name)
	}

	obj := pkg.Scope().Lookup("i")
	fmt.Printf("i: name=%s, type=%s\n", obj.Name(), obj.Type())
	typeOfI := obj.Type()
	fmt.Printf("type=%s, Underlying=%s\n", typeOfI.String(), typeOfI.Underlying().String())
}
