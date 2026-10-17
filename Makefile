NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' src/wordcount.c -o build/$(NAME)
clean:
	rm -rf build

TESTS := $(wildcard test/*.txt)

.PHONY: all clean check

check: build/$(NAME)
	@set -e; \
	for testfile in $(TESTS); do \
		expected="$${testfile%.txt}.expected"; \
		./build/$(NAME) "$$testfile" 2>&1 | diff -u "$$expected" -; \
	done

