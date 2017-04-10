package main

import "fmt"
import "strconv"

const FIZZ_BUZZ string  = "FizzBuzz"
const FIZZ string = "FIZZ"
const BUZZ string = "BUZZ"

func logic(i int) string {
    if (i % 3 ) == 0 && (i % 5) == 0 {
        return FIZZ_BUZZ
    } else if (i % 3 ) == 0 {
        return FIZZ
    } else if (i % 5) == 0 {
        return BUZZ
    } else {
        return strconv.Itoa(i)
    }
}

func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        s := logic(i)
        fmt.Println(s)
    }
}
