package main

import (
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
	log.Printf("[hanler] path=%s\n", r.URL.Path)
	time.Sleep(time.Second * 3)
	w.Write([]byte("Hi there, "))
	w.Write([]byte("Now it's  " + time.Now().String() + "!\n"))
}

const port = "8080"
const addr = ":" + port

var _ http.ResponseWriter = &responseWriter{}
type responseWriter struct {
	statusCode int
	buf        []byte
	conn       io.WriteCloser
}

func (rw *responseWriter) Header() http.Header {
	panic("implement me")
}

func (rw *responseWriter) Write(b []byte) (int, error) {
	rw.buf = append(rw.buf, b...)
	return len(b), nil
}

func (rw *responseWriter) WriteHeader(statusCode int) {
	rw.statusCode = statusCode
}


func main() {
	mux := &http.ServeMux{}
	mux.Handle("/", handler)
	mux.Handle("/hello", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("[hanler] path=%s\n", r.URL.Path)
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
	w := &responseWriter{conn: c}
	h, _ := mux.Handler(&req)
	h.ServeHTTP(w, &req)
	w.finishRequest()
}

func (w *responseWriter) finishRequest() {
	w.conn.Write([]byte(fmt.Sprintf("HTTP/1.1 %d OK\n", w.statusCode)))
	w.conn.Write([]byte("Content-Type: text/plain\n"))
	w.conn.Write([]byte(fmt.Sprintf("Content-Length: %d\n", len(w.buf))))
	w.conn.Write([]byte("\n"))
	w.conn.Write(w.buf)
	w.conn.Close()
}
