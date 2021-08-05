package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	log.Printf("[hanler] path=%s\n", r.RequestURI)
	fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

const port = "8080"
const addr = ":" + port

func main() {
	http.DefaultServeMux.HandleFunc("/", handler)
	http.DefaultServeMux.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		log.Printf("[hanler] path=%s\n", r.RequestURI)
		w.Write([]byte("This is a static 'hello' page\n"))
	})
	log.Printf("access http://localhost:%s/ from any client", port)
	server := http.Server{
		Addr: addr,
	}
	listener, err := net.Listen("tcp", addr)
	if err != nil {
		log.Fatal(err)
	}
	err = server.Serve(listener)
	log.Fatal(err)
}
