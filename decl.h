
#ifndef DECL_H
#define DECL_H

#include "type.h"
#include "stmt.h"
#include "expr.h"
#include "symbol.h"

struct decl {
	char *name; /* function name or variable name */
	struct type *type;
	struct expr *value; /* initializer */
	struct stmt *code; /* function body */
	struct symbol *symbol;
	struct decl *next;
};

struct decl *decl_create(char *name, struct type *t, struct expr *v, struct stmt *c, struct decl *next);
void decl_print(struct decl *d, int indent);
void decl_resolve(struct decl *d);

#endif
