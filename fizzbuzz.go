package main

import "fmt"

func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        if (i % 3 ) == 0 && (i % 5) == 0 {
            fmt.Println("fizz buzz")
        } else if (i % 3 ) == 0 {
            fmt.Println("fizz")
        } else if (i % 5) == 0 {
            fmt.Println("buzz")
        } else {
            fmt.Println(i)
        }
    }
}
