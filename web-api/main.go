package main

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"net/url"
	"strings"
	"time"
)

var handler http.HandlerFunc = func(w http.ResponseWriter, r *http.Request) {
	log.Printf("[hanler] path=%s\n", r.RequestURI)
	time.Sleep(time.Second * 3)
	w.Write([]byte("Hi there, Now it's  " + time.Now().String() + "!\n"))
}

const port = "8080"
const addr = ":" + port

type serverResponse struct {
	w *bufio.Writer
}

var _ http.ResponseWriter = &responseWriter{}
type responseWriter struct {
	statusCode int
	buf []byte
	w io.Writer
}

func (rw *responseWriter) Header() http.Header {
	panic("implement me")
}

func (rw *responseWriter) Write(b []byte) (int, error) {
	rw.buf = b
	return len(b), nil
}

func (rw *responseWriter) WriteHeader(statusCode int) {
	rw.statusCode = statusCode
}

func main() {
	mux := &http.ServeMux{}
	mux.Handle("/", handler)
	mux.Handle("/hello", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("[hanler] path=%s\n", r.RequestURI)
		w.WriteHeader(200)
		w.Write([]byte("This is a static 'hello' page\n"))
	}))

	log.Printf("access http://localhost:%s/ from any client", port)
	lc := net.ListenConfig{}
	ctx := context.Background()
	listener, err := lc.Listen(ctx,"tcp", addr)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("listener is created %v\n", listener)
	//err = server.Serve(listener)
	for {
		log.Printf("Accepting...\n")
		rwc, err := listener.Accept()
		if err != nil {
			panic(err)
		}
		go connServe(rwc, mux)
	}
	log.Fatal(err)
}

func connServe(c net.Conn, mux *http.ServeMux) {
	var rbuf []byte = make([]byte, 1024)
	n, err := c.Read(rbuf)
	if err != nil {
		panic(err)
	}
	_ = n
	var line []byte
	for i:=0;i<len(rbuf);i++ {
		if rbuf[i] == '\n' {
			line = rbuf[0:i]
			break
		}
	}
	// line = "GET /foo3 HTTP/1.1"
	parts := strings.Split(string(line), " ")
	method, path, ver := parts[0],parts[1], parts[2]
	log.Println("FirstLine=" + string(line))
	log.Printf("method=%s, path=%s, ver=%s\n", method, path, ver)
	req := http.Request{
		URL: &url.URL{Path: path},
	}
	w := &responseWriter{w: c}
	h, _ := mux.Handler(&req)
	h.ServeHTTP(w, &req)
	w.w.Write([]byte(fmt.Sprintf("HTTP/1.1 %d OK\n", w.statusCode)))
	w.w.Write([]byte("Content-Type: text/plain\n"))
	w.w.Write([]byte(fmt.Sprintf("Content-Length: %d\n", len(w.buf))))
	w.w.Write([]byte("\n"))
	w.w.Write(w.buf)
	c.Close()
}
