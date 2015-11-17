
#ifndef STMT_H
#define STMT_H

#include "decl.h"
#include "expr.h"

typedef enum {
	STMT_DECL,
	STMT_EXPR,
	STMT_IF_ELSE,
	STMT_FOR,
	STMT_PRINT,
	STMT_RETURN,
	STMT_BLOCK
} stmt_kind_t;

struct stmt {
	stmt_kind_t kind;
	struct decl *decl; /* x: integer; */
	struct expr *init_expr; /* the init expr of for stmt */
	struct expr *expr; /* expr; or middle expr of for stmt */
	struct expr *next_expr; /* the next expr of for stmt */
	struct stmt *body;
	struct stmt *else_body; /* body of else stmt */
	struct stmt *next;
};

struct stmt *stmt_create(stmt_kind_t kind, struct decl *d, struct expr *init_expr, struct expr *e, struct expr *next_expr, struct stmt *body, struct stmt *else_body, struct stmt *next);

/* 
indent1 and indent2:
	As for STMT_BLOCK, indent1 denotes the indent of left curly brace, indent2 denotes the indent of the right curly braces.
	As for other stmts, indent2 denotes the indent of the stmt, indent1 is ignored.
curly_newline: only used for STMT_BLOCK. decides whether a newline will be printed after the right curly brace. 
	1: add a newline after the right curly brace. 
	0: no newline after the right curly brace. This is useful for if-else stmts.
*/
void stmt_print(struct stmt *s, int indent1, int indent2, int curly_newline);

/* print indents */
void indent_process(int indent);

void stmt_resolve(struct stmt *s, int seq);

void stmt_typecheck(struct stmt *s, const char *func_name);
#endif
