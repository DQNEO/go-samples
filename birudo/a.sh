#!/usr/local/bin/bash

foo() {
  echo "foo bar"
}

VAR=`foo`

echo hoge $VAR
