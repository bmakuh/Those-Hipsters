%union yylval {
	float fval;
	int ival;
	char *sval;
}
%token <sval>MOTION
%token <sval>DIRECTION
%%
moveType: MOTION DIRECTION {printf("moving %s %s\n", $1, $2); };