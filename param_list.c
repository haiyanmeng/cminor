#include "param_list.h"
#include <stdio.h>
#include <stdlib.h>
#include "symbol.h"
#include "scope.h"

extern int level;

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

void param_list_resolve(struct param_list *p, int seq) {
	if(!p) return;

	struct symbol *sym = symbol_create(SYMBOL_PARAM, seq, p->type, p->name, FUNC_NOT);
	
	if(scope_lookup_local(p->name)) {
		fprintf(stderr, "resolve error: %s has been defined at the current scope (level %d)!\n", p->name, level);
		exit(EXIT_FAILURE);
	}

	p->symbol = sym;

	scope_bind(p->name, sym);
	
	param_list_resolve(p->next, seq+1);
}
