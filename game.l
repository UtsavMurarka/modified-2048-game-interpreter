%{
#include "y.tab.h"
#include <string.h>
void yyerror (char *s);
int yylex();
%}
%%

[0-9]+                  {yylval.num = atoi(yytext); return valtoken;}
"ADD"					{yylval.op = yytext[0]; return operation;}
"SUBTRACT"				{yylval.op = yytext[0]; return operation;}
"MULTIPLY"				{yylval.op = yytext[0]; return operation;}
"DIVIDE"				{yylval.op = yytext[0]; return operation;}

"LEFT"					{yylval.dir = yytext[0]; return direction;}
"RIGHT"					{yylval.dir = yytext[0]; return direction;}
"UP"					{yylval.dir = yytext[0]; return direction;}
"DOWN"					{yylval.dir = yytext[0]; return direction;}
"ASSIGN"				{return assign;}
"TO"					{return to;}
"VAR"					{return var;}
"IS"					{return is;}
"VALUE IN"				{return valin;}
[.]						{return yytext[0];}
[\n]					{return yytext[0];}
[ ]						{;}
[0-9]+[ \t]*[,][ \t]*[0-9]+			{		
										int i = 0, j = 0;
										while (yytext[i])
										{
											if (yytext[i] != ' ' && yytext[i] != '\t')
									          yytext[j++] = yytext[i];
											i++;
										}
										yytext[j] = '\0';
										

										char str[100];
										strcpy(str, yytext);
										char* token_x = strtok(str, ",");
										char* token_y = strtok(NULL, ",");
										int x = atoi(token_x);
										int y = atoi(token_y);
										if(x >= 1 && x <= 4 && y >=1 && y <= 4){
											yylval.id = yytext; 
											return coordinate;
										}
										else{
											printf("\n2048> %s is not a valid coordinate. The tile coordinates must be in the range 1,2,3,4.\n", yytext);
											return err_token;
										}
									}

[a-zA-Z_][a-zA-Z0-9_]*	{yylval.id = yytext; return identifier;}

.						{return err_token;}


%%
int yywrap (void) {return 1;}