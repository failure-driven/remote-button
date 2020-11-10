PROJECT := remote-button

default: usage
usage:
	bin/makefile/usage

rubocop_fix_all:
	bundle exec rubocop -a .

prettier_ruby:
	bin/makefile/prettier-ruby

.PHONY: build
build:
	bin/full-build
