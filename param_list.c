#include "param_list.h"
#include <stdio.h>
#include <stdlib.h>
#include "symbol.h"
#include "scope.h"

extern int level;

struct param_list *param_list_create(char *name, struct type *type, struct param_list *next, int line) {
	struct param_list *p = (struct param_list *)malloc(sizeof(struct param_list));

	if(!p) {
		fprintf(stdout, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	p->name = name;
	p->type = type;
	p->next = next;
	p->line = line;
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

int param_list_resolve(struct param_list *p, int seq) {
	if(!p) return 0;

	struct symbol *sym = symbol_create(SYMBOL_PARAM, seq, p->type, p->name, FUNC_NOT);
	
	struct symbol *s = scope_lookup_local(p->name);
	if(s) {
		fprintf(stdout, "resolve error (line %d): %s has been defined as param %d (level %d)\n", p->line, p->name, s->which, level);
		resolve_error_count += 1;
	} else {
		scope_bind(p->name, sym);
	}

	p->symbol = sym;
	
	return param_list_resolve(p->next, seq+1) + 1;
}

int params_equals(struct param_list *p, struct param_list *q) {
	if(!p && !q) {
		return 1;
	} else if((p && !q) || (!p && q)) {
		return 0;
	} else {
		if(type_equals(p->type, q->type)) {
			return params_equals(p->next, q->next);
		} else {
			return 0;
		}
	}
}

