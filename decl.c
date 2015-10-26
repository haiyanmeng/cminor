#include "decl.h"
#include <stdlib.h>

struct decl *decl_create(char *name, struct type *t, struct expr *v, struct stmt *c, struct decl *next) {
	struct decl *d = (struct decl *)malloc(sizeof(struct decl));
	d->name = name;
	d->type = t;
	d->value = v;
	d->code = c;
	d->next = next;
	return d;
}

void decl_print(struct decl *d, int indent) {
	if(!d) return;

	printf("\n");
	printf("%s: ", d->name);
	type_print(d->type);
	if(d->value) {
		printf("= ");
		expr_print(d->value);
		printf(";\n");
	} else if(d->code) {
		stmt_print(d->code, 4);
		printf("\n");
	} else {
		printf(";\n");
	}

	decl_print(d->next, 4);

	return;
}



