package main

import (
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"
)

func main() {
	ts := token.FileSet{}
	astFile, err := parser.ParseFile(&ts, "./hello.go", nil, parser.AllErrors)
	if err != nil {
		panic(err)
	}
	fmt.Println("# ---------")
	emitRuntime()

	for _, decl := range astFile.Decls {
		switch decl.(type) {
		case *ast.GenDecl:
			continue
		case *ast.FuncDecl:
			funcDecl := decl.(*ast.FuncDecl)
			fmt.Printf("# func %s\n", funcDecl.Name)
			for _, stmt := range funcDecl.Body.List {
				switch stmt.(type) {
				case *ast.ExprStmt:
					expr := stmt.(*ast.ExprStmt).X
					switch expr.(type) {
					case *ast.CallExpr:
						call := expr.(*ast.CallExpr)
						fn := call.Fun
						var fcall *Funcall = &Funcall{}
						switch fn.(type) {
						case *ast.SelectorExpr:
							selector := fn.(*ast.SelectorExpr)
							symbol := fmt.Sprintf("%s.%s", selector.X, selector.Sel)
							fmt.Printf("# symbol=%s\n", symbol)
							fcall.symbol = symbol
						default:
							panic("Unexpected fun type")
						}
						arg := call.Args[0] // assume args have only one element
						switch arg.(type) {
						case *ast.BasicLit:
							fcall.arg = arg.(*ast.BasicLit).Value
							fmt.Printf("# arg=%s\n", fcall.arg)
						default:
							panic("Unexpected type")
						}
						emitFuncall(fcall)
					default:
						panic("Unexpected expr type")
					}
				default:
					panic("Unexpected stmt type")
				}
			}
		default:
			panic("unexpected decl type")
		}
	}
}

func emitRuntime() {
	fmt.Printf(".text\n")
	fmt.Printf("fmt.Print:\n")
	fmt.Printf("  movq %%rdi, %%rax # arg1:buf\n")
	fmt.Printf("  movq %%rsi, %%rcx # arg2:len\n")
	fmt.Printf("  movq $1, %%rdi # stdout\n")
	fmt.Printf("  movq %%rax, %%rsi # buf\n")
	fmt.Printf("  movq %%rcx, %%rdx # len\n")
	fmt.Printf("  movq $1, %%rax # sys_write\n")
	fmt.Printf("  syscall\n")
	fmt.Printf("  ret\n")
	fmt.Printf(".text\n")
	fmt.Printf("  .global _start\n")
	fmt.Printf("_start:\n")
	fmt.Printf("  call main.main\n")
	fmt.Printf("  movq $60, %%rax # sys_exit\n")
	fmt.Printf("  movq $0, %%rdi\n")
	fmt.Printf("  syscall\n")
	fmt.Printf("  \n")
}

func emitFuncall(fcall *Funcall) {
	fmt.Printf(".data\n")
	fmt.Printf(".S1:\n")
	fmt.Printf("  .string %s\n", fcall.arg)
	fmt.Printf(".text\n")
	fmt.Printf("main.main:\n")
	fmt.Printf("  leaq .S1, %%rdi # arg1 \n")
	fmt.Printf("  movq $%d, %%rsi # arg2 \n", len(fcall.arg) -  2)
	fmt.Printf("  call %s\n", fcall.symbol)
	fmt.Printf("  ret\n")
}

type Funcall struct {
	symbol string
	arg string
}
