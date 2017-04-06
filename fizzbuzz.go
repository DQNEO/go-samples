package main

import "fmt"
import "strconv"

func logick(i int) string {
    if (i % 3 ) == 0 && (i % 5) == 0 {
        return "fizz buzz"
    } else if (i % 3 ) == 0 {
        return "fizz"
    } else if (i % 5) == 0 {
        return "buzz"
    } else {
        return strconv.Itoa(i)
    }
}

func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        s := logick(i)
        fmt.Println(s)
    }
}
