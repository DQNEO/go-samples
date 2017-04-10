package main

import "github.com/DQNEO/go-samples/fizzbuzz/entity"

import "fmt"

const FIZZ_BUZZ string  = "FizzBuzz"

func fizzable(i int) bool {
	return (i % 3) == 0
}

func buzzable(i int) bool {
	return (i % 5) == 0
}


func logic(i int) entity.Stringable {
    if (fizzable(i) && buzzable(i)) {
        return entity.MyString{Data:FIZZ_BUZZ}
    } else if fizzable(i) {
        return entity.FIZZ_ENTITY
    } else if buzzable(i) {
        return entity.BUZZ_ENTITY
    } else {
        return entity.MyInt{Data:i}
    }
}

func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        s := logic(i)
        fmt.Println(s.String())
    }
}


