%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define NUM_SYMBOLS 52

void yyerror(const char* err);
int yylex();

int symbols[NUM_SYMBOLS];
int symbol_value(char symbol);
void update_symbol_value(char symbol, int value);
%}

%union { int num; char id; }

%start line

%token print
%token exit_command

%token  <num>   number
%token  <id>    identifier
%type   <num>   line exp term
%type   <id>    assignment

%%

line    : assignment        ';'     {;}
        | exit_command      ';'     {exit(EXIT_SUCCESS);}
        | print exp         ';'     {printf("Value: %d\n", $2);}
        | line assignment   ';'     {;}
        | line print exp    ';'     {printf("Value: %d\n", $3);}
        | line exit_command ';'     {exit(EXIT_SUCCESS);}
        ;

assignment : identifier '=' exp     {update_symbol_value($1, $3);}
        ;

exp     : term                      {$$ = $1;}
        | exp '+' term              {$$ = $1 + $3;}
        | exp '-' term              {$$ = $1 - $3;}
        | exp '*' term              {$$ = $1 * $3;}
        | exp '/' term              {$$ = $1 / $3;}
        ;

term    : number                    {$$ = $1;}
        | identifier                {$$ = symbol_value($1);}

%%

int get_symbol_index(char token)
{
    if (islower(token))
    {
        return token - 'a' + 26;
    }

    if (isupper(token))
    {
        return token - 'A';
    }

    return -1;
}

int symbol_value(char symbol)
{
    const int bucket = get_symbol_index(symbol);
    return symbols[bucket];
}

void update_symbol_value(char symbol, int value)
{
    const int bucket = get_symbol_index(symbol);
    symbols[bucket] = value;
}

int main(void)
{
    for(size_t i = 0; i < NUM_SYMBOLS; i++)
    {
        symbols[i] = 0;
    }

    return yyparse();
}

void yyerror(const char* err)
{
    fprintf(stderr, "%s\n", err);
}
