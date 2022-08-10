package main

import (
	"fmt"
	"os"
)
import "github.com/mmcdole/gofeed"

func main() {
	fp := gofeed.NewParser()
	feed, _ := fp.Parse(os.Stdin)
	fmt.Printf("%#v\n", feed)
}
