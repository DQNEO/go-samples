# a minimal go compiler for hello world

## Characteristics
* Make the most use of go/* pakcages
* Emit x86-64 assembly
* No dependency to libc

## Usage

```
$ docker run -it --rm -w /mnt -v `pwd`:/mnt dqneo/ubuntu-build-essential:go bash
# go run compiler.go > a.s
# as -o a.o a.s && ld a.o && ./a.out
hello world
```
