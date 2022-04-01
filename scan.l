/*
* Filename scan.l
* Date 10/11/2020
* Author Junsik Seo
* Email jxs161930@utdallas.edu
* Version 1.0
* Copyright 2020, All Rights Reserved
* Description: This is lexical analysis, tokenizes the input via a lexcial scanner.
* 
*/ 

%option noyywrap
%option nounput
%option noinput

%{
#include <stdlib.h>
#include "y.tab.h"
%}

%%

[ \t\r]+  { /* eat up whitespace */ }
[\n] { return EOLTOKEN; } 
"Sr." {yylval.str=strdup(yytext); return SR; }
"Jr." {yylval.str=strdup(yytext); return JR; }
"," { return COMMA; }
"-" { return DASH; }
"#" { return HASH; }
[0-9]+ { yylval.value = atoi (yytext); return INTEGER; }
(I|II|III|IV) {yylval.str=strdup(yytext); return ROMAN; }
[0-9]+[A-Z]*            {yylval.str=strdup(yytext); return IDENTIFIER; }
[A-Z]|[A-Z]\.   {yylval.str=strdup(yytext); return NAME_INITIAL; }
[A-Za-z]{2,}   {yylval.str=strdup(yytext); return NAME; }

%%
