/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison implementation for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.5"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 268 of yacc.c  */
#line 1 "c-.y"

#include <iostream>
  //#include <stdio.h>
#include <fstream>
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "scanType.h"  
#include "c-.tab.h"
#include "symtab.h"
#include "emitCode.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
FILE* code; 
char *yyfilename;
extern char *yytext;
extern int linnum;
extern char tokenString[];
extern char* optarg;

#define MAXCHILDREN 3
#define gp GP   //0  The global pointer
#define fp FP   //1  The local frame pointer
#define rt RT   //2  Return value
#define ac AC   //3  Accumulator
#define ac1 AC1 //4  Accumulator
#define ac2 AC2 //5  Accumulator
#define ac3 AC3 //6  Accumulator
#define pc PC   //7  The program counter

int goffset = 0;
int toff;
int foffset, loc_main;

typedef int TokenType;
typedef enum {DeclK, StmtK, ExpK} NodeKind; 
typedef enum {VarK, FuncK, ParamK} DeclKind;
typedef enum {IfK, WhileK, ForEachK, CompoundK, ReturnK, BreakK} StmtKind;
typedef enum {OpK, ConstantK, IdK, AssignK, CallK} ExpKind;
typedef enum {LocalStatic, Local, Global, Parameter} typeallocation;

typedef struct treeNode {
  struct treeNode *child[MAXCHILDREN]; // children of the node
  struct treeNode *sibling;            // siblings for the node
  int linnum;                          // linenum relevant to this node
  NodeKind nodekind;                   // type of node
  union {                              // subtype of type 
    DeclKind decl;                     // used when DeclK
    StmtKind stmt;                     // used when StmtK
    ExpKind exp;                       // used when ExpK
  } kind;
  union {                              // relevant data to type -> attr
    TokenType op;                      // type of token (same as in bison)
    int val;                           // used when an integer constant
    char *name;                        // used when IdK
  } attr;                                 
  char* string;                        // used when a string constant
  ExpType expType;                     // used when ExpK for type checking
  bool isStatic;                       // is staticly allocated?
  bool isArray;                        // is this an array
  bool isConstant;                     // can this expression be precomputed?

  int loc; 
  int size; 
  typeallocation TypeAllocation;

} TreeNode;

static TreeNode* savedTree; // stores syntax tree for later return

using namespace std;
//#define YY_DECL extern "C" int yylex()
#define YYDEBUG 1
TreeNode * newStmtNode( StmtKind );
TreeNode * newDeclNode(DeclKind kind);
TreeNode * newExpNode( ExpKind );
//void FreeTree(Node *p);
static TokenData token; /* holds current token */
void yyerror(const char* s);
char* getType(int x);
char* getTypeAlloc(int x);
char * copyString( char * s);

static int indentno = 0;
#define INDENT indentno += 1
#define UNINDENT indentno -= 1
void printNode( TreeNode * tree);
void printTree( TreeNode * tree, int depth, unsigned int sepbits);
//void printTree( TreeNode * tree);
static void printSpaces(void);
static void insertCheckNode( TreeNode * t);
TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char*);
char str[64];

static int tempOffset = 0;
static void cgen(TreeNode* tree);
void emitIO(char * string);
int backPatchJumpToHere(int addr, char *comment);
int backPatchJumpToHere2(int addr, char *comment, char *cc);
void genGlobal();
bool isIO(TreeNode* t);

int i = 0;
int cmpi = 0;
int funci = 0;
int ifi = 0;
int whilei = 0;
int opi = 0;
int assigni = 0;
bool ReturnFlag = false;
bool LoopFlag = false;
bool WhileFlag = false;
bool ForEachFlag = false;
bool cpflag = false;
int depthcnt = 0;
int callcnt = 0;
int bkcnt = 0;
int breakloc;
TreeNode* assptr;
bool leftf = false;
bool funcf = false;
bool aindexf = false;



/* Line 268 of yacc.c  */
#line 201 "c-.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     PASSIGN = 258,
     MASSIGN = 259,
     INC = 260,
     DEC = 261,
     EQ = 262,
     NEQ = 263,
     LEQ = 264,
     GEQ = 265,
     ID = 266,
     CHARCONST = 267,
     NUMCONST = 268,
     STRINGCONST = 269,
     IF = 270,
     ELSE = 271,
     WHILE = 272,
     FOREACH = 273,
     IN = 274,
     STATIC = 275,
     INT = 276,
     BOOL = 277,
     CHAR = 278,
     VOID = 279,
     TRUE = 280,
     FALSE = 281,
     RETURN = 282,
     BREAK = 283,
     AND = 284,
     OR = 285,
     NOT = 286
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 293 of yacc.c  */
#line 130 "c-.y"

  ExpType type;    
  int number;
  TokenData * tokenData;
  struct treeNode * nodeptr;



/* Line 293 of yacc.c  */
#line 277 "c-.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 343 of yacc.c  */
#line 289 "c-.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  13
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   253

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  49
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  37
/* YYNRULES -- Number of rules.  */
#define YYNRULES  97
/* YYNRULES -- Number of states.  */
#define YYNSTATES  168

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   286

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,    45,     2,     2,
      33,    36,    44,    48,    29,    47,     2,    46,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    31,    30,
      41,    42,    43,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    34,     2,    37,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    32,     2,    35,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    38,    39,    40
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    14,    18,    23,
      27,    31,    33,    35,    40,    44,    51,    53,    55,    57,
      59,    66,    72,    74,    75,    80,    83,    87,    89,    91,
      95,    97,    99,   107,   113,   121,   123,   131,   137,   143,
     151,   153,   156,   160,   163,   166,   168,   173,   176,   177,
     180,   181,   185,   189,   193,   196,   199,   201,   205,   207,
     211,   213,   216,   218,   222,   226,   230,   234,   238,   242,
     244,   248,   252,   254,   258,   260,   262,   264,   266,   269,
     271,   273,   275,   277,   279,   281,   286,   290,   292,   294,
     296,   298,   300,   302,   307,   309,   310,   314
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      50,     0,    -1,    51,    -1,    51,    52,    -1,    52,    -1,
      53,    -1,    58,    -1,    57,    55,    30,    -1,    20,    57,
      55,    30,    -1,    57,    55,    30,    -1,    55,    29,    56,
      -1,    56,    -1,    11,    -1,    11,    34,    13,    37,    -1,
      11,    31,    71,    -1,    11,    34,    13,    37,    31,    71,
      -1,    21,    -1,    22,    -1,    23,    -1,    24,    -1,    57,
      11,    33,    59,    36,    63,    -1,    11,    33,    59,    36,
      63,    -1,    60,    -1,    -1,    60,    30,    57,    61,    -1,
      57,    61,    -1,    61,    29,    62,    -1,    62,    -1,    11,
      -1,    11,    34,    37,    -1,    64,    -1,    65,    -1,    15,
      33,    71,    36,    64,    16,    64,    -1,    17,    33,    71,
      36,    64,    -1,    18,    33,    81,    19,    71,    36,    64,
      -1,    66,    -1,    15,    33,    71,    36,    64,    16,    65,
      -1,    15,    33,    71,    36,    63,    -1,    17,    33,    71,
      36,    65,    -1,    18,    33,    81,    19,    71,    36,    65,
      -1,    67,    -1,    27,    30,    -1,    27,    70,    30,    -1,
      28,    30,    -1,    70,    30,    -1,    30,    -1,    32,    68,
      69,    35,    -1,    68,    54,    -1,    -1,    69,    63,    -1,
      -1,    81,    42,    70,    -1,    81,     3,    70,    -1,    81,
       4,    70,    -1,    81,     5,    -1,    81,     6,    -1,    71,
      -1,    71,    39,    72,    -1,    72,    -1,    72,    38,    73,
      -1,    73,    -1,    40,    73,    -1,    74,    -1,    75,    41,
      75,    -1,    75,    43,    75,    -1,    75,     9,    75,    -1,
      75,    10,    75,    -1,    75,     7,    75,    -1,    75,     8,
      75,    -1,    75,    -1,    75,    48,    76,    -1,    75,    47,
      76,    -1,    76,    -1,    76,    77,    78,    -1,    78,    -1,
      44,    -1,    46,    -1,    45,    -1,    79,    78,    -1,    80,
      -1,    47,    -1,    44,    -1,    82,    -1,    81,    -1,    11,
      -1,    11,    34,    70,    37,    -1,    33,    70,    36,    -1,
      83,    -1,    13,    -1,    12,    -1,    14,    -1,    25,    -1,
      26,    -1,    11,    33,    84,    36,    -1,    85,    -1,    -1,
      85,    29,    70,    -1,    70,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   156,   156,   158,   168,   170,   171,   174,   187,   201,
     217,   227,   229,   235,   244,   251,   261,   262,   263,   264,
     267,   278,   290,   291,   294,   312,   325,   335,   337,   343,
     352,   353,   355,   365,   374,   383,   385,   395,   404,   413,
     423,   424,   430,   437,   443,   444,   450,   458,   468,   470,
     480,   482,   492,   501,   510,   518,   526,   528,   537,   539,
     548,   550,   558,   560,   569,   578,   587,   596,   605,   614,
     616,   625,   634,   636,   642,   644,   651,   658,   666,   671,
     673,   680,   688,   689,   691,   698,   707,   708,   709,   717,
     725,   734,   743,   753,   761,   762,   764,   774
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "PASSIGN", "MASSIGN", "INC", "DEC", "EQ",
  "NEQ", "LEQ", "GEQ", "ID", "CHARCONST", "NUMCONST", "STRINGCONST", "IF",
  "ELSE", "WHILE", "FOREACH", "IN", "STATIC", "INT", "BOOL", "CHAR",
  "VOID", "TRUE", "FALSE", "RETURN", "BREAK", "','", "';'", "':'", "'{'",
  "'('", "'['", "'}'", "')'", "']'", "AND", "OR", "NOT", "'<'", "'='",
  "'>'", "'*'", "'%'", "'/'", "'-'", "'+'", "$accept", "program",
  "declaration_list", "declaration", "var_declaration",
  "scoped_var_declaration", "var_decl_list", "var_decl_initialize",
  "type_specifier", "fun_declaration", "params", "param_list",
  "param_id_list", "param_id", "statement", "ifmatched", "ifunmatched",
  "expression_stmt", "compound_stmt", "local_declarations",
  "statement_list", "expression", "simple_expression", "and_expression",
  "unary_rel_expression", "rel_expression", "sum_expression", "term",
  "mulop", "unary_expression", "unaryop", "factor", "mutable", "immutable",
  "call", "args", "arg_list", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,    44,
      59,    58,   123,    40,    91,   125,    41,    93,   284,   285,
     286,    60,    61,    62,    42,    37,    47,    45,    43
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    49,    50,    51,    51,    52,    52,    53,    54,    54,
      55,    55,    56,    56,    56,    56,    57,    57,    57,    57,
      58,    58,    59,    59,    60,    60,    61,    61,    62,    62,
      63,    63,    64,    64,    64,    64,    65,    65,    65,    65,
      66,    66,    66,    66,    66,    66,    67,    68,    68,    69,
      69,    70,    70,    70,    70,    70,    70,    71,    71,    72,
      72,    73,    73,    74,    74,    74,    74,    74,    74,    74,
      75,    75,    75,    76,    76,    77,    77,    77,    78,    78,
      79,    79,    80,    80,    81,    81,    82,    82,    82,    82,
      82,    82,    82,    83,    84,    84,    85,    85
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     3,     4,     3,
       3,     1,     1,     4,     3,     6,     1,     1,     1,     1,
       6,     5,     1,     0,     4,     2,     3,     1,     1,     3,
       1,     1,     7,     5,     7,     1,     7,     5,     5,     7,
       1,     2,     3,     2,     2,     1,     4,     2,     0,     2,
       0,     3,     3,     3,     2,     2,     1,     3,     1,     3,
       1,     2,     1,     3,     3,     3,     3,     3,     3,     1,
       3,     3,     1,     3,     1,     1,     1,     1,     2,     1,
       1,     1,     1,     1,     1,     4,     3,     1,     1,     1,
       1,     1,     1,     4,     1,     0,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,    16,    17,    18,    19,     0,     2,     4,     5,
       0,     6,    23,     1,     3,    12,     0,    11,     0,     0,
      22,     0,    23,     0,     0,     7,    28,    25,    27,     0,
       0,    84,    89,    88,    90,    91,    92,     0,     0,    81,
      80,    14,    58,    60,    62,    69,    72,    74,     0,    79,
      83,    82,    87,     0,     0,    12,    10,     0,     0,     0,
       0,     0,     0,     0,    45,    48,    21,    30,    31,    35,
      40,     0,    56,    83,     0,    95,     0,     0,    61,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    75,
      77,    76,     0,    78,     0,    13,    29,    26,     0,     0,
       0,    41,     0,    43,    50,    44,     0,     0,    54,    55,
       0,    24,    97,     0,    94,     0,    86,    57,    59,    67,
      68,    65,    66,    63,    64,    71,    70,    73,    20,     0,
       0,     0,    84,     0,    42,     0,    47,     0,     0,    52,
      53,    51,    93,     0,    85,    15,     0,     0,     0,     0,
       0,    46,    49,    96,    37,    30,    33,    38,     0,     0,
       9,     0,     0,     8,    32,    36,    34,    39
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     6,     7,     8,     9,   136,    16,    17,    10,    11,
      19,    20,    27,    28,    66,    67,    68,    69,    70,   104,
     138,    71,    72,    42,    43,    44,    45,    46,    92,    47,
      48,    49,    50,    51,    52,   113,   114
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -128
static const yytype_int16 yypact[] =
{
       7,   -26,  -128,  -128,  -128,  -128,    10,     7,  -128,  -128,
       1,  -128,    51,  -128,  -128,    54,    29,  -128,    21,    18,
      20,   206,    51,    63,    73,  -128,    30,    79,  -128,   160,
      51,     3,  -128,  -128,  -128,  -128,  -128,   206,   206,  -128,
    -128,    74,    85,  -128,  -128,    14,    -2,  -128,    78,  -128,
    -128,  -128,  -128,    80,    93,   -25,  -128,    94,    21,    95,
     106,   109,   169,   113,  -128,  -128,  -128,  -128,  -128,  -128,
    -128,   114,    74,    11,    21,   206,   206,   110,  -128,   206,
     206,    78,    78,    78,    78,    78,    78,    78,    78,  -128,
    -128,  -128,    78,  -128,   160,   116,  -128,  -128,   206,   206,
     134,  -128,   122,  -128,    46,  -128,   206,   206,  -128,  -128,
     206,    79,  -128,   118,   128,   124,  -128,    85,  -128,    53,
      53,    53,    53,    53,    53,    -2,    -2,  -128,  -128,   206,
      24,    66,   125,   141,  -128,    51,  -128,    73,   123,  -128,
    -128,  -128,  -128,   206,  -128,    74,   160,   160,   206,    73,
      77,  -128,  -128,  -128,  -128,   146,  -128,  -128,    76,    91,
    -128,   160,   160,  -128,  -128,  -128,  -128,  -128
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -128,  -128,  -128,   157,  -128,  -128,  -110,   142,   -11,  -128,
     143,  -128,   102,   111,   -90,  -121,  -127,  -128,  -128,  -128,
    -128,   -24,   -19,    89,   -35,  -128,    13,    39,  -128,   -43,
    -128,  -128,   -29,  -128,  -128,  -128,  -128
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      73,    18,    41,    78,   128,    93,    21,    12,    73,    23,
      13,    18,    15,    77,   106,   107,   108,   109,     1,    74,
     157,    81,    82,    83,    84,   155,   156,   150,     2,     3,
       4,     5,    26,    73,   165,   167,    75,    76,   102,   159,
     164,   166,    89,    90,    91,   118,    73,    73,   152,   127,
      30,   112,   115,   110,    29,    85,   154,    86,    24,    25,
     146,    87,    88,    79,    57,    73,   135,     2,     3,     4,
       5,   133,     2,     3,     4,     5,    54,    73,    73,   130,
     131,    73,   139,   140,    55,    21,   141,    22,    23,    31,
      32,    33,    34,   137,   119,   120,   121,   122,   123,   124,
      87,    88,   147,    35,    36,    79,    24,   160,    58,    73,
     145,    37,   162,    79,    73,    79,    94,    73,    73,   153,
      24,   163,    39,    80,   149,    40,   125,   126,    98,   158,
      95,    96,    73,    73,    31,    32,    33,    34,    59,    99,
      60,    61,   100,   103,   105,   132,   116,   129,    35,    36,
      62,    63,   134,    64,   142,    65,    37,   143,   151,    76,
     148,   144,   161,    38,    14,    53,    56,    39,   117,    97,
      40,    31,    32,    33,    34,    59,   111,    60,    61,     0,
      31,    32,    33,    34,     0,    35,    36,    62,    63,     0,
      64,     0,    65,    37,    35,    36,     0,     0,     0,   101,
      38,     0,    37,     0,    39,     0,     0,    40,     0,    38,
       0,     0,     0,    39,     0,     0,    40,    31,    32,    33,
      34,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,    35,    36,     0,     0,     0,     0,     0,     0,    37,
       0,     0,     0,     0,     0,     0,    38,     0,     0,     0,
      39,     0,     0,    40
};

