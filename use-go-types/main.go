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
	var a = 1
	var b int8 = 2
	c := 'c'
	var d byte = 'd'
	var ifc interface{}
	var bol bool
	var ifc2, ifc3 interface{}
	ifc2, ifc3 = ifc.(int)
	x1, x2 := ifc.(int)
	var ptr *int
	ptr = nil
	ifc = 1
	a, b = 5,6
	//a, b = (7,8) // cannot compile. https://go.dev/play/p/gkfk0gH58Nn
	fmt.Println(a, b, c, d, bol, ifc2, ifc3, x1, x2, ptr)
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
		Types:  make(map[ast.Expr]types.TypeAndValue),
		Scopes: make(map[ast.Node]*types.Scope),
		Defs:   make(map[*ast.Ident]types.Object),
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
		fmt.Printf("%s:    obj: kind=%T, type=%s, Underlying=%s, String()='%s' \n",
			fset.Position(obj.Pos()), objType.String(), objType.Underlying().String(), obj.String())
	}

	fmt.Println("[Defs]")
	for ident, obj := range info.Defs {
		if obj == nil {
			continue // package declaration ?
		}
		fmt.Printf("%s  def:%s\n", fset.Position(obj.Pos()), ident)
		fmt.Printf("    obj: kind=%T, String()='%s' \n",
			obj, obj.String())
	}

	fmt.Println("[Inspecting local ast nodes]")
	var inF bool
	var inLocal bool
	ast.Inspect(f, func(n ast.Node) bool {
		if n == nil {
			return true
		}
		if fdcl, isF := n.(*ast.FuncDecl); isF {
			fmt.Println("FuncDecl found :", fdcl.Name.Name)
			inF = true
			return true
		}
		if _, isBlockStmt := n.(*ast.BlockStmt); inF && isBlockStmt {
			inLocal = true
			return true
		}
		if inLocal {
			fmt.Printf("%s: node=%T %s\n", fset.Position(n.Pos()), n, n)
			if expr, isExpr := n.(ast.Expr); isExpr {
				tv := info.Types[expr]
				fmt.Printf("    TypeAndValue:type=%T \"%s\", value=%s\n", tv.Type, tv.Type, tv.Value)
			}
		}
		return true
	})
}
