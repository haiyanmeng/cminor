%option noyywrap

%{
#include "parser.tab.h"
%}

%{
void c_comment();
void check_id();
void check_str();
int real_strlen(const char *text, int len);
%}

%{
/*** RULES ***/
/* keywords: array boolean char else false for function if integer print return string true void while */
/* identifiers: Identifiers (i.e. variable and function names) may contain letters, numbers, and underscores. Identifiers must begin with a letter or an underscore. These are examples of valid identifiers. */
/* constants: integer, char, string */
/* comments */
/* operators: + - * /   */
/* punctuations : , ; */
/* whitespace: */
/* others */
%}

digit [0-9]
letter_ [a-zA-Z_]
single_char [^\\]|\\.
single_string_char \\.|[^\\"\n]
%%
	/* keywords */
array { fprintf(stdout, "TOKEN_ARRAY: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_ARRAY; }
boolean { fprintf(stdout, "TOKEN_BOOLEAN: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_BOOLEAN; }
char { fprintf(stdout, "TOKEN_CHAR: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_CHAR; }
else { fprintf(stdout, "TOKEN_ELSE: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_ELSE; }
false { fprintf(stdout, "TOKEN_FALSE: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_FALSE; }
for { fprintf(stdout, "TOKEN_FOR: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_FOR; }
function { fprintf(stdout, "TOKEN_FUNCTION: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_FUNCTION; }
if { fprintf(stdout, "TOKEN_IF: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_IF; }
integer { fprintf(stdout, "TOKEN_INTEGER: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_INTEGER; }
print { fprintf(stdout, "TOKEN_PRINT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_PRINT; }
return { fprintf(stdout, "TOKEN_RETURN: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_RETURN; }
string { fprintf(stdout, "TOKEN_STRING: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_STRING; }
true { fprintf(stdout, "TOKEN_TRUE: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_TRUE; }
void { fprintf(stdout, "TOKEN_VOID: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_VOID; }
while { fprintf(stdout, "TOKEN_WHILE: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_WHILE; }

	/* identifier */
{letter_}({letter_}|{digit})* { check_id(); fprintf(stdout, "TOKEN_IDENT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_IDENT; }

	/* integer */
[+-]?{digit}+ { fprintf(stdout, "TOKEN_INTEGER_LITERAL: %s\n", yytext); yylval.n = atoi(strdup(yytext)); return TOKEN_INTEGER_LITERAL; }

	/* char */
'{single_char}' { fprintf(stdout, "TOKEN_CHAR_LITERAL: %s\n", yytext); yylval.c = atoi(strdup(yytext)); return TOKEN_CHAR_LITERAL; }

	/* string */
\"{single_string_char}*\" { check_str(); fprintf(stdout, "TOKEN_STRING_LITERAL: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_STRING_LITERAL; }
	
	/* C-style comments */
"/*" { yyless(2); c_comment(); fprintf(stdout, "TOKEN_COMMENT_C\n"); }
	
	/* C++-style comments */
"//"[^\n]*\n /* C++-style comments */

	/* operators */
"(" { fprintf(stdout, "TOKEN_OP_LEFTPARENTHESS: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_LEFTPARENTHESS; }
")" { fprintf(stdout, "TOKEN_OP_RIGHTPARENTHESS: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_RIGHTPARENTHESS; }
"[" { fprintf(stdout, "TOKEN_OP_LEFTBRACKET: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_LEFTBRACKET; }
"]" { fprintf(stdout, "TOKEN_OP_RIGHTBRACKET: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_RIGHTBRACKET; }
"++" { fprintf(stdout, "TOKEN_OP_INCREMENT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_INCREMENT; }
"--" { fprintf(stdout, "TOKEN_OP_DECREMENT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_DECREMENT; }
"!" { fprintf(stdout, "TOKEN_OP_NOT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_NOT; }
"^" { fprintf(stdout, "TOKEN_OP_POWER: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_POWER; }
"*" { fprintf(stdout, "TOKEN_OP_MUL: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_MUL; }
"/" { fprintf(stdout, "TOKEN_OP_DIV: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_DIV; }
"%" { fprintf(stdout, "TOKEN_OP_MOD: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_MOD; }
"+" { fprintf(stdout, "TOKEN_OP_ADD: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_ADD; }
"-" { fprintf(stdout, "TOKEN_OP_SUB: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_SUB; }
"<=" { fprintf(stdout, "TOKEN_OP_LE: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_LE; }
"<" { fprintf(stdout, "TOKEN_OP_LT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_LT; }
">=" { fprintf(stdout, "TOKEN_OP_GE: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_GE; }
">" { fprintf(stdout, "TOKEN_OP_GT: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_GT; }
"==" { fprintf(stdout, "TOKEN_OP_EQ: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_EQ; }
"!=" { fprintf(stdout, "TOKEN_OP_UNEQ: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_UNEQ; }
"&&" { fprintf(stdout, "TOKEN_OP_AND: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_AND; }
"||" { fprintf(stdout, "TOKEN_OP_OR: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_OR; }
"=" { fprintf(stdout, "TOKEN_OP_ASSIGN: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_OP_ASSIGN; }
"{" { fprintf(stdout, "TOKEN_LEFTCURLY: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_LEFTCURLY; }
"}" { fprintf(stdout, "TOKEN_RIGHTCURLY: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_RIGHTCURLY; }
":" { fprintf(stdout, "TOKEN_COLON: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_COLON; }
"," { fprintf(stdout, "TOKEN_COMMA: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_COMMA; }
";" { fprintf(stdout, "TOKEN_SEMICOLON: %s\n", yytext); yylval.str = strdup(yytext); return TOKEN_SEMICOLON; }

	/* whitespace */
[ \t\n\r]+ /* white space */

	/* all the others */
. { fprintf(stderr, "scan error: %s is not a valid token!\n", yytext); exit(EXIT_FAILURE); }
%%

void check_id() {
	if(yyleng > 256) {
		fprintf(stderr, "scan error: the identifier(%s) is too long (its length is %d)! A identifer can be no longer than 256 characters!\n", yytext, yyleng);
		exit(EXIT_FAILURE);
	}
}

void check_str() {
	int real_len = real_strlen(yytext, yyleng);
	if(real_len > 255) {
		fprintf(stderr, "scan error: the string is too long (its length is %d)! A string can have at most 255 printable characters and 1 null-terminator!\n", real_len);
		exit(EXIT_FAILURE);
	}
}

/* get the real strlen TOKEN_STRING_LITERAL
 * flex scans the input literally, without considering any escape characters. Therefore, yytext includes each character of a token literally.
 * For example, for a char token whose yytext is "a\"b", strlen(yytext) is 6, even if cminor should treat the length of this token as 3.
 */
int real_strlen(const char *text, int len) {
	int i = 1;
	int real_len = 0;
	while(i < len - 1) {
		if(text[i] == '\\') {
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

void c_comment() {
	char c;
	int cur = 2;

loop1:
	while((c = input()) != '*' && c != EOF)
		yytext[cur++] = c;

	if(c == '*') {
		yytext[cur++] = c;
		while((c = input()) == '*') {
			yytext[cur++] = c;
		}
		yytext[cur++] = c;
		if(c == '/') {
			yytext[cur] = '\0';
		}
		else {
			goto loop1;
		}
	}

	if(c == EOF) {
		printf("scan error: the C-style comment is incomplete, EOF should not be included inside a comment!\n");
		exit(EXIT_FAILURE);
	}
}

