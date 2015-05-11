typedef struct token {
  int tokenClass;
  int linnum;
  char *tokenstr;  // literal string for token for use
  int iValue;      // value of number if number
} TokenData;

typedef enum {Void, Integer, Boolean, Character, Undefined} ExpType;