#define yypact_value_is_default(yystate) \
  ((yystate) == (-128))

#define yytable_value_is_error(yytable_value) \
  YYID (0)

static const yytype_int16 yycheck[] =
{
      29,    12,    21,    38,    94,    48,    31,    33,    37,    34,
       0,    22,    11,    37,     3,     4,     5,     6,    11,    30,
     147,     7,     8,     9,    10,   146,   147,   137,    21,    22,
      23,    24,    11,    62,   161,   162,    33,    34,    62,   149,
     161,   162,    44,    45,    46,    80,    75,    76,   138,    92,
      30,    75,    76,    42,    36,    41,   146,    43,    29,    30,
      36,    47,    48,    39,    34,    94,    20,    21,    22,    23,
      24,   100,    21,    22,    23,    24,    13,   106,   107,    98,
      99,   110,   106,   107,    11,    31,   110,    33,    34,    11,
      12,    13,    14,   104,    81,    82,    83,    84,    85,    86,
      47,    48,    36,    25,    26,    39,    29,    30,    29,   138,
     129,    33,    36,    39,   143,    39,    36,   146,   147,   143,
      29,    30,    44,    38,   135,    47,    87,    88,    33,   148,
      37,    37,   161,   162,    11,    12,    13,    14,    15,    33,
      17,    18,    33,    30,    30,    11,    36,    31,    25,    26,
      27,    28,    30,    30,    36,    32,    33,    29,    35,    34,
      19,    37,    16,    40,     7,    22,    24,    44,    79,    58,
      47,    11,    12,    13,    14,    15,    74,    17,    18,    -1,
      11,    12,    13,    14,    -1,    25,    26,    27,    28,    -1,
      30,    -1,    32,    33,    25,    26,    -1,    -1,    -1,    30,
      40,    -1,    33,    -1,    44,    -1,    -1,    47,    -1,    40,
      -1,    -1,    -1,    44,    -1,    -1,    47,    11,    12,    13,
      14,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    25,    26,    -1,    -1,    -1,    -1,    -1,    -1,    33,
      -1,    -1,    -1,    -1,    -1,    -1,    40,    -1,    -1,    -1,
      44,    -1,    -1,    47
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    11,    21,    22,    23,    24,    50,    51,    52,    53,
      57,    58,    33,     0,    52,    11,    55,    56,    57,    59,
      60,    31,    33,    34,    29,    30,    11,    61,    62,    36,
      30,    11,    12,    13,    14,    25,    26,    33,    40,    44,
      47,    71,    72,    73,    74,    75,    76,    78,    79,    80,
      81,    82,    83,    59,    13,    11,    56,    34,    29,    15,
      17,    18,    27,    28,    30,    32,    63,    64,    65,    66,
      67,    70,    71,    81,    57,    33,    34,    70,    73,    39,
      38,     7,     8,     9,    10,    41,    43,    47,    48,    44,
      45,    46,    77,    78,    36,    37,    37,    62,    33,    33,
      33,    30,    70,    30,    68,    30,     3,     4,     5,     6,
      42,    61,    70,    84,    85,    70,    36,    72,    73,    75,
      75,    75,    75,    75,    75,    76,    76,    78,    63,    31,
      71,    71,    11,    81,    30,    20,    54,    57,    69,    70,
      70,    70,    36,    29,    37,    71,    36,    36,    19,    57,
      55,    35,    63,    70,    63,    64,    64,    65,    71,    55,
      30,    16,    36,    30,    64,    65,    64,    65
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* This macro is provided for backward compatibility. */

#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (0, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  YYSIZE_T yysize1;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = 0;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - Assume YYFAIL is not used.  It's too flawed to consider.  See
       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
       for details.  YYERROR is fine as it does not invoke this
       function.
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                yysize1 = yysize + yytnamerr (0, yytname[yyx]);
                if (! (yysize <= yysize1
                       && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                  return 2;
                yysize = yysize1;
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  yysize1 = yysize + yystrlen (yyformat);
  if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
    return 2;
  yysize = yysize1;

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1806 of yacc.c  */
#line 156 "c-.y"
    { savedTree = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 3:

/* Line 1806 of yacc.c  */
#line 159 "c-.y"
    {
		   TreeNode* t = (yyvsp[(1) - (2)].nodeptr);
		   if (t != NULL){
		     while (t->sibling != NULL) t = t->sibling;
		     t->sibling = (yyvsp[(2) - (2)].nodeptr);
		     (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr);
		   } else
		     (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr);
		 }
    break;

  case 4:

/* Line 1806 of yacc.c  */
#line 168 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 5:

/* Line 1806 of yacc.c  */
#line 170 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr);}
    break;

  case 6:

/* Line 1806 of yacc.c  */
#line 171 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr);}
    break;

  case 7:

/* Line 1806 of yacc.c  */
#line 175 "c-.y"
    {
		  TreeNode* t = (yyvsp[(2) - (3)].nodeptr);
		  if (t != NULL){
		    t->expType = (yyvsp[(1) - (3)].type);
		    while (t->sibling != NULL) {
		      t = t->sibling;
		      t->expType = (yyvsp[(1) - (3)].type);
		    }
		    (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
		  }
		}
    break;

  case 8:

/* Line 1806 of yacc.c  */
#line 188 "c-.y"
    { 
			 TreeNode* t = (yyvsp[(3) - (4)].nodeptr);
			 if (t != NULL){
			   t->expType = (yyvsp[(2) - (4)].type);
			   t->isStatic = true;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = (yyvsp[(2) - (4)].type);
			     t->isStatic = true;
			   }
			 }
			 (yyval.nodeptr) = (yyvsp[(3) - (4)].nodeptr);
		       }
    break;

  case 9:

/* Line 1806 of yacc.c  */
#line 202 "c-.y"
    { 
			 TreeNode* t = (yyvsp[(2) - (3)].nodeptr);
			 if (t != NULL){
			   t->expType = (yyvsp[(1) - (3)].type);
			   t->isStatic = false;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = (yyvsp[(1) - (3)].type);
			     t->isStatic = false;
			   }
			 }
			 (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
		       }
    break;

  case 10:

/* Line 1806 of yacc.c  */
#line 218 "c-.y"
    {
		TreeNode* t = (yyvsp[(1) - (3)].nodeptr);
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = (yyvsp[(3) - (3)].nodeptr);
		  (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
		} else
		  (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
	      }
    break;

  case 11:

/* Line 1806 of yacc.c  */
#line 227 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 12:

/* Line 1806 of yacc.c  */
#line 230 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
		    }
    break;

  case 13:

/* Line 1806 of yacc.c  */
#line 236 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
		      //$$->child[0] = $3;
		      (yyval.nodeptr)->isArray = true;
		      (yyval.nodeptr)->size = (yyvsp[(3) - (4)].tokenData)->iValue; 
		    }
    break;

  case 14:

/* Line 1806 of yacc.c  */
#line 245 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (3)].tokenData)->tokenstr;
		      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (3)].nodeptr);
		    }
    break;

  case 15:

/* Line 1806 of yacc.c  */
#line 252 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (6)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (6)].tokenData)->tokenstr;
		      (yyval.nodeptr)->size = (yyvsp[(3) - (6)].tokenData)->iValue; 
		      (yyval.nodeptr)->child[0] = (yyvsp[(6) - (6)].nodeptr);
		      (yyval.nodeptr)->isArray = true;
		    }
    break;

  case 16:

/* Line 1806 of yacc.c  */
#line 261 "c-.y"
    { (yyval.type) = Integer; }
    break;

  case 17:

/* Line 1806 of yacc.c  */
#line 262 "c-.y"
    { (yyval.type) = Boolean; }
    break;

  case 18:

/* Line 1806 of yacc.c  */
#line 263 "c-.y"
    { (yyval.type) = Character; }
    break;

  case 19:

/* Line 1806 of yacc.c  */
#line 264 "c-.y"
    { (yyval.type) = Void; }
    break;

  case 20:

/* Line 1806 of yacc.c  */
#line 268 "c-.y"
    {
		  TreeNode* t = newDeclNode(FuncK); 
		  t->string = (yyvsp[(2) - (6)].tokenData)->tokenstr;
		  t->linnum = (yyvsp[(2) - (6)].tokenData)->linnum;
		  t->expType = (yyvsp[(1) - (6)].type);
		  (yyval.nodeptr) = t;
		  (yyval.nodeptr)->child[0] = (yyvsp[(4) - (6)].nodeptr);
		  (yyval.nodeptr)->child[1] = (yyvsp[(6) - (6)].nodeptr);
		  //$$->child[1]->string = $2->tokenstr;
		}
    break;

  case 21:

