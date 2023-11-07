all: flex gcc run 

flex:

	@flex -o lex.yy.c myFirstLexer.l
	
gcc: 

	@gcc lex.yy.c -o ./lexer -lfl

run:
	@./lexer
	

