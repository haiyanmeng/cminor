
#ifndef DECL_H
#define DECL_H

#include "type.h"
#include "stmt.h"
#include "expr.h"
#include "symbol.h"

extern int local_no;
extern int str_no;
extern int func_no;

struct decl {
	char *name; /* function name or variable name */
	struct type *type;
	struct expr *value; /* initializer */
	struct stmt *code; /* function body */
	struct symbol *symbol;
	int line;
	struct decl *next;
};

struct decl *decl_create(char *name, struct type *t, struct expr *v, struct stmt *c, int line, struct decl *next);
void decl_print(struct decl *d, int indent);

/*
 * name resolution errors: function redefinition
 */
void decl_resolve(struct decl *d);

/*
 * type checking errors: conflict between function prototype and function definition
 */
void decl_typecheck(struct decl *d);

void decl_codegen(struct decl *d, FILE *f);
void decl_func_paramcheck(struct decl *d);
void decl_func_saveargs(int count, FILE *f);
#endif
