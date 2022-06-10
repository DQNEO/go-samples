Build for debug

```
go build -gcflags '-N -l' -o main main.go
```

Disassemble

```
objdump --disassemble main > objdump.txt
```

Binary editing

```
# Dump
xxd -g 1 main  > xxd.txt

# Edit xxd.txt manually

# Restore
xxd -r xxd.txt main2
chmod 0755 main2
```

