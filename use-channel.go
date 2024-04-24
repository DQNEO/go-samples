package main

var n = 3

func mySend(c chan int, n int) {
	c <- n // send n to c
}

func myReceive(c chan int) int {
	n := <-c // receive n from c
	return n
}

func emptyReceive(ch chan struct{}) {
	println("start emptyReceive")
	//x := <-ch
	<-ch
	println("end emptyReceive")
}

func main() {
	ch := make(chan struct{})
	go emptyReceive(ch)
	//time.Sleep(time.Second * 2)
	ch <- struct{}{}
	//time.Sleep(time.Second * 2)
	println("end program")
	return
	c := make(chan int)
	go mySend(c, 3)
	go mySend(c, 5)
	var n int
	n = myReceive(c)
	println(n)
	n = myReceive(c)
	println(n)
}
