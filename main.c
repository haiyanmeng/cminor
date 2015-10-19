#include "lex.yy.c"
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
	int i;

//	for(i=0; i<argc; i++)
//		fprintf(stdout, "argc %d: %s\n", i, argv[i]);

	if(strcmp(argv[1], "-scan") != 0) {
		fprintf(stderr, "The option of %s should be: -scan\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	if((yyin = fopen(argv[2], "r")) == NULL) {
		fprintf(stderr, "fopen fails to open %s: %s.\n", argv[2], strerror(errno));
		exit(EXIT_FAILURE);
	}

	while(1) {
		int t;
		t = yylex();
		
		if(!t) 
			break;

		if(token_string(t, yytext, yyleng) != 0)
			exit(EXIT_FAILURE);
	}

	return 0;
}
