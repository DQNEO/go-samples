main: ./testdata/*
	GO111MODULE=off go build -x -work -o main ./testdata  2>./log/go-build-x.log

run: main
	./main

sum.o: testdata/sum.s
	$(GOROOT)/pkg/tool/darwin_amd64/asm -p main -I /usr/local/opt/go/libexec/pkg/include -D GOOS_darwin -D GOARCH_amd64 -D GOAMD64_v1 -o $@ $<


myfunc.o: testdata/myfunc.s
	$(GOROOT)/pkg/tool/darwin_amd64/asm -p main -I /usr/local/opt/go/libexec/pkg/include -D GOOS_darwin -D GOARCH_amd64 -D GOAMD64_v1 -o $@ $<

exp:
	echo $(GOROOT)

clean:
	rm myfunc.o sum.o main