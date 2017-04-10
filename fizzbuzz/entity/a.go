package entity

import "strconv"

const FIZZ string = "FIZZ"
const BUZZ string = "BUZZ"
const FIZZ_BUZZ string  = "FizzBuzz"

type MyInt struct {
	Data int
}

func (myInt MyInt) String() string {
	return strconv.Itoa(myInt.Data)
}


type MyString struct {
	Data string
}

func (myString MyString) String() string {
	return myString.Data;
}

type Stringable interface {
	String() string
}


var FIZZ_ENTITY MyString = MyString{Data: FIZZ}

var BUZZ_ENTITY MyString = MyString{Data:BUZZ}

var FIZZ_BUZZ_ENTITY MyString = MyString{Data:FIZZ_BUZZ}