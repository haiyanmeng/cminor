#include "param_list.h"
#include <stdio.h>
#include <stdlib.h>

struct param_list *param_list_create(char *name, struct type *type, struct param_list *next) {
	struct param_list *p = (struct param_list *)malloc(sizeof(struct param_list));

	if(!p) {
		fprintf(stderr, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	p->name = name;
	p->type = type;
	p->next = next;
	return p;
}
void param_list_print(struct param_list *p) {
	if(!p) return;

	printf("%s: ", p->name);
	type_print(p->type);
	if(p->next) {
		printf(", ");
		param_list_print(p->next);
	}
}
