CC := gcc
MAKEFLAGS := --silent

build_folder:
	rm -rf build
	mkdir build

build: build_folder
	bison -d src/main.y -o build/lang.c
	flex src/main.l
	mv lex.yy.c build/lang.lex.c
	cp src/main.c build/main.c
	cp src/main.h build/main.h
	$(CC) -o build/lang.o build/lang.lex.c build/lang.c build/main.c -lfl
