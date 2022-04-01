/*
 * Filename myfile.cc
 * Date 10/18/2020
 * Author Junsik Seo
 * Email jxs161930@utdallas.edu
 * Version 1.0
 * Copyrights 2020, All Rights Reserved
 * Description This is c program that call parser and scanner.
 * If input is ./scanner, it will perform as scanner, if input is ./parser, it will perform as parser.
 * Otherwise, it will perform as parser.
 */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "myheader.h"
#include "y.tab.h"

int yyparse(void);
extern char *yytext;

int main(int argc, char *argv[]){
  
   
  int token;
    
  if(strcmp(argv[0], "./scanner") == 0 ) {
    token= yylex();
  while (token!=0) {
    printf("\tyylex returned ");

      switch(token) {
	
        case HASH:
	printf("HASH Token (%s) \n",yytext);
	break;
        case DASH:
	printf("DASH Token (%s) \n",yytext);
	break;
	case COMMA:
	printf("COMMA Token (%s) \n",yytext);
	break;
	case SR:
	printf("Sr. Token (%s) \n",yytext);
	break;
	case JR:
	printf("JR Token (%s) \n",yytext);
	break;
        case ROMAN:
	printf("ROMAN Token (%s) \n",yytext);
	break;
	case INTEGER:
	printf("INTEGER Token (%s) \n",yytext);
	break;
	case EOLTOKEN:
	printf("EOLTOKEN Token (%d) \n",token);
	break;
        case IDENTIFIER:
	printf("IDENTIFIER Token (%s) \n",yytext);
	break;
	case NAME_INITIAL:
        printf("NAME_INITIAL Token (%s) \n",yytext);
	break;
	case NAME:
	printf("NAME Token (%s) \n",yytext);
	break;
        default:
	  printf("UNKNOWN\n");
      }
      token=yylex();
      
  }
  printf("Finished scanner\n");
}
  
  else if(strcmp(argv[0], "./parser") == 0 ) {
    yyparse();

}

  
  else {
  printf("About to call the parser\n");

  switch (yyparse())
    {
    case 0:
      printf("\nParse Successful!\n");
      break;
    case 1:
      printf("\nParse Failedl!\n");
      break;
    case 2:
      printf("\nOut of memory\n");
      break;
    default:
      printf("\nParse Successful!\n");
      break;
    }

  printf("Finished with the parse\n");
  }
  return 0;
}
