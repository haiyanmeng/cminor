#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include "decl.h"

// declare the parser function generated from parser.bison
extern int yyparse();
extern FILE *yyin;
extern struct decl *program;

int main(int argc, char *argv[]) {

	if(strcmp(argv[1], "-scan") != 0 && strcmp(argv[1], "-parse") != 0) {
		fprintf(stderr, "The option of %s should be: -scan or -parse\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	if((yyin = fopen(argv[2], "r")) == NULL) {
		fprintf(stderr, "fopen fails to open %s: %s.\n", argv[2], strerror(errno));
		exit(EXIT_FAILURE);
	}

	if(yyparse() == 0) {
		fprintf(stdout, "parse successful: \n");
		decl_print(program, 0);
	} else {
		fprintf(stdout, "parse failed\n");
		exit(EXIT_FAILURE);
	}

	return 0;
}
