#include "decl.h"
#include <stdlib.h>

struct decl *decl_create(char *name, struct type *t, struct expr *v, struct stmt *c, struct decl *next) {
	struct decl *d = (struct decl *)malloc(sizeof(struct decl));

	if(!d) {
		fprintf(stderr, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	d->name = name;
	d->type = t;
	d->value = v;
	d->code = c;
	d->next = next;
	return d;
}

void decl_print(struct decl *d, int indent) {
	if(!d) return;

	/* indent process */
	if(indent > 0) {
		char *spaces = (char *)malloc(indent+1);

		if(!spaces) {
			fprintf(stderr, "malloc fails!\n");
			exit(EXIT_FAILURE);
		}

		int i;
		for(i = 0; i < indent; i++) {
			spaces[i] = ' ';
		}
		spaces[i] = '\0';
		printf("%s", spaces);
		
		free(spaces);
	}

	printf("%s: ", d->name);
	type_print(d->type);
	if(d->value) {
		// declaration with initialization
		printf(" = ");
		expr_print(d->value);
		printf(";\n");
	} else if(d->code) {
		// function definition
		printf(" =\n");
		stmt_print(d->code, indent, indent, 1);
	} else {
		// declaration without initialization
		printf(";\n");
	}

	decl_print(d->next, indent);

	return;
}



