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
	printf("type_print\n");
	switch(t->kind) {
		case TYPE_BOOLEAN:
			printf("boolean");	 
			break;
		case TYPE_CHARACTER:
			printf("char");
			break;
		case TYPE_INTEGER:
			printf("integer");
			break;
		case TYPE_STRING:
			printf("string");
			break;
		case TYPE_ARRAY:
			printf("array");
			break;
		case TYPE_FUNCTION:
			printf("function");
			break;
		case TYPE_VOID:
			printf("void");
			break;
	}

	param_list_print(t->params);
	type_print(t->subtype);
	printf("type_print\n");
}
