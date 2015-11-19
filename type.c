#include "type.h"
#include <stdio.h>
#include <stdlib.h>
#include "scope.h"

struct type *type_create(type_kind_t kind, struct param_list *params, struct expr *expr, struct type *subtype) {
	struct type *t = (struct type *)malloc(sizeof(struct type));	

	if(!t) {
		fprintf(stderr, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	t->kind = kind;
	t->params = params;
	t->expr = expr;
	t->subtype = subtype;
	return t;
}

void type_print(struct type *t) {
	if(!t) return;

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
			printf("array [");
			expr_print(t->expr);
			printf("] ");
			type_print(t->subtype);
			return;
		case TYPE_FUNCTION:
			printf("function ");
			type_print(t->subtype);
			printf(" ");
			printf("(");
			if(t->params) {
				printf(" ");
				param_list_print(t->params);
				printf(" ");
			}
			printf(")");
			return;
		case TYPE_VOID:
			printf("void");
			break;
	}
}

int type_equals(struct type *s, struct type *t) {
	if(!s && !t) {
		return 1;
	} else if(s && t && (s->kind == t->kind)) {
		if(!(s->subtype) && !(t->subtype) && !(s->params) && !(t->params)) {
			return 1;
		} else {
			return type_equals(s->subtype, t->subtype) && params_equals(s->params, t->params);
		}
	} else {
		return 0;
	}
}

void type_resolve(struct type *t) {
	if(!t) return;

	switch(t->kind) {
		case TYPE_ARRAY:
			expr_resolve(t->expr);
			type_resolve(t->subtype);
			break;
		default:
			break;
	}
}

void type_typecheck(struct type *t) {
	if(!t) return;

	switch(t->kind) {
		case TYPE_ARRAY:
			if(!(t->expr)) {
				fprintf(stderr, "type error: the array size is missing!\n");
				type_error_count += 1;
			} else {
				if(t->expr->kind != EXPR_INTEGER_LITERAL) {
					fprintf(stderr, "type error: the array size must be an positive integer literal!\n");
					type_error_count += 1;
				} else {
					if(t->expr->literal_value <= 0) {
						fprintf(stderr, "type error: the array size must be an positive integer literal!\n");
						type_error_count += 1;
					}
				}
			}
			type_typecheck(t->subtype);
			break;
		default:
			break;
	}
	
}

void type_arraysize_typecheck(struct type *t, struct expr *init) {
	if(t->kind == TYPE_ARRAY) {
		int count = t->expr->literal_value;
		int init_count = expr_count_item(init->right);	
	
		if(count != init_count) {
			fprintf(stderr, "type error: the initializer size of the array does not match the size of the array!\n"); 
			type_error_count += 1;
		}

		int min;
		if(count >= init_count) {
			min = init_count;
		} else {
			min = count;
		}

		int i;
		for(i = 1; i <= min; i++) {
			struct expr *e = expr_get_item(init->right, init_count, i);
			type_arraysize_typecheck(t->subtype, e);
		}
	}
}
