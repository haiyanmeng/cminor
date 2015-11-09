#ifndef SCOPE_H
#define SCOPE_H

#include "symbol.h"

/*
 * Increase the scope level;
 * Create a new scope which inclues a pointer to a new hash table, put it into the beginning of the scope list. 
 */
void scope_enter();

void scope_exit();

int scope_level();

void scope_bind(const char *name, struct symbol *s);

struct symbol *scope_lookup(const char *name);

#endif
