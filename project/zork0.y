%union yylval {
	float fval;
	int ival;
	char *sval;
}
%token <sval>START
%token <sval>LOOK
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
%type  <sval>lookType
%type  <sval>anError
%type  <sval>someAction
%{
void quit();
struct aRoom;
void initGame();
void moveDirection(char direction);
void attack(char* how);
void consume(char* how);
void look();
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
	| lookType {$$ = $1;}
	| anError {$$ = $1;}
;

moveType: MOTION DIRECTION { moveDirection(*$2); }
;

fightType: AGGRESSION HAZARD { attack($1); }
;

eatType: CONSUMPTION FOOD { consume($1); }
;

lookType: LOOK { look(); $$ = $1; }
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
	int  hasObject;
	int  hasOvercomeHazard;
	char objectName[50];
	char hazardName[50];
	char roomName[50];
	char exits[8];
	int  w;
	int  e;
	int  n;
	int  s;
};

void look() {
	printf("Welcome to %s\nHazards: %s\nObjects: %s\nExits: %s\n", rooms[room].roomName, rooms[room].hazardName, rooms[room].objectName, rooms[room].exits);
}

void moveDirection(char direction) {
	switch(tolower(direction)) {
		case 'n':
			if(rooms[room].n != -1)
				room = rooms[room].n;
			else
				printf("You can't go that way!\n");
			break;
		case 'e':
			if(rooms[room].e != -1)
				room = rooms[room].e;
			else
				printf("You can't go that way!\n");
			break;
		case 's':
			if(rooms[room].s != -1)
				room = rooms[room].s;
			else
				printf("You can't go that way!\n");
			break;
		case 'w':
			if(rooms[room].w != -1)
				room = rooms[room].w;
			else
				printf("You can't go that way!\n");
			break;
	}
	/*printf("direction: %c\n", direction);
	printf("N E S W: %i %i %i %i\n", rooms[room].n, rooms[room].e, rooms[room].s, rooms[room].w);*/
	printf("Welcome to %s\nHazards: %s\nObjects: %s\nExits: %s\n", rooms[room].roomName, rooms[room].hazardName, rooms[room].objectName, rooms[room].exits);
}

void attack(char* how) {
	printf("You %s the %s to death!\n", how, rooms[room].hazardName);
	strcpy(rooms[room].hazardName, "none");
}

void consume(char* how) {
	printf("You are %sing a %s.\n", how, rooms[room].objectName);
	strcpy(rooms[room].objectName, "none");
}

void initGame() {
	printf("Welcome to the land of Zork!\n");
	printf("You are in the stargate.\nexits: s\n");

	strcpy(rooms[0].hazardName, "none");
	strcpy(rooms[0].objectName, "none");
	strcpy(rooms[0].roomName, "The Stargate");
	strcpy(rooms[0].exits, "s");
	rooms[0].n = -1;
	rooms[0].e = -1;
	rooms[0].s = 1;
	rooms[0].w = -1;
	
	strcpy(rooms[1].hazardName, "Bush_administration");
	strcpy(rooms[1].objectName, "none");
	strcpy(rooms[1].roomName, "Guantanamo Bay");
	strcpy(rooms[1].exits, "e s");
	rooms[1].n = -1;
	rooms[1].e = 3;
	rooms[1].s = 2;
	rooms[1].w = -1;
	
	strcpy(rooms[2].hazardName, "none");
	strcpy(rooms[2].objectName, "delectable_morsel");
	strcpy(rooms[2].roomName, "Room of Awesome Woodland Creatures");
	strcpy(rooms[2].exits, "n e");
	rooms[2].n = 1;
	rooms[2].e = 3;
	rooms[2].s = -1;
	rooms[2].w = -1;
	
	strcpy(rooms[3].hazardName, "none");
	strcpy(rooms[3].objectName, "none");
	strcpy(rooms[3].roomName, "A Really Confusing Room");
	strcpy(rooms[3].exits, "n e s w");
	rooms[3].n = 3;
	rooms[3].e = 5;
	rooms[3].s = 3;
	rooms[3].w = 2;
	
	strcpy(rooms[4].hazardName, "none");
	strcpy(rooms[4].objectName, "Unicorndog");
	strcpy(rooms[4].roomName, "Unicorndog Stables");
	strcpy(rooms[4].exits, "w");
	rooms[4].n = -1;
	rooms[4].e = -1;
	rooms[4].s = -1;
	rooms[4].w = 3;
	
	strcpy(rooms[5].hazardName, "Voldemort");
	strcpy(rooms[5].objectName, "none");
	strcpy(rooms[5].roomName, "The Shire");
	strcpy(rooms[5].exits, "n w");
	rooms[5].n = 4;
	rooms[5].e = -1;
	rooms[5].s = -1;
	rooms[5].w = 3;

	room = 0;

	return;
}