/* Line 1806 of yacc.c  */
#line 279 "c-.y"
    {
		  TreeNode* t = newDeclNode(FuncK);
		  t->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
		  t->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
		  t->expType = Void;  // 0
		  (yyval.nodeptr) = t;
		  (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
		  (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
		  //$$->child[1]->string = $2->tokenstr;
		}
    break;

  case 22:

/* Line 1806 of yacc.c  */
#line 290 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 23:

/* Line 1806 of yacc.c  */
#line 291 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 24:

/* Line 1806 of yacc.c  */
#line 295 "c-.y"
    {
	     TreeNode* t = (yyvsp[(1) - (4)].nodeptr);
	     TreeNode* v = (yyvsp[(4) - (4)].nodeptr);
	     if (v != NULL){
	       v->expType = (yyvsp[(3) - (4)].type);
	       while (v->sibling != NULL) {
		 v = v->sibling;
		 v->expType = (yyvsp[(3) - (4)].type);
	       }
	     }
	     if (t != NULL){
	       while (t->sibling != NULL) t = t->sibling;
	       t->sibling = (yyvsp[(4) - (4)].nodeptr);
	       (yyval.nodeptr) = (yyvsp[(1) - (4)].nodeptr);
	     } else
	       (yyval.nodeptr) = (yyvsp[(4) - (4)].nodeptr);
	   }
    break;

  case 25:

/* Line 1806 of yacc.c  */
#line 313 "c-.y"
    {
	     TreeNode* v = (yyvsp[(2) - (2)].nodeptr);
	     if (v != NULL){
	       v->expType = (yyvsp[(1) - (2)].type);
	       while (v->sibling != NULL) {
		 v = v->sibling;
		 v->expType = (yyvsp[(1) - (2)].type);
	       }
	     } 
	     (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr);
	   }
    break;

  case 26:

/* Line 1806 of yacc.c  */
#line 326 "c-.y"
    {
		TreeNode* t = (yyvsp[(1) - (3)].nodeptr);
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = (yyvsp[(3) - (3)].nodeptr);
		  (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
		} else
		  (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
	      }
    break;

  case 27:

/* Line 1806 of yacc.c  */
#line 335 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 28:

/* Line 1806 of yacc.c  */
#line 338 "c-.y"
    {
	   (yyval.nodeptr) = newDeclNode(ParamK);
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	 }
    break;

  case 29:

/* Line 1806 of yacc.c  */
#line 344 "c-.y"
    {
	   (yyval.nodeptr) = newDeclNode(ParamK);
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (3)].tokenData)->tokenstr;
	   (yyval.nodeptr)->isArray = true;
	 }
    break;

  case 30:

/* Line 1806 of yacc.c  */
#line 352 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 31:

/* Line 1806 of yacc.c  */
#line 353 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 32:

/* Line 1806 of yacc.c  */
#line 356 "c-.y"
    { 
	    (yyval.nodeptr) = newStmtNode(IfK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	    (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	    (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	    (yyval.nodeptr)->child[1]->expType = Boolean;
	    (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	  }
    break;

  case 33:

/* Line 1806 of yacc.c  */
#line 366 "c-.y"
    { 
	    (yyval.nodeptr) = newStmtNode(WhileK);
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	    (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	    (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	    (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	    //$$->child[1]->expType = Boolean;
	  }
    break;

  case 34:

/* Line 1806 of yacc.c  */
#line 375 "c-.y"
    { 
	    (yyval.nodeptr) = newStmtNode(ForEachK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	    (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	    (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	    (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	  }
    break;

  case 35:

/* Line 1806 of yacc.c  */
#line 383 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 36:

/* Line 1806 of yacc.c  */
#line 386 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(IfK);
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	      (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	      (yyval.nodeptr)->child[1]->expType = Boolean;
	      (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	    }
    break;

  case 37:

/* Line 1806 of yacc.c  */
#line 396 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(IfK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	      //$$->child[1]->expType = Boolean;
	    }
    break;

  case 38:

/* Line 1806 of yacc.c  */
#line 405 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(WhileK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	      //$$->child[1]->expType = Boolean;
	    }
    break;

  case 39:

/* Line 1806 of yacc.c  */
#line 414 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(ForEachK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	      (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	    }
    break;

  case 40:

/* Line 1806 of yacc.c  */
#line 423 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 41:

/* Line 1806 of yacc.c  */
#line 425 "c-.y"
    {
		 (yyval.nodeptr) = newStmtNode(ReturnK);
		 (yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum;
		 (yyval.nodeptr)->expType = Void;
	       }
    break;

  case 42:

/* Line 1806 of yacc.c  */
#line 431 "c-.y"
    {
		 (yyval.nodeptr) = newStmtNode(ReturnK);
		 (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
		 (yyval.nodeptr)->child[0] = (yyvsp[(2) - (3)].nodeptr);
		 (yyval.nodeptr)->expType = (yyvsp[(2) - (3)].nodeptr)->expType; 
	       }
    break;

  case 43:

/* Line 1806 of yacc.c  */
#line 438 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(BreakK);
		(yyval.nodeptr)->string = (yyvsp[(1) - (2)].tokenData)->tokenstr;
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum;
	      }
    break;

  case 44:

/* Line 1806 of yacc.c  */
#line 443 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); }
    break;

  case 45:

/* Line 1806 of yacc.c  */
#line 444 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 46:

/* Line 1806 of yacc.c  */
#line 451 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(CompoundK);
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
		(yyval.nodeptr)->child[0] = (yyvsp[(2) - (4)].nodeptr);
		(yyval.nodeptr)->child[1] = (yyvsp[(3) - (4)].nodeptr);
	      }
    break;

  case 47:

/* Line 1806 of yacc.c  */
#line 459 "c-.y"
    {
		     TreeNode* t = (yyvsp[(1) - (2)].nodeptr);
		     if (t != NULL){
		       while (t->sibling != NULL) t = t->sibling;
		       t->sibling = (yyvsp[(2) - (2)].nodeptr);
		       (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr);
		     } else
		       (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr);
		   }
    break;

  case 48:

/* Line 1806 of yacc.c  */
#line 468 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 49:

/* Line 1806 of yacc.c  */
#line 471 "c-.y"
    {
		 TreeNode* t = (yyvsp[(1) - (2)].nodeptr);
		 if (t != NULL){
		   while (t->sibling != NULL) t = t->sibling;
		   t->sibling = (yyvsp[(2) - (2)].nodeptr);
		   (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr);
		 } else
		   (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr);
	       }
    break;

  case 50:

/* Line 1806 of yacc.c  */
#line 480 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 51:

/* Line 1806 of yacc.c  */
#line 483 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK); 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
	     (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
	     (yyval.nodeptr)->expType = (yyvsp[(1) - (3)].nodeptr)->expType;  // modified here
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
	     (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	   }
    break;

  case 52:

/* Line 1806 of yacc.c  */
#line 493 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK);
	     (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
	     (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	   }
    break;

  case 53:

/* Line 1806 of yacc.c  */
#line 502 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK);
	     (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
	     (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	   }
    break;

  case 54:

/* Line 1806 of yacc.c  */
#line 511 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK);
	     (yyval.nodeptr)->string = (yyvsp[(2) - (2)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (2)].tokenData)->linnum; 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (2)].tokenData)->tokenClass;
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (2)].nodeptr);
	   }
    break;

  case 55:

/* Line 1806 of yacc.c  */
#line 519 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK);
	     (yyval.nodeptr)->string = (yyvsp[(2) - (2)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (2)].tokenData)->linnum; 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (2)].tokenData)->tokenClass;
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (2)].nodeptr);
	   }
    break;

  case 56:

/* Line 1806 of yacc.c  */
#line 526 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 57:

/* Line 1806 of yacc.c  */
#line 529 "c-.y"
    {
		    (yyval.nodeptr) = newExpNode(OpK); 
		    (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		    (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		    (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		    (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		    (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
		  }
    break;

  case 58:

/* Line 1806 of yacc.c  */
#line 537 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 59:

/* Line 1806 of yacc.c  */
#line 540 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK); 
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 60:

/* Line 1806 of yacc.c  */
#line 548 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 61:

/* Line 1806 of yacc.c  */
#line 551 "c-.y"
    { 
		       (yyval.nodeptr) = newExpNode(OpK);
		       (yyval.nodeptr)->attr.op = (yyvsp[(1) - (2)].tokenData)->tokenClass;
		       (yyval.nodeptr)->string = (yyvsp[(1) - (2)].tokenData)->tokenstr;
		       (yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum; 
		       (yyval.nodeptr)->child[0] = (yyvsp[(2) - (2)].nodeptr);
		     }
    break;

  case 62:

/* Line 1806 of yacc.c  */
#line 558 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 63:

/* Line 1806 of yacc.c  */
#line 561 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 64:

/* Line 1806 of yacc.c  */
#line 570 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 65:

/* Line 1806 of yacc.c  */
#line 579 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 66:

/* Line 1806 of yacc.c  */
#line 588 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 67:

/* Line 1806 of yacc.c  */
#line 597 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK); // '=='
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 68:

/* Line 1806 of yacc.c  */
#line 606 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 69:

/* Line 1806 of yacc.c  */
#line 614 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 70:

/* Line 1806 of yacc.c  */
#line 617 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum;
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 71:

/* Line 1806 of yacc.c  */
#line 626 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK);
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum;
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 72:

/* Line 1806 of yacc.c  */
#line 634 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 73:

/* Line 1806 of yacc.c  */
#line 637 "c-.y"
    {
       (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
       (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
       (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
     }
    break;

  case 74:

/* Line 1806 of yacc.c  */
#line 642 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 75:

/* Line 1806 of yacc.c  */
#line 645 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 76:

/* Line 1806 of yacc.c  */
#line 652 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 77:

/* Line 1806 of yacc.c  */
#line 659 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 78:

/* Line 1806 of yacc.c  */
#line 667 "c-.y"
    {
		   (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); 
		   (yyval.nodeptr)->child[0] = (yyvsp[(2) - (2)].nodeptr);
		 }
    break;

  case 79:

/* Line 1806 of yacc.c  */
#line 671 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 80:

/* Line 1806 of yacc.c  */
#line 674 "c-.y"
    { 
	  (yyval.nodeptr) = newExpNode(OpK); 
	  (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	}
    break;

  case 81:

/* Line 1806 of yacc.c  */
#line 681 "c-.y"
    { 
	  (yyval.nodeptr) = newExpNode(OpK); 
	  (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	}
    break;

  case 82:

/* Line 1806 of yacc.c  */
#line 688 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 83:

/* Line 1806 of yacc.c  */
#line 689 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 84:

/* Line 1806 of yacc.c  */
#line 692 "c-.y"
    {
	  (yyval.nodeptr) = newExpNode(IdK);
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	  (yyval.nodeptr)->isArray = false; 
	}
    break;

  case 85:

/* Line 1806 of yacc.c  */
#line 699 "c-.y"
    {
	  (yyval.nodeptr) = newExpNode(IdK);
	  (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
	  (yyval.nodeptr)->isArray = true; 
	  (yyval.nodeptr)->child[0] = (yyvsp[(3) - (4)].nodeptr);
	}
    break;

  case 86:

/* Line 1806 of yacc.c  */
#line 707 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr); }
    break;

  case 87:

/* Line 1806 of yacc.c  */
#line 708 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 88:

/* Line 1806 of yacc.c  */
#line 710 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->attr.val = (yyvsp[(1) - (1)].tokenData)->iValue;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Integer;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 89:

/* Line 1806 of yacc.c  */
#line 718 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->expType = Character;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 90:

/* Line 1806 of yacc.c  */
#line 726 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Character;
	    (yyval.nodeptr)->isArray = true;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 91:

/* Line 1806 of yacc.c  */
#line 735 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Boolean;
	    (yyval.nodeptr)->isConstant = true;
	    (yyval.nodeptr)->attr.val = 1;
	  }
    break;

  case 92:

/* Line 1806 of yacc.c  */
#line 744 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	    (yyval.nodeptr)->expType = Boolean;
	    (yyval.nodeptr)->isConstant = true;
	    (yyval.nodeptr)->attr.val = 0;
	  }
    break;

  case 93:

/* Line 1806 of yacc.c  */
#line 754 "c-.y"
    {
       (yyval.nodeptr) = newExpNode(CallK);
       (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
       (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
       (yyval.nodeptr)->child[0] = (yyvsp[(3) - (4)].nodeptr);
     }
    break;

  case 94:

/* Line 1806 of yacc.c  */
#line 761 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 95:

/* Line 1806 of yacc.c  */
#line 762 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 96:

/* Line 1806 of yacc.c  */
#line 765 "c-.y"
    {
	   TreeNode * t = (yyvsp[(1) - (3)].nodeptr);
	   if (t != NULL){
	     while  (t->sibling != NULL) t = t->sibling;
	     t->sibling = (yyvsp[(3) - (3)].nodeptr);
	     (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
	   } else
	     (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
	 }
    break;

  case 97:

/* Line 1806 of yacc.c  */
#line 774 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;



/* Line 1806 of yacc.c  */
#line 2779 "c-.tab.c"
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 2067 of yacc.c  */
#line 777 "c-.y"


void nodePrint(void * p){
    TreeNode * t = (TreeNode*)p;
    //printTree(t, 0, 0);
    printNode(t);
}
SymTab * st = new SymTab(nodePrint);

int numError = 0; 
int numWarnings = 0;
char nameCompoundStat[64];
char nameParam[32];
int depth = 1;
int depcp = 0;

main(int argc, char* argv[]){
  int d_flag = 0;
  int s_flag = 0;
  char *d_value = NULL;
  char *s_value = NULL;
  int c;
  /*
    if (argc == 1) 
    yyin = stdin;
    else if (argc == 2) {
    yyin = fopen(argv[1], "r");
    } else if (argc > 2) {     */

  while ((c = getopt (argc, argv, "o:p")) != -1) {
    switch (c) {      
    case 'p':   // printTree
      d_flag = 1;
      break;
    case 'o':  // output file
      s_flag = 1;
      s_value = optarg;
      //printf("filename: %s\n", s_value);

      //code = fopen(optarg, "w");
      break;
    default:
      abort ();
      break;
    }
  }
      /*
      yyin = fopen(argv[2], "r");
    } else {
      printf("Usage:./c- TestFileName\nUsage:./c- < TestFileName\nUsage: cat TestFileName | ./c-\n");
        exit(-1);
    }
    if (yyin == NULL){
        printf("Can't open/read '%s'\n", argv[2]);
        exit(-1);
    }
    yyfilename = argv[1];  */

  yyin = fopen(argv[optind], "r");
  linnum = 1;

  yyparse();
  savedTree = siblingNode(savedTree, Integer, (char*)("input"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Void, (char*)("output"), Integer, (char*)("xyz"));
  savedTree = siblingNode(savedTree, Boolean, (char*)("inputb"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Void, (char*)("outputb"), Boolean, (char*)("xyz"));
  savedTree = siblingNode(savedTree, Void, (char*)("outnl"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Character, (char*)("inputc"), Void, (char*)(" "));
  savedTree = siblingNode(savedTree, Void, (char*)("outputc"), Character, (char*)("xyz"));
  insertCheckNode(savedTree);  
 
  if (!st->lookup("main")) {
    printf("ERROR(LINKER): Procedure main is not defined.\n");
    ++numError;
    printf("Number of warnings: %d\n", numWarnings);
    printf("Number of errors: %d\n", numError);
  }

  if (s_flag == 1) {
    //printf("s_value: %s\n", s_value);
    code = fopen(s_value, "w");
  } else {   
    //if (s_flag != 1) {
    char* filename = argv[optind];
    int length = strlen(filename);
    filename[length-1] = 'm';
    filename[length-2] = 't';
    s_value = filename;
    code = fopen(filename, "w");
  }
  //st->print();

  emitComment("C- compiler version C-F07");
  emitComment("Author: Heyan Huang");
  emitComment("Backend adapted from work by Jorge Williams (2001)");
  emitComment2("File compiled: ", s_value);
  emitComment("Nov 29, 2007");
  emitSkip(1);  // for initial later on

  emitIO("input");
  emitIO("output");
  emitIO("inputb");
  emitIO("outputb");
  emitIO("outnl");
  //emitIO("inputc");
  emitIO("outputc");

  cgen(savedTree);

  backPatchJumpToHere(0, "Jump to init");
  emitComment("BEGIN Init");
  emitRM("LD", gp, 0, gp, "Set the global pointer");
  goffset = 0;
  genGlobal();

  emitRM("LDA", fp, goffset, gp, "set first frame at end of globals");
  emitRM("ST", fp, 0, fp, "store old fp (point to self)");
  emitRM("LDA", ac, 1, pc, "Return address in ac");
  emitRMAbs("LDA", pc, ((TreeNode*)(st->lookup("main")))->loc, "Jump to main");
  emitRO("HALT", gp, 0, gp, "DONE!");
  emitComment("END Init");

  if (d_flag == 1) {
    printTree(savedTree, 0, 0);
  }

  printf("Number of warnings: %d\n", numWarnings);
  printf("Number of errors: %d\n", numError);

  if (argc != 1)
    fclose(yyin);
  fclose (code);
}

static void cgen(TreeNode* t) {
  if (t) {
  switch (t->nodekind) {
  case DeclK:
    TreeNode *r, *s, *u;
    int savedLoc1, sadLoc2, currloc;
    int loc;

    switch(t->kind.decl) {    
    case VarK:
      if (t->isArray) {
	emitRM2("LDC", ac, t->size, ac3, "load size of array", t->string);
	emitRM2("ST", ac, t->loc+1, fp, "save size of array", t->string);
      } else {
	if (t->child[0]) {
	  TreeNode* f = t->child[0];
	  cgen(f);
	  if ( (t->TypeAllocation == Global) ||  (t->TypeAllocation == LocalStatic) )
	    emitRM2("ST", ac, t->loc, gp, "Store variable", t->string);
	  if (t->TypeAllocation == Local)
	    emitRM2("ST", ac, t->loc, fp, "Store variable", t->string);
	}
      }
      if (t->sibling)
	cgen(t->sibling);
      break;

    case FuncK:
      if (isIO(t)) {
	if (t->string == "input") {
	  t->loc = 1;
	  t->size = -1;
	  t->TypeAllocation = Global;
	} else if (t->string == "output") {
	  t->loc = 6;
	  t->size = -2;
	  t->TypeAllocation = Global;
	} else if (t->string == "inputb") {
	  t->loc = 13;
	  t->size = -1;
	  t->TypeAllocation = Global;
	} else if (t->string == "outputb") {
	  t->loc = 18;
	  t->size = -2;
	  t->TypeAllocation = Global;
	} else if (t->string == "outnl") {
	  t->loc = 25;
	  t->size = -1;
	  t->TypeAllocation = Global;
	} else if (t->string == "outputc") {
	  t->loc = 30;
	  t->size = -2;
	  t->TypeAllocation = Global;
	}
      } else {
	emitComment2((char*)("BEGIN function"), t->string);
	t->loc = emitSkip(0);
	TreeNode* p = (TreeNode*)(st->lookup(t->string));
	toff = p->size; 
	//printf("FuncK->size: %d\n", toff);

	emitRM("ST", ac, -1, fp, "Store return address");
	r=t->child[0];
	s=t->child[1];
	cgen(r);
	cgen(s);

	emitComment("Add standard closing in case there is no return statement");
	emitRM("LDC", rt, 0, ac3, "Set return value to 0");
	emitRM("LD", ac, -1, fp, "Load return address");
	emitRM("LD", FP, 0, FP, "Adjust fp");
	emitRM("LDA", PC, 0, AC, "Return");

	emitComment2((char*)("END function"), t->string);
      }
      if ( (t->sibling) && (((TreeNode*)(st->lookup(t->sibling->string)))->kind.decl == VarK) ) {
	t = t->sibling;
	cgen(t->sibling);
      }
      if ( (t->sibling) && (((TreeNode*)(st->lookup(t->sibling->string)))->kind.decl == FuncK) )
	cgen(t->sibling);
      break;

    case ParamK:
      /*      if (t->sibling) 
	      cgen(t->sibling); */
      break; 
    }  
    break;

  case StmtK:
    switch(t->kind.stmt) {   
 
    case IfK:
      emitComment("IfK:");
      r=t->child[0];
      s=t->child[1];
      u=t->child[2];

      //逻辑表达式的代码
      emitComment("IfK: t->child[0] condition");
      cgen(r);
      savedLoc1=emitSkip(1); //回填位置1

      //then部分代码
      emitComment("IfK: t->child[1] then part");
      cgen(s);
      sadLoc2=emitSkip(1);//回填位置2
      currloc=emitSkip(0);
      emitBackup(savedLoc1);
      emitRMAbs("JEQ", ac, currloc, "if: jmp to else"); //回填位置1的代码
      emitRestore();

      //else部分代码
      emitComment("IfK: t->child[2] else part");
      cgen(u);
      currloc=emitSkip(0);
      emitBackup(sadLoc2);

      emitRMAbs("LDA", pc, currloc, "jmp to end"); //回填位置2的代码
      emitRestore();
      emitComment("ENDIF");

      if (t->sibling)
	cgen(t->sibling);
      break;

    case WhileK:
      {
	emitComment("WHILE");
	currloc = emitSkip(0);             // return to here to do the test
	cgen(t->child[0]);
	emitRM("JGT", AC, 1, PC, "Jump to while part"); // JEQ
	emitComment("DO");

	int skiploc = breakloc;              // save the old break statement return point

	breakloc = emitSkip(1);            // addr of instr that jumps to end of loop
	skiploc = breakloc;            // addr of instr that jumps to end of loop

	cgen(t->child[1]);

	emitRMAbs("LDA", PC, currloc, "go to beginning of loop");
	backPatchJumpToHere(breakloc, "No more loop");   // backpatch jump to end of loop
	breakloc = skiploc;              // restore for break statement

	emitComment("ENDWHILE");

	if (t->sibling)
	  cgen(t->sibling);
	break;
      }

    case ForEachK:
	if (t->sibling)
	  cgen(t->sibling);
      break;

    case CompoundK:
      emitComment("BEGIN compound statement");
      cgen(t->child[0]);
      //emitComment("EXPRESSION STMT");
      cgen(t->child[1]);
      emitComment("END compound statement");
      if (t->sibling)
	cgen(t->sibling);
      break;

    case ReturnK:
      emitComment("RETURN");
      if (t->child[0]) {
	cgen(t->child[0]);
      }
      emitRM("LDA", RT, 0, AC, "Copy result to rt register");
      //emitRM("LD", AC, RETURN_OFFSET, FP, "Load return address");
      emitRM("LD", AC, -1, FP, "Load return address");
      //emitRM("LD", FP, OFPOFF, FP, "Adjust fp");
      emitRM("LD", FP, 0, FP, "Adjust fp");
      emitRM("LDA", PC, 0, AC, "Return");
      if (t->sibling)
	cgen(t->sibling);
      break;

    case BreakK:
      if (t->sibling)
	cgen(t->sibling);
      break;
    }
    break;

  case ExpK:
    //TreeNode* f;
    //TreeNode* j;
    switch(t->kind.exp) {    

    case ConstantK:
      if ( (t->expType == Integer) || (t->expType == Boolean) )
	emitRM("LDC", ac, t->attr.val, ac3, "Load constant"); 
      //if (t->expType == Character) 
      //emitRM("LD", ac, t->loc, fp, "Load character value"); 
      break;

    case IdK:
      {
	if (!t->child[0]) {
	  if (t->isArray) {
	    if (t->TypeAllocation == Global || t->TypeAllocation == LocalStatic )
	      emitRM2("LDA", ac, t->loc, gp, "Load address of base of array", t->string);
	    if (t->TypeAllocation == Local || t->TypeAllocation == Parameter )
	      emitRM2("LDA", ac, t->loc, fp, "Load address of bases of array", t->string);
	  } else {
	    if (t->TypeAllocation == Global || t->TypeAllocation == LocalStatic )
	      emitRM2("LD", ac, t->loc, gp, "Load variable", t->string); 
	    if (t->TypeAllocation == Local || t->TypeAllocation == Parameter )
	      emitRM2("LD", ac, t->loc, fp, "Load variable", t->string);
	  }
	} else { // t->child[0] Array
	  cgen(t->child[0]);

	  if (leftf) {
	    emitRM("ST", ac, toff--, fp, "Save index");
	    leftf = false;
	  }
	  else {
	    if (t->TypeAllocation == Global || t->TypeAllocation == LocalStatic )
	      emitRM2("LDA", ac1, t->loc, gp, "Load address of base of array", t->string);
	    if (t->TypeAllocation == Local)
	      emitRM2("LDA", ac1, t->loc, fp, "Load address of bases of array", t->string);
	    if ( t->TypeAllocation == Parameter )
	      emitRM2("LD", ac1, t->loc, fp, "Load base address of Parameter array", t->string);
	    emitRO("SUB", ac, ac1, ac, "Compute offset of value");
	    emitRM("LD", ac, 0, ac, "Load the value");
	  }
	}
	if ( (t->sibling) && (callcnt == 0) )
	  cgen(t->sibling);
	break;
      }

    case CallK:
      { 
	callcnt++;
	emitComment("EXPRESSION STMT");
	emitRM("ST", fp, toff, fp, "Store old frame in ghost frame");
	int temp = toff;
	toff -= 2; // rt address

	TreeNode* tmp = t->child[0];
	if (tmp) {
	  cgen(tmp);
	  emitRM("ST", ac, toff--, fp, "Store parameter");
	  while (tmp->sibling) {
	    tmp = tmp->sibling; 
	    cgen(tmp);
	    emitRM("ST", ac, toff--, fp, "Store parameter");
	  }
	}
	emitRM("LDA", fp, temp, fp, "Load address of new frame");
	emitRM("LDA", ac, 1, pc, "Return address in ac");
	emitRMAbs2("LDA", pc, ((TreeNode*)(st->lookup(t->string)))->loc, "CALL", t->string);
	emitRM("LDA", ac, 0, rt, "Save the result in ac");
	toff = temp;
	callcnt--;

	if ( (t->sibling) && (!callcnt) )
	  cgen(t->sibling);
	break;
      }

    case AssignK:
      { 
	emitComment("EXPRESSION STMT AssignK");
	TreeNode* f = t->child[0];
	TreeNode* j = NULL;
	if (t->child[1])
	  j = t->child[1];

	if (f && j) {
	  if (f->child[0]) {
	    if (f->kind.exp == IdK)
	      leftf = true;
	    cgen(f);  //left
	  }
	  cgen(j);//right

	  if ( (f->kind.exp == IdK) && f->child[0] ) {
	    emitRM("LD", ac1, ++toff, fp, "Restore index");
	    if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic ) 
	      emitRM2("LDA", ac2, f->loc, gp, "Load address of base of array", f->string); 
	    if (f->TypeAllocation == Local) 
	      emitRM2("LDA", ac2, f->loc, fp, "Load address of base of array", f->string);
	    if (f->TypeAllocation == Parameter )
	      emitRM2("LD", ac2, f->loc, fp, "Load base address of Parameter array", f->string);
	    emitRO("SUB", ac2, ac2, ac1, "Compute offset of value");

	    switch (t->attr.op) {
	    case '=':
	      emitRM2("ST", ac, 0, ac2, "AssignK = : Store variable", f->string);  // do not feel confortable
	      break;
	    case PASSIGN:
	      emitRM("LD", ac1, 0, ac2, "Load the value");
	      emitRO("ADD", ac, ac1, ac, "AssignK += : Update variable value");
	      emitRM2("ST", ac, 0, ac2, "Store variable", f->string);
	      break;
	    case MASSIGN:
	      emitRM("LD", ac1, 0, ac2, "Load the value");
	      emitRO("SUB", ac, ac1, ac, "AssignK -= : Update variable value");
	      emitRM2("ST", ac, 0, ac2, "store variable", f->string);
	      break;
	    }
	  } else { // Id, not indexed array
	    switch (t->attr.op) {
	    case '=':
	      if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
		emitRM2("ST", ac, f->loc, gp, "AssignK = : Store variable", f->string);
	      if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
		emitRM2("ST", ac, f->loc, fp, "AssignK = : Store variable", f->string);
	      break;
	    case PASSIGN:
	      if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
		emitRM("LD", ac1, f->loc, gp, "Load the value");
	      if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
		emitRM("LD", ac1, f->loc, fp, "Load the value");
	      emitRO("ADD", ac, ac1, ac, "AssignK += : Update variable value");
	      if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
		emitRM2("ST", ac, f->loc, gp, "Store variable", f->string);
	      if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
		emitRM2("ST", ac, f->loc, fp, "Store variable", f->string);
	      break;
	    case MASSIGN:
	      if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
		emitRM("LD", ac1, f->loc, gp, "Load the value");
	      if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
		emitRM("LD", ac1, f->loc, fp, "Load the value");
	      emitRO("SUB", ac, ac1, ac, "AssignK -= : Update variable value");
	      if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
		emitRM2("ST", ac, f->loc, gp, "Store variable", f->string);
	      if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
		emitRM2("ST", ac, f->loc, fp, "Store variable", f->string);
	      break;   
	    }
	  }
	} else if ( f && (!j)) {
	  if (f->child[0]) {
	    cgen(f);  
	  }
	  switch (t->attr.op) {
	  case INC:
	    if ( (f->TypeAllocation == Global) || (f->TypeAllocation == LocalStatic) ) {
	      emitRM2("LD", ac, f->loc, gp, "load lhs variable", f->string);
	      emitRM("LDC", ac1, 1, ac3, "Load 1");
	      emitRO2("ADD", ac, ac, ac1, "AssignK ++ : increment value of", f->string);		     
	      emitRM2("ST", ac, f->loc, gp, "Store variable", f->string);	
	    }
	    if ( (f->TypeAllocation == Local) || (f->TypeAllocation == Parameter) ) {
	      emitRM2("LD", ac1, f->loc, fp, "load lhs variable", f->string);		     
	      emitRM("LDC", ac, 1, ac3, "Load 1");
	      emitRO2("ADD", ac, ac, ac1, "AssignK ++ : increment value of", f->string);		     
	      emitRM2("ST", ac, f->loc, fp, "Store variable", f->string);	
	    }
	    break;
	  case DEC:
	    if ( (f->TypeAllocation == Global) || (f->TypeAllocation == LocalStatic) ) {
	      emitRM2("LD", ac, f->loc, gp, "load lhs variable", f->string);		     
	      emitRM2("LDA", ac, -1, ac, "AssignK -- : decrement value of", f->string);		     
	      emitRM2("ST", ac, f->loc, gp, "Store variable", f->string);	
	    }
	    if ( (f->TypeAllocation == Local) || (f->TypeAllocation == Parameter) ) {
	      emitRM2("LD", ac, f->loc, fp, "load lhs variable", f->string);		     
	      emitRM2("LDA", ac, -1, ac, "AssignK -- : decrement value of", f->string);		     
	      emitRM2("ST", ac, f->loc, fp, "Store variable", f->string);	
	    }
	    break;
	  }
	}

	if (t->sibling)
	  cgen(t->sibling);
	break;
      }

    case OpK:
      {
	TreeNode* f=t->child[0];
	TreeNode * j = NULL;
	if (t->child[1])
	  j=t->child[1];
	cgen(f);   // process lhs

	if (j) {   // process rhs if binary operator
	  emitRM("ST", AC, toff--, FP, "Save left side");
	  cgen(j);
	  emitRM("LD", AC1, ++toff, FP, "Load left into ac1" );
	}

	switch(t->attr.op) {        
	case '+':
	  emitRO("ADD", ac, ac1, ac, "Op +");
	  break;
	case '-':
	  if (!j) {
	    emitRM("LDC", ac1, 0, ac3, "Load 0");
	    emitRO("SUB",ac, ac1,ac, "Op unary -");
	  } else
	    emitRO("SUB",ac, ac1,ac, "Op -");
	  break;
	case '*':
	  if (!j) {
	    if (f->TypeAllocation == Global || f->TypeAllocation == LocalStatic )
	      emitRM2("LD", ac, f->loc+1, gp, "Load array size", f->string);
	    if (f->TypeAllocation == Local || f->TypeAllocation == Parameter )
	      emitRM2("LD", ac, f->loc+1, fp, "Load array size", f->string);
	  } else
	    emitRO("MUL",ac, ac1, ac, "Op *");
	  break;
	case '/':
	  emitRO("DIV", ac, ac1, ac, "Op /");
	  break;
	case '<':
	  emitRO("SUB", ac1, ac1, ac, "Op <");
	  emitRM("LDC", ac, 1, ac3, "True case"); //reg[ac]=1
	  emitRM("JLT", ac1, 1, pc, "Jump if true");
	  emitRM("LDC", ac, 0, ac3, "False case");//reg[ac]=0
	  emitRM("LDA", pc, 1, pc, "unconditional jmp");//跳过下面这一句
	  break;

	case '>':
	  emitRO("SUB", ac1, ac1, ac, "Op >");
	  emitRM("LDC", ac, 1, ac3, "True case"); //reg[ac]=1
	  emitRM("JLT", ac1, 1, pc, "Jump if true");
	  emitRM("LDC", ac, 0, ac3, "False case");//reg[ac]=0
	  emitRM("LDA", pc, 1, pc, "unconditional jmp");//跳过下面这一句
	  break;

	case EQ:
	  emitRO("SUB", ac1, ac1, ac, "Op ==");
	  emitRM("LDC", ac, 1, ac3, "True case"); //reg[ac]=1
	  emitRM("JEQ", ac1, 1, pc, "Jump if true");
	  emitRM("LDC", ac, 0, ac3, "False case");//reg[ac]=0
	  emitRM("LDA", pc, 1, pc, "unconditional jmp");//跳过下面这一句
	  break;

	case AND: 
	  emitRM("JEQ", ac, 1, pc, "Op AND");
	  emitRM("LDA", ac, 0, ac1, "");
	} //t->attr.op
	if (t->sibling)
	  cgen(t->sibling);
	break;
      } // OpK

      break;
    } // ExpK
  }
  }
}

//根据语法树生成代码
void codeGen(TreeNode* syntaxTree, char *codefile) {
    //从内存的地址0处加载内存最大地址到reg[mp]处
    emitRM("LD", pc, 0, 0, "load maxaddress from location 0");
    //清除内存地址0处的值
    emitRM("ST", 0, 0, 0, "clear location 0");
    cgen(syntaxTree);
    emitRO("HALT", 0, 0, 0, "");
}

void genGlobal() {
  //printf("Loop through global scope\n");
  for (SymTabEntry *ste = st->findScope((char *)"globals") + 1; st->moreScope(ste); ste = st->nextSymTabEntry(ste)) {
    if ( ((TreeNode*)(ste->ptr))->isArray )  {
      emitComment("BEGIN init of global array sizes");
      emitRM2("LDC", ac, ((TreeNode*)(ste->ptr))->size, ac3, "load size of array", ste->name);
      emitRM2("ST", ac, goffset--, gp, "save size of array", ste->name);
      goffset -= ((TreeNode*)(ste->ptr))->size;
      emitComment("END init of global array sizes");
    } else if ( ((TreeNode*)(ste->ptr))->kind.decl == VarK )
      goffset -= 1;

    fflush(stdout);
  }
}

bool isIO(TreeNode* t) {
  if ( (t->nodekind == DeclK) && (t->kind.decl == FuncK) 
       && ((t->string == "output")
	   || (t->string == "outputb")
	   || (t->string == "outputc")
	   || (t->string == "input")
	   || (t->string == "inputb")
	   || (t->string == "inputc")
	   || (t->string == "outnl")) )
    return true; 
  else
    return false;
}

// the classic backpatch using the emit functions
int backPatchJumpToHere(int addr, char *comment) {
    int currloc;
    currloc = emitSkip(0);
    emitBackup(addr);
    emitRMAbs("LDA", PC, currloc, comment);
    emitBackup(currloc);
}

int backPatchJumpToHere2(int addr, char *comment, char* cc) {
    int currloc;
    currloc = emitSkip(0);
    emitBackup(addr);
    emitRMAbs2("LDA", PC, currloc, comment, cc);
    emitBackup(currloc);
}

void emitIO(char * string) {
  if (string == "input") {
    emitComment2((char*)("BEGIN function"), (char*)("input"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address"));
    emitRO((char*)("IN"),RT, 2, RT, (char*)("Grab int input"));
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address"));
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("input"));
  }
  else if (string == "output") {
    emitComment2((char*)("BEGIN function"), (char*)("output"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRM((char*)("LD"),AC,-2, FP, (char*)("Load parameter")); 
    emitRO((char*)("OUT"),AC,3, AC, (char*)("Output integer")); 
    emitRM((char*)("LDC"),RT,0, AC3, (char*)("Set return to 0")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("output"));

  } else if (string == "inputb") {
    emitComment2((char*)("BEGIN function"), (char*)("inputb"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRO((char*)("INB"),RT,2,2, (char*)("Grab bool input")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("inputb"));
  } else if (string == "outputb") {
    emitComment2((char*)("BEGIN function"), (char*)("outputb"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRM((char*)("LD"),AC,-2, FP, (char*)("Load parameter")); 
    emitRO((char*)("OUTB"),AC,3, AC, (char*)("Output bool")); 
    emitRM((char*)("LDC"),RT, 0, AC3, (char*)("Set return to 0"));    // 0?
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP, 0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("outputb"));

  } else if (string == "outnl") {
    emitComment2((char*)("BEGIN function"), (char*)("outnl"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRO((char*)("OUTNL"),AC,3, AC, (char*)("Output a newline")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("outnl"));

  } else if (string == "inputc") {
    emitComment2((char*)("BEGIN function"), (char*)("inputc"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRO((char*)("INC"),RT,2,2, (char*)("Grab character input")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("inputc"));
  } else if (string == "outputc") {
    emitComment2((char*)("BEGIN function"), (char*)("outputc"));
    emitRM((char*)("ST"),AC,-1, FP, (char*)("Store return address")); 
    emitRM((char*)("LD"),AC,-2, FP, (char*)("Load parameter")); 
    emitRO((char*)("OUTC"),AC,3, AC, (char*)("Output character")); 
    emitRM((char*)("LDC"),RT,0, AC3, (char*)("Set return to 0")); 
    emitRM((char*)("LD"),AC,-1, FP, (char*)("Load return address")); 
    emitRM((char*)("LD"),FP,0, FP, (char*)("Adjust fp")); 
    emitRM((char*)("LDA"),PC,0, AC, (char*)("Return")); 
    emitComment2((char*)("END of function"), (char*)("outputc"));
  }
}

TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char* id) {
  TreeNode* newTree; 
  newTree = newDeclNode(FuncK);
  newTree->string = string; 
  newTree->linnum = -1;
  newTree->expType = expType;
  if (argType != Void) {
    newTree->child[0] = newDeclNode(ParamK);
    newTree->child[0]->string = id;
    newTree->child[0]->expType = argType;
  }
  newTree->sibling = t;
  return newTree;
}

static void insertCheckNode( TreeNode * t)  {

  switch (t->nodekind) {
  case DeclK:  
    switch(t->kind.decl){

    case VarK:
      if (!t->isArray)
	t->size = 1;
      if ( (!t->TypeAllocation) && (!funcf) )
	t->TypeAllocation = Global; 
      else if  ( (!t->TypeAllocation) && (funcf) )
	t->TypeAllocation = Local; 

      switch(t->TypeAllocation) {
      case Local:
	if (!t->isArray)
	  t->loc = foffset; 
	else {
	  t->loc = foffset-1; 
	  foffset -= 1;
	  toff -= 1;
	}
	foffset -= t->size;
	toff -= t->size;
	break; 
      case Parameter:
	t->loc = foffset; 
	foffset -= 1;//t->size;
	toff -= 1;   //t->size;
	break; 
      case Global: 
	if (t->isArray) {
	  t->loc = goffset-1; 
	  goffset -= t->size + 1; // +1
	} else
	  t->loc = goffset--; 
	break; 
      case LocalStatic: 
	t->loc = goffset; 
	goffset -= t->size + 1; // +1
	break; 
      default: 
	break; 
      }

      if (t->child[0]) {
	insertCheckNode(t->child[0]);

	if (t->child[0]->isConstant == false) {
	  printf("ERROR(%d): Initializer for variable '%s' is not a constant expression.\n", 
		 t->child[0]->linnum, t->string);
	  ++numError;
	}

	// initialize array variable
	if ( (t->isArray == true) && (t->child[0] != NULL) ) {
	  //if ( (t->child[0]->isArray) && (t->child[0]->expType != Character) ) { // Character	  
	  //if (t->child[0]->expType != Character) { // Character	  
	  if (t->expType != Character) { // Character	  
	    printf("ERROR(%d): Array '%s' must be of type char to be initialized, but is of type %s.\n",
		   t->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	  if ( t->child[0]->isArray == false ) {
	    printf("ERROR(%d): Initializer for array variable '%s' must be a string, but is of nonarray type %s.\n",
		   t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	    ++numError;
	  } 
	  if ( (t->child[0]->isArray) && (t->child[0]->expType != Character) ) {
	    printf("ERROR(%d): Array '%s' must be of type char to be initialized, but is of type %s.\n", 
		   t->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	}
      }

      if ( (t->isArray == false) && (t->child[0] != NULL) ) {
	if ( (t->expType != t->child[0]->expType) && (t->child[0]->expType != Undefined) ){
	  printf("ERROR(%d): Variable '%s' is of type %s but is being initialized with an expression of type %s.\n", 
		 t->linnum, t->string, getType(t->expType), getType(t->child[0]->expType));
	  ++numError;
	}
      }

      //st->print();
      if ((st->lookup(t->string) == NULL) || //(depcp) ||
	  ( ((st->lookupSymTabEntry(t->string))->depth != st->depth()-1 ) //ParamK
	    //&& (st->lookupSymTabEntry(t->string))->depth != st->depth()-2) 
	    && (st->lookupSymTabEntry(t->string))->depth != st->depth()) ) {
	  //|| ((cpflag == true) && depcp)) { 
	 
	st->insert(t->string, (void*)t ); 

	if (t->child[0] != NULL) {
	  /*	  if ( (t->isArray == false) && (t->expType != t->child[0]->expType) ) {
	    printf("ERROR(%d): Variable '%s' is of type %s but is being initialized with an expression of type %s.\n", 
		   t->linnum, t->string, getType(t->expType), getType(t->child[0]->expType));
	    ++numError;
	    }  */   
	  if ( (t->isArray == false) && (t->child[0]->isArray == true) ) {
	    printf("ERROR(%d): Initializer for nonarray variable '%s' of type %s cannot be initialized with an array.\n",
		   t->child[0]->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	} // child[0] != NULL

      } else { // exist in symtab
	//cout << "st->depth: " << st->depth() << endl;
	//sprintf(str, "Compound Statement:%d", st->depth());
	//if (st->lookupSymTabEntry(t->string)->scope != str) {  // logic is not correct

	//st->print();
	//cout << "st->depth: " << st->depth() << endl;

	//if ( (depcp && ((st->lookupSymTabEntry(t->string))->depth == st->depth()-1)) || (!depcp) ) {
	  printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", 
		 t->linnum, t->string, ((TreeNode*)(st->lookup(t->string)))->linnum);
	  ++numError;
	  //}
      }

      if  (t->sibling != NULL) {
	//t->sibling->TypeAllocation = t->TypeAllocation; 
	insertCheckNode(t->sibling);
      }
      break;

    case FuncK:
      t->TypeAllocation = Global; 
      funcf = true;
      if (st->lookup(t->string) == NULL) {   
	st->insert(t->string, (void*)t ); 
      } else { 
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", t->linnum, t->string, 
	       ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
      }

      st->enter(t->string);
      foffset = -2;
      toff = -2;

      if (t->child[0]) {
	t->child[0]->TypeAllocation = Parameter;  
	insertCheckNode(t->child[0]);
      }
      if (t->child[1])
	insertCheckNode(t->child[1]);

      if (t->child[1] != NULL){
	if ( (t->expType == 0) && (t->child[1]->expType != 0) ) {
	  printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has return value.\n", 
		 t->child[1]->linnum, t->string, t->linnum);
	  ++numError;
	} else if ( (t->expType == 0) && (ReturnFlag == true) && (t->child[1]->expType != 0) ) {
	  //} else if ( (t->expType == 0) && (ReturnFlag == true) ) {
	  printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has return value.\n", 
		 t->child[1]->linnum, t->string, t->linnum);
	  ++numError;
	} else if (t->expType != 0) {
	  if ( (t->child[1]->expType == 0) && (ReturnFlag == true) ) {
	    printf("ERROR(%d): Function '%s' at line %d is expecting to return type %s but return has no return value.\n", 
		   t->child[1]->linnum, t->string, t->linnum, getType(t->expType));
	    ++numError;
	  } else if  ((t->child[1]->expType != 0) && (t->expType != t->child[1]->expType)) {
	    printf("ERROR(%d): Function '%s' at line %d is expecting to return type %s but got type %s.\n", 
		   t->child[1]->linnum, t->string, t->linnum, getType(t->expType), getType(t->child[1]->expType));
	    ++numError;
	  } else if ( (t->child[1]->expType == 0) && (ReturnFlag == false) ){
	    printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement.\n", 
		   t->linnum, getType(t->expType), t->string);
	    ++numWarnings;
	  }
	}
	ReturnFlag = false; // set back to default
      } // child1
      st->leave();

      if ( (t->child[1] == NULL) && (t->expType != Void) 
	   && ((t->string != (char*)"input") && (t->string != (char*)"inputb") && (t->string != (char*)"inputc"))) {
	printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement.\n", 
	       t->linnum, getType(t->expType), t->string);
	++numWarnings;
      }
      t->size = foffset; 
      funcf = false;

      if (t->sibling != NULL) {
	t->sibling->TypeAllocation = Global; 
	insertCheckNode(t->sibling);
      }
      break;

    case ParamK:
      t->loc = foffset; 
      t->size = 1; // could be different
      t->TypeAllocation = Parameter;  
      foffset -= t->size;
      toff -= t->size;

      st->insert(t->string, (void*)t );
      /*      for (int i = 0; i < MAXCHILDREN; i++) {
	if (t->child[i])
	  insertCheckNode(t->child[i]);
	  }   */
      if (t->sibling != NULL) {   
	t->sibling->TypeAllocation = Global;
	insertCheckNode(t->sibling);
      }  
      break;
    }
    break;

  case StmtK:   
    switch (t->kind.stmt) {
    case WhileK:
      ++depthcnt;
      LoopFlag = true;

      if (st->lookup(t->string) == NULL)   
	st->insert(t->string, (void*)t );  

      for (ifi = 0; ifi < MAXCHILDREN; ifi++) {
	if (t->child[ifi] != NULL)
	  insertCheckNode(t->child[ifi]);
      }
      if (t->child[0] != NULL) {
	if (t->child[0]->expType != 2) {
	  printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", 
		 t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	} //else if ( (t->child[0]->expType == 2) && (t->child[0]->isArray == true) ) {
	if (t->child[0]->isArray == true) {
	  printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->child[0]->linnum, t->string);
	  ++numError;
	} 
      }
      if (t->child[1]) {
	sprintf(str, "Return:%d", st->depth());
	if (st->lookup(str) == NULL) {
	  t->expType = Void;
	  ReturnFlag = false;
	} else {
	  ReturnFlag = true;
	  t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	  //t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
	}
      }

      --depthcnt;
      LoopFlag = false;
      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case IfK:
      if (st->lookup(t->string) == NULL)   
	st->insert(t->string, (void*)t );  

      for (ifi = 0; ifi < MAXCHILDREN; ifi++) {
	if (t->child[ifi] != NULL)
	  insertCheckNode(t->child[ifi]);
      }

      if (t->child[0]->expType != 2) {
	printf("ERROR(%d): Expecting Boolean test condition in %s statement but got type %s.\n", 
	       t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	++numError;
      } //else if ( (t->child[0]->expType == 2) && (t->child[0]->isArray == true) ) {
      if (t->child[0]->isArray == true) {
	printf("ERROR(%d): Cannot use array as test condition in %s statement.\n", t->child[0]->linnum, t->string);
	++numError;
      } 
      if (t->child[1]) {
	sprintf(str, "Return:%d", st->depth());
	if (st->lookup(str) == NULL) {
	  t->expType = Void;
	  ReturnFlag = false;
	} else {
	  ReturnFlag = true;
	  t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	  //t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
	}
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;
  
    case ForEachK:
      ++depthcnt;
      LoopFlag = true;
      for (i = 0; i < MAXCHILDREN; i++)  {
	if (t->child[i] != NULL)
	  insertCheckNode(t->child[i]);
      }

      if (t->child[0] != NULL) {
	//if ( ((TreeNode*)(t->child[0]->string))->isArray == true )  {  //need work here
	if ( t->child[0]->isArray == true )  {
	  printf("ERROR(%d): In foreach statement the variable to the left of 'in' must not be an array.\n", t->linnum);
	  ++numError;
	}
	if (t->child[1] != NULL) {
	  if (t->child[1]->isArray == true) {
	    if (t->child[0]->expType != t->child[1]->expType) {
	      printf("ERROR(%d): Foreach requires operands of 'in' be the same type but lhs is type %s and rhs array is type %s.\n", 
		     t->linnum, getType(t->child[0]->expType), getType(t->child[1]->expType));  
	      ++numError;  
	    }
	  } else { //t->child[1]->isArray == false
	    if ( t->child[0]->expType != Integer ) {
	      printf("ERROR(%d): If not an array, foreach requires lhs of 'in' be of type int but it is type %s.\n", 
		     t->linnum, getType(t->child[0]->expType)); 
	      ++numError;
	      t->child[0]->expType = Integer; 
	    } 
	    if (t->child[1]->expType != Integer) {
	      printf("ERROR(%d): If not an array, foreach requires rhs of 'in' be of type int but it is type %s.\n", 
		     t->linnum, getType(t->child[1]->expType)); 
	      ++numError;
	      t->child[1]->expType = Integer; 
	    }
	  }
	} //t->child[1] != NULL
	if (t->child[2]) {
	  sprintf(str, "Return:%d", st->depth());
	  if (st->lookup(str) == NULL) {
	    t->expType = Void;
	    ReturnFlag = false;
	  } else {
	    ReturnFlag = true;
	    t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	    //t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
	  }
	}
      }
      --depthcnt;
      LoopFlag = false;
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);
      break;

    case BreakK:
      if ( (LoopFlag == false) && (!depthcnt) ) {   // potential problems with nested loops
      //if ( LoopFlag == false ) {
	printf("ERROR(%d): Cannot have a break statement outside of loop.\n", t->linnum);  
	++numError;
      } 
      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case ReturnK:  
      if (t->child[0] == NULL) 
	t->expType = Void;
      
      if (t->child[0] != NULL) {
	insertCheckNode(t->child[0]);
	if (t->child[0]->expType == Void)
	  t->expType = Undefined;
	else
	  t->expType = t->child[0]->expType;
	if ( (t->child[0]->kind.exp == IdK) && (t->child[0]->isArray) ) {
	  printf("ERROR(%d): Cannot return an array.\n", t->linnum);  
	  ++numError;
	  t->child[0]->isArray = false; 
	} 
      }
      sprintf(str, "Return:%d", st->depth());
      st->insert(str, (void*)t );
      if (t->sibling != NULL)  // just added
	insertCheckNode(t->sibling);
      break;

    case CompoundK:  
      //depth = st->depth() + 1;
      sprintf(nameCompoundStat, "Compound Statement:%d", st->depth()+1);
      st->enter(nameCompoundStat);
      cpflag = true;
      depcp++;

      /*
      for (cmpi = 0; cmpi < MAXCHILDREN; cmpi++) { 
	if (t->child[cmpi] != NULL) 
	  insertCheckNode(t->child[cmpi]);
      }
      */

      if (t->child[0]) {
	if (t->child[0]->isStatic==true)
	  t->child[0]->TypeAllocation = LocalStatic; 
	else
	  t->child[0]->TypeAllocation = Local; 
	insertCheckNode(t->child[0]);
      }

      if (t->child[1]) 
	insertCheckNode(t->child[1]);

      /*  // not sure if this one is necessary any more
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);
      */

      sprintf(str, "Return:%d", st->depth());
      if (st->lookup(str) == NULL) {
	t->expType = Void;
	ReturnFlag = false;
	/*     } else if (t->child[1]) {
	  t->expType = t->child[1]->expType;
	  if (t->expType)
	    ReturnFlag = true;
	    cout << "t->expType: A " << t->expType << endl;    */
      } else {
	ReturnFlag = true;
	t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
      }

      st->leave();
      cpflag = false;
      if (ReturnFlag && t->expType) {
	sprintf(str, "Return:%d", st->depth());
	st->insert(str, (void*)t );
      }

      depcp--;
      //depth--;
      if (t->sibling != NULL)  // just added
	insertCheckNode(t->sibling);
      break;

    }
    break;

  case ExpK:  
    switch (t->kind.exp){

    case ConstantK: 
      break;

    case AssignK:
      if (st->lookup(t->string) == NULL)   
	st->insert(t->string, (void*)t );   
      for (assigni = 0; assigni < MAXCHILDREN; assigni++) {
	if (t->child[assigni] != NULL)
	  insertCheckNode(t->child[assigni]);
      }

      if ( (t->child[0] != NULL) && (t->child[1] != NULL) 
	   && (t->child[0]->expType != t->child[1]->expType) )  {

	if ( (t->attr.op == PASSIGN) || (t->attr.op == MASSIGN) ) {
	  if (t->child[0]->expType != Integer) {
	    printf("ERROR(%d): '%s' requires operands of type int but lhs is of type %s.\n", 
		   t->linnum, t->string, getType(t->child[0]->expType));
	    ++numError;
	  } else {
	    printf("ERROR(%d): '%s' requires operands of type int but rhs is of type %s.\n", 
		   t->linnum, t->string, getType(t->child[1]->expType));
	    ++numError;
	  }
	} else if (t->attr.op == '=') {
	  /*if ( t->child[0]->isArray != t->child[1]->isArray ){
	    printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		   t->linnum, t->string);
	    ++numError;
	    } */
	  if ( (t->child[0]->expType != Undefined) && (t->child[1]->expType != Undefined) ) {
	    printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		   t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	    ++numError;
	    t->expType = t->child[0]->expType; 
	  }
	  if (t->child[1]->expType == Undefined)
	    t->expType = t->child[0]->expType; 
	  //else if ( (t->child[0]->expType == Undefined) && (t->child[1]->expType != Undefined) )
	  else if (t->child[0]->expType == Undefined)
	    t->expType = Undefined; 
	} else { 
	  printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	  ++numError;
	}
      }

      if ( ((t->attr.op == INC) || (t->attr.op == DEC))
	   && (t->child[0] != NULL) && (t->child[1] == NULL) ) {
	if (t->child[0]->expType != Integer) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type int but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	}
	if (t->child[0]->isArray == true) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
	t->expType = Integer; 
      }

      if ( (t->attr.op == '=') && t->child[0] && t->child[1] ) {
	if ( (t->child[0]->isArray != t->child[1]->isArray)
	     && ((t->child[0]->expType != Undefined) && (t->child[1]->expType != Undefined)) ) {
	     //&& ((t->child[0]->expType != Character) && (t->child[1]->expType != Character)) ) {

	  //cout << "t->child[0]->isArray: " << t->child[0]->isArray << endl;
	  //cout << "t->child[1]->isArray: " << t->child[1]->isArray << endl;

	  printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		 t->linnum, t->string);
	  ++numError;
	}
	if (t->child[0]->expType == t->child[1]->expType)
	  t->expType = t->child[0]->expType;
      }

      if ( ((t->attr.op == PASSIGN) || (t->attr.op == MASSIGN)) && (t->child[0]) && (t->child[1]) ) {
	if (t->child[0]->expType == t->child[1]->expType)
	  t->expType = t->child[0]->expType;
      }

      if ( (t->sibling != NULL) && (callcnt == 0))
	//if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case CallK:
      callcnt++;
      if (st->lookup(t->string) == NULL) {
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	if (t->child[0]) {
	  TreeNode* tmpt = t->child[0];
	  insertCheckNode(tmpt);
	  while (tmpt->sibling != NULL) {
	    tmpt = tmpt->sibling;
	    insertCheckNode(tmpt);
	  }
	}
	t->expType = Undefined; 
      } else {
	if ( (((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK)
	     || (((TreeNode*)(st->lookup(t->string)))->kind.decl == ParamK) ) {
	  printf("ERROR(%d): '%s' is a simple variable and cannot be called.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = Undefined;
	  if ( t->child[0] ) {
	    TreeNode* tmpt = t->child[0];
	    insertCheckNode(tmpt);
	    while (tmpt->sibling != NULL) {
	      tmpt = tmpt->sibling;
	      insertCheckNode(tmpt);
	    }
	  }
	  t->expType = Undefined; 
	} else { //FuncK
	  TreeNode* tmp = t; 
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  if ( (tmp->child[0] == NULL) && (p->child[0] != NULL) ) {
	    printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		   tmp->linnum, tmp->string, p->linnum);
	    ++numError;
	  }
	  if (tmp->child[0]) {
	    insertCheckNode(tmp->child[0]);  // process whole list, order: before or after?
	    if (p->child[0] == NULL) {
	      printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		     tmp->child[0]->linnum, tmp->string, p->linnum);
	      ++numError;
	    } else {
	      int pcnt = 0;
	      TreeNode* tmp_p = p->child[0];
	      TreeNode* tmp_t = tmp->child[0];

	      if ((tmp->child[0]->expType != p->child[0]->expType) && (tmp->child[0]->expType != Undefined) ) {
		printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
		       t->linnum, getType(p->child[0]->expType), pcnt+1, t->string, p->linnum, getType(tmp->child[0]->expType));
		++numError;
	      }
	      if ( (tmp->child[0]->isArray == true) && (p->child[0]->isArray == false) ) {
		printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
		       t->linnum, pcnt+1, t->string, p->linnum);
		++numError;
	      }
	      if ( (tmp->child[0]->isArray == false) && (p->child[0]->isArray == true) ) {
		printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
		       t->linnum, pcnt+1, t->string, p->linnum);
		++numError;
	      }

	      while (tmp_t->sibling && tmp_p->sibling) {
		pcnt++;
		tmp_t = tmp_t->sibling;
		tmp_p = tmp_p->sibling;
		insertCheckNode(tmp_t);
		if ((tmp_t->expType != tmp_p->expType) && (tmp_t->expType != Undefined) ) {
		  printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
			 t->linnum, getType(tmp_p->expType), pcnt+1, t->string, p->linnum, getType(tmp_t->expType));
		  ++numError;
		}
		if ( (tmp_t->isArray == true) && (tmp_p->isArray == false) ) {
		  printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		if ( (tmp_t->isArray == false) && (tmp_p->isArray == true) ) {
		  printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		tmp_t->expType = tmp_p->expType;
		tmp_t->isArray = tmp_p->isArray;
	      } //while

	      if ( (tmp_t->sibling == NULL) &&  (tmp_p->sibling != NULL) ) {
		printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		       t->linnum, t->string, p->linnum);
		++numError;
	      }
	      if ( (tmp_t->sibling != NULL) && (tmp_p->sibling == NULL) ) {
		printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		       t->linnum, t->string, p->linnum);
		++numError;
		while (tmp_t->sibling!=NULL) {
		  tmp_t = tmp_t->sibling;
		  insertCheckNode(tmp_t);
		}
	      }
	    } // end p->child[0]
	  } // if
	  t->expType = p->expType; 
	} //   end t->child[0] 
      }
      callcnt--;
      if ( (t->sibling != NULL) && (!callcnt) )
	insertCheckNode(t->sibling);
      break;

    case IdK:
      if (st->lookup(t->string) == NULL) { 	   
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	t->expType = Undefined; //4 Undefined
	t->isArray = false;
	t->isConstant = false;
	t->isStatic = false;
	if (t->child[0] != NULL) {
	  insertCheckNode(t->child[0]);
	  t->isArray = false;  } //double check
      } else {  // symtab != NULL

	if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK ) {
	  printf("ERROR(%d): Cannot use function '%s' as a simple variable.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = ((TreeNode*)(st->lookup(t->string)))->expType; 
	  //t->expType = Undefined;
	  if (t->child[0] != NULL) {
	    insertCheckNode(t->child[0]);
	    t->isArray = false;  } //double check
	} else { //if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK ) {
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  t->loc = p->loc; 
	  t->size = p->size; 
	  t->TypeAllocation = p->TypeAllocation;

	  // Dealing Array or Not
	  if (((TreeNode*)(st->lookup(t->string)))->isArray == false) {
	    t->isArray = false;
	    t->expType = ((TreeNode*)(st->lookup(t->string)))->expType;
	    if (t->child[0] != NULL) {
	      printf("ERROR(%d): Cannot index nonarray '%s'.\n", t->linnum, t->string);
	      ++numError;
	    } 
	  } else { //isArray == true

	    if (t->child[0] != NULL) {
	      insertCheckNode(t->child[0]);

	      if ( (t->child[0]->expType != Integer) && (t->child[0]->expType != Undefined) ) { //t->child[0]->expType: int
		printf("ERROR(%d): Array '%s' should be indexed by type int but got type %s.\n", 
		       t->linnum, t->string, getType(t->child[0]->expType));
		++numError;
		t->child[0]->expType == Integer;
		t->isArray = false;
	      }
	      if (t->child[0]->isArray == true) {
		printf("ERROR(%d): Array index is the unindexed array '%s'.\n", 
		       t->child[0]->linnum, t->child[0]->string);
		++numError;
	      }
	      t->isArray = false;
	    } else  // child[0] != NULL
	    t->isArray = true; 
	  }
	  t->expType = ((TreeNode*)(st->lookup(t->string)))->expType;
	} // VarK
	t->isConstant = ((TreeNode*)(st->lookup(t->string)))->isConstant;  // double check when array beco nonarr
      }
      //if (t->sibling != NULL)
      if ( (t->sibling != NULL) && (callcnt ==0))
	insertCheckNode(t->sibling);
      break;

    case OpK:  // + - * / % < > == != <= >= or not and
      int opi;
      for (opi = 0; opi < MAXCHILDREN; opi++) {
	if (t->child[opi] != NULL)
	  insertCheckNode(t->child[opi]);
      }
 
      if ( ((t->attr.op == '+') || (t->attr.op == '-') || (t->attr.op == '*') 
	  || (t->attr.op == '/') || (t->attr.op == '%'))
	   && ((t->child[0] != NULL) && (t->child[1] != NULL)) ) {
	if ( (t->child[0]->expType != Integer) && (t->child[0]->expType != Undefined) ) {
	  printf("ERROR(%d): '%s' requires operands of type %s but lhs is of type %s.\n", t->linnum, t->string, 
		 getType(1), getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Integer; 
	} 
	if ( (t->child[1]->expType != Integer) && (t->child[1]->expType != Undefined) ) {
	  printf("ERROR(%d): '%s' requires operands of type %s but rhs is of type %s.\n", t->linnum, t->string, 
		 getType(1), getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Integer; 
	} 
	t->expType = Integer; 
	if ( (t->child[0]->isConstant == true) && (t->child[1]->isConstant == true) )
	  t->isConstant = true;
      }  

      if ((t->attr.op == '-') && (t->child[0] != NULL) && (t->child[1] == NULL)) {
	if (t->child[0]->expType != Integer) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type int but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));	       
	  ++numError;
	  t->child[0]->expType = Integer; 
	}
	if ( t->child[0]->isConstant == true ) {
	  t->isConstant = true;
	}
	t->expType = Integer;
      }

      if ( (t->attr.op == '+') || (t->attr.op == '-') || (t->attr.op == '*') ) {
	if ( (t->child[0] != NULL) && (t->child[1] != NULL) && //both sides
	     ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	} 
      } 

      if ( (t->attr.op == '*') && (t->child[0] != NULL) && (t->child[1] == NULL) ) {
	if (t->child[0]->isArray == false) {
	  printf("ERROR(%d): The operation '%s' only works with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
	//if ( (t->child[0]->isArray == true) && (t->child[0]->expType == Character) ) {
	if ( (t->child[0]->isArray == true) && (t->child[0]->isConstant == true) ) {
	  t->isConstant = true;
	}
	t->expType = Integer; 
      }

      if ( ((t->attr.op == EQ) || (t->attr.op == NEQ))
	   && (t->child[0] != NULL) && (t->child[1] != NULL) ) {
	if (t->child[0]->expType != t->child[1]->expType) {
	  printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	  ++numError;
	} 
	t->expType = Boolean;
	if (t->child[0]->isArray != t->child[1]->isArray) {
	  printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		 t->linnum, t->string);
	  ++numError;
	}
      }

      if ( (t->attr.op == AND) && t->child[0] && t->child[1] ) {
	if ( (t->child[0]->expType != Boolean) && (t->child[0]->expType != Undefined) ) { //Undefined
	  printf("ERROR(%d): '%s' requires operands of type bool but lhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Boolean;
	}
	if ( (t->child[1]->expType != Boolean) && (t->child[1]->expType != Undefined) ) {
	  printf("ERROR(%d): '%s' requires operands of type bool but rhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Boolean;
	}
	//t->expType = Boolean; 
	if ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
	t->expType = Boolean; 
      }

      if ( (t->attr.op == '>') || (t->attr.op == '<') || (t->attr.op == GEQ) || (t->attr.op == LEQ) ) {
	if ( (t->child[0] != NULL) && (t->child[0]->expType != Integer) && (t->child[0]->expType != Character) ) {
	  printf("ERROR(%d): '%s' requires operands of type char or type int but lhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->expType = Boolean;
	} 
	if ( (t->child[1] != NULL) && (t->child[1]->expType != Integer) && (t->child[1]->expType != Character) ) {
	  printf("ERROR(%d): '%s' requires operands of type char or type int but rhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[1]->expType));
	  ++numError;
	  t->expType = Boolean;
	}

	if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) 
	     && ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }

      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->expType == 1) && (t->child[1]->expType == 1)) ) {
	if ( (t->attr.op == EQ) || (t->attr.op == NEQ) || (t->attr.op == LEQ) || (t->attr.op == GEQ) 
	     || (t->attr.op == '<') || (t->attr.op == '>') ) 
	  t->expType = Boolean;
	else 
	  t->expType = Integer;
      }

      if (t->attr.op == OR) {
	if ( (t->child[0] != NULL) && (t->child[0]->expType != 2) ) { //Undefined
	  printf("ERROR(%d): '%s' requires operands of type bool but lhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Boolean;
	}
	if ( (t->child[1] != NULL) && (t->child[1]->expType != 2) ) {
	  printf("ERROR(%d): '%s' requires operands of type bool but rhs is of type %s.\n", 
		 t->linnum, t->string, getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Boolean;
	}
	t->expType = Boolean; 
      }

      if (t->attr.op == NOT) {
	if ( (t->child[0] != NULL) && (t->child[1] == NULL) && (t->child[0]->expType != 2) ) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type bool but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Boolean; 
	}

	if ( (t->child[0]) && (!t->child[1]) && (t->child[0]->isConstant == true) )
	  t->isConstant = true;

	if ( (t->child[0] != NULL) && (t->child[0]->isArray == true) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	  t->child[0]->expType = Boolean; 
	}
	t->expType = Boolean; 
      }

      if ( (t->attr.op == '+') || (t->attr.op == '-') ) {
	if ( (((t->child[0] != NULL) && (t->child[0]->isArray == 1)) && (t->child[1] == NULL)) || 
	     (((t->child[1] != NULL) && (t->child[1]->isArray == 1)) && (t->child[0] == NULL)) ) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }
   
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->isConstant == true) && (t->child[1]->isConstant == true)) ) 
	t->isConstant = true;
      //else 
      //t->isConstant = false;
    
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->expType != Integer) || (t->child[1]->expType != Integer)) ) {  
	if ( (t->attr.op == '<') || (t->attr.op == '>') || (t->attr.op == AND) || (t->attr.op == OR) 
	     || (t->attr.op == EQ) || (t->attr.op == NEQ) || (t->attr.op == LEQ) || (t->attr.op == GEQ) )
	  t->expType = Boolean;   
	else   
	  t->expType = Integer;   
      }

      //if (t->sibling != NULL)
      if ( (t->sibling != NULL) && (callcnt == 0))
	insertCheckNode(t->sibling);
      break;  // OpK
    }
    break;  // exp
  }
}


static void printSpaces(int indent){
  for ( int i = 0; i < indent; i++){
    printf("|  ");
  }
}

void printNode( TreeNode * tree) {
  if (tree->nodekind == DeclK) {
    switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	default:
	  printf(" of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	}
	break;
      case FuncK:
	printf("Func %s returns type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	break;
      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	default:
	  printf(" of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	}
	break;
      default: 
	printf("Unknown DeclNode kind. ");
	break;
      }
  }
}

void printTree( TreeNode * tree, int depth, unsigned int sepbits){
  int counter = 0; 
  while (tree != NULL){
    INDENT;
    printSpaces(depth);
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	}
	break;
      case FuncK:
	//printf("Func %s returns type %s [line: %d]\n", tree->string, getType(tree->expType), tree->linnum);
	printf("Func %s returns type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	break;

      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	}
	break;
      default: 
	printf("Unknown DeclNode kind. ");
	break;
      }
    } else if (tree->nodekind == StmtK){    
      switch (tree->kind.stmt){
      case IfK:
	printf("If [line: %d]\n", tree->linnum);
        break;
      case WhileK:
	printf("While [line: %d]\n", tree->linnum);
        break;
      case ForEachK:
	printf("Foreach [line: %d]\n", tree->linnum);
	break;
      case CompoundK:
	printf("Compound [line: %d]\n", tree->linnum);
	break;
      case ReturnK:
	printf("Return [line: %d]\n", tree->linnum);
	break;
      case BreakK:
	printf("Break [line: %d]\n", tree->linnum);
	break;
      default:
	printf("Unknown DeclNode kind. ");
        break;
      }
    } else if (tree->nodekind == ExpK){   
      switch (tree->kind.exp){
      case OpK:
	printf("Op: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case ConstantK:
	printf("Const: ");
	switch ( tree->expType ){
	case Integer:
	  printf("%d [line: %d]\n", tree->attr.val, tree->linnum);
	  break;
	case Boolean:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	case Character:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	}
        break;
      case IdK:
	//printf("Id: %s [line: %d]\n", tree->string, tree->linnum);
	printf("Id: %s [line: %d] of type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, tree->linnum, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
        break;
      case AssignK:
	printf("Assign: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case CallK:
	printf("Call: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      default:
	printf("Unknown ExpNode kind: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      }
    } else
      printf("Unknown DeclNode kind. ");

    int childcnt = 0;
    for (int i = 0; i < MAXCHILDREN; i++){
      if (tree->child[i] == NULL) 
	continue;
      else {
	printSpaces(depth);
	printf("Child: %d\n", i+1);
	childcnt++;
	depth++;
	printTree(tree->child[i], depth, depth);
	depth--;
      } 
    } 

    tree = tree->sibling; 
    if (tree != NULL){
      counter++;
      if ( counter > 0 && depth ){
	printSpaces(depth-1);
	printf("Sibling: %d\n", counter);
      }
    }
  }
  UNINDENT;
}


/*
void printTree( TreeNode * tree, int depth, unsigned int sepbits){
  int counter = 0; 
  while (tree != NULL){
    INDENT;
    printSpaces(depth);
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d. foffset: %d; goffset: %d \n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc, foffset, goffset);
	  break;
	}
	break;
      case FuncK:
	//printf("Func %s returns type %s [line: %d]\n", tree->string, getType(tree->expType), tree->linnum);
	printf("Func %s returns type %s allocated as %s of size %d at location %d.\n", 
	       tree->string, getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	break;

      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  //printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" is array of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	default:
	  //printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  printf(" of type %s allocated as %s of size %d at location %d.\n", 
		 getType(tree->expType), getTypeAlloc(tree->TypeAllocation), tree->size, tree->loc);
	  break;
	}
	break;
      default: 
	printf("Unknown DeclNode kind. ");
	break;
      }
    } else if (tree->nodekind == StmtK){    
      switch (tree->kind.stmt){
      case IfK:
	printf("If [line: %d]\n", tree->linnum);
        break;
      case WhileK:
	printf("While [line: %d]\n", tree->linnum);
        break;
      case ForEachK:
	printf("Foreach [line: %d]\n", tree->linnum);
	break;
      case CompoundK:
	printf("Compound [line: %d]\n", tree->linnum);
	break;
      case ReturnK:
	printf("Return [line: %d]\n", tree->linnum);
	break;
      case BreakK:
	printf("Break [line: %d]\n", tree->linnum);
	break;
      default:
	printf("Unknown DeclNode kind. ");
        break;
      }
    } else if (tree->nodekind == ExpK){   
      switch (tree->kind.exp){
      case OpK:
	printf("Op: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case ConstantK:
	printf("Const: ");
	switch ( tree->expType ){
	case Integer:
	  printf("%d [line: %d]\n", tree->attr.val, tree->linnum);
	  break;
	case Boolean:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	case Character:
	  printf("%s [line: %d]\n", tree->string, tree->linnum);
	  break;
	}
        break;
      case IdK:
	printf("Id: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case AssignK:
	printf("Assign: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      case CallK:
	printf("Call: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      default:
	printf("Unknown ExpNode kind: %s [line: %d]\n", tree->string, tree->linnum);
        break;
      }
    } else
      printf("Unknown DeclNode kind. ");

    int childcnt = 0;
    for (int i = 0; i < MAXCHILDREN; i++){
      if (tree->child[i] == NULL) 
	continue;
      else {
	printSpaces(depth);
	printf("Child: %d\n", i+1);
	childcnt++;
	depth++;
	printTree(tree->child[i], depth, depth);
	depth--;
      } 
    } 

    tree = tree->sibling; 
    if (tree != NULL){
      counter++;
      if ( counter > 0 && depth ){
	printSpaces(depth-1);
	printf("Sibling: %d\n", counter);
      }
    }
  }
  UNINDENT;
}
*/

char* getTypeAlloc(int x){
  char* typeall;
  switch (x){
  case 0: 
    typeall = (char*)"LocalStatic";
    break;
  case 1:
    typeall = (char*)"Local";
    break;
  case 2:
    typeall = (char*)"Global";
    break;
  case 3:
    typeall = (char*)"Parameter";
    break;
  }
  return typeall;
}

char* getType(int x){
  char* typeString;
  switch (x){
  case 0: 
    typeString = (char*)"void";
    break;
  case 1:
    typeString = (char*)"int";
    break;
  case 2:
    typeString = (char*)"bool";
    break;
  case 3:
    typeString = (char*)"char";
    break;
  }
  return typeString;
}

TreeNode * newStmtNode( StmtKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind.stmt = kind;   
    t->linnum = linnum;
    t->isArray = false;
    t->isConstant = false;
    t->isStatic = false;
  }
  return t;
}

TreeNode * newDeclNode(DeclKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = DeclK;
    t->kind.decl = kind;   
    t->linnum = linnum;
    t->isArray = false;
    t->isConstant = false;
    t->isStatic = false;
  }
  return t;
}

TreeNode * newExpNode( ExpKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind.exp = kind; 
    t->linnum = linnum;
    t->expType = Void;        // added type here compared with newStmtNode
    t->isArray = false;
    t->isConstant = false;
    t->isStatic = false;
  }
  return t;
}

// allocates and makes a new copy of an existing string
char * copyString( char * s){
  int n; 
  if (s==NULL) return NULL;
  n = strlen(s) + 1;
  char * t = (char*)malloc(n);
  if (t==NULL)
    printf("Out of memory error at line %d\n", linnum);
  else strcpy(t, s);
  return t;
}

void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, linnum, yytext);
  //printf("ERROR linnum(%d):%s. I got: %s\n", linnum, s, yytext);
  exit(-1);
}

/*
static void traverse( TreeNode * t, void (* preProc) (TreeNode *), void (* postProc) (TreeNode *) ) {
  if (t != NULL) {
    preProc(t);   
    { 
      int i;   
      for (i=0; i < MAXCHILDREN; i++) 
	traverse(t->child[i],preProc,postProc);   
    }   
    postProc(t);   
    traverse(t->sibling,preProc,postProc);   
  }   
}   
*/


