%{
#include <stdio.h>
#include <stdlib.h>
#include "Helper.h"
#include <string>

void printstr();

extern "C" int yylex(); //TODO: check if needed
%}

%option yylineno
%option noyywrap
%option outfile="Reader.cpp"

digit       ([0-9])
letter      ([a-zA-Z])
whitespace  ([ \t\n\r])
symbols     [(){},.:;]
id          {letter}({letter}|{digit}|_)*
num         {digit}+(\.{digit}+)?
QMark       \"
str         {QMark}((\\.|[^"\r\n])*([^"\\\r\n])+)*{QMark}
relop       "=="|"<>"|"<"|"<="|">"|">="
addop       "+"|"-"
mulop       "*"|"/"
assign      "="
and         "&&"
or          "||"
not         "!"
comment     "#"[^\n]*

%%

int {
    yylval.content = yytext;
    return int_token;
}

float {
    yylval.content = yytext;
    return float_token;
}

struct {
    yylval.content = yytext;
    return struct_token;
}

void {
    yylval.content = yytext;
    return void_token;
}

write {
    yylval.content = yytext;
    return write_token;
}

read {
    yylval.content = yytext;
    return read_token;
}

while {
    yylval.content = yytext;
    return while_token;
}

do {
    yylval.content = yytext;
    return do_token;
}

if {
    yylval.content = yytext;
    return if_token;
}

then {
    yylval.content = yytext;
    return then_token;
}

else {
    yylval.content = yytext;
    return else_token;
}

return {
    yylval.content = yytext;
    return return_token;
}

{symbols}   {
    yylval.content = yytext;
    return yytext[0];
}

{num}   {
    yylval.content = yytext;
    return num_token;
}

{id}    {
    yylval.content = yytext;
    return id_token;
}

{relop}   {
    yylval.content = yytext;
    return relop_token;
}

{addop}   {
    yylval.content = yytext;
    return addop_token;
}

{mulop}   {
    yylval.content = yytext;
    return mulop_token;
}

{assign}   {
    yylval.content = yytext;
    return assign_token;
}

{and}   {
    yylval.content = yytext;
    return and_token;
}

{or}    {
    yylval.content = yytext;
    return or_token;
}

{not}	{
    yylval.content = yytext;
    return not_token;
}

{str}   {
    printstr(); //for easier reading, function is below
    return str_token;
}

{comment}       ;

{whitespace}    ;

.		{
			printf("Lexical error: '%s' in line number %d\n", yytext, yylineno);
			exit(LEXICAL_ERROR);
		}

%%

void printstr() {
        char* string = yytext;
        string[yyleng-1] = 0;
        string++;
        yylval.content = yytext;
}