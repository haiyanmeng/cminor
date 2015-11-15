#include "stmt.h"
#include "decl.h"
#include "expr.h"
#include <stdio.h>
#include <stdlib.h>
#include "scope.h"

struct stmt *stmt_create(stmt_kind_t kind, struct decl *d, struct expr *init_expr, struct expr *e, struct expr *next_expr, struct stmt *body, struct stmt *else_body, struct stmt *next) {
	struct stmt *s = (struct stmt *)malloc(sizeof(struct stmt));

	if(!s) {
		fprintf(stderr, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	s->kind = kind;
	s->decl = d;
	s->init_expr = init_expr;
	s->expr = e;
	s->next_expr = next_expr;
	s->body = body;
	s->else_body = else_body;
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
}

void stmt_resolve(struct stmt *s, int seq) {
	if(!s) return;

	switch(s->kind) {
		case STMT_DECL:
			decl_resolve(s->decl, seq);
			break;
		case STMT_EXPR:
			expr_resolve(s->expr, 0);
			break;
		case STMT_PRINT:
			expr_resolve(s->expr, 0);
			break;
		case STMT_RETURN:
			expr_resolve(s->expr, 0);
			break;
		case STMT_IF_ELSE:
			expr_resolve(s->expr, 0);
			stmt_resolve(s->body, seq);
			stmt_resolve(s->else_body, seq);
			break;
		case STMT_FOR:
			expr_resolve(s->init_expr, 0);
			expr_resolve(s->expr, 0);
			expr_resolve(s->next_expr, 0);
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

void stmt_typecheck(struct stmt *s) {
	if(!s) return;

	struct type *t;
	switch(s->kind) {
		case STMT_DECL:
			decl_typecheck(s->decl);
			break;
		case STMT_EXPR:
		case STMT_PRINT:
		case STMT_RETURN:
			expr_typecheck(s->expr);
			break;
		case STMT_IF_ELSE:
			t = expr_typecheck(s->expr);
			if(!t) {
				fprintf(stderr, "type error: if() is not legal! The correct syntax should be if(expr)!\n");
				exit(EXIT_FAILURE);
			}
			if(t->kind != TYPE_BOOLEAN) {
				fprintf(stderr, "type error: the expr of if_stmt must be boolean!\n"); 
				exit(EXIT_FAILURE);
			}

			stmt_typecheck(s->body);
			stmt_typecheck(s->else_body);
			break;
		case STMT_FOR:
			expr_typecheck(s->init_expr);

			t = expr_typecheck(s->expr);
			if(t->kind != TYPE_BOOLEAN) {
				fprintf(stderr, "type error: the expr of if_stmt must be boolean!\n"); 
				exit(EXIT_FAILURE);
			}

			expr_typecheck(s->next_expr);
			stmt_typecheck(s->body);
			break;
		case STMT_BLOCK:	
			stmt_typecheck(s->body);
			break;
	}	
	stmt_typecheck(s->next);
}
