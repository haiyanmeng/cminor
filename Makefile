FLEX_FILE = scanner.flex
BISON_FILE = parser.bison

all: cminor

cminor: main.c expr.o scanner.o parser.tab.o
	gcc main.o expr.o scanner.o parser.tab.o -o cminor -lm

%.o: %.c *.h
	gcc -Wall -c $< -o $@

scanner.c: $(FLEX_FILE) parser.tab.h
	flex -o scanner.c $(FLEX_FILE)

parser.tab.c parser.tab.h: $(BISON_FILE)
	yacc -d -bparser -v $(BISON_FILE)
	
clean:
	rm -f cminor *.o scanner.c parser.tab.* parser.output
