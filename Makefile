NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' src/wordcount.c -o build/$(NAME)
clean:
	rm -rf build
