#include "scope.h"
#include "hash_table.h"
#include <stdio.h>
#include <stdlib.h>

static int level = 0; // level 0 means the global namespace

/*
 * Use two-layer hash tables. The first layer maps a scope level to a hash table; 
 * the second layer maps a identifer to a symbol.
*/

struct scope {
	struct hash_table *h;
	struct scope *next;
};
struct scope *head;

void scope_enter() {
	level += 1;

	struct hash_table *h = hash_table_create(0, 0);
	if(!h) {
		fprintf(stderr, "Fails to create a hash table!\n");
		exit(EXIT_FAILURE);
	}
	struct scope *s = (struct scope *)malloc(sizeof(struct scope));
	if(!s) {
		fprintf(stderr, "Fails to create a new scope!\n");
		exit(EXIT_FAILURE);
	}
	s->h = h;
	s->next = head;
	head = s;
}

void scope_exit() {
	level -= 1;
	struct scope *h = head;
	head = head->next;
	free(h);
}

int scope_level() {
	return level;
}

void scope_bind(const char *name, struct symbol *s) {
	if(hash_table_insert(head->h, name, (const void *)s)) {
		fprintf(stderr, "Fails to insert a new item into the hash table!\n");
		exit(EXIT_FAILURE);
	}
}

struct symbol *scope_lookup(const char *name) {
	int i = level;
	struct scope *s = head;
	while(i >= 0) {
		struct symbol *sym = (struct symbol *)hash_table_lookup(s->h, name);
		if(sym) {
			fprintf(stdout, "Scope lookup succeeds: find %s at level %d\n", name, i);
			return sym;
		} else {
			i -= 1;
			s = s->next;
		}
	}
	fprintf(stdout, "resolve error: can not find %s in any scope!\n", name);
	return 0;
}




