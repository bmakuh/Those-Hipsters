%union yylval {
	float fval;
	int ival;
	char *sval;
}
%token <sval>START
%token <sval>MOTION
%token <sval>DIRECTION
%token <sval>AGGRESSION
%token <sval>HAZARD
%token <sval>CONSUMPTION
%token <sval>FOOD
%token <sval>EXIT
%token <sval>UNKNOWN
%type  <sval>actionList
%type  <sval>game
%type  <sval>action
%type  <sval>moveType
%type  <sval>fightType
%type  <sval>eatType
%type  <sval>anError
%type  <sval>someAction
%{
void quit();
void initGame();
%}

%%
game: startGame actionList { printf("enter a command: "); }
	| EXIT { quit(); }
;

startGame: START { initGame(); }
;

actionList: actionList action
	| action
;

action: moveType {$$ = $1;}
	| fightType {$$ = $1;}
	| eatType {$$ = $1;}
	| anError {$$ = $1;}
;

moveType: MOTION DIRECTION {printf("you %s %s\n", $1, $2); }
;

fightType: AGGRESSION HAZARD {printf("you %s %s to death!\n", $1, $2); }
;

eatType: CONSUMPTION FOOD {printf("you are %sing a %s\n", $1, $2); }
;

anError: someAction UNKNOWN {printf("Don't know how to %s %s\n", $1, $2); }
;

someAction: MOTION {$$ = $1;}
	| AGGRESSION {$$ = $1;}
	| CONSUMPTION {$$ = $1;}
;
%%
void quit()
{
	printf("Thanks for playing Zork!\n"); 
	exit(0);
}

void initGame()
{
	printf("you're playing the game!\n");
}