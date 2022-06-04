CC := gcc
MAKEFLAGS := --silent

build_folder:
	rm -rf build
	mkdir build

build: build_folder
	bison -d src/main.y -o build/lang.c
	flex src/main.l
	mv lex.yy.c build/lang.lex.c
	$(CC) -o build/lang.o build/lang.lex.c build/lang.c -lfl
