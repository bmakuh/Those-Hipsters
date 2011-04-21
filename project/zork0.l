%{
/* 
 * bmakuh & cmckenna
 */
#include "zork0.tab.h"
%}
%%

[\t ]+		/* ignore white space */ ;

start { yylval.sval = strdup(yytext); return START; }

go |
move |
walk |
run { yylval.sval = strdup(yytext); return MOTION; }

kill |
fight |
hit |
punch |
stab { yylval.sval = strdup(yytext); return AGGRESSION; }

eat |
consume |
digest |
chew |
chomp { yylval.sval = strdup(yytext); return CONSUMPTION; }

Bush_administration |
voldemort |
death { yylval.sval = strdup(yytext); return HAZARD; }

unicorndog |
delectable_morsel { yylval.sval = strdup(yytext); return FOOD; }

quit |
q |
exit |
leave {yylval.sval = strdup(yytext); return EXIT; }

N |
n |
E |
e |
S |
s |
W |
w |
NE |
ne |
SE |
se |
SW |
sw |
NW |
nw { yylval.sval = strdup(yytext); return DIRECTION; }

[0-9a-zA-Z]+ {yylval.sval = strdup(yytext); return UNKNOWN; }

.		  return yytext[0];
\n        return 0;

%%
/*---------------------------------------------------------------------------*/
/* 5. Other C code that we need.                                           */
 
yyerror(char *errmsg)
{
    fprintf(stderr, "%s\n", errmsg);
}

main()
{
	yyparse();
}
