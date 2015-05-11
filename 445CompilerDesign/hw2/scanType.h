// scanType.h

typedef struct token {
  int tokenClass;
  int linnum;
  char *tokenstr;  // literal string for token for use
  int numValue;    // value of number if number
} Token;


