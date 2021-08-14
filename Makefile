PROJECT := remote-button

default: usage

install-tools:
	bin/makefile/install-tools

install: install-tools

usage:
	bin/makefile/usage

check-tools:
	bin/makefile/check-tools

check: check-tools

setup: check
	bin/setup

rubocop_fix_all:
	bundle exec rubocop -a .

prettier_ruby:
	bin/makefile/prettier-ruby

.PHONY: build
build:
	bin/full-build

.PHONY: deploy
deploy:
	RAILS_MASTER_KEY=`cat config/master.key` \
		HEROKU_APP_NAME=stg-remote-button      \
		bin/heroku-create
