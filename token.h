
enum token {
	TOKEN_ARRAY = 1,
	TOKEN_BOOLEAN,
	TOKEN_CHAR,
	TOKEN_ELSE,
	TOKEN_FALSE,
	TOKEN_FOR,
	TOKEN_FUNCTION,
	TOKEN_IF,
	TOKEN_INTEGER,
	TOKEN_PRINT,
	TOKEN_RETURN,
	TOKEN_STRING,
	TOKEN_TRUE,
	TOKEN_VOID,
	TOKEN_WHILE,
	TOKEN_IDENT,
	TOKEN_INTEGER_LITERAL,
	TOKEN_CHAR_LITERAL,
	TOKEN_STRING_LITERAL,
	TOKEN_COMMENT_C, // /* ... */
	TOKEN_COMMENT_CPLUSPLUS, // //
	TOKEN_OP_LEFTPARENTHESS, // (
	TOKEN_OP_RIGHTPARENTHESS, // )
	TOKEN_OP_LEFTBRACKET, // [
	TOKEN_OP_RIGHTBRACKET, // ]
	TOKEN_OP_INCREMENT, // ++
	TOKEN_OP_DECREMENT, // --
	TOKEN_OP_NOT, // !
	TOKEN_OP_POWER, // ^
	TOKEN_OP_MUL, // *
	TOKEN_OP_DIV, // /
	TOKEN_OP_MOD, // %
	TOKEN_OP_ADD, // +
	TOKEN_OP_SUB, // - this is a little tricky, both binary subtraction and unary negation are this.
	TOKEN_OP_LE, // <=
	TOKEN_OP_LT, // <
	TOKEN_OP_GE, // >=
	TOKEN_OP_GT, // >
	TOKEN_OP_EQ, // ==
	TOKEN_OP_UNEQ, // !=
	TOKEN_OP_AND, // &&
	TOKEN_OP_OR, // ||
	TOKEN_OP_ASSIGN, // =
	TOKEN_LEFTCURLY, // {
	TOKEN_RIGHTCURLY, // }
	TOKEN_COLON, // :
	TOKEN_COMMA, // ,
	TOKEN_SEMICOLON, // ;
	TOKEN_ERROR
};

typedef enum token token_t;

int token_string(token_t t, const char *token_text, int token_len);

int print_char(char a, char b);

int print_str(const char *text, int len);

