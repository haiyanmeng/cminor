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
			decl_print(s->decl, 4);
			break;
		case STMT_EXPR:
			expr_print(s->expr);
			printf(";\n");
			break;
		case STMT_IF_ELSE:
			printf("if(");
			expr_print(s->expr);
			printf(") {\n");
			stmt_print(s->body, 4);
			printf("} else {\n");
			stmt_print(s->else_body, 4);
			printf("}\n");
			break;
		case STMT_FOR:
			printf("for(");
			expr_print(s->init_expr);
			printf("; ");
			expr_print(s->expr);
			printf("; ");
			expr_print(s->next_expr);
			printf(") {\n");
			stmt_print(s->body, 4);
			printf("}\n");
			break;
		case STMT_PRINT:
			printf("print ");
			expr_print(s->expr);
			printf(";\n");
			break;
		case STMT_RETURN:
			printf("return ");
			expr_print(s->expr);
			printf(";\n");
			break;
		case STMT_BLOCK:	
			printf("{\n");
			stmt_print(s->body, 4);
			printf("}\n");
			break;
	}	
	stmt_print(s->next, 4);
	return;
}







