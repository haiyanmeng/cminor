%option noyywrap

%{
#include "token.h"
#include "parser.tab.h"
%}

%{
void c_comment();
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
{letter_}({letter_}|{digit})* { return TOKEN_IDENT; }

	/* integer */
[+-]?{digit}+ { return TOKEN_INTEGER_LITERAL; }

	/* char */
'{single_char}' { return TOKEN_CHAR_LITERAL; }

	/* string */
\"{single_string_char}*\" { return TOKEN_STRING_LITERAL; }
	
	/* C-style comments */
"/*" { yyless(2); c_comment(); return TOKEN_COMMENT_C; }
	
	/* C++-style comments */
"//"[^\n]*\n { return TOKEN_COMMENT_CPLUSPLUS; }

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
. { return TOKEN_ERROR; }
%%

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

