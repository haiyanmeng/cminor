FLEX_FILE = scanner.flex

all: cminor

lex.yy.c: $(FLEX_FILE)
	flex $(FLEX_FILE)
	
cminor: main.c lex.yy.c token.c
	gcc -o cminor main.c token.c

clean:
	rm -f cminor *.o lex.yy.c


