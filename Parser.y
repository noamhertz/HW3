%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "Helper.h"
    #include "Symbol.h"
    #include "Quads.h"
    #include "Function.h"
	
    extern "C" int yylex();
    extern "C" char* yytext;
    extern "C" int yylineno;
    extern "C" void yyerror (const char* err);

    typedef struct node ParserNode;

    ParserNode* parseTree = NULL;
%}

%token int_token float_token struct_token void_token write_token read_token while_token do_token return_token
%token num_token id_token str_token
%left ','
%right assign_token
%right if_token then_token else_token
%left or_token
%left and_token
%left relop_token
%left addop_token
%left mulop_token
%right not_token
%left '.'
%left '('
%left ')'
%left '{'
%left '}'
%left ':'
%left ';'

%%

PROGRAM : TDEFS FDEFS
    {
        $$ = parseTree = makeNode("PROGRAM", NULL, $1);
        concatList($1, $2);
    }
;

TDEFS : TDEFS struct_token id_token '{' DECLARELIST '}' ';'
    {
        $$ = makeNode("TDEFS", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
        concatList($1, $4);
        concatList($1, $5);
        concatList($1, $6);
        concatList($1, $7);
    }
        |
    {
        $$ = makeNode("TDEFS", NULL, makeNode("EPSILON", NULL, NULL));
    }
;

FDEFS : FDEFS FUNC_API BLK
    {
        $$ = makeNode("FDEFS", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
    }
        | FDEFS FUNC_API ';'
    {
        $$ = makeNode("FDEFS", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
    }
        |
    {
        $$ = makeNode("FDEFS", NULL, makeNode("EPSILON", NULL, NULL));
    }
;

FUNC_API : TYPE id_token '(' FUNC_ARGS ')'
    {
        $$ = makeNode("FUNC_API", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
        concatList($1, $4);
        concatList($1, $5);
    }
;

FUNC_ARGS : FUNC_ARGLIST
    {
        $$ = makeNode("FUNC_ARGS", NULL, $1);
    }
        |
    {
        $$ = makeNode("FUNC_ARGS", NULL, makeNode("EPSILON", NULL, NULL));
    }
;

FUNC_ARGLIST : FUNC_ARGLIST ',' DCL
    {
        $$ = makeNode("FUNC_ARGLIST", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
    }
        | DCL
    {
        $$ = makeNode("FUNC_ARGLIST", NULL, $1);
    }
;

BLK : '{' STLIST '}'
    {
        $$ = makeNode("BLK", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
    }
;

DECLARELIST : DECLARELIST DCL ';'
    {
        $$ = makeNode("DECLARELIST", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
    }
        | DCL ';'
    {
        $$ = makeNode("DECLARELIST", NULL, $1);
        concatList($1, $2);
    }
;

DCL : id_token ':' TYPE
    {
    	$$.content = $1.content;
    	$$.type = $3.type;
	scopeSymbolTable[$1.content]->setType($3.type);
    }
        | id_token ':' id_token
    {
        $$ = makeNode("DCL", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
    }
        | id_token ',' DCL
    {
        $$ = makeNode("DCL", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
;

TYPE : int_token
	{
	$$.type = INT;
    	}
	| float_token
	{	
        $$.type = FLOAT;
    	}
	| void_token
	{	
        $$.type = VOID;
    	}
;

STLIST : STLIST STMT 
	{
		$$ = makeNode("STLIST", NULL, $1);
		concatList($1, $2);
	}
		|
	{
		$$ = makeNode("STLIST", NULL, makeNode("EPSILON", NULL, NULL));
	}
;
	
STMT : DCL ';'
	{
		$$ = makeNode("STMT", NULL, $1);
		concatList($1, $2);
	}
		| ASSN
	{
		$$ = makeNode("STMT", NULL, $1);
	}
		| EXP ';'
	{
		$$ = makeNode("STMT", NULL, $1);
		concatList($1, $2);
	}
		| CNTRL
	{
		$$ = makeNode("STMT", NULL, $1);
	}
		| READ
	{
		$$ = makeNode("STMT", NULL, $1);
	}
		| WRITE
	{
		$$ = makeNode("STMT", NULL, $1);
	}
		| RETURN
	{
		$$ = makeNode("STMT", NULL, $1);
	}
		| BLK
	{
		$$ = makeNode("STMT", NULL, $1);
	}
;

RETURN : return_token EXP ';'
	{
		$$ = makeNode("RETURN", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| return_token ';'
	{
		$$ = makeNode("RETURN", NULL, $1);
        concatList($1, $2);
	}
;

WRITE : write_token '(' EXP ')' ';'
	{
		$$ = makeNode("WRITE", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
		concatList($1, $5);
	}
		| write_token '(' str_token ')' ';'
	{
		$$ = makeNode("WRITE", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
		concatList($1, $5);
	}
;

READ : read_token '(' LVAL ')' ';'
	{
		$$ = makeNode("READ", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
		concatList($1, $5);
	}
;

ASSN : LVAL assign_token EXP ';'
	{
		$$ = makeNode("ASSN", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
	}
;

LVAL : id_token
	{
		$$ = makeNode("LVAL", NULL, $1);
	}
		| STRUCT_MEMBER
	{
		$$ = makeNode("LVAL", NULL, $1);
	}
;

CNTRL : if_token BEXP then_token STMT else_token STMT
	{
		$$ = makeNode("CNTRL", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
		concatList($1, $5);
		concatList($1, $6);
	}
		| if_token BEXP then_token STMT
	{
		$$ = makeNode("CNTRL", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
	}
		| while_token BEXP do_token STMT
	{
		$$ = makeNode("CNTRL", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
	}
;

BEXP : BEXP or_token BEXP
	{
		$$ = makeNode("BEXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| BEXP and_token BEXP
	{
		$$ = makeNode("BEXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| not_token BEXP
	{
		$$ = makeNode("BEXP", NULL, $1);
        concatList($1, $2);
	}
		| EXP relop_token EXP
	{
		$$ = makeNode("BEXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| '(' BEXP ')'
	{
		$$ = makeNode("BEXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
;

EXP : EXP addop_token EXP
	{
		$$ = makeNode("EXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| EXP mulop_token EXP
	{
		$$ = makeNode("EXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| '(' EXP ')'
	{
		$$ = makeNode("EXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| '(' TYPE ')' EXP
	{
		$$ = makeNode("EXP", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
	}
		| id_token
	{
		$$ = makeNode("EXP", NULL, $1);
	}
		| STRUCT_MEMBER
	{
		$$ = makeNode("EXP", NULL, $1);
	}
		| num_token
	{
		$$ = makeNode("EXP", NULL, $1);
	}
		| CALL
	{
		$$ = makeNode("EXP", NULL, $1);
	}
;

STRUCT_MEMBER : id_token '.' id_token
	{
		$$ = makeNode("STRUCT_MEMBER", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| STRUCT_MEMBER '.' id_token
	{
		$$ = makeNode("STRUCT_MEMBER", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
;

CALL : id_token '(' CALL_ARGS ')'
	{
		$$ = makeNode("CALL", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
		concatList($1, $4);
	}
;

CALL_ARGS : CALL_ARGLIST
	{
		$$ = makeNode("CALL_ARGS", NULL, $1);
	}
		|
	{
		$$ = makeNode("CALL_ARGS", NULL, makeNode("EPSILON", NULL, NULL));
	}
;

CALL_ARGLIST : CALL_ARGLIST ',' EXP
	{
		$$ = makeNode("CALL_ARGLIST", NULL, $1);
        concatList($1, $2);
        concatList($1, $3);
	}
		| EXP
	{
		$$ = makeNode("CALL_ARGLIST", NULL, $1);
	}
;

%%

void yyerror(const char* err)
{
	printf("Syntax error: '%s' in line number %d\n", yytext, yylineno);
	exit(1);
}