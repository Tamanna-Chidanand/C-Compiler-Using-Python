%{
    #include <unistd.h>
    #include "y.tab.h"
    #include <stdio.h>
    #include <string.h>
    extern void yyerror(const char *);
    extern FILE* yyin;
%}

/* Regular definitions */
digit    [0-9]
letter    [a-zA-Z]
id    {letter}({letter}|{digit}|_)*
digits    {digit}+
opFraction    (\.{digits})?
opExponent    ([Ee][+-]?{digits})?
number    {digits}{opFraction}{opExponent}
%option yylineno

%%
\/\/.* ; /* ignore comments */
[\t\n ]+ ; /* ignore whitespaces */

"if"        { return IF; }
"else"      { return ELSE; }
"do"        { return DO; }
"while"     { return WHILE; }

"("        { return *yytext; }
")"        { return *yytext; }
"{"        { return *yytext; }
"}"        { return *yytext; }
"."        { return *yytext; }
","        { return *yytext; }
"*"        { return *yytext; }
"+"        { return *yytext; }
";"        { return *yytext; }
"-"        { return *yytext; }
"/"        { return *yytext; }
"="        { return *yytext; }
">"        { return *yytext; }
"<"        { return *yytext; }
"=="       { return EQ; }
"!="       { return NE; }
">="       { return GE; }
"<="       { return LE; }

{number}    {
            yylval.text = strdup(yytext);  // Note: using .text member of union
            return T_NUM;
        }
{id}        {
            yylval.text = strdup(yytext);  // Note: using .text member of union
            return T_ID;
        }
.        { yyerror("Unknown character"); }
%%
int yywrap() {
    return 1;  // Indicates end of input
}