
#ifndef SYMBOL_H
#define SYMBOL_H

#include "type.h"

/* 
global variables are not put onto stack, and do not needed to be numbered.
parameters need to be put onto stack, and need to be numbered. Start from 0.
local variables need to be put onto stack and need to numbered. Start from 0.
parameters and local variables are numbered separately, because they are treated separatedly during function calls.
 */
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

struct symbol *symbol_create(symbol_t kind, int seq, struct type *type, char *name);

#endif
