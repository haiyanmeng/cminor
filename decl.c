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
		// here can have function prototype, function definition, variable declaration.
		if(d->type->kind == TYPE_FUNCTION) {
			if(!(d->code)) {
				sym = symbol_create(SYMBOL_GLOBAL, seq, d->type, d->name, FUNC_PROTO);
			} else {
				sym = symbol_create(SYMBOL_GLOBAL, seq, d->type, d->name, FUNC_DEF);
			}
		} else {
				sym = symbol_create(SYMBOL_GLOBAL, seq, d->type, d->name, FUNC_NOT);
		}
	} else {
		//FIXME: here can have function prototype and variable declaration, and stmt.
		if(d->type->kind == TYPE_FUNCTION) {
			if(!(d->code)) {
				sym = symbol_create(SYMBOL_LOCAL, seq, d->type, d->name, FUNC_PROTO);
			} else {
				fprintf(stderr, "Function definitions can not be nested!\n");
			}
		} else {
			sym = symbol_create(SYMBOL_LOCAL, seq, d->type, d->name, FUNC_NOT);
		}
	}

	struct symbol *s = scope_lookup_local(d->name);	
	if(s) {
		switch(s->kind) {
			case SYMBOL_GLOBAL:
				if(s->t == FUNC_PROTO && sym->t == FUNC_DEF) {
					scope_rebind(d->name, sym);
				} else if(s->t == FUNC_PROTO && sym->t == FUNC_PROTO) {
					d->symbol = sym;
				} else {
					fprintf(stderr, "resolve error: %s has been defined globally!\n", d->name);
					resolve_error_count += 1;
				}
				break;
			case SYMBOL_LOCAL:
				if(s->t == FUNC_PROTO) {
					fprintf(stderr, "resolve error: a function prototype named %s has been declared locally (level %d)\n", d->name, level);
				} else {
					fprintf(stderr, "resolve error: %s has been defined as local %d (level %d)\n", d->name, s->which, level);
				}
				resolve_error_count += 1;
				break;
			case SYMBOL_PARAM:
				fprintf(stderr, "resolve error: %s has been defined as param %d (level %d)\n", d->name, s->which, level);
				resolve_error_count += 1;
				break;
		}
	} else {
		d->symbol = sym;
		scope_bind(d->name, sym);
		if(d->type->kind != TYPE_FUNCTION) {
			seq += 1;
		}
	}		

	/* resolve the size of array */
	type_resolve(d->type);

	/* resolve the initializer and function body no matter whether the variable or the function is defined or not. */
	if(d->value) {
		expr_resolve(d->value);
	}

	if(d->code) {
		scope_enter();	
		param_list_resolve(d->type->params, 0);
		stmt_resolve(d->code->body, 0);
		scope_exit();
	} 

	decl_resolve(d->next, seq);
}

//here, all the local hash tables and scopes have been disappeared except for the global hash table.
void decl_typecheck(struct decl *d) {
	if(!d) return;

	if(d->value) {
		// declaration with initialization
		if(d->symbol->kind == SYMBOL_GLOBAL) {
			if(!expr_is_constant(d->value)) {
				fprintf(stderr, "type error: the intializer of a global variable (%s) should be constant!\n", d->name);
				type_error_count += 1;
			}
		}

		struct type *t;
		if(d->type->kind == TYPE_ARRAY) {
			type_typecheck(d->type);
			t = expr_typecheck(d->value, 1);
			type_arraysize_typecheck(d->type, d->value);		
		} else {
			t = expr_typecheck(d->value, 0);
		}

		if(!type_equals(d->type, t)) {
			fprintf(stderr, "type error: the type of %s does not match the type of its initializer!\n", d->name);
			type_error_count += 1;
		}
	} else if(d->code) {
		// function definition
		stmt_typecheck(d->code, d->name);
	} else {
		// declaration without initialization or function prototype
		if(d->type->kind == TYPE_ARRAY) {
			type_typecheck(d->type);
		}

		// check the consistency between function prototype and function definition
		if(!(d->symbol->t == FUNC_NOT)) {
			struct symbol *s = scope_lookup(d->name, 0);
			if(!s) {
				exit(EXIT_FAILURE);
			}
			if(s->t == FUNC_PROTO) { //the source code file does not include the definition of a function
				if(s != d->symbol) {
					if(!type_equals(d->type, s->type)) {
						fprintf(stderr, "type error: the function %s has multiple conflicting prototype!\n", d->name);
						type_error_count += 1;
					}
				}
			} else { //function definition exists in the same source file
				if(!type_equals(d->type, s->type)) {
					fprintf(stderr, "type error: the function definition of %s does not match its prototype!\n", d->name);
					type_error_count += 1;
				}
			} 
		}
	}
	decl_typecheck(d->next);
}




