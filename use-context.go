package main

import (
	"context"
	"fmt"
	"time"
)

// 5秒かかる処理
func heavyFunc(ctx context.Context) {
	time.Sleep(5 * time.Second)
}

func main() {
	ctx := context.Background()
	ctx, cancel := context.WithTimeout(ctx, time.Second*10) // 1秒後にキャンセル

	go heavyFunc(ctx)
	go heavyFunc(ctx)

	cancel()
	select {
	case <-ctx.Done(): // 1秒以上かかると Done() がcloseされる
		fmt.Println("done:", ctx.Err()) // done: context deadline exceeded
	}
}
