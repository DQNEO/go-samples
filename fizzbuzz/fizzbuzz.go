package main

import "fmt"
import "strconv"

const FIZZ_BUZZ string  = "FizzBuzz"
const FIZZ string = "FIZZ"
const BUZZ string = "BUZZ"

type MyInt struct {
    data int
}

func (myInt MyInt) String() string {
	return strconv.Itoa(myInt.data)
}


type MyString struct {
	data string
}

func (myString MyString) String() string {
	return myString.data;
}

type Stringable interface {
	String() string
}

func fizzable(i int) bool {
	return (i % 3) == 0
}

func buzzable(i int) bool {
	return (i % 5) == 0
}

func logic(i int) Stringable {
    if (fizzable(i) && buzzable(i)) {
        return MyString{data:FIZZ_BUZZ}
    } else if fizzable(i) {
        return MyString{data:FIZZ}
    } else if buzzable(i) {
        return MyString{data:BUZZ}
    } else {
        return MyInt{data:i}
    }
}

func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        s := logic(i)
        fmt.Println(s.String())
    }
}
