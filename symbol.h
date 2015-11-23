
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

typedef enum {
	FUNC_PROTO,
	FUNC_DEF,
	FUNC_NOT
} func_t;

struct symbol {
	symbol_t kind;
	int which; /* number of each symbol in a scope */
	struct type *type;
	char *name;
	func_t t;
	int local_count;
	int param_count;
};

struct symbol *symbol_create(symbol_t kind, int seq, struct type *type, char *name, func_t t);
void symbol_set_local_count(struct symbol *s, int local_count);
void symbol_set_param_count(struct symbol *s, int param_count);
#endif
