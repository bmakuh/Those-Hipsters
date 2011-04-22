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
struct aRoom;
void initGame();
int room;
struct aRoom rooms[7];
%}

%%
game: startGame actionList EXIT { quit(); }
;

startGame: START { initGame(); printf("enter a command: "); }
;

actionList: actionList action { printf("enter a command: "); }
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

struct aRoom {
	int hasObject;
	int hasOvercomeHazard;
	char objectName[50];
	char hazardName[50];
	char roomName[50];
};

void initGame() {
	printf("Welcome to the land of Zork!\n");

	strcpy(rooms[0].hazardName, "none");
	strcpy(rooms[0].objectName, "none");
	strcpy(rooms[0].roomName, "The Stargate");
	
	strcpy(rooms[1].hazardName, "The Bush Administration");
	strcpy(rooms[1].objectName, "none");
	strcpy(rooms[1].roomName, "Guantanamo Bay");
	
	strcpy(rooms[2].hazardName, "none");
	strcpy(rooms[2].objectName, "Delectable morsel");
	strcpy(rooms[2].roomName, "Room of Awesome Woodland Creatures");
	
	strcpy(rooms[3].hazardName, "none");
	strcpy(rooms[3].objectName, "none");
	strcpy(rooms[3].roomName, "A Really Confusing Room");
	
	strcpy(rooms[4].hazardName, "none");
	strcpy(rooms[4].objectName, "Unicorndog");
	strcpy(rooms[4].roomName, "Unicorndog Stables");
	
	strcpy(rooms[5].hazardName, "Voldemort");
	strcpy(rooms[5].objectName, "none");
	strcpy(rooms[5].roomName, "The Shire");

	return;
}