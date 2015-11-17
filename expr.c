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
		e->symbol = scope_lookup(e->name, 1);
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

struct type *expr_typecheck(struct expr *e, int is_array_initializer) {
	if(!e) return 0;
	
	struct type *left, *right;
	switch(e->kind) {
		case EXPR_LEFTCURLY:
			return type_create(TYPE_ARRAY, 0, 0, expr_typecheck(e->right, is_array_initializer));
			break;
		case EXPR_LEFTPARENTHESS:
			if(e->left) {
				//function call
				//check function call arguments and function definition paramters
				expr_func_typecheck(e, is_array_initializer);
				return scope_lookup(e->left->name, 0)->type->subtype;
			} else {
				//grouping
				return expr_typecheck(e->right, is_array_initializer);
			}
			break;
		case EXPR_LEFTBRACKET:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);

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
			left = expr_typecheck(e->left, is_array_initializer);
			if(left->kind != TYPE_INTEGER) {
				fprintf(stderr, "type error: ++/-- expr only applys to integer types!\n");
				exit(EXIT_FAILURE);
			}
			return left;
			break;
		case EXPR_UNARY_NEG:
			right = expr_typecheck(e->right, is_array_initializer);
			if(right->kind != TYPE_INTEGER) {
				fprintf(stderr, "type error: unary neg operator expr only applys to integer types!\n");
				exit(EXIT_FAILURE);
			}
			return right;
			break;
		case EXPR_NOT:
			right = expr_typecheck(e->right, is_array_initializer);
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
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of binary arithmetic operator expr mismatch.\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_INTEGER) {
					fprintf(stderr, "type error: the operands of binary arithmetic operator must be integers!\n");
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_LE:
		case EXPR_LT:
		case EXPR_GE:
		case EXPR_GT:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of a comparison operator mismatch!\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_INTEGER) {
					fprintf(stderr, "type error: the operands of a comparison operator must be integers!\n");
					exit(EXIT_FAILURE);
				}
				return type_create(TYPE_BOOLEAN, 0, 0, 0);
			}
			break;
		case EXPR_EQ:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of the == operator mismatch!\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind == TYPE_ARRAY || left->kind == TYPE_FUNCTION) {
					fprintf(stderr, "type error: the == operator does not apply to array and function types!\n");
					exit(EXIT_FAILURE);
				}
				return type_create(TYPE_BOOLEAN, 0, 0, 0);
			}
			break;
		case EXPR_UNEQ:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of the != operator mismatch!\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind == TYPE_ARRAY || left->kind == TYPE_FUNCTION) {
					fprintf(stderr, "type error: the != operator does not apply to array and function types!\n");
					exit(EXIT_FAILURE);
				}
				return type_create(TYPE_BOOLEAN, 0, 0, 0);
			}
			break;
		case EXPR_AND:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of the && operator mismatch!\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_BOOLEAN) {
					fprintf(stderr, "type error: the && operator only applys to boolean types!\n");
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_OR:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of the || operator mismatch!\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind != TYPE_BOOLEAN) {
					fprintf(stderr, "type error: the || operator only applys to boolean types!\n");
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_ASSIGN:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(!type_equals(left, right)) {
				fprintf(stderr, "type error: the operands of the = operator mismatch!\n");
				exit(EXIT_FAILURE);
			} else {
				if(left->kind == TYPE_FUNCTION) {
					fprintf(stderr, "type error: the = operator does not apply to function types!\n");
					exit(EXIT_FAILURE);
				}
				return left;
			}
			break;
		case EXPR_COMMA:
			left = expr_typecheck(e->left, is_array_initializer);
			right = expr_typecheck(e->right, is_array_initializer);
			if(is_array_initializer) {
				if(!type_equals(left, right)) {
					printf("type error: the elements of an array intializer should have the same type!\n");
					exit(EXIT_FAILURE);
				} else {
					return left;
			}
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

//check function call arguments and function definition paramters
void expr_func_typecheck(struct expr *e, int is_array_initializer) {
	//search for the function in the global scope, get its type 
	struct symbol *s = scope_lookup(e->left->name, 0);
	struct param_list *p = s->type->params;

	//get the argument number of the function call
	int n = expr_func_countargc(e->right);

	int i = 0;
	struct expr *arg;
	while(p) {
		i += 1;	
		if(i > n) {
			fprintf(stderr, "type error: function call does not have enough arguments!\n");
			exit(EXIT_FAILURE);
		}
		arg = expr_func_getarg(e->right, n, i);
		if(!type_equals(p->type, expr_typecheck(arg, is_array_initializer))) {
			fprintf(stderr, "type error: the types of function call arguments do not match the types of function parameters!\n");
			exit(EXIT_FAILURE);
		}
		p = p->next;
	}

	if(i < n) {
		fprintf(stderr, "type error: function call has too much arguments!\n");
		exit(EXIT_FAILURE);
	}

	return;
}

struct expr *expr_func_getarg(struct expr *e, int n, int i) {
	if(i == n) {
		if(n == 1) {
			return e;
		} else {	
			return e->right;
		}
	}

	int x = n - i;
	while(x > 0) {
		e = e->left;	
		x -= 1; 
	}

	if(i == 1) {
		return e;
	} else {
		return e->right;
	}
}

int expr_func_countargc(struct expr *e) {
	if(!e) return 0;
	int n = 1;
	while(e->kind == EXPR_COMMA) {
		n += 1;
		e = e->left;
	}
	return n;
}





