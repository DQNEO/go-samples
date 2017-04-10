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

func logic(i int) string {
    if (i % 3 ) == 0 && (i % 5) == 0 {
        return MyString{data:FIZZ_BUZZ}.String()
    } else if (i % 3 ) == 0 {
        return MyString{data:FIZZ}.String()
    } else if (i % 5) == 0 {
        return MyString{data:BUZZ}.String()
    } else {
        return MyInt{data:i}.String()
    }
}

func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        s := logic(i)
        fmt.Println(s)
    }
}
