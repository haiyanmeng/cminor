%option noyywrap
%option yylineno

%{
#include "parser.tab.h"
%}

%{
void c_comment();
void check_id();
void check_str();
int char_process();
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

/*
yytext is the interal buffer flex uses to match tokens, and it will be overwritten
when the next yylex call tries to read the next token.
Therefore, bison cannot rely on yytext to keep the token content.
One solution is to use strdup copy yytext to some storage pointed by yylval.<union_member>.
*/
%}

digit [0-9]
letter_ [a-zA-Z_]
single_char [^\\]|\\.
single_string_char \\.|[^\\"\n]
%%
	/* keywords */
array { return TOKEN_ARRAY; }
boolean { return TOKEN_BOOLEAN; }
char { return TOKEN_CHAR; }
else { return TOKEN_ELSE; }
false { return TOKEN_FALSE; }
for { return TOKEN_FOR; }
function { return TOKEN_FUNCTION; }
if { return TOKEN_IF; }
integer { return TOKEN_INTEGER; }
print { return TOKEN_PRINT; }
return { return TOKEN_RETURN; }
string { return TOKEN_STRING; }
true { return TOKEN_TRUE; }
void { return TOKEN_VOID; }
while { return TOKEN_WHILE; }

	/* identifier */
{letter_}({letter_}|{digit})* { check_id(); yylval.str = strdup(yytext); return TOKEN_IDENT; }

	/* integer */
{digit}+ { yylval.n = atoi(yytext); return TOKEN_INTEGER_LITERAL; }

	/* char */
'{single_char}' { yylval.str = strdup(yytext); return TOKEN_CHAR_LITERAL; }

	/* string */
\"{single_string_char}*\" { check_str(); yylval.str = strdup(yytext); return TOKEN_STRING_LITERAL; }
	
	/* C-style comments */
"/*" { yyless(2); c_comment(); }
	
	/* C++-style comments */
"//"[^\n]*\n /* C++-style comments */

	/* operators */
"(" { return TOKEN_OP_LEFTPARENTHESS; }
")" { return TOKEN_OP_RIGHTPARENTHESS; }
"[" { return TOKEN_OP_LEFTBRACKET; }
"]" { return TOKEN_OP_RIGHTBRACKET; }
"++" { return TOKEN_OP_INCREMENT; }
"--" { return TOKEN_OP_DECREMENT; }
"!" { return TOKEN_OP_NOT; }
"^" { return TOKEN_OP_POWER; }
"*" { return TOKEN_OP_MUL; }
"/" { return TOKEN_OP_DIV; }
"%" { return TOKEN_OP_MOD; }
"+" { return TOKEN_OP_ADD; }
"-" { return TOKEN_OP_SUB; }
"<=" { return TOKEN_OP_LE; }
"<" { return TOKEN_OP_LT; }
">=" { return TOKEN_OP_GE; }
">" { return TOKEN_OP_GT; }
"==" { return TOKEN_OP_EQ; }
"!=" { return TOKEN_OP_UNEQ; }
"&&" { return TOKEN_OP_AND; }
"||" { return TOKEN_OP_OR; }
"=" { return TOKEN_OP_ASSIGN; }
"{" { return TOKEN_LEFTCURLY; }
"}" { return TOKEN_RIGHTCURLY; }
":" { return TOKEN_COLON; }
"," { return TOKEN_COMMA; }
";" { return TOKEN_SEMICOLON; }

	/* whitespace */
[ \t\n\r]+ /* white space */

	/* all the others */
. { fprintf(stderr, "scan error: %s is not a valid token! (Error Location: Line %d)\n", yytext, yylineno); exit(EXIT_FAILURE); }
%%

void check_id() {
	if(yyleng > 256) {
		fprintf(stderr, "scan error: the identifier(%s) is too long (its length is %d)! A identifer can be no longer than 256 characters! (Error Location: Line %d)\n", yytext, yyleng, yylineno);
		exit(EXIT_FAILURE);
	}
}

void check_str() {
	int real_len = real_strlen(yytext, yyleng);
	if(real_len > 255) {
		fprintf(stderr, "scan error: the string is too long (its length is %d)! A string can have at most 255 printable characters and 1 null-terminator! (Error Location: Line %d)\n", real_len, yylineno);
		exit(EXIT_FAILURE);
	}
}

int char_process() {
	if(yytext[1] == '\\') {
		switch(yytext[2]) {
			case '0':
				return '\0';
			case 't':
				return '\t';
			case 'n':
				return '\n';
			case 'r':
				return '\r';
			default:
				return yytext[2];
		}
		return 2;
	} else {
		return yytext[1];
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
		printf("scan error: the C-style comment is incomplete, EOF should not be included inside a comment! (Error Location: Line %d)\n", yylineno);
		exit(EXIT_FAILURE);
	}
}

