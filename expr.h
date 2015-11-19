#ifndef EXPR_H
#define EXPR_H

/* the operators */
typedef enum {
	EXPR_LEFTCURLY,
	EXPR_LEFTPARENTHESS,
	EXPR_LEFTBRACKET,
	EXPR_INCREMENT,
	EXPR_DECREMENT,
	EXPR_UNARY_NEG,
	EXPR_NOT,
	EXPR_POWER,
	EXPR_MUL,
	EXPR_DIV,
	EXPR_MOD,
	EXPR_ADD,
	EXPR_SUB,
	EXPR_LE,
	EXPR_LT,
	EXPR_GE,
	EXPR_GT,
	EXPR_EQ,
	EXPR_UNEQ,
	EXPR_AND,
	EXPR_OR,
	EXPR_ASSIGN,
	EXPR_COMMA,
	/* the following are leaves in AST */
	EXPR_IDENT_NAME,
	EXPR_BOOLEAN_LITERAL,
	EXPR_INTEGER_LITERAL,
	EXPR_CHARACTER_LITERAL,
	EXPR_STRING_LITERAL
} expr_t;

struct expr {
	/* used by all expr types */
	expr_t kind;
	struct expr *left;
	struct expr *right;
	int line;

	/* used by leaf expr types */
	const char *name; /* identifier */
	struct symbol *symbol; /* symbol */
	int literal_value; /* boolean and integer */
	const char * string_literal; /* string */
};

struct expr * expr_create(expr_t kind, struct expr *left, struct expr *right, int line);

struct expr * expr_create_name(const char *n, int line);
struct expr * expr_create_boolean_literal(int c, int line);
struct expr * expr_create_integer_literal(int c, int line);
struct expr * expr_create_character_literal(const char *str, int line);
struct expr * expr_create_string_literal(const char *str, int line);

void expr_print(struct expr *e);
void expr_resolve(struct expr *e);
struct type *expr_typecheck(struct expr *e, int is_array_initializer, int silent_mode);

/* return 1 if expr is constant; return 0 if expr is not constant. */
int expr_is_constant(struct expr *e);
void expr_func_typecheck(struct expr *e, int silent_mode);
int expr_count_item(struct expr *e);
struct expr *expr_get_item(struct expr *e, int n, int i);
void expr_print_typecheck(struct expr *e);
int expr_equals(struct expr *s, struct expr *t);
#endif
