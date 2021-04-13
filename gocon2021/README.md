# Learn how Hello-world works in low level. (Go Conference Tokyo 2021)

Get the docker image

```
docker pull dqneo/ubuntu-build-essential:go
```

Run a docker container

```
$ ./docker-run
```

In the docker container, 
```
$ go build -o min min.go
$ go build -o hello hello.go
```

Use strace
```
$ strace ./hello >/dev/null
```

Use gdb
```
$ gdb ./hello

> catch syscall write
> run
```


