birudo0: *.go Makefile
	GOOS=linux GOARCH=amd64 go build -o $@ .

run0: birudo0
	docker run --rm -v `pwd`:/mnt/ -w /mnt ubuntu ./$<

build-script0.sh:*.go Makefile
	GOOS=linux GOARCH=amd64 go build -o birudo1 -n -a -p 1 . 2>$@

birudo1: build-script0.sh
	cat $< | sed -e "s/'EOF'/EOF/g" | GOOS=linux GOARCH=amd64 WORK=/tmp/go-build-20230606 bash -eux

run1: birudo1
	docker run --rm -v `pwd`:/mnt/ -w /mnt ubuntu ./$<

birudo2: build-script1.sh *.go
	./$<

run2: birudo2
	docker run --rm -v `pwd`:/mnt/ -w /mnt ubuntu ./$<

clean:
	rm -f birudo birudo0 birudo1 birudo2 /tmp/go-build
