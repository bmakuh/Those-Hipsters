%union {
	float fval;
	int ival;
	char *sval;
}
%token <ival>NUMBER
%token <sval>NAME
%token <fval>FNUMBER
%type <fval> expression
%type <fval> term
%type <fval> factor

%{
void endProgram();
void updateTotal(float value);
float total=0;
%}

%%
program: '{' statements '}' { endProgram(); }
	;
	
statements: statement ';' statements
	| statement 
	;

statement:	NAME '=' expression { updateTotal($3); printf("%s = %f\n", $1, $3); }
	|	expression		{ updateTotal($1); printf("= %f\n", $1); }
	;
	
expression:	expression '+' term { $$ = $1 + $3; }
	|	term		{ $$ = $1; }
	;

term:	term '*' factor	{ $$ = $1 * $3; }
	|	factor			{ $$ = $1; }
	;

factor:	'(' expression ')'	{ $$ = $2; }
	|	NUMBER			{ $$ = $1; }
	|   FNUMBER         { $$ = $1; }
	;

%%
void endProgram()
{
	printf("Your total is: %f, Goodbye!\n", total); 
	exit(0);
}

void updateTotal(float value) {
	total += value;
}
	


