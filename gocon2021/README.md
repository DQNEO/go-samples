# Learn how Hello-world works in low level. (Go Conference Tokyo 2021)

Get the docker image

```
docker pull dqneo/ubuntu-build-essential:go
```

Run a docker container

```
$ ./docker-run
```

In the docker container, build the "hello" binary

```
# cat hello.go
package main

import "fmt"

func main() {
        fmt.Print("Hello world\n")
}

# go build -o hello hello.go
# ./hello
Hello world
```

Use strace
```
# strace ./hello >/dev/null
```

Use gdb
```
# gdb ./hello

> catch syscall write
> run
```


