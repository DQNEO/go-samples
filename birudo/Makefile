birudo: *.go Makefile
	GOOS=linux GOARCH=amd64 go build .

build-script0.sh:*.go Makefile
	GOOS=linux GOARCH=amd64 go build -x -a . 2>$@

birudo-by-script0: build-script0.sh
	rm -f birudo
	GOOS=linux GOARCH=amd64 bash $<
	docker run --rm -v `pwd`:/mnt/ -w /mnt ubuntu ./birudo

clean:
	rm -f birudo
