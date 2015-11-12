#include "decl.h"
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"
#include "scope.h"

extern int level;
extern struct scope *head; 

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

void decl_resolve(struct decl *d, int seq) {
	if(!d) return;

	struct symbol *sym;
	if(level == 0) {
		sym = symbol_create(SYMBOL_GLOBAL, seq, d->type, d->name);
	} else {
		sym = symbol_create(SYMBOL_LOCAL, seq, d->type, d->name);
	}

	struct symbol *s = scope_lookup_local(d->name);	
	if(s) {
		switch(s->kind) {
			case SYMBOL_GLOBAL:
				fprintf(stderr, "resolve error: %s has been defined globally!\n", d->name);
				break;
			case SYMBOL_LOCAL:
				fprintf(stderr, "resolve error: %s has been defined as local %d (level %d)\n", d->name, s->which, level);
				break;
			case SYMBOL_PARAM:
				fprintf(stderr, "resolve error: %s has been defined as param %d (level %d)\n", d->name, s->which, level);
				break;
		}
	} else {
		d->symbol = sym;
	
		scope_bind(d->name, sym);
		
		/* resolve the initializer, the intializer of level 0 can not involve identifier */
	
		if(d->value) {
			expr_resolve(d->value, d->name);
		}
	
		if(d->code) {
			scope_enter();	
			param_list_resolve(d->type->params, 0);
			stmt_resolve(d->code->body, 0);
			scope_exit();
		}
	}

	decl_resolve(d->next, seq+1);
}

