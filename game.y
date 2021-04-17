%{
void yyerror (char *s);
int yylex();
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <string.h>
int board[4][4];
char var_board[4][4][1000];
void move(char op, char dir);
void moveLeft(char op);
void moveRight(char op);
void moveUp(char op);
void moveDown(char op);
void shiftAndMergeRow(int row, char dir, char op);
void shiftAndMergeCol(int col, char dir, char op);
void assignment (int num, char* coord);
void printBoard();
void clearNamesForZeroTiles();
int isNameNew(char* name);
int getVal(char* coord);
void var_init(char* coord, char* varstr);
void printError();
%}

%union {char dir; char op; int num; char* id;}
%start command
%type <num> number
%token <id> identifier
%token <num> valtoken
%token <op> operation
%token <dir> direction
%token <id> coordinate
%token assign
%token to
%token var
%token is
%token valin
%token err_token

%%


command : operation direction end_st						{move($1, $2);}
		| assign number to coordinate end_st 				{assignment($2, $4);}
		| var identifier is coordinate end_st 				{var_init($4, $2);}
		| valin coordinate end_st 							{getVal($2);}
		| command operation direction end_st				{move($2, $3);}
		| command assign number to coordinate end_st 		{assignment($3, $5);}
		| command var identifier is coordinate end_st 		{var_init($5, $3);}
		| command valin coordinate end_st 					{getVal($3);}
		| error '\n'										{printError() ;yyerrok;yyclearin ;}
		;

number : valin coordinate								{$$ = getVal($2);}
	   | valtoken										{$$ = $1;}
	   ;

end_st : '.' '\n'										{}
	   | '.'											{}
	   ;
%%


int main (void) {
	// init game board
	int i, j;
	for(i=0; i<4; i++) {
		for(int j=0; j<4; j++){
			board[i][j] = 0;
		}
	}
	// Generate random numbers to determine tile value and location
	srand(time(0));
	int x = rand()%4;
	int y = rand()%4;
	int val = rand()%2 + 1;
	board[x][y] = 2*val;
	printf("2048> Hi, I am the 2048-game Engine.\n");
	printBoard();

	return yyparse ( );
}


void printError(){
	printf("2048> Invalid Command. Please Re-enter\n----> ");
	fprintf(stderr, "-1\n");
}


int isNameNew(char* name){
	for(int i=0; i<4; i++){
		for(int j=0; j<4; j++){
			char temp[1000];
			strcpy(temp, var_board[i][j]);
			char* token = strtok(temp, ",");
			while(token != NULL){
				if(strcmp(token, name) == 0){
					printf("\n2048> The name %s is already assigned to the tile %d,%d. Cannot be reused.\n", name, i+1, j+1);
					printError();
					return 0;
				}
				token = strtok(NULL, ",");
			}
		}
	}
	return 1;
}

void var_init(char* coord, char* varstr){
	char *varname;
	const char deli[] = " ";
	varname = strtok(varstr, deli);
	int x = coord[0]-'0'-1;
	int y = coord[2]-'0'-1;
	if(board[x][y] == 0){
		printf("\n2048> Cannot assign name to 0 tile.\n");
		printError();
		return;
	}
	if(isNameNew(varname) == 1){
		strcat(var_board[x][y], varname);
		strcat(var_board[x][y], ",");
		printf("\n2048> Tile Named Succesfully.\n");
		printBoard();

	}

}

int getVal(char* coord){
	printf("\n2048> Value at %d,%d is %d\n----> ", coord[0]-'0', coord[2]-'0', board[coord[0]-'0'-1][coord[2]-'0'-1]);
	return board[coord[0]-'0'-1][coord[2]-'0'-1];
}

void assignment (int num, char* coord){
	char xc = coord[0];
	char yc = coord[2];
	int x = xc - '0';
	int y = yc - '0';
	board[x-1][y-1] = num;
	clearNamesForZeroTiles();
	printf("\n2048> Assignment Done\n");
	printBoard();
}

void clearNamesForZeroTiles(){
	for(int i=0; i<4; i++){
		for(int j=0; j<4; j++){
			if(board[i][j] == 0){
				strcpy(var_board[i][j], "");
			}
		}
	}
}

