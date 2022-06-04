%{
#include "lang.h"
#include "main.h"
%}

%%
"print"     {return print;}
"exit"      {return exit_command;}
"clear"     {return clear;}
[a-zA-Z]    {yylval.id = yytext[0];     return identifier;}
[0-9]+      {yylval.num = atoi(yytext); return number;}
[ \t\n]     {;}
[-+\*/=;]   {return yytext[0];}
.           {ECHO; yyerror("Unexpected character");}
%%
