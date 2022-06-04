%{
#include <stdio.h>
#include <stdlib.h>
#include "main.h"
%}

%union { int num; char id; }

%start line

%token print
%token exit_command
%token clear

%token  <num>   number
%token  <id>    identifier
%type   <num>   line exp term
%type   <id>    assignment

%%
line    : assignment        ';'     {;}
        | exit_command      ';'     {exit(EXIT_SUCCESS);}
        | print exp         ';'     {printf("Value: %d\n", $2);}
        | clear             ';'     {printf("\e[1;1H\e[2J");}
        | line assignment   ';'     {;}
        | line print exp    ';'     {printf("Value: %d\n", $3);}
        | line clear        ';'     {printf("\e[1;1H\e[2J");}
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
        | identifier                {$$ = get_symbol_value($1);}
%%
