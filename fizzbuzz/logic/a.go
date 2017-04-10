package logic

import "github.com/DQNEO/go-samples/fizzbuzz/entity"

func fizzable(i int) bool {
	return (i % 3) == 0
}

func buzzable(i int) bool {
	return (i % 5) == 0
}


func Logic(i int) entity.Stringable {
	if (fizzable(i) && buzzable(i)) {
		return entity.FIZZ_BUZZ_ENTITY
	} else if fizzable(i) {
		return entity.FIZZ_ENTITY
	} else if buzzable(i) {
		return entity.BUZZ_ENTITY
	} else {
		return entity.MyInt{Data:i}
	}
}

