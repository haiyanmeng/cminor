
#ifndef SYMBOL_H
#define SYMBOL_H

#include "type.h"

typedef enum {
	SYMBOL_LOCAL,
	SYMBOL_PARAM,
	SYMBOL_GLOBAL
} symbol_t;

struct symbol {
	symbol_t kind;
	int which; /* number of each symbol in a scope */
	struct type *type;
	char *name;
};

struct symbol *symbol_create(symbol_t kind, struct type *type, char *name);

#endif
