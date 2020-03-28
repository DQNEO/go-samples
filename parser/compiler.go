package main

import (
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"
)

func main() {
	ts := token.FileSet{}
	astFile, err := parser.ParseFile(&ts, "./source.go", nil, parser.AllErrors)
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
			emitFuncDecl(funcDecl)
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


func emitFuncDecl(funcDecl *ast.FuncDecl) {
	var strings []string
	var stmts []*Stmt
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
					symbol := fmt.Sprintf("%s.%s", selector.X, selector.Sel) // fmt.Print
					fmt.Printf("# symbol=%s\n", symbol)
					fcall.symbol = symbol
				default:
					panic("Unexpected fun type")
				}
				arg := call.Args[0] // assume args have only one element
				switch arg.(type) {
				case *ast.BasicLit:
					s := arg.(*ast.BasicLit).Value
					strings = append(strings, s)
					fcall.arg = &StringLiteral{
						index: len(strings) - 1,
						val:   s,
					}
					fmt.Printf("# arg=%s\n", fcall.arg) // "hello world"
					stmts = append(stmts, &Stmt{
						funcall:fcall,
					})
				default:
					panic("Unexpected type")
				}
			default:
				panic("Unexpected expr type")
			}
		default:
			panic("Unexpected stmt type")
		}
	}

	fmt.Printf(".data\n")
	for i, s := range strings {
		fmt.Printf(".S%d:\n", i)
		fmt.Printf("  .string %s\n", s)
	}

	fmt.Printf(".text\n")
	fmt.Printf("main.%s:\n", funcDecl.Name)

	for _, stmt := range stmts {
		fcall := stmt.funcall
		fmt.Printf("  leaq .S%d, %%rdi # arg1 \n", fcall.arg.index)
		fmt.Printf("  movq $%d, %%rsi # arg2 \n", len(fcall.arg.val)-2)
		fmt.Printf("  call %s\n", fcall.symbol)
	}

	fmt.Printf("  ret\n")
}

type Stmt struct {
	funcall *Funcall
}

type StringLiteral struct {
	index int
	val string
}

type Funcall struct {
	symbol string
	arg    *StringLiteral
}
