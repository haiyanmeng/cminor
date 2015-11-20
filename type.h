#ifndef TYPE_H
#define TYPE_H

#include "param_list.h"
#include "expr.h"

typedef enum {
	TYPE_BOOLEAN,
	TYPE_CHARACTER,
	TYPE_INTEGER,
	TYPE_STRING,
	TYPE_ARRAY,
	TYPE_FUNCTION,
	TYPE_VOID
} type_kind_t;

/*
f: function void (x:string);
kind = TYPE_FUNCTION, params = p1, subtype = p3
p1: p1->name = x, p1->type = p2, p2->symbol = null, p2->next = null 
p2->kind = TYPE_STRING, p2->params = null, p2->subtype = null
p3->kind = TYPE_VOID, p3->params = null, p3->subtype = null

a: integer;
kind = TYPE_INTEGER, params = null, subtype = null 
*/
struct type {
	type_kind_t kind;
	struct param_list *params; /* function parameter list */
	struct expr *expr; /* array size (e.g., a: array[5+23-3] integer; */
	struct type *subtype; /* function return value type; type of array elements */
	int line;
	int inAST;
};

struct type *type_create(type_kind_t kind, struct param_list *params, struct expr *expr, struct type *subtype, int line, int inAST);
void type_print(struct type *t);

/* 
 * return 1 if s and t have the same type; return 0 if s and t have different types.
 */
int type_equals(struct type *s, struct type *t);
void type_resolve(struct type *t);
void type_typecheck(struct type *t);
void type_arraysize_typecheck(struct type *t, struct expr *init);
void type_free(struct type *t);
#endif
