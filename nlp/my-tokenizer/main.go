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

func tokenize(bytes []byte) []string {
	var tokens []string
	var token []byte
	var isInWord bool
	for _, b := range bytes {
		switch b {
		case ' ', '\n', '.', '"', ',' , '\'', '?', '!', '(', ')':
			if !isInWord {
				continue
			}
			tokens = append(tokens, string(token))
			token = nil
			isInWord = false
		default:
			isInWord = true
			byte := b
			if 'A' <= b && b <= 'Z' {
				byte = b - 'A' + 'a'
			}
			token = append(token, byte)
		}
	}

	return tokens
}

func printTokens(tokens []string) {
	for _, tok := range tokens {
		fmt.Printf("%s\n", tok)
	}
}

func main() {
	bytes := getText()
	tokens := tokenize(bytes)
	fmt.Printf("number of tokens: %d\n", len(tokens))
	printTokens(tokens)
}
