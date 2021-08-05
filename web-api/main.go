package main

import (
	"fmt"
	"log"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

const port = "8080"
const addr = ":" + port

func main() {
	http.DefaultServeMux.HandleFunc("/", handler)
	http.DefaultServeMux.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello\n"))
	})
	log.Printf("access http://localhost:%s/ from any client", port)
	server := http.Server{
		Addr: addr,
	}
	err := server.ListenAndServe()
	log.Fatal(err)
}
