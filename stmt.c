#include "stmt.h"
#include "decl.h"
#include "expr.h"
#include <stdio.h>
#include <stdlib.h>

struct stmt *stmt_create(stmt_kind_t kind, struct decl *d, struct expr *init_expr, struct expr *e, struct expr *next_expr, struct stmt *body, struct stmt *else_body, struct stmt *next) {
	struct stmt *s = (struct stmt *)malloc(sizeof(struct stmt));
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

void stmt_print(struct stmt *s, int indent) {
	if(!s) return;

	switch(s->kind) {
		case STMT_DECL:
			decl_print(s->decl, indent);
			break;
		case STMT_EXPR:
			indent_process(indent);
			expr_print(s->expr);
			printf(";\n");
			break;
		case STMT_IF_ELSE:
			indent_process(indent);
			printf("if(");
			expr_print(s->expr);
			printf(")\n");
			if(s->body->kind == STMT_BLOCK)
				stmt_print(s->body, indent);
			else
				stmt_print(s->body, indent + 4);
			indent_process(indent);
			printf("else\n");
			if(s->body->kind == STMT_BLOCK)
				stmt_print(s->else_body, indent);
			else
				stmt_print(s->else_body, indent + 4);
			break;
		case STMT_FOR:
			indent_process(indent);
			printf("for(");
			expr_print(s->init_expr);
			printf(";");
			expr_print(s->expr);
			printf(";");
			expr_print(s->next_expr);
			printf(")\n");
			if(s->body->kind == STMT_BLOCK)
				stmt_print(s->body, indent);
			else
				stmt_print(s->body, indent + 4);
			break;
		case STMT_PRINT:
			indent_process(indent);
			printf("print");
			if(s->expr) {
				printf(" ");
				expr_print(s->expr);
			}
			printf(";\n");
			break;
		case STMT_RETURN:
			indent_process(indent);
			printf("return");
			if(s->expr) {
				printf(" ");
				expr_print(s->expr);
			}
			printf(";\n");
			break;
		case STMT_BLOCK:	
			indent_process(indent);
			printf("{\n");
			stmt_print(s->body, indent + 4);
			indent_process(indent);
			printf("}\n");
			break;
	}	
	stmt_print(s->next, indent);
	return;
}

void indent_process(int indent) {
	/* indent process */
	if(indent > 0) {
		char *spaces = (char *)malloc(indent * sizeof(char));
		int i;
		for(i = 0; i < indent; i++) {
			spaces[i] = ' ';
		}
		printf("%s", spaces);
	}
}







