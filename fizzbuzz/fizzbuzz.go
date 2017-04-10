package main

import "github.com/DQNEO/go-samples/fizzbuzz/logic"
import "fmt"


func main() {
    var start,end int = 1,15
    for i := start; i <= end ; i++ {
        s := logic.Logic(i)
        fmt.Println(s.String())
    }
}


