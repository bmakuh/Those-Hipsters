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
void moveDirection(char direction);
void attack(char how);
void consume(char how);
int room;
int numRooms = 6;
struct aRoom rooms[6];
%}

%%
game: startGame actionList EXIT { quit(); }
;

startGame: START { initGame(); printf("enter a command: "); }
;

actionList: actionList action { printf("enter a command: "); }
	| action { printf("enter a command: "); }
;

action: moveType {$$ = $1;}
	| fightType {$$ = $1;}
	| eatType {$$ = $1;}
	| anError {$$ = $1;}
;

moveType: MOTION DIRECTION { moveDirection($2); }
;

fightType: AGGRESSION HAZARD { attack($1); }
;

eatType: CONSUMPTION FOOD { consume($1); }
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

void moveDirection(char direction) {
	if ( room < numRooms ) {
		room++;
	} else {
		room--;
	}
}

void attack(char how) {
	printf("You %s the %s to death!\n", how, rooms[room].hazardName);
	strcpy(rooms[room].hazardName, "none");
}

void consume(char how) {
	printf("You are %sing a %s.\n", how, rooms[room].objectName);
	strcpy(rooms[room].objectName, "none");
}

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

	room = 0;

	return;
}