# Go Conference Tokyo 2021

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


