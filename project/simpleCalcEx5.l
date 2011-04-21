%{
#include "simpleCalcEx5.tab.h"

char* extract_name(char *text_in);

%}
DIGIT [0-9] 

%%
{DIGIT}+	{ yylval.ival = atoi(yytext); return NUMBER; }
{DIGIT}+"."{DIGIT}* { yylval.fval = atof(yytext); return FNUMBER; }
@[a-zA-Z]+ { yylval.sval = extract_name(yytext); return NAME; }

[ \t\n]	;		/* ignore white space */
.	return yytext[0];
%%
/*---------------------------------------------------------------------------*/
/* 5. Other C code that we need.                                           */
 
yyerror(char *errmsg)
{
    fprintf(stderr, "%s\n", errmsg);
}

char* extract_name(char *text_in)
{
    int i;
	// start at 1 to skip @
	for (i=1; i<strlen(text_in); ++i)
	    text_in[i-1] = text_in[i];
	text_in[i-1] = '\0';
	return text_in;
}

main()
{
	yyparse();
}

