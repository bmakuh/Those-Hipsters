%{
/* 
 * bmakuh & cmckenna
 */
#include "zork0.tab.h"
%}
%%

[\t ]+		/* ignore white space */ ;

go |
move |
walk |
run { yylval.sval = strdup(yytext); return MOTION; }

kill |
fight |
hit |
punch |
stab { printf("%s AGGRESSION\n", yytext); }

eat |
consume |
digest |
chew |
chomp { printf("%s CONSUMPTION\n", yytext); }

Bush_administration |
voldemort |
death { printf("%s HAZARD\n", yytext); }

unicorndog |
delectable_morsel { printf("%s FOOD\n", yytext); }

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
nw { printf("%s DIRECTION\n", yytext); }

.|\n        { printf("Other: %s \n", yytext); /* normal default anyway */ }

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
