#ifndef SCOPE_H
#define SCOPE_H

#include "symbol.h"
#include "hash_table.h"

extern int level;
extern int resolve_error_count;
extern int type_error_count;

struct scope {
	struct hash_table *h; /* each hash table corresponds a scope and maps an identifier to a symbol. */
	struct scope *next;
};

/* 
 * a singly linked list of hash tables, each hash table corresponds a scope and maps an identifier to a symbol.
 * the closest scope is at the beginning of the linked list.
 */
extern struct scope *head;

/*
 * Increase the scope level;
 * Create a new scope which inclues a pointer to a new hash table, put it into the beginning of the scope list. 
 */
void scope_enter();

void scope_exit();

int scope_level();

void scope_bind(const char *name, struct symbol *s);

void scope_rebind(const char *name, struct symbol *s);

struct symbol *scope_lookup(const char *name, int resolving);

struct symbol *scope_lookup_local(const char *name);

void scope_init();
void scope_print();
void hash_table_traverse(struct hash_table *h);
#endif
