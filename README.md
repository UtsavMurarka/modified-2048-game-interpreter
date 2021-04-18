# Modified 2048 Game Interpreter
An interpreter for a modified version of the 2048 game created using Flex and Bison for the compiler construction course

# The Game
This is a modified version of the 2048 game, which supports subtraction, multiplication and division apart from simple addition of tiles, which means, 2 equal tiles can annihilate together (be made 0 by subtraction), or be reduced to 1 by division, or be squared by multiplication, or double by addition (as in the standard game).

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

## Example

### Input (example/input.txt)
```
ADD LEFT.
SUBTRACT RIGHT.
ASSIGN 2 TO 2,2.
ASSIGN 2 TO 1,2.
VAR var1 IS 2,2.
VAR var2 IS 1,2.
ADD UP.
DIVIDE DOWN.
MULTIPLY LEFT.
WRONG STATEMENT
ASSIGN 7 TO 4,4.
ASSIGN VALUE IN 4,4 TO 3,3.
ASSIGN VALUE IN 3,3 TO 2,2.
ASSIGN VALUE IN 2,2 TO 1,1.
VALUE IN 1,1.
```

### Output (example/output.txt)
```
2048> Hi, I am the 2048-game Engine.
2048> The Current State is

-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 0 | 4 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Left Move Complete and Random Tile Added
2048> The Current State is

-----------------
| 0 | 0 | 4 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 4 | 0 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Right Move Complete and Random Tile Added
2048> The Current State is

-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Assignment Done
2048> The Current State is

-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Assignment Done
2048> The Current State is

-----------------
| 0 | 2 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Tile Named Succesfully.
2048> The Current State is

-----------------
| 0 | 2 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Tile Named Succesfully.
2048> The Current State is

-----------------
| 0 | 2 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 4 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Up Move Complete and Random Tile Added
2048> The Current State is

-----------------
| 0 | 4 | 4 | 8 | 
-----------------
| 0 | 2 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
2048> Please type a command
----> 
2048> Down Move Complete and Random Tile Added
2048> The Current State is

-----------------
| 0 | 0 | 4 | 0 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 0 | 4 | 0 | 0 | 
-----------------
| 0 | 2 | 4 | 8 | 
-----------------
2048> Please type a command
----> 
2048> Left Move Complete and Random Tile Added
2048> The Current State is

-----------------
| 4 | 0 | 0 | 2 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 4 | 0 | 0 | 0 | 
-----------------
| 2 | 4 | 8 | 0 | 
-----------------
2048> Please type a command
----> 2048> Invalid Command. Please Re-enter
----> 
2048> Assignment Done
2048> The Current State is

-----------------
| 4 | 0 | 0 | 2 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 4 | 0 | 0 | 0 | 
-----------------
| 2 | 4 | 8 | 7 | 
-----------------
2048> Please type a command
----> 
2048> Value at 4,4 is 7
----> 
2048> Assignment Done
2048> The Current State is

-----------------
| 4 | 0 | 0 | 2 | 
-----------------
| 0 | 0 | 0 | 0 | 
-----------------
| 4 | 0 | 7 | 0 | 
-----------------
| 2 | 4 | 8 | 7 | 
-----------------
2048> Please type a command
----> 
2048> Value at 3,3 is 7
----> 
2048> Assignment Done
2048> The Current State is

-----------------
| 4 | 0 | 0 | 2 | 
-----------------
| 0 | 7 | 0 | 0 | 
-----------------
| 4 | 0 | 7 | 0 | 
-----------------
| 2 | 4 | 8 | 7 | 
-----------------
2048> Please type a command
----> 
2048> Value at 2,2 is 7
----> 
2048> Assignment Done
2048> The Current State is

-----------------
| 7 | 0 | 0 | 2 | 
-----------------
| 0 | 7 | 0 | 0 | 
-----------------
| 4 | 0 | 7 | 0 | 
-----------------
| 2 | 4 | 8 | 7 | 
-----------------
2048> Please type a command
----> 
2048> Value at 1,1 is 7
----> 
```
