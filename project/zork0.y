%union yylval {
	float fval;
	int ival;
	char *sval;
}
%token <sval>MOTION
%token <sval>DIRECTION
%token <sval>AGGRESSION
%token <sval>HAZARD
%token <sval>CONSUMPTION
%token <sval>FOOD
%token <sval>EXIT
%type  <sval>actionList
%type  <sval>game
%type  <sval>action
%type  <sval>moveType
%type  <sval>fightType
%type  <sval>eatType
%%
game: actionList EXIT {printf("Thanks for playing zork!\n"); $2 }
;

actionList: actionList action 
	| action
;

action: moveType {$$ = $1;}
	| fightType {$$ = $1;}
	| eatType {$$ = $1;}
;

moveType: MOTION DIRECTION {printf("you are %sing %s\n", $1, $2); }
;

fightType: AGGRESSION HAZARD {printf("you are %sing %s\n", $1, $2); }
;

eatType: CONSUMPTION FOOD {printf("you are %sing a %s", $1, $2); }
;