package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"net/http"
)

var handler http.HandlerFunc = func(w http.ResponseWriter, r *http.Request) {
	log.Printf("[hanler] path=%s\n", r.RequestURI)
	fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
}

const port = "8080"
const addr = ":" + port

func main() {
	mux := &http.ServeMux{}
	mux.Handle("/", handler)
	mux.Handle("/hello", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("[hanler] path=%s\n", r.RequestURI)
		w.Write([]byte("This is a static 'hello' page\n"))
	}))

	log.Printf("access http://localhost:%s/ from any client", port)
	server := http.Server{
		Addr: addr,
		Handler: mux,
	}
	lc := net.ListenConfig{}
	ctx := context.Background()
	listener, err := lc.Listen(ctx,"tcp", addr)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("listener is created %v\n", listener)
	err = server.Serve(listener)
	log.Fatal(err)
}
