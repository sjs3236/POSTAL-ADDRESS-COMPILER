/*
 * Filename parse.y
 * Date 10/18/2020
 * Author Junsik Seo
 * Email jxs161930@utdallas.edu
 * Version 1.0
 * Copyright 2020, All Rights Reserved
 * Description: This is parser program that generates an abstract model of the token and
 * genreates useful cotent from that model.
 */

%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char *str);
  %}

%union
 {
   int value;
   char *str;
}

%type <str> NAME
%type <str> IDENTIFIER
%type <str> NAME_INITIAL
%type <str> SR
%type <str> JR
%type <str> COMMA
%type <str> DASH
%type <str> HASH
%type <value> INTEGER
%type <str> ROMAN

%token INTEGER
%token ROMAN
%token NAME
%token IDENTIFIER
%token NAME_INITIAL
%token SR
%token JR
%token COMMA
%token DASH
%token HASH
%token NEWLINE
%token EOLTOKEN

%start Postal_addresses

%%

Postal_addresses:
					Postal_addresses EOLTOKEN AddressBlock
	    |   AddressBlock
	    ;

AddressBlock: 
              NamePart StreetAddress LocationPart
	      ;

NamePart:
PersonalPart LastName SuffixPart EOLTOKEN
| PersonalPart LastName EOLTOKEN
| error EOLTOKEN {printf("\nBad name-part. Skipping to next line\n");}
;

PersonalPart:
NAME {fprintf(stderr, "\n<FirstName>%s</FirstName>\n",$1);}
| NAME_INITIAL {fprintf(stderr, "\n<FirstName>%s</FirstName>\n",$1);}
;

LastName:
NAME {fprintf(stderr, "<LastName>%s</LastName>\n",$1);}
;

SuffixPart:
SR {fprintf(stderr, "<Suffix>%s</Suffix>\n",$1);}
|JR {fprintf(stderr, "<Suffix>%s</Suffix>\n",$1);}
|ROMAN {fprintf(stderr, "<Suffix>%s</Suffix>\n",$1);}
;

StreetAddress:
StreetNumber StreetName INTEGER EOLTOKEN {fprintf(stderr, "<AptNum>%d</AptNum>\n",$3);}
| StreetNumber StreetName HASH INTEGER EOLTOKEN {fprintf(stderr, "<AptNum>%d</AptNum>\n",$4);}
| StreetNumber StreetName EOLTOKEN
| error EOLTOKEN {printf("Bad address-line. Skipping to next line\n");}
;

StreetNumber:
INTEGER  {fprintf(stderr, "<HouseNumber>%d</HouseNumber>\n",$1);}
|IDENTIFIER  {fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n",$1);}
;

StreetName:
NAME  {fprintf(stderr, "<Streetname>%s</Streetname>\n",$1);}
;

LocationPart:
TownName COMMA StateCode ZipCode EOLTOKEN
| error EOLTOKEN {printf("Bad location_line. Skipping to next line\n");}
;

TownName:
NAME  {fprintf(stderr, "<City>%s</City>\n",$1);}
;

StateCode:
NAME  {fprintf(stderr, "<State>%s</State>\n",$1);}
;

ZipCode:
INTEGER DASH INTEGER  {fprintf(stderr, "<Zip5>%d</Zip5>\n<Zip4>%d</Zip4>\n",$1,$3);}
|INTEGER  {fprintf(stderr, "<Zip5>%d</Zip5>\n",$1);}
;

%%

void yyerror(char *str)
{}
