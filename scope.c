#include "scope.h"
#include "hash_table.h"
#include <stdio.h>
#include <stdlib.h>

int level = 0;
int error_count = 0;
struct scope *head = 0;

void scope_init() {
	level = 0;

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
	s->next = 0;
	head = s;
}

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
	struct scope *h = head;
	head = head->next;
	hash_table_traverse(h->h);
	free(h);
	level -= 1;
}

int scope_level() {
	return level;
}

void scope_bind(const char *name, struct symbol *s) {
	//hash_table_traverse(head->h);

	if(!hash_table_insert(head->h, name, (const void *)s)) {
		fprintf(stderr, "Fails to insert a new item into the hash table!\n");
		exit(EXIT_FAILURE);
	}
}

void scope_rebind(const char *name, struct symbol *s) {
	if(!hash_table_remove(head->h, name)) {
		fprintf(stderr, "Fails to remove an item (%s) into the hash table!\n", name);
		exit(EXIT_FAILURE);
	}

	if(!hash_table_insert(head->h, name, (const void *)s)) {
		fprintf(stderr, "Fails to insert a new item (%s) into the hash table!\n", name);
		exit(EXIT_FAILURE);
	}
}

struct symbol *scope_lookup(const char *name) {
	int i = level;
	struct scope *s = head;
	while(i >= 0) {
		struct symbol *sym = (struct symbol *)hash_table_lookup(s->h, name);
		if(sym) {
			switch(sym->kind) {
				case SYMBOL_GLOBAL:
					fprintf(stdout, "%s resolves to global %s (level %d)\n", name, name, i);
					break;
				case SYMBOL_LOCAL:
					fprintf(stdout, "%s resolves to local %d (level %d)\n", name, sym->which, i);
					break;
				case SYMBOL_PARAM:
					fprintf(stdout, "%s resolves to param %d (level %d)\n", name, sym->which, i);
					break;
			}
			return sym;
		} else {
			i -= 1;
			s = s->next;
		}
	}
	fprintf(stdout, "resolve error: %s is not defined!\n", name);
	error_count += 1;
	return 0;
}

struct symbol *scope_lookup_local(const char *name) {
	struct symbol *sym = (struct symbol *)hash_table_lookup(head->h, name);
	if(sym) {
		return sym;
	} else {
		return 0;
	}
}

void scope_print() {
	int i = level;
	struct scope *s = head;
	char *key;
	void *value;
	while(i >= 0) {
		fprintf(stdout, "\nScope Level %d: \n", i);
		hash_table_firstkey(s->h);
		
		while(hash_table_nextkey(s->h, &key, &value)) {
			fprintf(stdout, "%s: %s\n", key, ((struct symbol *)value)->name);
		}

		i -= 1;
		s = s->next;
	}
	
}

void hash_table_traverse(struct hash_table *h) {
	printf("\nstart to traverse a hash_table for level %d\n", level);
	char *key;
	void *value;
	hash_table_firstkey(h);
	while(hash_table_nextkey(h, &key, &value)) {
		fprintf(stdout, "%s: %s\n", key, ((struct symbol *)value)->name);
	}
	printf("finish traverse a hash_table\n\n");
}

