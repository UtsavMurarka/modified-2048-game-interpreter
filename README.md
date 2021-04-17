# Modified 2048 Game Interpreter
An interpreter for a modified version of the 2048 game created using Flex and Bison for the compiler construction course

# The Game
This is a modified version of the 2048 game, which supports subtraction, multiplication and division apart from simple addition of tiles, which means, 2 equal tiles can annihilate together (be made 0 by subtraction), or be reduced to 1 by division, or be squared by multiplication.

The interpreter also allows for setting values to the tiles (possibly to make puzzles), Naming Tiles, Querying the value in a tile. 

### Supported Functionality and Syntax
1. 16 Moves: `ADD/SUBTRACT/MULTIPLY/DIVIDE LEFT/RIGHT/UP/DOWN.`
2. Assignment: `ASSIGN <value> TO <x>,<y>.`
3. Naming: `VAR <varname> IS <x>,<y>.`
4. Query: `VALUE IN <x>,<y>.`

Note: Command 2 and 4 can be nested like this:
`ASSIGN VALUE IN <x>,<y> TO <x>,<y>.`


### Files
1. `game.l` : lexer
2. `game.y` : parser


### Steps to run
1. `make`
2. `./game`
