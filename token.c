#include "token.h"
#include <stdio.h>
#include <string.h>

int token_string(token_t t, const char *token_text, int token_len) {
	char *new_text;
	switch(t) {
	case TOKEN_ARRAY:
		fprintf(stdout, "TOKEN_ARRAY\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_BOOLEAN:
		fprintf(stdout, "TOKEN_BOOLEAN\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_CHAR:
		fprintf(stdout, "TOKEN_CHAR\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_ELSE:
		fprintf(stdout, "TOKEN_ELSE\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_FALSE:
		fprintf(stdout, "TOKEN_FALSE\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_FOR:
		fprintf(stdout, "TOKEN_FOR\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_FUNCTION:
		fprintf(stdout, "TOKEN_FUNCTION\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_IF:
		fprintf(stdout, "TOKEN_IF\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_INTEGER:
		fprintf(stdout, "TOKEN_INTEGER\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_PRINT:
		fprintf(stdout, "TOKEN_PRINT\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_RETURN:
		fprintf(stdout, "TOKEN_RETURN\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_STRING:
		fprintf(stdout, "TOKEN_STRING\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_TRUE:
		fprintf(stdout, "TOKEN_TRUE\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_VOID:
		fprintf(stdout, "TOKEN_VOID\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_WHILE:
		fprintf(stdout, "TOKEN_WHILE\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_IDENT:
		if(token_len > 256) {
			fprintf(stderr, "scan error: the identifier(%s) is too long (its length is %d)! A identifer can be no longer than 256 characters!\n", token_text, token_len);
			return -2;
		}
		fprintf(stdout, "TOKEN_IDENT\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_INTEGER_LITERAL:
		fprintf(stdout, "TOKEN_INTEGER_LITERAL\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_CHAR_LITERAL:
		//fprintf(stdout, "TOKEN_CHAR_LITERAL %s\n", token_text);
		//fprintf(stdout, "len: %d\n", strlen(token_text));
		fprintf(stdout, "TOKEN_CHAR_LITERAL ");
		print_char(token_text[1], token_text[2]);
		fprintf(stdout, "\n");
		break;
	case TOKEN_STRING_LITERAL:
		//fprintf(stdout, "TOKEN_STRING_LITERAL %s\n", token_text);
		//fprintf(stdout, "len: %d\n", strlen(token_text));
		fprintf(stdout, "TOKEN_STRING_LITERAL ");
		int real_len = print_str(token_text, token_len);
		fprintf(stdout, "\n");
		if(real_len > 255) {
			fprintf(stderr, "scan error: the string is too long (its length is %d)! A string can have at most 255 printable characters and 1 null-terminator!\n", real_len);
			return -2;
		}
		//fprintf(stdout, "real_len: %d\n", real_len);
		break;
	case TOKEN_COMMENT_C:
		fprintf(stdout, "TOKEN_COMMENT_C\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_COMMENT_CPLUSPLUS:
		fprintf(stdout, "TOKEN_COMMENT_CPLUSPLUS\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_LEFTPARENTHESS:
		fprintf(stdout, "TOKEN_OP_LEFTPARENTHESS\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_RIGHTPARENTHESS:
		fprintf(stdout, "TOKEN_OP_RIGHTPARENTHESS\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_LEFTBRACKET:
		fprintf(stdout, "TOKEN_OP_LEFTBRACKET\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_RIGHTBRACKET:
		fprintf(stdout, "TOKEN_OP_RIGHTBRACKET\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_INCREMENT:
		fprintf(stdout, "TOKEN_OP_INCREMENT\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_DECREMENT:
		fprintf(stdout, "TOKEN_OP_DECREMENT\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_POWER:
		fprintf(stdout, "TOKEN_OP_POWER\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_MUL:
		fprintf(stdout, "TOKEN_OP_MUL\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_DIV:
		fprintf(stdout, "TOKEN_OP_DIV\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_MOD:
		fprintf(stdout, "TOKEN_OP_MOD\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_ADD:
		fprintf(stdout, "TOKEN_OP_ADD\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_SUB:
		fprintf(stdout, "TOKEN_OP_SUB\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_LE:
		fprintf(stdout, "TOKEN_OP_LE\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_LT:
		fprintf(stdout, "TOKEN_OP_LT\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_GE:
		fprintf(stdout, "TOKEN_OP_GE\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_GT:
		fprintf(stdout, "TOKEN_OP_GT\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_EQ:
		fprintf(stdout, "TOKEN_OP_EQ\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_UNEQ:
		fprintf(stdout, "TOKEN_OP_UNEQ\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_AND:
		fprintf(stdout, "TOKEN_OP_AND\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_OR:
		fprintf(stdout, "TOKEN_OP_OR\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_OP_ASSIGN:
		fprintf(stdout, "TOKEN_OP_ASSIGN\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_LEFTCURLY:
		fprintf(stdout, "TOKEN_LEFTCURLY\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_RIGHTCURLY:
		fprintf(stdout, "TOKEN_RIGHTCURLY\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_COLON:
		fprintf(stdout, "TOKEN_COLON\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_COMMA:
		fprintf(stdout, "TOKEN_COMMA\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_SEMICOLON:
		fprintf(stdout, "TOKEN_SEMICOLON\n");
		//fprintf(stdout, "%s\n", token_text);
		break;
	case TOKEN_ERROR:
		fprintf(stderr, "scan error: %s is not a valid token!\n", token_text);
		//fprintf(stderr, "%s\n", token_text);
		return -1;
	}
	return 0;
}

/* Print TOKEN_CHAR_LITERAL
 * flex scans the input literally, without considering any escape characters. Therefore, yytext includes each character of a token literally.
 * For example, for a char token whose yytext is '\n', strlen(yytext) is 4, even if cminor should treat the length of this token as 1.
 */
int print_char(char a, char b) {
	if(a == '\\') {
		switch(b) {
			case '0':
				fprintf(stdout, "%c", '\0');
				break;
			case 't':
				fprintf(stdout, "%c", '\t');
				break;
			case 'n':
				fprintf(stdout, "%c", '\n');
				break;
			case 'r':
				fprintf(stdout, "%c", '\r');
				break;
			default:
				fprintf(stdout, "%c", b);
				break;
		}
		return 2;
	} else {
		fprintf(stdout, "%c", a);
		return 1;
	}
}

/* Print TOKEN_STRING_LITERAL
 * flex scans the input literally, without considering any escape characters. Therefore, yytext includes each character of a token literally.
 * For example, for a char token whose yytext is "a\"b", strlen(yytext) is 6, even if cminor should treat the length of this token as 3.
 */
int print_str(const char *text, int len) {
	int i = 1;
	int real_len = 0;
	while(i < len - 1) {
		if(print_char(text[i], text[i+1]) == 2) {
			if(text[i+1] == '0') {
				return real_len;
			}
			i += 2;
			real_len += 1;
		} else {
			i += 1;
			real_len += 1;
		}
	}
	return real_len;
}
