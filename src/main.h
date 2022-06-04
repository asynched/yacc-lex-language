#ifndef _MAIN_H_
#define _MAIN_H_

int get_symbol_value(char symbol);
void update_symbol_value(char symbol, int value);
void yyerror(const char *err);
int yylex();

#endif
