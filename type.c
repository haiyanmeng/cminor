#include "type.h"
#include <stdio.h>
#include <stdlib.h>

struct type *type_create(type_kind_t kind, struct param_list *params, struct type *subtype) {
	struct type *t = (struct type *)malloc(sizeof(struct type));	
	t->kind = kind;
	t->params = params;
	t->subtype = subtype;
	return t;
}

void type_print(struct type *t) {
	if(!t) return;

	switch(t->kind) {
		case TYPE_BOOLEAN:
			printf("boolean ");	 
			break;
		case TYPE_CHARACTER:
			printf("char ");
			break;
		case TYPE_INTEGER:
			printf("integer ");
			break;
		case TYPE_STRING:
			printf("string ");
			break;
		case TYPE_ARRAY:
			printf("array [ ");
			param_list_print(t->params);
			printf("] ");
			type_print(t->subtype);
			return;
		case TYPE_FUNCTION:
			printf("function ");
			type_print(t->subtype);
			printf("( ");
			param_list_print(t->params);
			printf(")");
			return;
		case TYPE_VOID:
			printf("void ");
			break;
	}
}
