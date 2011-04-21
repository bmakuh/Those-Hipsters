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
%{
void quit();
void initGame();
struct aRoom;
%}

%%
game: actionList
	| EXIT { quit(); }
;

actionList: actionList action
	| action
;

action: moveType {$$ = $1;}
	| fightType {$$ = $1;}
	| eatType {$$ = $1;}
;

moveType: MOTION DIRECTION {printf("you %s %s\n", $1, $2); }
;

fightType: AGGRESSION HAZARD {printf("you %s %s to death!\n", $1, $2); }
;

eatType: CONSUMPTION FOOD {printf("you are %sing a %s\n", $1, $2); }
;
%%
void quit()
{
	printf("Thanks for playing Zork!\n"); 
	exit(0);
}

struct aRoom {

}