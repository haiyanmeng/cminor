#include "param_list.h"
#include <stdio.h>
#include <stdlib.h>

struct param_list *param_list_create(char *name, struct type *type, struct param_list *next) {
	struct param_list *p = (struct param_list *)malloc(sizeof(struct param_list));
	p->name = name;
	p->type = type;
	p->next = next;
	return p;
}
void param_list_print(struct param_list *p) {
	if(!p) return;

	printf("%s", p->name);
	type_print(p->type);
	param_list_print(p->next);
}
