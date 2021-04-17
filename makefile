game: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o game

lex.yy.c: y.tab.c game.l
	lex game.l

y.tab.c: game.y
	yacc -d game.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h game game.dSYM