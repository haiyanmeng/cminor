FLEX_FILE = scanner.flex
BISON_FILE = parser.bison

all: cminor good1.s good2.s good3.s good4.s good5.s good6.s good7.s good8.s good9.s good10.s good11.s good12.s good13.s good14.s good15.s good16.s good17.s good18.s good19.s good20.s a.out.1 a.out.2 a.out.3 a.out.4 a.out.5 a.out.6 a.out.7 a.out.8 a.out.9 a.out.10 a.out.11 a.out.12 a.out.13 a.out.14 a.out.15 a.out.16 a.out.17 a.out.18 a.out.19 a.out.20

a.out.1: good1.o library.o
	gcc $^ -o $@

a.out.2: good2.o library.o
	gcc $^ -o $@

a.out.3: good3.o library.o
	gcc $^ -o $@

a.out.4: good4.o library.o
	gcc $^ -o $@

a.out.5: good5.o library.o
	gcc $^ -o $@

a.out.6: good6.o library.o
	gcc $^ -o $@

a.out.7: good7.o library.o
	gcc $^ -o $@

a.out.8: good8.o library.o
	gcc $^ -o $@

a.out.9: good9.o library.o
	gcc $^ -o $@

a.out.10: good10.o library.o
	gcc $^ -o $@

a.out.11: good11.o library.o
	gcc $^ -o $@

a.out.12: good12.o library.o
	gcc $^ -o $@

a.out.13: good13.o library.o
	gcc $^ -o $@

a.out.14: good14.o library.o
	gcc $^ -o $@

a.out.15: good15.o library.o
	gcc $^ -o $@

a.out.16: good16.o library.o
	gcc $^ -o $@

a.out.17: good17.o library.o
	gcc $^ -o $@

a.out.18: good18.o library.o
	gcc $^ -o $@

a.out.19: good19.o library.o
	gcc $^ -o $@

a.out.20: good20.o library.o
	gcc $^ -o $@

%.o: %s
	gcc -c $< -o $@ -g

%.o: %.c
	gcc -c $< -o $@ -g

%.s: %.cminor
	./cminor -codegen $< $@

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
	rm -f cminor *.o scanner.c parser.tab.* parser.output lex.yy.* a.out* *.s
