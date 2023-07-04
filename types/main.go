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

const code = `package main
import "fmt"

type MyInt int
type MyMyInt MyInt
var i MyMyInt = 1
var x = 123
var s = "abc"
var ch = 'a' 

func main() {
	var i1 = 456
	i2 := 789
	fmt.Println(i1, i2)
}`

func main() {
	fset := token.NewFileSet()

	// Parse the input string, []byte, or io.Reader,
	// recording position information in fset.
	// ParseFile returns an *ast.File, a syntax tree.
	f, err := parser.ParseFile(fset, "code.go", code, 0)
	if err != nil {
		log.Fatal(err) // parse error
	}

	// A Config controls various options of the type checker.
	// The defaults work fine except for one setting:
	// we must specify how to deal with imports.
	conf := types.Config{Importer: importer.Default()}

	// Type-check the package containing only file f.
	// Check returns a *types.Package.
	info := types.Info{
		Scopes: make(map[ast.Node]*types.Scope),
	}
	pkg, err := conf.Check("pseudo", fset, []*ast.File{f}, &info)
	if err != nil {
		log.Fatal(err) // type error
	}

	fmt.Printf("Package.Path()  %q\n", pkg.Path())
	fmt.Printf("Package.Name():    %s\n", pkg.Name())
	fmt.Printf("Package.Imports(): %s\n", pkg.Imports())
	fmt.Printf("Package,Scope():   %s\n", pkg.Scope())

	fmt.Println("[Names in the package scope]")
	for i, name := range pkg.Scope().Names() {
		fmt.Printf("  %d:  name=%s\n", i, name)
		obj := pkg.Scope().Lookup(name)
		objType := obj.Type()
		fmt.Printf("    obj: kind=%T, type=%s, Underlying=%s, String()='%s' \n",
			obj, objType.String(), objType.Underlying().String(), obj.String())
	}

	fmt.Println("[Looking into local scopes]")
	for node, scope := range info.Scopes {
		if _, isFunc := node.(*ast.FuncType); isFunc {
			fmt.Printf("%s: node=%T, scope=%s\n", node.Pos(), node, scope)
		}
	}
}
