#include "expr.h"
#include <stdio.h>
#include <stdlib.h>
#include "scope.h"

struct expr *expr_create(expr_t kind, struct expr *left, struct expr *right) {
	struct expr *e = (struct expr *)malloc(sizeof(struct expr));

	if(!e) {
		fprintf(stderr, "malloc fails!\n");
		exit(EXIT_FAILURE);
	}

	e->kind = kind;
	e->left = left;
	e->right = right;
	return e;
}

struct expr *expr_create_name(const char *n) {
	struct expr *e = expr_create(EXPR_IDENT_NAME, 0, 0);
	e->name = n;
	return e;
}

struct expr *expr_create_boolean_literal(int c) {
	struct expr *e = expr_create(EXPR_BOOLEAN_LITERAL, 0, 0);
	e->literal_value = c;
	return e;
}

struct expr *expr_create_integer_literal(int c) {
	struct expr *e = expr_create(EXPR_INTEGER_LITERAL, 0, 0);
	e->literal_value = c;
	return e;
}

struct expr *expr_create_character_literal(const char *str) {
	struct expr *e = expr_create(EXPR_CHARACTER_LITERAL, 0, 0);
	e->string_literal = str;
	return e;
}

struct expr *expr_create_string_literal(const char *str) {
	struct expr *e = expr_create(EXPR_STRING_LITERAL, 0, 0);
	e->string_literal = str;
	return e;
}

void expr_print(struct expr *e) {
	if(!e) return;
	
	switch(e->kind) {
		case EXPR_LEFTCURLY:
			printf("{");
			expr_print(e->right);
			printf("}");
			break;
		case EXPR_LEFTPARENTHESS:
			expr_print(e->left);
			printf("(");
			expr_print(e->right);
			printf(")");
			break;
		case EXPR_LEFTBRACKET:
			expr_print(e->left);
			printf("[");
			expr_print(e->right);
			printf("]");
			break;
		case EXPR_INCREMENT:
			expr_print(e->left);
			printf("++");
			break;
		case EXPR_DECREMENT:
			expr_print(e->left);
			printf("--");
			break;
		case EXPR_UNARY_NEG:
			printf("-");
			expr_print(e->right);
			break;
		case EXPR_NOT:
			printf("!");
			expr_print(e->right);
			break;
		case EXPR_POWER:
			expr_print(e->left);
			printf("^");
			expr_print(e->right);
			break;
		case EXPR_MUL:
			expr_print(e->left);
			printf("*");
			expr_print(e->right);
			break;
		case EXPR_DIV:
			expr_print(e->left);
			printf("/");
			expr_print(e->right);
			break;
		case EXPR_MOD:
			expr_print(e->left);
			printf("%%");
			expr_print(e->right);
			break;
		case EXPR_ADD:
			expr_print(e->left);
			printf("+");
			expr_print(e->right);
			break;
		case EXPR_SUB:
			expr_print(e->left);
			printf("-");
			expr_print(e->right);
			break;
		case EXPR_LE:
			expr_print(e->left);
			printf("<=");
			expr_print(e->right);
			break;
		case EXPR_LT:
			expr_print(e->left);
			printf("<");
			expr_print(e->right);
			break;
		case EXPR_GE:
			expr_print(e->left);
			printf(">=");
			expr_print(e->right);
			break;
		case EXPR_GT:
			expr_print(e->left);
			printf(">");
			expr_print(e->right);
			break;
		case EXPR_EQ:
			expr_print(e->left);
			printf("==");
			expr_print(e->right);
			break;
		case EXPR_UNEQ:
			expr_print(e->left);
			printf("!=");
			expr_print(e->right);
			break;
		case EXPR_AND:
			expr_print(e->left);
			printf("&&");
			expr_print(e->right);
			break;
		case EXPR_OR:
			expr_print(e->left);
			printf("||");
			expr_print(e->right);
			break;
		case EXPR_ASSIGN:
			expr_print(e->left);
			printf("=");
			expr_print(e->right);
			break;
		case EXPR_COMMA:
			expr_print(e->left);
			printf(",");
			expr_print(e->right);
			break;
		case EXPR_IDENT_NAME:
			printf("%s", e->name);
			break;
		case EXPR_BOOLEAN_LITERAL:
			if(e->literal_value)
				printf("true");
			else
				printf("false");
			break;
		case EXPR_INTEGER_LITERAL:
			printf("%d", e->literal_value);
			break;
		case EXPR_CHARACTER_LITERAL: /*FIXME: need more work, print using the function in token.c */
			printf("%s", e->string_literal);
			break;
		case EXPR_STRING_LITERAL: /*FIXME: need more work, print using the function in token.c */
			printf("%s", e->string_literal);
			break;
	}
	return;
}

void expr_resolve(struct expr *e, const char *lvalue) {
	if(!e) return;
	
	expr_resolve(e->left, lvalue);
	expr_resolve(e->right, lvalue);

	if(e->kind == EXPR_IDENT_NAME) {
		scope_lookup(e->name);
		if(level == 0) {
			fprintf(stderr, "resolve error: the intializer of a global variable (%s) should be constant and should not involve another global variable (%s)!\n", lvalue, e->name);
		} 
	}
	return;
}



