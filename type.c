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
			printf("boolean");	 
			printf(" ");
			break;
		case TYPE_CHARACTER:
			printf("char");
			printf(" ");
			break;
		case TYPE_INTEGER:
			printf("integer");
			printf(" ");
			break;
		case TYPE_STRING:
			printf("string");
			printf(" ");
			break;
		case TYPE_ARRAY:
			printf("array");
			printf(" ");
			break;
		case TYPE_FUNCTION:
			printf("function");
			printf(" ");
			break;
		case TYPE_VOID:
			printf("void");
			printf(" ");
			break;
	}

	param_list_print(t->params);
	type_print(t->subtype);
}
