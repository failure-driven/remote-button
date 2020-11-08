PROJECT := remote-button

default: usage
usage:
	bin/makefile/usage

.PHONY: build
build:
	bin/full-build
