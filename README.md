# yacc-lex-language

A simple language with an interpreter using yacc/lex.

## Building

### Requirements

- GNU/Make
- GCC
- Bison
- Flex

### How to build?

To build the executable, run:

```sh
$ make build
```

> This will generate a `build/` directory with the executable `lang.o`.

## Running the interpreter

To run the interpreter, type in your terminal:

```sh
$ build/lang.o
```

This language only recognizes a few symbols and operations, such as add, subtract, print and exit.

- Adding

```
print 1 + 2;
```

- Subtracting

```
print 2 - 1;
```

- Assignment

```
a = 10 + 5;
```

- Exiting

```
exit;
```

## Sources

- [Language tutorial](https://www.youtube.com/watch?v=__-wUHG2rfM)
- [Github Repository](https://github.com/jengelsma/yacc-tutorial)
