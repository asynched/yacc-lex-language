#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define NUM_SYMBOLS 52

extern int yyparse(void);

/**
 * @brief Wrapper for an error return value in yacc.
 * 
 * @return int Error value.
 */
int yywrap(void)
{
    return 1;
}

/**
 * @brief Prints an error message to stderr.
 * 
 * @param err Error message to be printed.
 */
void yyerror(const char* err)
{
    fprintf(stderr, "%s\n", err);
}

int symbols[NUM_SYMBOLS];

/**
 * @brief Get the symbol index with a given symbol name.
 * 
 * @param symbol Symbol to get the index to. 
 * @return int The given symbol index.
 */
int get_symbol_index(char symbol)
{
    if (islower(symbol))
    {
        return symbol - 'a' + 26;
    }

    if (isupper(symbol))
    {
        return symbol - 'A';
    }

    return -1;
}

/**
 * @brief Get the symbol value for a given symbol.
 * 
 * @param symbol Symbol to get the value for.
 * @return int Value of that symbol.
 */
int get_symbol_value(char symbol)
{
    const int index = get_symbol_index(symbol);
    return symbols[index];
}

/**
 * @brief Updates the symbol value in memory.
 * 
 * @param symbol Symbol to update.
 * @param value Value to set that symbol to.
 */
void update_symbol_value(char symbol, int value)
{
    const int index = get_symbol_index(symbol);
    symbols[index] = value;
}

int main(void)
{
    for(size_t i = 0; i < NUM_SYMBOLS; i++)
    {
        symbols[i] = 0;
    }

    return yyparse();
}
