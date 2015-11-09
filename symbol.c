#include "symbol.h"
#include <stdio.h>
#include <stdlib.h>


struct symbol *symbol_create(symbol_t kind, struct type *type, char *name) {
	struct symbol *s = (struct symbol *)malloc(sizeof(struct symbol));

	if(!s) {
		fprintf(stderr, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	s->kind = kind;
	s->type = type;
	s->name = name;
	return s;
}