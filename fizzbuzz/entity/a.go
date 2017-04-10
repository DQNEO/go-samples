package entity

import "strconv"

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

const FIZZ string = "FIZZ"
const BUZZ string = "BUZZ"

var FIZZ_ENTITY MyString = MyString{Data: FIZZ}

var BUZZ_ENTITY MyString = MyString{Data:BUZZ}