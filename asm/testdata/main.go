package main

func myfunc() int

func sum64(a int, b int) int
func sum32(a int32, b int32) int32
func sum16(a int16, b int16) int16
func sum8(a int8, b int8) int8

func main() {
	println(myfunc())
	return
	println(sum64(1, 2))
	println(sum32(2, 3))
	println(sum16(3, 4))
	println(sum8(4, 5))
}
