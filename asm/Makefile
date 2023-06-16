main: ./testdata/*
	GO111MODULE=off go build -x -a -o main ./testdata

sum.o:
	/usr/local/opt/go/libexec/pkg/tool/darwin_amd64/asm -p main -I /usr/local/opt/go/libexec/pkg/include -D GOOS_darwin -D GOARCH_amd64 -D GOAMD64_v1 -o sum.o testdata/sum.s