void printBoard(){
	printf("2048> The Current State is\n");
	for(int i=0; i<4; i++){
		printf("\n-----------------\n");
		printf("| ");
		for(int j=0; j<4; j++){
			printf("%d", board[i][j]);
			printf(" | ");
		}
	}
	printf("\n-----------------\n");
	printf("2048> Please type a command\n----> ");

	/* Writing To stderr for automated evaluation*/

	for(int i=0; i<4; i++){
		for(int j=0; j<4; j++){
			fprintf(stderr, "%d ", board[i][j]);
		}
	}
	for(int i=0; i<4; i++){
		for(int j=0; j<4; j++){
			if(strcmp(var_board[i][j], "") != 0){
				char temp[1000];
				strcpy(temp, var_board[i][j]);
				char* token = strtok(temp, ",");
				fprintf(stderr, "%d,%d", i+1, j+1);
				while (token != NULL) {
					fprintf(stderr, "%s", token);
			        // printf("%s\n", token);
			        token = strtok(NULL, ",");
			        if(token != NULL) {
			        	fprintf(stderr, ",");
			        }
			        else{
			        	fprintf(stderr, " ");	
			        }
			    }
			}
		}
	}
	fprintf(stderr, "\n");
}

void move(char op, char dir){
	if(dir == 'L') moveLeft(op);
	if(dir == 'R') moveRight(op);
	if(dir == 'U') moveUp(op);
	if(dir == 'D') moveDown(op);
}

void moveLeft(char op){
	for(int i=0; i<4; i++){
		shiftAndMergeRow(i, 'L', op);
	}
	// add random tile
	int x = rand()%4;
	int y = rand()%4;
	while(board[x][y] != 0){
		x = rand()%4;
		y = rand()%4;
	}
	board[x][y] = 2 * (rand()%2 + 1);
	printf("\n2048> Left Move Complete and Random Tile Added\n");
	clearNamesForZeroTiles();
	printBoard();
}
void moveRight(char op){
	for(int i=0; i<4; i++){
		shiftAndMergeRow(i, 'R', op);
	}
	// add random tile
	int x = rand()%4;
	int y = rand()%4;
	while(board[x][y] != 0){
		x = rand()%4;
		y = rand()%4;
	}
	board[x][y] = 2 * (rand()%2 + 1);
	printf("\n2048> Right Move Complete and Random Tile Added\n");
	clearNamesForZeroTiles();
	printBoard();
}
void moveUp(char op){
	for(int i=0; i<4; i++){
		shiftAndMergeCol(i, 'U', op);
	}
	// add random tile
	int x = rand()%4;
	int y = rand()%4;
	while(board[x][y] != 0){
		x = rand()%4;
		y = rand()%4;
	}
	board[x][y] = 2 * (rand()%2 + 1);
	printf("\n2048> Up Move Complete and Random Tile Added\n");
	clearNamesForZeroTiles();
	printBoard();
}
void moveDown(char op){
	for(int i=0; i<4; i++){
		shiftAndMergeCol(i, 'D', op);
	}
	// add random tile
	int x = rand()%4;
	int y = rand()%4;
	while(board[x][y] != 0){
		x = rand()%4;
		y = rand()%4;
	}
	board[x][y] = 2 * (rand()%2 + 1);
	printf("\n2048> Down Move Complete and Random Tile Added\n");
	clearNamesForZeroTiles();
	printBoard();
}

