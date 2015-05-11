typedef union {
	Inst *inst;    /* 指令 */
	symrec *tptr;  /* 符号表指针 */
	int narg;      /* 参数 */
	int delim;     /* 分界符(不存入符号表中) */
	int op;		   /* 操作符(不存入符号表中) */
	char *str;	   /* 字符串(不存入符号表中) */
} YYSTYPE;
#define	NL	258
#define	COMMA	259
#define	LP	260
#define	RP	261
#define	LB	262
#define	RB	263
#define	MINUSMINUS	264
#define	PLUSPLUS	265
#define	PLUSMINUS	266
#define	MINUSPLUS	267
#define	NUMBER	268
#define	CONST	269
#define	VAR	270
#define	BLTIN	271
#de		
