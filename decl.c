#include "decl.h"
#include <stdlib.h>
#include <stdio.h>
#include "symbol.h"
#include "scope.h"
#include "register.h"

extern int level;
extern struct scope *head; 
int local_no = 0;
int str_no = 0;
int func_no = 0;

struct decl *decl_create(char *name, struct type *t, struct expr *v, struct stmt *c, int line, struct decl *next) {
	struct decl *d = (struct decl *)malloc(sizeof(struct decl));

	if(!d) {
		fprintf(stdout, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	d->name = name;
	d->type = t;
	d->value = v;
	d->code = c;
	d->line = line;
	d->next = next;
	return d;
}

void decl_print(struct decl *d, int indent) {
	if(!d) return;

	/* indent process */
	if(indent > 0) {
		char *spaces = (char *)malloc(indent+1);

		if(!spaces) {
			fprintf(stdout, "malloc fails!\n");
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

void decl_resolve(struct decl *d) {
	if(!d) return;

	struct symbol *sym;

	if(level == 0) {
		// here can have function prototype, function definition, variable declaration.
		if(d->type->kind == TYPE_FUNCTION) {
			if(!(d->code)) {
				sym = symbol_create(SYMBOL_GLOBAL, local_no, d->type, d->name, FUNC_PROTO);
			} else {
				local_no = 0;
				sym = symbol_create(SYMBOL_GLOBAL, local_no, d->type, d->name, FUNC_DEF);
			}
		} else {
				sym = symbol_create(SYMBOL_GLOBAL, local_no, d->type, d->name, FUNC_NOT);
		}
	} else {
		//FIXME: here can have function prototype and variable declaration, and stmt.
		if(d->type->kind == TYPE_FUNCTION) {
			if(!(d->code)) {
				sym = symbol_create(SYMBOL_LOCAL, local_no, d->type, d->name, FUNC_PROTO);
			} else {
				fprintf(stdout, "Function definitions can not be nested!\n");
			}
		} else {
			sym = symbol_create(SYMBOL_LOCAL, local_no, d->type, d->name, FUNC_NOT);
		}
	}

	d->symbol = sym;
	struct symbol *s = scope_lookup_local(d->name);	
	if(s) {
		switch(s->kind) {
			case SYMBOL_GLOBAL:
				if(s->t == FUNC_PROTO && sym->t == FUNC_DEF) {
					scope_rebind(d->name, sym);
				} else if(s->t == FUNC_PROTO && sym->t == FUNC_PROTO) {
					d->symbol = sym;
				} else if(s->t == FUNC_DEF && sym->t == FUNC_PROTO) {
					d->symbol = sym;
				}else {
					fprintf(stdout, "resolve error (line %d): %s has been defined globally!\n", d->line, d->name);
					resolve_error_count += 1;
				}
				break;
			case SYMBOL_LOCAL:
				if(s->t == FUNC_PROTO) {
					if(!type_equals(s->type, sym->type)) {
						fprintf(stdout, "resolve error (line %d): a function prototype named %s with a different type has been declared locally (level %d)\n", d->line, d->name, level);
						resolve_error_count += 1;
					}
					d->symbol = sym;	
				} else {
					fprintf(stdout, "resolve error (line %d): %s has been defined as local %d (level %d)\n", d->line, d->name, s->which, level);
					resolve_error_count += 1;
				}
				break;
			case SYMBOL_PARAM:
				fprintf(stdout, "resolve error (line %d): %s has been defined as param %d (level %d)\n", d->line, d->name, s->which, level);
				resolve_error_count += 1;
				break;
		}
	} else {
		scope_bind(d->name, sym);
		if(d->type->kind != TYPE_FUNCTION) {
			local_no += 1;
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
		int params = param_list_resolve(d->type->params, 0);
		symbol_set_param_count(d->symbol, params);
		stmt_resolve(d->code->body);
		scope_exit();
		symbol_set_local_count(d->symbol, local_no);
	} 

	decl_resolve(d->next);
}

//here, all the local hash tables and scopes have been disappeared except for the global hash table.
void decl_typecheck(struct decl *d) {
	if(!d) return;

	if(d->value) {
		// declaration with initialization
		if(d->symbol->kind == SYMBOL_GLOBAL) {
			if(!expr_is_constant(d->value)) {
				fprintf(stdout, "type error (line %d): the intializer (", d->line);
				expr_print(d->value);
				fprintf(stdout, ") of a global variable (%s) should be constant!\n", d->name);
				type_error_count += 1;
			}
		}

		struct type *t;
		if(d->type->kind == TYPE_ARRAY) {
			type_typecheck(d->type);
			t = expr_typecheck(d->value, 1, 0);
			if(!type_equals(t, d->type)) {
				fprintf(stdout, "type error (line %d) : the type (", d->value->line);
				type_print(d->type);
				fprintf(stdout, ") of an array (%s) does not match the type of its initializer (", d->name);
				expr_print(d->value);
				fprintf(stdout, ")!\n");
				type_error_count += 1;
			}
		} else {
			t = expr_typecheck(d->value, 0, 0);
		}

		if(!type_equals(d->type, t)) {
			fprintf(stdout, "type error (line %d): the type (", d->line);
			type_print(d->type);
			fprintf(stdout, ") of %s does not match the type of its initializer (", d->name);
			expr_print(d->value);
			fprintf(stdout, ")!\n");
			type_error_count += 1;
		}
		type_free(t);
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
			struct symbol *s = scope_lookup(d->name, d->line, 0);
			if(!s) {
				exit(EXIT_FAILURE);
			}
			if(s->t == FUNC_PROTO) { //the source code file does not include the definition of a function
				if(s != d->symbol) {
					if(!type_equals(d->type, s->type)) {
						fprintf(stdout, "type error (line %d): the function prototype (%s:", d->line, d->name);
						type_print(d->type);
						fprintf(stdout, ") does not match another function prototype (%s:", s->name);
						type_print(s->type);
						fprintf(stdout, ")!\n");
						type_error_count += 1;
					}
				}
			} else { //function definition exists in the same source file
				if(!type_equals(d->type, s->type)) {
					fprintf(stdout, "type error (line %d): the function prototype (%s:", d->line, d->name);
					type_print(d->type);
					fprintf(stdout, ") does not match the type of its definition (%s:", s->name);
					type_print(s->type);
					fprintf(stdout, ")!\n");
					type_error_count += 1;
				}
			} 
		}
	}
	decl_typecheck(d->next);
}

void decl_codegen(struct decl *d, FILE *f) {
	if(!d) return;

	if(d->value) {
		if(d->type->kind == TYPE_ARRAY) {
			fprintf(stderr, "cminor does not support array currently!\n");
			exit(EXIT_FAILURE);
		}

		// declaration with initialization
		if(d->symbol->kind == SYMBOL_GLOBAL) {
			d->value->is_global = 1;
			fprintf(f, "\n\t.globl %s\n", d->name);
		}
		
		expr_codegen(d->value, f);

		if(d->symbol->kind == SYMBOL_GLOBAL) {
			fprintf(f, "\t.data\n");
			fprintf(f, "\t.align 8\n");
			fprintf(f, "\t.type   %s, @object\n", d->name);
			fprintf(f, "\t.size   %s, 8\n", d->name);
			fprintf(f, "%s:\n", d->name);

			if(d->type->kind == TYPE_STRING) {
				fprintf(f, "\t.quad   .str%d\n", str_no-1);
			} else {
				fprintf(f, "\t.quad   %d\n", d->value->literal_value);
			}

		} else {
			fprintf(f, "\n.text\n");
			fprintf(f, "lea .str%d, %%%s\n", str_no-1, register_name(d->value->reg));
			register_freeall();
		}
	} else if(d->code) {
		// function definition
		fprintf(f, "\t.text\n");
		fprintf(f, "\t.globl  %s\n", d->name);
		fprintf(f, "\t.type   %s, @function\n", d->name);
		fprintf(f, "%s:\n", d->name);
		fprintf(f, ".LFB%d:\n", func_no);
		
		fprintf(f, "\tpushq	%%rbp\n");
		fprintf(f, "\tmovq	%%rsp, %%rbp\n");
		fprintf(f, "\tpushq	%%rbx\n");
		fprintf(f, "\tpushq	%%r12\n");
		fprintf(f, "\tpushq	%%r13\n");
		fprintf(f, "\tpushq	%%r14\n");
		fprintf(f, "\tpushq	%%r15\n");

		//parameter, and local variables

		//function body
		stmt_codegen(d->code, f);

		fprintf(f, "\tpopq	%%r15\n");
		fprintf(f, "\tpopq	%%r14\n");
		fprintf(f, "\tpopq	%%r13\n");
		fprintf(f, "\tpopq	%%r12\n");
		fprintf(f, "\tpopq	%%rbx\n");
		
		fprintf(f, "\tmovq	%%rbp, %%rsp\n");
		fprintf(f, "\tpopq	%%rbp\n");
		fprintf(f, "\tret\n");
		fprintf(f, ".LFE%d:\n", func_no);
		fprintf(f, "\t.size	%s, .-%s\n", d->name, d->name);


		func_no += 1;
	} else {
		// declaration without initialization or function prototype
		if(d->type->kind == TYPE_ARRAY) {
			fprintf(stderr, "cminor does not support array currently!\n");
			exit(EXIT_FAILURE);
		}
		
		if(d->type->kind != TYPE_FUNCTION) {
			fprintf(f, "\t.comm %s, 8, 8\n", d->name);	
		}
	}
	decl_codegen(d->next, f);
}


