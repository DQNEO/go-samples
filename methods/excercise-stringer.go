package main

import "fmt"

type IPADDR [4]byte

func (ip IPADDR) String() string {
	return fmt.Sprintf("%d.%d.%d.%d", ip[0], ip[1], ip[2], ip[3])
}

func main() {
	ipmap := map[string]IPADDR{
		"loopback" : IPADDR{127,0,0,1},
		"google" : IPADDR{8,8,8,8},
	}

	for k,v := range(ipmap) {
		fmt.Printf("%s => %d.%d.%d.%d\n", k, v[0], v[1], v[2], v[3])
	}

	fmt.Println("=====")
	for k,v := range(ipmap) {
		fmt.Printf("%s => %s\n", k, v)
	}
}

