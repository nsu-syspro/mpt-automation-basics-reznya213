NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

TESTS := $(wildcard test/*.txt)
TEST_TARGETS := $(TESTS:test/%.txt=test-%)

.PHONY: all clean check $(TEST_TARGETS)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' src/wordcount.c -o build/$(NAME)

clean:
	rm -rf build

check: build/$(NAME) $(TEST_TARGETS)

$(TEST_TARGETS): test-%: test/%.txt build/$(NAME)
	@./build/$(NAME) $< | diff -u test/$*.expected -
