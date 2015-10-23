#ifndef TYPE_H
#define TYPE_H

#include "param_list.h"

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
	struct param_list *params; /* function parameter list; array size */
	struct type *subtype; /* function return value type; type of array elements */
};

struct type *type_create(type_kind_t kind, struct param_list *params, struct type *subtype);
void type_print(struct type *t);

#endif
