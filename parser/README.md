# a minimal go compiler making the most use of go/parser

## Usage

```
$ docker run -it --rm -w /mnt -v `pwd`:/mnt dqneo/ubuntu-build-essential:go bash
# go run compiler.go > a.s
# as -o a.o a.s && ld a.o && ./a.out
hello world
```
