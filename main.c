#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include "decl.h"
#include "scope.h"

// declare the parser function generated from parser.bison
extern int yyparse();
extern FILE *yyin;
extern struct decl *program;

int main(int argc, char *argv[]) {
	/* there is no difference between these three options. */
	if(strcmp(argv[1], "-scan") != 0 && strcmp(argv[1], "-parse") != 0 && strcmp(argv[1], "-print") != 0 \
		&& strcmp(argv[1], "-resolve")) {
		fprintf(stderr, "The option of %s should be: -scan or -parse or -print\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	if((yyin = fopen(argv[2], "r")) == NULL) {
		fprintf(stderr, "fopen fails to open %s: %s.\n", argv[2], strerror(errno));
		exit(EXIT_FAILURE);
	}

	if(yyparse() == 0) {
		if(!strcmp(argv[1], "-scan")) {
			fprintf(stdout, "scan succeeded!\n");
		} else if(!strcmp(argv[1], "-print") || !strcmp(argv[1], "-parse")) {
			decl_print(program, 0);
		} else if(!strcmp(argv[1], "-resolve")) {
			scope_init();
			decl_resolve(program, 0);
			scope_print();
		}
	} else {
		exit(EXIT_FAILURE);
	}

	return 0;
}
