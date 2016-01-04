FLEX_FILE = scanner.flex
BISON_FILE = parser.bison

all: cminor 

# Add expr.o and other.o here 
cminor: main.o scanner.o parser.tab.o type.o param_list.o expr.o stmt.o decl.o symbol.o hash_table.o scope.o library.o register.o
	gcc -g main.o scanner.o parser.tab.o type.o param_list.o expr.o stmt.o decl.o symbol.o hash_table.o scope.o library.o register.o -o cminor -lm

%.o: %.c *.h
	gcc -g -Wall -c $< -o $@

scanner.c: $(FLEX_FILE) parser.tab.h
	flex -o scanner.c $(FLEX_FILE)

parser.tab.c parser.tab.h: $(BISON_FILE)
	yacc -d -bparser -v $(BISON_FILE)
	
clean:
	rm -f cminor *.o scanner.c parser.tab.* parser.output lex.yy.*
