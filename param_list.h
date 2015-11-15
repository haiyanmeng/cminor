
#ifndef PARAM_LIST_H
#define PARAM_LIST_H

#include "type.h"
#include "symbol.h"

struct param_list {
	char *name;
	struct type *type;
	struct symbol *symbol;
	struct param_list *next;
};

struct param_list *param_list_create(char *name, struct type *type, struct param_list *next);
void param_list_print(struct param_list *p);
void param_list_resolve(struct param_list *p, int seq);

/*
 * return 1 if p and q have the same type; return 0 if p and q have different types.
 */
int params_equals(struct param_list *p, struct param_list *q);
#endif