void shiftAndMergeRow(int row, char dir, char op){
	if(dir == 'L'){
		for(int i=0; i<4; i++){
			for(int j=1; j<4; j++){
				if(board[row][j-1] == 0){
					board[row][j-1] = board[row][j];
					strcat(var_board[row][j-1], var_board[row][j]);
					
					board[row][j] = 0;
					strcpy(var_board[row][j], "");
				}
			}
		}

		for(int i=0; i<3; i++){
			if(board[row][i] == board[row][i+1] && board[row][i]!=0){
				// op
				if(op == 'A'){board[row][i] = board[row][i] + board[row][i];	board[row][i+1] = 0;}
				if(op == 'S'){board[row][i] = board[row][i] - board[row][i];	board[row][i+1] = 0;}
				if(op == 'M'){board[row][i] = board[row][i] * board[row][i];	board[row][i+1] = 0;}
				if(op == 'D'){board[row][i] = board[row][i] / board[row][i];	board[row][i+1] = 0;}
				strcat(var_board[row][i], var_board[row][i+1]); 
				strcpy(var_board[row][i+1], "");
				
			}
		}
		for(int i=0; i<4; i++){
			for(int j=1; j<4; j++){
				if(board[row][j-1] == 0){
					board[row][j-1] = board[row][j];
					strcat(var_board[row][j-1], var_board[row][j]);

					board[row][j] = 0;
					strcpy(var_board[row][j], "");
				}
			}
		}
	}
	if(dir == 'R'){
		for(int i=0; i<4; i++){
			for(int j=0; j<3; j++){
				if(board[row][j+1] == 0){
					board[row][j+1] = board[row][j];
					strcat(var_board[row][j+1], var_board[row][j]);

					board[row][j] = 0;
					strcpy(var_board[row][j], "");
				}
			}
		}
		for(int i=3; i>0; i--){
			if(board[row][i] == board[row][i-1] && board[row][i]!=0){
				// op
				if(op == 'A'){board[row][i] = board[row][i] + board[row][i];	board[row][i-1] = 0;}
				if(op == 'S'){board[row][i] = board[row][i] - board[row][i];	board[row][i-1] = 0;}
				if(op == 'M'){board[row][i] = board[row][i] * board[row][i];	board[row][i-1] = 0;}
				if(op == 'D'){board[row][i] = board[row][i] / board[row][i];	board[row][i-1] = 0;}
				strcat(var_board[row][i], var_board[row][i-1]); 
				strcpy(var_board[row][i-1], "");
			}
		}
		for(int i=0; i<4; i++){
			for(int j=0; j<3; j++){
				if(board[row][j+1] == 0){
					board[row][j+1] = board[row][j];
					strcat(var_board[row][j+1], var_board[row][j]);

					board[row][j] = 0;
					strcpy(var_board[row][j], "");
				}
			}
		}
	}
}

void shiftAndMergeCol(int col, char dir, char op){
	if(dir == 'U'){
		for(int i=0; i<4; i++){
			for(int j=1; j<4; j++){
				if(board[j-1][col] == 0){
					board[j-1][col] = board[j][col];
					strcat(var_board[j-1][col], var_board[j][col]);

					board[j][col] = 0;
					strcpy(var_board[j][col], "");
				}
			}
		}
		for(int i=0; i<3; i++){
			if(board[i][col] == board[i+1][col] && board[i][col]!=0){
				// op
				if(op == 'A'){board[i][col] = board[i][col] + board[i][col];	board[i+1][col] = 0;}
				if(op == 'S'){board[i][col] = board[i][col] - board[i][col];	board[i+1][col] = 0;}
				if(op == 'M'){board[i][col] = board[i][col] * board[i][col];	board[i+1][col] = 0;}
				if(op == 'D'){board[i][col] = board[i][col] / board[i][col];	board[i+1][col] = 0;}
				strcat(var_board[i][col], var_board[i+1][col]); 
				strcpy(var_board[i+1][col], "");
			}
		}
		for(int i=0; i<4; i++){
			for(int j=1; j<4; j++){
				if(board[j-1][col] == 0){
					board[j-1][col] = board[j][col];
					strcat(var_board[j-1][col], var_board[j][col]);

					board[j][col] = 0;
					strcpy(var_board[j][col], "");
				}
			}
		}
	}
	if(dir == 'D'){
		for(int i=0; i<4; i++){
			for(int j=0; j<3; j++){
				if(board[j+1][col] == 0){
					board[j+1][col] = board[j][col];
					strcat(var_board[j+1][col], var_board[j][col]);

					board[j][col] = 0;
					strcpy(var_board[j][col], "");
				}
			}
		}
		for(int i=3; i>0; i--){
			if(board[i][col] == board[i-1][col] && board[i][col]!=0){
				// op
				if(op == 'A'){board[i][col] = board[i][col] + board[i][col];	board[i-1][col] = 0;}
				if(op == 'S'){board[i][col] = board[i][col] - board[i][col];	board[i-1][col] = 0;}
				if(op == 'M'){board[i][col] = board[i][col] * board[i][col];	board[i-1][col] = 0;}
				if(op == 'D'){board[i][col] = board[i][col] / board[i][col];	board[i-1][col] = 0;}
				strcat(var_board[i][col], var_board[i-1][col]); 
				strcpy(var_board[i-1][col], "");
			}
		}
		for(int i=0; i<4; i++){
			for(int j=0; j<3; j++){
				if(board[j+1][col] == 0){
					board[j+1][col] = board[j][col];
					strcat(var_board[j+1][col], var_board[j][col]);

					board[j][col] = 0;
					strcpy(var_board[j][col], "");
				}
			}
		}
	}
}

void yyerror (char *s) {/*fprintf (stderr, "%s\n", s);*/}