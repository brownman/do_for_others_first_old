#!/bin/sh

testEquality() {
	assertEquals 1 1
}
testEquality1() {
	assertEquals 2 1
}



. ./VENDOR/shunit2-2.0.3/src/shell/shunit2
