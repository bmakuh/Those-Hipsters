%{
/* 
 * bmakuh & cmckenna
 */

%}
%%

[\t ]+		/* ignore white space */ ;

go |
move |
walk |
run { printf("%s MOVEMENT\n", yytext); }

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
E |
S |
W |
NE |
SE |
SW |
NW { printf("%s DIRECTION\n", yytext); }

.|\n        { printf("Other: %s \n", yytext); /* normal default anyway */ }

%%

main()
{
	yylex();
}
