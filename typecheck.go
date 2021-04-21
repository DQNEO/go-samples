package main

import (
	"bytes"
	"fmt"
	"go/ast"
	"go/parser"
	"go/token"
	"go/types"
)

func main() {
	fset := token.NewFileSet()
	expr, err := parser.ParseExprFrom(fset, "my.go", `var x interface{} = nil`, 0)
	if err != nil {
		/* エラー処理 */
		panic(err)
	}

	info := &types.Info{
		Types: map[ast.Expr]types.TypeAndValue{},
	}
	err = types.CheckExpr(fset, nil, token.NoPos, expr, info)
	if err != nil {
		/* エラー処理 */
		panic(err)
	}

	for expr, tv := range info.Types {
		var buf bytes.Buffer
		types.WriteExpr(&buf, expr)
		fmt.Println(&buf, ":", tv.Type, tv.Value)
	}
}
