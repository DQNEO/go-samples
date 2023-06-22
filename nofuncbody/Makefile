all: run-mac run-linux

run-mac: bin.mac
	./bin.mac

run-linux: bin.linux
	docker run --rm -v `pwd`:/mnt/ -w /mnt busybox ./bin.linux

bin.mac: *.go *.s
	GOOS=darwin GOARCH=amd64 go build -o $@

bin.linux: *.go *.s
	GOOS=linux GOARCH=amd64 go build -o $@
