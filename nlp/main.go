package main

import (
	"fmt"
	"io/ioutil"
)
// Take a English text from stdin, and analyze it
// Usage: go run nlp/main.go < ,/english.txt

func getText() []byte {
	bytes, err := ioutil.ReadFile("/dev/stdin")
	if err != nil {
		panic(err)
	}
	return bytes
}

func main() {
	bytes := getText()
	fmt.Printf("%s", bytes)
}
