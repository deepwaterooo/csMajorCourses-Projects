typedef union {
	Inst *inst;    /* ָ�� */
	symrec *tptr;  /* ���ű�ָ�� */
	int narg;      /* ���� */
	int delim;     /* �ֽ��(��������ű���) */
	int op;		   /* ������(��������ű���) */
	char *str;	   /* �ַ���(��������ű���) */
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
