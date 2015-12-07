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
int ctl_no = 0;
struct symbol *cur_func = 0;

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
	} else if(d->code) {
		scope_enter();	
		int params = param_list_resolve(d->type->params, 0);
		symbol_set_param_count(d->symbol, params);
		stmt_resolve(d->code->body);
		scope_exit();
		symbol_set_local_count(d->symbol, local_no);
	} else {
		if(d->type->kind == TYPE_FUNCTION) {
			scope_enter();	
			int params = param_list_resolve(d->type->params, 0);
			symbol_set_param_count(d->symbol, params);
			scope_exit();
		}
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
			fprintf(stderr, "line %d: cminor does not support array currently!\n", d->line);
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
			fprintf(f, "\tmovq\t%%%s, %d(%%rbp)\n", register_name(d->value->reg), -8 * (cur_func->param_count + d->symbol->which + 1));
		}
	} else if(d->code) {
		//set current function symbol
		cur_func = d->symbol;

		//check the number of function parameters
		decl_func_paramcheck(d);
	
		// function definition
		fprintf(f, "\t.text\n");
		fprintf(f, "\t.globl\t%s\n", d->name);
		fprintf(f, "\t.type\t%s, @function\n", d->name);
		fprintf(f, "%s:\n", d->name);
		fprintf(f, ".LFB%d:\n", func_no);
		
		fprintf(f, "\tpushq\t%%rbp\n");
		fprintf(f, "\tmovq\t%%rsp, %%rbp\n");

		//save function arguments on the stack
		decl_func_saveargs(d->symbol->param_count, f);

		//local variables
		if(d->symbol->local_count > 0) {
			fprintf(f, "\tsubq\t$%d, %%rsp\n", 8 * d->symbol->local_count);
		}

		fprintf(f, "\tpushq\t%%rbx\n");
		fprintf(f, "\tpushq\t%%r12\n");
		fprintf(f, "\tpushq\t%%r13\n");
		fprintf(f, "\tpushq\t%%r14\n");
		fprintf(f, "\tpushq\t%%r15\n");

		//function body
		stmt_codegen(d->code, f);

		/* 
		 * the postamble is used for the case the function misses a return stmt. 
		 * This solution, however, does not solve the problem when a function whose return type is string misses a return stmt: %rax 
		 * may not be a string, so "Segmentation fault (core dumped)" would be met.
		 */
		fprintf(f, "\tpopq\t%%r15\n");
		fprintf(f, "\tpopq\t%%r14\n");
		fprintf(f, "\tpopq\t%%r13\n");
		fprintf(f, "\tpopq\t%%r12\n");
		fprintf(f, "\tpopq\t%%rbx\n");
		
		fprintf(f, "\tmovq\t%%rbp, %%rsp\n");
		fprintf(f, "\tpopq\t%%rbp\n");
		fprintf(f, "\tret\n");

		fprintf(f, ".LFE%d:\n", func_no);
		fprintf(f, "\t.size\t%s, .-%s\n", d->name, d->name);

		func_no += 1;
	} else {
		// declaration without initialization or function prototype
		if(d->type->kind == TYPE_ARRAY) {
			fprintf(stderr, "line %d: cminor does not support array currently!\n", d->line);
			exit(EXIT_FAILURE);
		}
		
		if(d->type->kind != TYPE_FUNCTION) {
			if(d->symbol->kind == SYMBOL_GLOBAL) {
				fprintf(f, "\t.comm %s, 8, 8\n", d->name);	
			}
		}
	}
	decl_codegen(d->next, f);
}

void decl_func_paramcheck(struct decl *d) {
	if(d->symbol->param_count > 6) {
		fprintf(stderr, "line %d: the function (%s) has too many parameters (%d params)! Cminor supports at most 6 parameters!\n", d->line, d->name, d->symbol->param_count);
		exit(EXIT_FAILURE);
	}
}

void decl_func_saveargs(int count, FILE *f) {
	if(count > 0) fprintf(f, "\tpushq\t%%rdi\n"); 
	if(count > 1) fprintf(f, "\tpushq\t%%rsi\n"); 
	if(count > 2) fprintf(f, "\tpushq\t%%rdx\n"); 
	if(count > 3) fprintf(f, "\tpushq\t%%rcx\n"); 
	if(count > 4) fprintf(f, "\tpushq\t%%r8\n"); 
	if(count > 5) fprintf(f, "\tpushq\t%%r9\n"); 
}


