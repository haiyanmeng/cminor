#include "stmt.h"
#include "decl.h"
#include "expr.h"
#include <stdio.h>
#include <stdlib.h>
#include "scope.h"

struct stmt *stmt_create(stmt_kind_t kind, struct decl *d, struct expr *init_expr, struct expr *e, struct expr *next_expr, struct stmt *body, struct stmt *else_body, int line, struct stmt *next) {
	struct stmt *s = (struct stmt *)malloc(sizeof(struct stmt));

	if(!s) {
		fprintf(stdout, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	s->kind = kind;
	s->decl = d;
	s->init_expr = init_expr;
	s->expr = e;
	s->next_expr = next_expr;
	s->body = body;
	s->else_body = else_body;
	s->line = line;
	s->next = next;
	return s;
}

void stmt_print(struct stmt *s, int indent1, int indent2, int curly_newline) {
	if(!s) return;

	switch(s->kind) {
		case STMT_DECL:
			decl_print(s->decl, indent1);
			break;
		case STMT_EXPR:
			indent_process(indent2);
			expr_print(s->expr);
			printf(";\n");
			break;
		case STMT_PRINT:
			indent_process(indent2);
			printf("print");
			if(s->expr) {
				printf(" ");
				expr_print(s->expr);
			}
			printf(";\n");
			break;
		case STMT_RETURN:
			indent_process(indent2);
			printf("return");
			if(s->expr) {
				printf(" ");
				expr_print(s->expr);
			}
			printf(";\n");
			break;
		case STMT_IF_ELSE:
			indent_process(indent2);
			printf("if(");
			expr_print(s->expr);
			printf(")");
			if(s->body->kind == STMT_BLOCK) {
				printf(" ");
				stmt_print(s->body, 0, indent2, 0);
				printf(" ");
			} else {
				printf("\n");
				stmt_print(s->body, indent1 + 4, indent2 + 4, 1);
			}
			if(s->else_body) {
				if(s->body->kind == STMT_BLOCK) {
					printf("else");
					printf(" ");
					stmt_print(s->else_body, 0, indent2, 1);
				} else {
					indent_process(indent2);
					printf("else");
					printf("\n");
					stmt_print(s->else_body, indent1 + 4, indent2 + 4, 1);
				}
			} else {
				if(s->body->kind == STMT_BLOCK)
					printf("\n");
			}
			break;
		case STMT_FOR:
			indent_process(indent2);
			printf("for(");
			expr_print(s->init_expr);
			printf(";");
			expr_print(s->expr);
			printf(";");
			expr_print(s->next_expr);
			printf(")");
			if(s->body->kind == STMT_BLOCK) {
				printf(" ");
				stmt_print(s->body, 0, indent2, 1);
			} else {
				printf("\n");
				stmt_print(s->body, indent1 + 4, indent2 + 4, 1);
			}
			break;
		case STMT_BLOCK:	
			indent_process(indent1);
			printf("{\n");
			stmt_print(s->body, indent2 + 4, indent2 + 4, 1);
			indent_process(indent2);
			printf("}");
			if(curly_newline) 
				printf("\n");
			break;
	}	
	stmt_print(s->next, indent2, indent2, 1);
	return;
}

void indent_process(int indent) {
	/* indent process */
	if(indent > 0) {
		char *spaces = (char *)malloc((indent+1) * sizeof(char));

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
}

void stmt_resolve(struct stmt *s, int seq) {
	if(!s) return;

	int increase_seq = 0;	
	switch(s->kind) {
		case STMT_DECL:
			if(!scope_lookup_local(s->decl->name) && s->decl->type->kind != TYPE_FUNCTION) {
				increase_seq = 1;
			}
			decl_resolve(s->decl, seq);
			if(increase_seq == 1) {
				seq += 1;
				increase_seq = 0;
			}
			break;
		case STMT_EXPR:
			expr_resolve(s->expr);
			break;
		case STMT_PRINT:
			expr_resolve(s->expr);
			break;
		case STMT_RETURN:
			expr_resolve(s->expr);
			break;
		case STMT_IF_ELSE:
			expr_resolve(s->expr);
			stmt_resolve(s->body, seq);
			stmt_resolve(s->else_body, seq);
			break;
		case STMT_FOR:
			expr_resolve(s->init_expr);
			expr_resolve(s->expr);
			expr_resolve(s->next_expr);
			stmt_resolve(s->body, seq);
			break;
		case STMT_BLOCK:	
			scope_enter();
			stmt_resolve(s->body, 0);
			scope_exit();
			break;
	}	
	stmt_resolve(s->next, seq);
	return;
}

void stmt_typecheck(struct stmt *s, const char *func_name) {
	if(!s) return;

	struct type *t, *func_return;
	switch(s->kind) {
		case STMT_DECL:
			decl_typecheck(s->decl);
			break;
		case STMT_EXPR:
			expr_typecheck(s->expr, 0, 0);
			break;
		case STMT_PRINT:
			expr_typecheck(s->expr, 0, 0);
			expr_print_typecheck(s->expr);
			break;
		case STMT_RETURN:
			t = expr_typecheck(s->expr, 0, 0);
			//return wrong number 
			func_return = scope_lookup(func_name, s->line, 0)->type->subtype;
			if(!t) { //return;
				if(func_return->kind != TYPE_VOID) {
					fprintf(stdout, "type error (line %d): function (%s) returns a wrong type (void), and should return type ", s->line, func_name);
					type_print(func_return);
					printf("!\n");
					type_error_count += 1;
				}	
			} else {
				if(!type_equals(t, func_return)) {
					fprintf(stdout, "type error (line %d): function (%s) returns a wrong type (", s->line, func_name);
					type_print(t);
					printf("), and should return type ");
					type_print(func_return);
					printf("!\n");
					type_error_count += 1;
				}
			}
			break;
		case STMT_IF_ELSE:
			t = expr_typecheck(s->expr, 0, 0);
			if(t->kind != TYPE_BOOLEAN) {
				fprintf(stdout, "type error (line %d): the expr (", s->expr->line);
				expr_print(s->expr);
				printf(") of if_stmt has wrong type (");
				type_print(t);
				printf("), and should be boolean!\n");
				type_error_count += 1;
			}

			stmt_typecheck(s->body, func_name);
			stmt_typecheck(s->else_body, func_name);
			break;
		case STMT_FOR:
			expr_typecheck(s->init_expr, 0, 0);

			t = expr_typecheck(s->expr, 0, 0);
			if(t->kind != TYPE_BOOLEAN) {
				fprintf(stdout, "type error (line %d): the expr (", s->expr->line);
				expr_print(s->expr);
				printf(") of for_stmt has wrong type (");
				type_print(t);
				printf("), and should be boolean!\n"); 
				type_error_count += 1;
			}

			expr_typecheck(s->next_expr, 0, 0);
			stmt_typecheck(s->body, func_name);
			break;
		case STMT_BLOCK:	
			stmt_typecheck(s->body, func_name);
			break;
	}	
	stmt_typecheck(s->next, func_name);
}
