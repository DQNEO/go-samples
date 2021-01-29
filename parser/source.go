package main

import "fmt"
import "os"

func main() {
	fmt.Print("hello world\n")
	fmt.Print("This program exits with status code 42\n")
	os.Exit(42)
}
