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
	e->symbol = 0;
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

void expr_resolve(struct expr *e) {
	if(!e) return;
	
	expr_resolve(e->left);
	expr_resolve(e->right);

	if(e->kind == EXPR_IDENT_NAME) {
		e->symbol = scope_lookup(e->name);
	}
}

int expr_is_constant(struct expr *e) {
	if(!e) return 1;

	if(e->kind == EXPR_IDENT_NAME) {
		return 0;
	} else {
		return expr_is_constant(e->left) && expr_is_constant(e->right);
	}
}

struct type *expr_typecheck(struct expr *e) {
	if(!e) return 0;
	
	struct type *left, *right;
	switch(e->kind) {
		case EXPR_LEFTCURLY:
			return type_create(TYPE_ARRAY, 0, 0, expr_typecheck(e->right));
			break;
		case EXPR_LEFTPARENTHESS:
			if(e->left) {
				//function call
				return scope_lookup(e->left->name)->type->subtype;
			} else {
				//grouping
				return expr_typecheck(e->right);
			}
			break;
		case EXPR_LEFTBRACKET:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);

			//the left child should be type array
			if(left->kind != TYPE_ARRAY) {
				fprintf(stderr, "type error: %s is not an array, and can not be indexed.\n", e->left->name);
				exit(EXIT_FAILURE);
			}

			//the right child should be type integer
			if(right->kind != TYPE_INTEGER) {
				fprintf(stderr, "type error: an array index must be integer!\n");
				exit(EXIT_FAILURE);
			}
			return left->subtype;
			break;
		case EXPR_INCREMENT:
		case EXPR_DECREMENT:
			left = expr_typecheck(e->left);
			if(left->kind != TYPE_INTEGER) {
				fprintf(stderr, "type error: ++/-- expr only applys to integer types!\n");
				type_print(left);
				type_print(left);
				exit(EXIT_FAILURE);
			}
			return left;
			break;
		case EXPR_UNARY_NEG:
			right = expr_typecheck(e->right);
			if(right->kind != TYPE_INTEGER) {
				fprintf(stderr, "type error: unary neg operator expr only applys to integer types!\n");
				type_print(right);
				exit(EXIT_FAILURE);
			}
			return right;
			break;
		case EXPR_NOT:
			right = expr_typecheck(e->right);
			if(right->kind != TYPE_BOOLEAN) {
				fprintf(stderr, "type error: not operator expr only applys to boolean types!\n");
				type_print(right);
				exit(EXIT_FAILURE);
			}
			return right;
			break;
		case EXPR_POWER:
		case EXPR_MUL:
		case EXPR_DIV:
		case EXPR_MOD:
		case EXPR_ADD:
		case EXPR_SUB:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: binary operator expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_INTEGER) {
					fprintf(stderr, "type error: binary operator expr only applys to integer types!\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_LE:
		case EXPR_LT:
		case EXPR_GE:
		case EXPR_GT:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: comparison expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_INTEGER) {
					fprintf(stderr, "type error: comparison expr only applys to integer types!\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return type_create(TYPE_BOOLEAN, 0, 0, 0);
			}
			break;
		case EXPR_EQ:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: eq expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind == TYPE_ARRAY || left->kind == TYPE_FUNCTION) {
					fprintf(stderr, "type error: eq expr does not apply to array and function types!\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return type_create(TYPE_BOOLEAN, 0, 0, 0);
			}
			break;
		case EXPR_UNEQ:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: uneq expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind == TYPE_ARRAY || left->kind == TYPE_FUNCTION) {
					fprintf(stderr, "type error: uneq expr does not apply to array and function types!\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_AND:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: and expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_BOOLEAN) {
					fprintf(stderr, "type error: and expr only applys to boolean types!\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_OR:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: or expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_BOOLEAN) {
					fprintf(stderr, "type error: or expr only applys to boolean types!\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_ASSIGN:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: assign expr mismatch. ");
				type_print(left);
				type_print(right);
				exit(EXIT_FAILURE);
			} else {
				if(left->kind == TYPE_FUNCTION) {
					fprintf(stderr, "type error: assign expr does not apply to function types\n");
					type_print(left);
					type_print(right);
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_COMMA:
			left = expr_typecheck(e->left);
			right = expr_typecheck(e->right);
			if(!type_equals(left, right)) {
				printf("type error: comma expr mismatch: ");
				type_print(left);
				printf(", ");	
				type_print(right);
				printf("\n");	
				exit(EXIT_FAILURE);
			} else {
				return left;
			}
			break;
		case EXPR_IDENT_NAME:
			return e->symbol->type;
			break;
		case EXPR_BOOLEAN_LITERAL:
			return type_create(TYPE_BOOLEAN, 0, 0, 0);
			break;
		case EXPR_INTEGER_LITERAL:
			return type_create(TYPE_INTEGER, 0, 0, 0);
			break;
		case EXPR_CHARACTER_LITERAL: 
			return type_create(TYPE_CHARACTER, 0, 0, 0);
			break;
		case EXPR_STRING_LITERAL: 
			return type_create(TYPE_STRING, 0, 0, 0);
			break;
	}
	return 0;
}

