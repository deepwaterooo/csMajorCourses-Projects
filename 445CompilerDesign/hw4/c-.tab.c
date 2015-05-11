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
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
  //#include "c-.tab.h"
#include "symtab.h"
#include "scanType.h"  
#include "yyerror.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
char *yyfilename;
extern char *yytext;
extern int linnum;
extern char tokenString[];
int numError; 
int numWarnings;

#define MAXCHILDREN 3
typedef int TokenType;

typedef enum {DeclK, StmtK, ExpK} NodeKind; 
typedef enum {VarK, FuncK, ParamK} DeclKind;
typedef enum {IfK, WhileK, ForEachK, CompoundK, ReturnK, BreakK} StmtKind;
typedef enum {OpK, ConstantK, IdK, AssignK, CallK} ExpKind;
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
} TreeNode;

static TreeNode* savedTree; // stores syntax tree for later return
using namespace std;
//#define YY_DECL extern "C" int yylex()
#define YYDEBUG 1
#define YYERROR_VERBOSE

TreeNode * newStmtNode( StmtKind );
TreeNode * newDeclNode(DeclKind kind);
TreeNode * newExpNode( ExpKind );
  //void FreeTree(Node *p);

static TokenData token; /* holds current token */
//void yyerror(const char* s);
char* getType(int x);
char * copyString( char * s);

static int indentno = 0;
#define INDENT indentno += 3
#define UNINDENT indentno -= 3
static void printSpaces(void);

void printTree( TreeNode * tree);
static void insertCheckNode( TreeNode * t);
TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char*);
char str[64];



/* Line 268 of yacc.c  */
#line 151 "c-.tab.c"

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
     TRUE = 279,
     FALSE = 280,
     RETURN = 281,
     BREAK = 282,
     AND = 283,
     OR = 284,
     NOT = 285
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 293 of yacc.c  */
#line 80 "c-.y"

  ExpType type;    
  int number;
  TokenData * tokenData;
  struct treeNode * nodeptr;



/* Line 293 of yacc.c  */
#line 226 "c-.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 343 of yacc.c  */
#line 238 "c-.tab.c"

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
#define YYFINAL  14
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1614

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  48
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  45
/* YYNRULES -- Number of rules.  */
#define YYNRULES  162
/* YYNRULES -- Number of states.  */
#define YYNSTATES  310

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   285

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,    44,     2,     2,
      32,    35,    43,    47,    28,    46,     2,    45,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    30,    29,
      40,    41,    42,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    33,     2,    36,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    31,     2,    34,     2,     2,     2,     2,
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
      25,    26,    27,    37,    38,    39
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    14,    16,    20,
      24,    29,    33,    37,    41,    43,    47,    51,    53,    57,
      61,    65,    67,    72,    76,    81,    83,    85,    87,    94,
     100,   107,   112,   118,   122,   124,   125,   129,   131,   135,
     138,   141,   145,   147,   151,   155,   157,   161,   166,   170,
     173,   174,   177,   179,   181,   184,   187,   195,   199,   205,
     211,   215,   223,   227,   229,   237,   243,   251,   255,   259,
     265,   269,   277,   281,   283,   285,   288,   290,   293,   297,
     300,   303,   305,   308,   313,   316,   321,   324,   325,   327,
     331,   335,   339,   343,   346,   349,   352,   355,   357,   359,
     361,   365,   367,   371,   375,   379,   381,   385,   389,   392,
     394,   397,   401,   403,   407,   411,   413,   415,   417,   419,
     421,   423,   427,   429,   433,   437,   439,   441,   445,   447,
     451,   455,   457,   459,   461,   464,   466,   469,   471,   473,
     475,   477,   479,   484,   488,   491,   493,   497,   499,   502,
     505,   507,   509,   511,   513,   515,   520,   525,   529,   531,
     532,   536,   538
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      49,     0,    -1,    50,    -1,    50,    51,    -1,    51,    -1,
       1,    -1,    52,    -1,    58,    -1,    57,    54,    29,    -1,
      57,     1,    29,    -1,    20,    57,    54,    29,    -1,    57,
      54,    29,    -1,    57,     1,    29,    -1,    54,    28,    55,
      -1,    55,    -1,     1,    28,    55,    -1,    54,    28,     1,
      -1,    56,    -1,    56,    30,    75,    -1,     1,    30,    75,
      -1,    56,    30,     1,    -1,    11,    -1,    11,    33,    13,
      36,    -1,    11,    33,     1,    -1,     1,    33,    13,    36,
      -1,    22,    -1,    23,    -1,    21,    -1,    57,    11,    32,
      59,    35,    65,    -1,    11,    32,    59,    35,    65,    -1,
      57,     1,    32,    59,    35,    65,    -1,    57,    11,    32,
       1,    -1,    11,    32,     1,    35,    65,    -1,     1,    35,
      65,    -1,    60,    -1,    -1,    60,    29,    61,    -1,    61,
      -1,     1,    29,    61,    -1,    57,    62,    -1,    57,     1,
      -1,    62,    28,    63,    -1,    63,    -1,     1,    28,    63,
      -1,    62,    28,     1,    -1,    11,    -1,    11,    33,    36,
      -1,     1,    33,    13,    36,    -1,    11,    33,     1,    -1,
      64,    65,    -1,    -1,    64,     1,    -1,    66,    -1,    67,
      -1,    66,     1,    -1,    67,     1,    -1,    15,    32,    75,
      35,    66,    16,    66,    -1,    15,    32,     1,    -1,     1,
      35,    66,    16,    66,    -1,    17,    32,    75,    35,    66,
      -1,    17,    32,     1,    -1,    18,    32,    87,    19,    75,
      35,    66,    -1,    18,    32,     1,    -1,    68,    -1,    15,
      32,    75,    35,    66,    16,    67,    -1,    15,    32,    75,
      35,    65,    -1,    15,    32,    75,    35,     1,    16,    67,
      -1,    15,    32,     1,    -1,     1,    35,    65,    -1,    17,
      32,    75,    35,    67,    -1,    17,    32,     1,    -1,    18,
      32,    87,    19,    75,    35,    67,    -1,    18,    32,     1,
      -1,    71,    -1,    69,    -1,    27,    29,    -1,    70,    -1,
      26,    29,    -1,    26,    73,    29,    -1,    26,     1,    -1,
      73,    29,    -1,    29,    -1,     1,    29,    -1,    31,    72,
      64,    34,    -1,     1,    34,    -1,    31,     1,    64,    34,
      -1,    72,    53,    -1,    -1,    75,    -1,    87,    74,    73,
      -1,     1,    74,    73,    -1,    87,    74,     1,    -1,    87,
       1,    73,    -1,    87,     5,    -1,    87,     6,    -1,     1,
       5,    -1,     1,     6,    -1,    41,    -1,     3,    -1,     4,
      -1,    75,    38,    76,    -1,    76,    -1,    75,    38,     1,
      -1,     1,    38,    76,    -1,    76,    37,    77,    -1,    77,
      -1,     1,    37,    77,    -1,    76,    37,     1,    -1,    39,
      77,    -1,    78,    -1,    39,     1,    -1,    80,    79,    80,
      -1,    80,    -1,     1,    79,    80,    -1,    80,    79,     1,
      -1,    40,    -1,    42,    -1,     9,    -1,    10,    -1,     7,
      -1,     8,    -1,    80,    81,    82,    -1,    82,    -1,     1,
      81,    82,    -1,    80,    81,     1,    -1,    47,    -1,    46,
      -1,    82,    83,    84,    -1,    84,    -1,     1,    83,    84,
      -1,    82,    83,     1,    -1,    43,    -1,    45,    -1,    44,
      -1,    85,    84,    -1,    86,    -1,    85,     1,    -1,    46,
      -1,    43,    -1,    88,    -1,    87,    -1,    11,    -1,    11,
      33,    73,    36,    -1,    11,    33,     1,    -1,     1,    33,
      -1,    90,    -1,    32,    73,    35,    -1,    89,    -1,    32,
       1,    -1,     1,    35,    -1,    13,    -1,    12,    -1,    14,
      -1,    24,    -1,    25,    -1,    11,    32,    91,    35,    -1,
       1,    32,    91,    35,    -1,    11,    32,     1,    -1,    92,
      -1,    -1,    92,    28,    73,    -1,    73,    -1,     1,    28,
      73,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   106,   106,   108,   123,   124,   126,   127,   129,   142,
     165,   180,   195,   198,   209,   210,   211,   248,   249,   254,
     255,   257,   263,   270,   271,   273,   274,   275,   287,   298,
     308,   309,   310,   311,   353,   354,   356,   368,   370,   372,
     385,   387,   400,   401,   402,   404,   410,   417,   418,   425,
     436,   437,   439,   440,   441,   442,   444,   453,   454,   456,
     464,   466,   475,   476,   478,   488,   496,   497,   499,   501,
     509,   511,   520,   525,   526,   527,   533,   535,   542,   550,
     552,   553,   554,   557,   565,   566,   568,   578,   580,   581,
     587,   588,   589,   590,   598,   606,   607,   609,   616,   623,
     631,   640,   641,   642,   644,   653,   654,   655,   657,   665,
     666,   668,   674,   675,   676,   678,   685,   692,   699,   706,
     713,   721,   727,   728,   729,   731,   738,   746,   752,   753,
     754,   756,   763,   770,   778,   783,   784,   786,   793,   801,
     802,   804,   810,   818,   819,   822,   823,   824,   825,   826,
     828,   836,   844,   853,   861,   870,   877,   878,   879,   880,
     882,   893,   894
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
  "TRUE", "FALSE", "RETURN", "BREAK", "','", "';'", "':'", "'{'", "'('",
  "'['", "'}'", "')'", "']'", "AND", "OR", "NOT", "'<'", "'='", "'>'",
  "'*'", "'%'", "'/'", "'-'", "'+'", "$accept", "program",
  "declaration_list", "declaration", "var_declaration",
  "scoped_var_declaration", "var_decl_list", "var_decl_initialize",
  "var_decl_id", "type_specifier", "fun_declaration", "params",
  "param_list", "param_type_list", "param_id_list", "param_id",
  "statement_list", "statement", "ifmatched", "ifunmatched",
  "expression_stmt", "return_stmt", "expressionstmt", "compound_stmt",
  "local_declarations", "expression", "assignop", "simple_expression",
  "and_expression", "unary_rel_expression", "rel_expression", "relop",
  "sum_expression", "sumop", "term", "mulop", "unary_expression",
  "unaryop", "factor", "mutable", "immutable", "constant", "call", "args",
  "arg_list", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,    44,    59,
      58,   123,    40,    91,   125,    41,    93,   283,   284,   285,
      60,    61,    62,    42,    37,    47,    45,    43
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    48,    49,    50,    50,    50,    51,    51,    52,    52,
      53,    53,    53,    54,    54,    54,    54,    55,    55,    55,
      55,    56,    56,    56,    56,    57,    57,    57,    58,    58,
      58,    58,    58,    58,    59,    59,    60,    60,    60,    61,
      61,    62,    62,    62,    62,    63,    63,    63,    63,    64,
      64,    64,    65,    65,    65,    65,    66,    66,    66,    66,
      66,    66,    66,    66,    67,    67,    67,    67,    67,    67,
      67,    67,    67,    68,    68,    68,    68,    69,    69,    69,
      70,    70,    70,    71,    71,    71,    72,    72,    73,    73,
      73,    73,    73,    73,    73,    73,    73,    74,    74,    74,
      75,    75,    75,    75,    76,    76,    76,    76,    77,    77,
      77,    78,    78,    78,    78,    79,    79,    79,    79,    79,
      79,    80,    80,    80,    80,    81,    81,    82,    82,    82,
      82,    83,    83,    83,    84,    84,    84,    85,    85,    86,
      86,    87,    87,    87,    87,    88,    88,    88,    88,    88,
      89,    89,    89,    89,    89,    90,    90,    90,    91,    91,
      92,    92,    92
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     3,     3,
       4,     3,     3,     3,     1,     3,     3,     1,     3,     3,
       3,     1,     4,     3,     4,     1,     1,     1,     6,     5,
       6,     4,     5,     3,     1,     0,     3,     1,     3,     2,
       2,     3,     1,     3,     3,     1,     3,     4,     3,     2,
       0,     2,     1,     1,     2,     2,     7,     3,     5,     5,
       3,     7,     3,     1,     7,     5,     7,     3,     3,     5,
       3,     7,     3,     1,     1,     2,     1,     2,     3,     2,
       2,     1,     2,     4,     2,     4,     2,     0,     1,     3,
       3,     3,     3,     2,     2,     2,     2,     1,     1,     1,
       3,     1,     3,     3,     3,     1,     3,     3,     2,     1,
       2,     3,     1,     3,     3,     1,     1,     1,     1,     1,
       1,     3,     1,     3,     3,     1,     1,     3,     1,     3,
       3,     1,     1,     1,     2,     1,     2,     1,     1,     1,
       1,     1,     4,     3,     2,     1,     3,     1,     2,     2,
       1,     1,     1,     1,     1,     4,     4,     3,     1,     0,
       3,     1,     3
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     5,     0,    27,    25,    26,     0,     0,     4,     6,
       0,     7,     0,     0,     1,     0,     3,     0,    21,     0,
      14,    17,     0,   141,   151,   150,   152,     0,     0,     0,
     153,   154,     0,     0,    81,     0,     0,     0,   138,   137,
      33,     0,     0,    63,    74,    76,    73,     0,    88,   101,
     105,   109,   112,   122,   128,     0,   135,     0,   139,   147,
     145,     0,     0,     0,    34,    37,     0,     9,     0,     0,
       0,     0,     0,     0,     8,     0,    98,    99,    95,    96,
     119,   120,   117,   118,    82,     0,   144,    84,     0,     0,
       0,   115,    97,   116,   131,   133,   132,   126,   125,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    79,    77,
       0,    75,    50,    50,   148,     0,   110,   108,   140,    54,
      55,    80,     0,     0,     0,     0,     0,   136,   134,     0,
      93,    94,     0,     0,     0,    40,    45,    39,    42,     0,
       0,     0,    21,    15,     0,    19,     0,     0,     0,    31,
       0,    23,     0,    16,    13,    20,    18,     0,   161,     0,
     158,    68,     0,     0,   106,     0,   103,     0,    90,     0,
     113,     0,   123,     0,   129,   157,     0,   143,     0,    57,
       0,    60,     0,    62,   141,     0,   149,    78,     0,     0,
      86,     0,     0,   146,   102,   100,   107,   104,   114,   111,
     124,   121,   130,   127,    92,    91,    89,    38,    32,     0,
       0,     0,     0,    29,    36,     0,    24,     0,    22,     0,
     156,     0,     0,   155,   142,     0,     0,     0,    51,    85,
      49,     0,     0,     0,    83,     0,    43,     0,    48,    46,
      44,    41,    30,    28,   162,   160,     0,     0,     0,     0,
      58,     0,    65,     0,    59,    69,     0,     0,     0,    12,
      11,    47,     0,     0,     0,     0,     0,     0,     0,    10,
       0,    57,     0,    60,     0,    62,     0,     0,     0,     0,
       0,    66,    56,    64,    61,    71,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    67,     0,    70,     0,    72,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     6,     7,     8,     9,   190,    19,    20,    21,    62,
      11,    63,    64,    65,   137,   138,   188,   161,    41,    42,
      43,    44,    45,    46,   113,    47,    99,    48,    49,    50,
      51,   100,    52,   101,    53,   102,    54,    55,    56,    57,
      58,    59,    60,   159,   160
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -194
static const yytype_int16 yypact[] =
{
     166,    11,    35,  -194,  -194,  -194,   107,   119,  -194,  -194,
      16,  -194,   633,    27,  -194,    11,  -194,   178,   115,   186,
    -194,    69,  1363,   239,  -194,  -194,  -194,    80,   165,   170,
    -194,  -194,   741,    96,  -194,   525,   818,   823,  -194,  -194,
    -194,   453,   489,  -194,  -194,  -194,  -194,   131,   184,   167,
    -194,  -194,     5,   194,  -194,  1151,  -194,   128,  -194,  -194,
    -194,   155,    67,   189,   203,  -194,    90,  -194,   859,    59,
     240,    62,    30,    99,  -194,   864,  -194,  -194,  -194,  -194,
    -194,  -194,  -194,  -194,  -194,   777,  -194,  -194,   250,   900,
     905,  -194,  -194,  -194,  -194,  -194,  -194,  -194,  -194,   941,
    1187,  1192,  1228,   782,   946,   982,   987,   102,  1469,  -194,
     237,  -194,  -194,   263,  1469,   243,  1567,  -194,  -194,  -194,
    -194,  -194,  1023,  1028,  1233,  1269,  1274,    63,  -194,   941,
    -194,  -194,  1064,   296,   633,    -3,   247,   273,  -194,   633,
     296,    93,   287,  -194,  1510,   184,   304,   290,   302,   304,
     316,  -194,   317,    93,  -194,  1510,   184,  1453,  -194,   320,
     324,  -194,   345,  1567,  -194,  1526,   167,  1469,  -194,    -9,
     285,   198,   194,    63,  -194,  1453,   329,  1469,   318,  1510,
     108,  1510,   144,   332,   340,   356,  -194,  -194,   561,   296,
    -194,   103,   597,  -194,  1526,   167,  1567,  -194,    -9,   285,
     198,   194,    63,  -194,  -194,  1469,  -194,  -194,  -194,   117,
     365,    21,   138,  -194,  -194,   633,  -194,   633,  -194,   941,
    -194,   941,   669,  -194,  -194,   705,   633,   859,  1363,  -194,
    -194,   143,   188,   319,  -194,   347,  -194,   349,  -194,  -194,
     347,  -194,  -194,  -194,  -194,  -194,  1408,   351,   354,   355,
    -194,  1318,  -194,   381,  -194,  -194,   174,   216,   321,  -194,
    -194,  -194,   297,  1069,  1105,   150,    91,   633,   633,  -194,
     373,  1510,   210,  1510,   212,   332,   371,   366,   368,   377,
     379,  -194,  -194,  -194,  -194,  -194,   669,   669,   859,   633,
    1110,  1146,   185,   398,   235,  1510,   264,  1510,   265,   332,
     397,   669,   669,   705,    91,   859,   417,   278,    91,    91
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -194,  -194,  -194,   412,  -194,  -194,  -175,    79,  -194,     4,
    -194,   112,  -194,    45,  -194,   118,   308,   -12,   -67,  -193,
    -194,  -194,  -194,  -194,  -194,   -27,   369,   -65,   -61,   -30,
    -194,   370,   -82,   -46,   -81,   -51,   -47,  -194,  -194,   -36,
    -194,  -194,  -194,   322,  -194
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -160
static const yytype_int16 yytable[] =
{
      40,   118,   126,   145,    10,   110,   125,   117,   128,   115,
     156,    10,    80,    81,    82,    83,   233,    17,   170,   118,
     172,   162,   238,    85,    86,   209,   186,    18,    61,   166,
     210,   151,   118,   255,    94,    95,    96,    97,    98,   118,
     180,   182,   199,   152,   201,    91,    12,    93,     3,     4,
       5,    97,    98,   118,   118,   174,   258,   239,   158,   164,
     146,   195,   -35,   149,   118,   118,   118,    13,   135,   118,
     118,   185,   168,   281,   283,   285,   158,   178,   136,   203,
       3,     4,     5,     3,     4,     5,   118,   118,   118,   118,
     118,   141,   277,   197,   -35,    85,    86,   -35,   186,    75,
     153,   142,   204,   183,   232,   206,   278,    14,   279,   280,
     142,   255,   105,   184,   142,   283,   285,   191,   235,    -2,
      15,   126,   208,    68,   125,   111,    70,   213,   136,   129,
       2,    76,    77,   130,   131,  -140,  -140,  -140,  -140,   240,
       3,     4,     5,   225,   257,   143,   122,    71,    72,   136,
     126,   275,   154,   125,   142,   250,  -140,  -140,   253,   254,
     121,   184,   256,  -140,  -140,  -140,  -140,     1,  -140,    92,
    -140,  -140,  -140,  -140,  -140,  -140,   230,     2,   207,   226,
     230,   147,   122,   150,   133,   214,   299,     3,     4,     5,
     134,   118,   244,   231,   245,   270,   184,   106,   272,   274,
     282,   284,   107,   242,   123,   243,    66,    67,    68,   268,
      69,    70,   122,   252,    73,    74,    66,   259,    68,   293,
     254,    70,   122,   294,   139,   296,   298,   118,   118,   276,
      85,    86,   140,   186,   282,   284,   306,    94,    95,    96,
     307,    94,    95,    96,    66,   286,    68,   287,   122,    70,
     122,    22,   118,   148,   118,   118,   300,  -149,  -149,  -149,
    -149,    23,    24,    25,    26,    27,   187,    28,    29,   118,
     302,   103,   104,   122,    30,    31,    32,    33,   193,    34,
     211,    35,    36,   189,     3,     4,     5,  -149,  -149,    37,
    -149,   252,  -149,    38,  -149,  -149,    39,  -149,   246,   303,
     304,   212,   122,   122,  -149,  -149,  -149,  -149,    23,    24,
      25,    26,   247,   309,   248,   249,   122,     3,     4,     5,
      72,    30,    31,    32,    33,   215,    34,   236,    35,    36,
     241,    97,    98,   133,  -149,  -149,    37,  -149,   216,  -149,
      38,  -149,  -149,    39,  -149,   -52,   119,    73,   260,    73,
     269,   217,   221,   218,   224,   220,   -52,   -52,   -52,   -52,
     -52,   222,   -52,   -52,   223,    86,   -52,   -52,   -52,   -52,
     -52,   -52,   -52,   104,   -52,   227,   -52,   -52,   237,   -52,
     210,   -52,   119,   263,   -52,   261,   264,   265,   -52,   222,
     288,   -52,   -52,   -52,   -52,   -52,   -52,   267,   -52,   -52,
     290,   289,   -52,   -52,   -52,   -52,   -52,   -52,   -52,   291,
     -52,   292,   -52,   -52,   301,   -52,   305,   -52,   119,    16,
     -52,   192,   124,     0,   -52,   176,   132,   -52,   -52,   -52,
     -52,   -52,   -52,   308,   -52,   -52,     0,     0,   -52,   -52,
     -52,   -52,   -52,   -52,   -52,     0,   -52,     0,   -52,   -52,
       0,   -52,     0,   -52,   119,     0,   -52,     0,     0,     0,
     -52,     0,     0,   -52,   -52,   -52,   -52,   -52,   -52,     0,
     -52,   -52,     0,     0,   -52,   -52,   -52,   -52,   -52,   -52,
     -52,     0,   -52,     0,   -52,   -52,     0,   -52,     0,   -53,
     120,     0,   -52,     0,     0,     0,   -52,     0,     0,   -52,
     -53,   -53,   -53,   -53,   -53,     0,   -53,   -53,     0,     0,
     -53,   -53,   -53,   -53,   -53,   -53,   -53,     0,   -53,     0,
     -53,   -53,     0,   -53,     0,     0,   112,     0,   -53,     0,
       0,     0,   -53,     0,     0,   -53,   -87,   -87,   -87,   -87,
     -87,     0,   -87,   -87,     0,   -87,   -87,   -87,   -87,   -87,
     -87,   -87,   -87,     0,   -87,     0,   -87,   -87,     0,   -87,
       0,     0,   228,     0,   -87,     0,     0,     0,   -87,     0,
       0,   -87,    23,    24,    25,    26,    27,     0,    28,    29,
       0,     0,     0,     0,     0,    30,    31,    32,    33,     0,
      34,     0,    35,    36,     0,   229,     0,     0,   228,     0,
      37,     0,     0,     0,    38,     0,     0,    39,    23,    24,
      25,    26,    27,     0,    28,    29,     0,     0,     0,     0,
       0,    30,    31,    32,    33,     0,    34,     0,    35,    36,
       0,   234,     0,     0,    22,     0,    37,     0,     0,     0,
      38,     0,     0,    39,    23,    24,    25,    26,    27,     0,
      28,    29,     0,     0,     0,     0,     0,    30,    31,    32,
      33,     0,    34,     0,    35,    36,     0,     0,     0,     0,
     246,     0,    37,     0,     0,     0,    38,     0,     0,    39,
      23,    24,    25,    26,   247,     0,   248,   249,     0,     0,
       0,     0,     0,    30,    31,    32,    33,     0,    34,     0,
      35,    36,     0,     0,     0,     0,   251,     0,    37,     0,
       0,     0,    38,     0,     0,    39,    23,    24,    25,    26,
      27,     0,    28,    29,     0,     0,     0,     0,     0,    30,
      31,    32,    33,     0,    34,     0,    35,    36,     0,     0,
       0,     0,   108,     0,    37,     0,     0,     0,    38,     0,
       0,    39,    23,    24,    25,    26,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    30,    31,     0,     0,     0,
     109,     0,     0,    36,     0,     0,     0,     0,   157,     0,
      37,     0,     0,   175,    38,     0,     0,    39,    23,    24,
      25,    26,     0,    23,    24,    25,    26,     0,     0,     0,
       0,    30,    31,     0,     0,     0,    30,    31,     0,    36,
       0,     0,  -159,     0,    36,     0,    37,  -159,     0,   114,
      38,    37,     0,    39,   116,    38,     0,     0,    39,    23,
      24,    25,    26,     0,    23,    24,    25,    26,     0,     0,
       0,     0,    30,    31,     0,     0,     0,    30,    31,     0,
      36,     0,     0,     0,     0,    36,     0,    37,     0,     0,
     144,    38,    37,     0,    39,   155,    38,     0,     0,    39,
      23,    24,    25,    26,     0,    23,    24,    25,    26,     0,
       0,     0,     0,    30,    31,     0,     0,     0,    30,    31,
       0,    36,     0,     0,     0,     0,    36,     0,    37,     0,
       0,   163,    38,    37,     0,    39,   165,    38,     0,     0,
      39,    23,    24,    25,    26,     0,    23,    24,    25,    26,
       0,     0,     0,     0,    30,    31,     0,     0,     0,    30,
      31,     0,    36,     0,     0,     0,     0,    36,     0,    37,
       0,     0,   167,    38,    37,     0,    39,   177,    38,     0,
       0,    39,    23,    24,    25,    26,     0,    23,    24,    25,
      26,     0,     0,     0,     0,    30,    31,     0,     0,     0,
      30,    31,     0,    36,     0,     0,     0,     0,    36,     0,
      37,     0,     0,   179,    38,    37,     0,    39,   181,    38,
       0,     0,    39,    23,    24,    25,    26,     0,    23,    24,
      25,    26,     0,     0,     0,     0,    30,    31,     0,     0,
       0,    30,    31,     0,    36,     0,     0,     0,     0,    36,
       0,    37,     0,     0,   194,    38,    37,     0,    39,   196,
      38,     0,     0,    39,    23,    24,    25,    26,     0,    23,
      24,    25,    26,     0,     0,     0,     0,    30,    31,     0,
       0,     0,    30,    31,     0,    36,     0,     0,     0,     0,
      36,     0,    37,     0,     0,   205,    38,    37,     0,    39,
     271,    38,     0,     0,    39,    23,    24,    25,    26,     0,
      23,    24,    25,    26,     0,     0,     0,     0,    30,    31,
       0,     0,     0,    30,    31,     0,    36,     0,     0,     0,
       0,    36,     0,    37,     0,     0,   273,    38,    37,     0,
      39,   295,    38,     0,     0,    39,    23,    24,    25,    26,
       0,    23,    24,    25,    26,     0,     0,     0,     0,    30,
      31,     0,     0,     0,    30,    31,     0,    36,     0,     0,
       0,     0,    36,     0,    37,     0,     0,   297,    38,    37,
       0,    39,   127,    38,     0,     0,    39,    23,    24,    25,
      26,     0,    23,    24,    25,    26,     0,     0,     0,     0,
      30,    31,     0,     0,     0,    30,    31,     0,    36,     0,
       0,     0,     0,    36,     0,    37,     0,     0,   169,    38,
       0,     0,    39,   171,    38,     0,     0,    39,    23,    24,
      25,    26,     0,    23,    24,    25,    26,     0,     0,     0,
       0,    30,    31,     0,     0,     0,    30,    31,     0,    36,
       0,     0,     0,     0,    36,     0,     0,     0,     0,   173,
      38,     0,     0,    39,   198,    38,     0,     0,    39,    23,
      24,    25,    26,     0,    23,    24,    25,    26,     0,     0,
       0,     0,    30,    31,     0,     0,     0,    30,    31,     0,
      36,     0,     0,     0,     0,    36,     0,     0,     0,     0,
     200,    38,     0,     0,    39,   202,    38,     0,     0,    39,
      23,    24,    25,    26,     0,    23,    24,    25,    26,     0,
       0,     0,     0,    30,    31,     0,     0,     0,    30,    31,
       0,    36,     0,     0,     0,     0,    36,     0,     0,     0,
       0,     0,    38,     0,     0,    39,     0,    38,     0,     0,
      39,    76,    77,    78,    79,    80,    81,    82,    83,     0,
       0,     0,     0,     0,   266,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    84,     0,     0,
      85,    86,    87,    88,     0,    89,    90,     0,    91,    92,
      93,    94,    95,    96,    97,    98,    76,    77,    78,    79,
      80,    81,    82,    83,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    84,     0,     0,    85,    86,    87,    88,     0,
      89,    90,     0,    91,    92,    93,    94,    95,    96,    97,
      98,    76,    77,    78,    79,    80,    81,    82,    83,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,    84,     0,     0,
      85,    86,    87,   262,     0,    89,    90,     0,    91,    92,
      93,    94,    95,    96,    97,    98,    76,    77,    78,    79,
      80,    81,    82,    83,     0,     0,     0,     0,     0,     0,
       0,     0,    76,    77,    78,    79,    80,    81,    82,    83,
       0,   219,     0,     0,     0,    85,    86,     0,   186,     0,
      89,    90,     0,    91,    92,    93,    94,    95,    96,    97,
      98,    85,    86,     0,   186,     0,    89,    90,     0,    91,
      92,    93,    94,    95,    96,    97,    98,    80,    81,    82,
      83,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    80,    81,    82,    83,     0,     0,     0,
       0,     0,    85,    86,     0,   186,     0,    89,    90,     0,
      91,     0,    93,    94,    95,    96,    97,    98,    85,    86,
       0,   186,     0,    89,     0,     0,    91,     0,    93,    94,
      95,    96,    97,    98,    80,    81,    82,    83,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    85,
      86,     0,   186,     0,     0,     0,     0,    91,     0,    93,
      94,    95,    96,    97,    98
};

#define yypact_value_is_default(yystate) \
  ((yystate) == (-194))

#define yytable_value_is_error(yytable_value) \
  YYID (0)

static const yytype_int16 yycheck[] =
{
      12,    37,    53,    68,     0,    32,    52,    37,    55,    36,
      75,     7,     7,     8,     9,    10,   191,     1,   100,    55,
     101,    88,     1,    32,    33,    28,    35,    11,     1,    90,
      33,     1,    68,   226,    43,    44,    45,    46,    47,    75,
     105,   106,   124,    13,   125,    40,    35,    42,    21,    22,
      23,    46,    47,    89,    90,   102,   231,    36,    85,    89,
       1,   122,    35,     1,   100,   101,   102,    32,     1,   105,
     106,   107,    99,   266,   267,   268,   103,   104,    11,   126,
      21,    22,    23,    21,    22,    23,   122,   123,   124,   125,
     126,     1,     1,   123,    35,    32,    33,    35,    35,    30,
       1,    11,   129,     1,     1,   132,    15,     0,    17,    18,
      11,   304,    32,    11,    11,   308,   309,   113,     1,     0,
       1,   172,   134,    30,   170,    29,    33,   139,    11,     1,
      11,     3,     4,     5,     6,     7,     8,     9,    10,     1,
      21,    22,    23,    35,     1,    66,    38,    32,    33,    11,
     201,     1,    73,   199,    11,   222,    28,    29,   225,   226,
      29,    11,   227,    35,    36,    37,    38,     1,    40,    41,
      42,    43,    44,    45,    46,    47,   188,    11,   133,    35,
     192,    69,    38,    71,    29,   140,     1,    21,    22,    23,
      35,   227,   219,   189,   221,   262,    11,    32,   263,   264,
     267,   268,    32,   215,    37,   217,    28,    29,    30,    35,
      32,    33,    38,   225,    28,    29,    28,    29,    30,   286,
     287,    33,    38,   288,    35,   290,   291,   263,   264,   265,
      32,    33,    29,    35,   301,   302,   303,    43,    44,    45,
     305,    43,    44,    45,    28,    35,    30,    35,    38,    33,
      38,     1,   288,    13,   290,   291,   292,     7,     8,     9,
      10,    11,    12,    13,    14,    15,    29,    17,    18,   305,
      35,    32,    33,    38,    24,    25,    26,    27,    35,    29,
      33,    31,    32,    20,    21,    22,    23,    37,    38,    39,
      40,   303,    42,    43,    44,    45,    46,    47,     1,    35,
      35,    28,    38,    38,     7,     8,     9,    10,    11,    12,
      13,    14,    15,    35,    17,    18,    38,    21,    22,    23,
      33,    24,    25,    26,    27,    35,    29,   209,    31,    32,
     212,    46,    47,    29,    37,    38,    39,    40,    36,    42,
      43,    44,    45,    46,    47,     0,     1,    28,    29,    28,
      29,    35,    28,    36,    36,    35,    11,    12,    13,    14,
      15,    16,    17,    18,    35,    33,    21,    22,    23,    24,
      25,    26,    27,    33,    29,    19,    31,    32,    13,    34,
      33,     0,     1,    32,    39,    36,    32,    32,    43,    16,
      19,    46,    11,    12,    13,    14,    15,    16,    17,    18,
      32,    35,    21,    22,    23,    24,    25,    26,    27,    32,
      29,    32,    31,    32,    16,    34,    19,     0,     1,     7,
      39,   113,    52,    -1,    43,   103,    57,    46,    11,    12,
      13,    14,    15,    16,    17,    18,    -1,    -1,    21,    22,
      23,    24,    25,    26,    27,    -1,    29,    -1,    31,    32,
      -1,    34,    -1,     0,     1,    -1,    39,    -1,    -1,    -1,
      43,    -1,    -1,    46,    11,    12,    13,    14,    15,    -1,
      17,    18,    -1,    -1,    21,    22,    23,    24,    25,    26,
      27,    -1,    29,    -1,    31,    32,    -1,    34,    -1,     0,
       1,    -1,    39,    -1,    -1,    -1,    43,    -1,    -1,    46,
      11,    12,    13,    14,    15,    -1,    17,    18,    -1,    -1,
      21,    22,    23,    24,    25,    26,    27,    -1,    29,    -1,
      31,    32,    -1,    34,    -1,    -1,     1,    -1,    39,    -1,
      -1,    -1,    43,    -1,    -1,    46,    11,    12,    13,    14,
      15,    -1,    17,    18,    -1,    20,    21,    22,    23,    24,
      25,    26,    27,    -1,    29,    -1,    31,    32,    -1,    34,
      -1,    -1,     1,    -1,    39,    -1,    -1,    -1,    43,    -1,
      -1,    46,    11,    12,    13,    14,    15,    -1,    17,    18,
      -1,    -1,    -1,    -1,    -1,    24,    25,    26,    27,    -1,
      29,    -1,    31,    32,    -1,    34,    -1,    -1,     1,    -1,
      39,    -1,    -1,    -1,    43,    -1,    -1,    46,    11,    12,
      13,    14,    15,    -1,    17,    18,    -1,    -1,    -1,    -1,
      -1,    24,    25,    26,    27,    -1,    29,    -1,    31,    32,
      -1,    34,    -1,    -1,     1,    -1,    39,    -1,    -1,    -1,
      43,    -1,    -1,    46,    11,    12,    13,    14,    15,    -1,
      17,    18,    -1,    -1,    -1,    -1,    -1,    24,    25,    26,
      27,    -1,    29,    -1,    31,    32,    -1,    -1,    -1,    -1,
       1,    -1,    39,    -1,    -1,    -1,    43,    -1,    -1,    46,
      11,    12,    13,    14,    15,    -1,    17,    18,    -1,    -1,
      -1,    -1,    -1,    24,    25,    26,    27,    -1,    29,    -1,
      31,    32,    -1,    -1,    -1,    -1,     1,    -1,    39,    -1,
      -1,    -1,    43,    -1,    -1,    46,    11,    12,    13,    14,
      15,    -1,    17,    18,    -1,    -1,    -1,    -1,    -1,    24,
      25,    26,    27,    -1,    29,    -1,    31,    32,    -1,    -1,
      -1,    -1,     1,    -1,    39,    -1,    -1,    -1,    43,    -1,
      -1,    46,    11,    12,    13,    14,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    24,    25,    -1,    -1,    -1,
      29,    -1,    -1,    32,    -1,    -1,    -1,    -1,     1,    -1,
      39,    -1,    -1,     1,    43,    -1,    -1,    46,    11,    12,
      13,    14,    -1,    11,    12,    13,    14,    -1,    -1,    -1,
      -1,    24,    25,    -1,    -1,    -1,    24,    25,    -1,    32,
      -1,    -1,    35,    -1,    32,    -1,    39,    35,    -1,     1,
      43,    39,    -1,    46,     1,    43,    -1,    -1,    46,    11,
      12,    13,    14,    -1,    11,    12,    13,    14,    -1,    -1,
      -1,    -1,    24,    25,    -1,    -1,    -1,    24,    25,    -1,
      32,    -1,    -1,    -1,    -1,    32,    -1,    39,    -1,    -1,
       1,    43,    39,    -1,    46,     1,    43,    -1,    -1,    46,
      11,    12,    13,    14,    -1,    11,    12,    13,    14,    -1,
      -1,    -1,    -1,    24,    25,    -1,    -1,    -1,    24,    25,
      -1,    32,    -1,    -1,    -1,    -1,    32,    -1,    39,    -1,
      -1,     1,    43,    39,    -1,    46,     1,    43,    -1,    -1,
      46,    11,    12,    13,    14,    -1,    11,    12,    13,    14,
      -1,    -1,    -1,    -1,    24,    25,    -1,    -1,    -1,    24,
      25,    -1,    32,    -1,    -1,    -1,    -1,    32,    -1,    39,
      -1,    -1,     1,    43,    39,    -1,    46,     1,    43,    -1,
      -1,    46,    11,    12,    13,    14,    -1,    11,    12,    13,
      14,    -1,    -1,    -1,    -1,    24,    25,    -1,    -1,    -1,
      24,    25,    -1,    32,    -1,    -1,    -1,    -1,    32,    -1,
      39,    -1,    -1,     1,    43,    39,    -1,    46,     1,    43,
      -1,    -1,    46,    11,    12,    13,    14,    -1,    11,    12,
      13,    14,    -1,    -1,    -1,    -1,    24,    25,    -1,    -1,
      -1,    24,    25,    -1,    32,    -1,    -1,    -1,    -1,    32,
      -1,    39,    -1,    -1,     1,    43,    39,    -1,    46,     1,
      43,    -1,    -1,    46,    11,    12,    13,    14,    -1,    11,
      12,    13,    14,    -1,    -1,    -1,    -1,    24,    25,    -1,
      -1,    -1,    24,    25,    -1,    32,    -1,    -1,    -1,    -1,
      32,    -1,    39,    -1,    -1,     1,    43,    39,    -1,    46,
       1,    43,    -1,    -1,    46,    11,    12,    13,    14,    -1,
      11,    12,    13,    14,    -1,    -1,    -1,    -1,    24,    25,
      -1,    -1,    -1,    24,    25,    -1,    32,    -1,    -1,    -1,
      -1,    32,    -1,    39,    -1,    -1,     1,    43,    39,    -1,
      46,     1,    43,    -1,    -1,    46,    11,    12,    13,    14,
      -1,    11,    12,    13,    14,    -1,    -1,    -1,    -1,    24,
      25,    -1,    -1,    -1,    24,    25,    -1,    32,    -1,    -1,
      -1,    -1,    32,    -1,    39,    -1,    -1,     1,    43,    39,
      -1,    46,     1,    43,    -1,    -1,    46,    11,    12,    13,
      14,    -1,    11,    12,    13,    14,    -1,    -1,    -1,    -1,
      24,    25,    -1,    -1,    -1,    24,    25,    -1,    32,    -1,
      -1,    -1,    -1,    32,    -1,    39,    -1,    -1,     1,    43,
      -1,    -1,    46,     1,    43,    -1,    -1,    46,    11,    12,
      13,    14,    -1,    11,    12,    13,    14,    -1,    -1,    -1,
      -1,    24,    25,    -1,    -1,    -1,    24,    25,    -1,    32,
      -1,    -1,    -1,    -1,    32,    -1,    -1,    -1,    -1,     1,
      43,    -1,    -1,    46,     1,    43,    -1,    -1,    46,    11,
      12,    13,    14,    -1,    11,    12,    13,    14,    -1,    -1,
      -1,    -1,    24,    25,    -1,    -1,    -1,    24,    25,    -1,
      32,    -1,    -1,    -1,    -1,    32,    -1,    -1,    -1,    -1,
       1,    43,    -1,    -1,    46,     1,    43,    -1,    -1,    46,
      11,    12,    13,    14,    -1,    11,    12,    13,    14,    -1,
      -1,    -1,    -1,    24,    25,    -1,    -1,    -1,    24,    25,
      -1,    32,    -1,    -1,    -1,    -1,    32,    -1,    -1,    -1,
      -1,    -1,    43,    -1,    -1,    46,    -1,    43,    -1,    -1,
      46,     3,     4,     5,     6,     7,     8,     9,    10,    -1,
      -1,    -1,    -1,    -1,    16,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    29,    -1,    -1,
      32,    33,    34,    35,    -1,    37,    38,    -1,    40,    41,
      42,    43,    44,    45,    46,    47,     3,     4,     5,     6,
       7,     8,     9,    10,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    29,    -1,    -1,    32,    33,    34,    35,    -1,
      37,    38,    -1,    40,    41,    42,    43,    44,    45,    46,
      47,     3,     4,     5,     6,     7,     8,     9,    10,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    29,    -1,    -1,
      32,    33,    34,    35,    -1,    37,    38,    -1,    40,    41,
      42,    43,    44,    45,    46,    47,     3,     4,     5,     6,
       7,     8,     9,    10,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,     3,     4,     5,     6,     7,     8,     9,    10,
      -1,    28,    -1,    -1,    -1,    32,    33,    -1,    35,    -1,
      37,    38,    -1,    40,    41,    42,    43,    44,    45,    46,
      47,    32,    33,    -1,    35,    -1,    37,    38,    -1,    40,
      41,    42,    43,    44,    45,    46,    47,     7,     8,     9,
      10,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,     7,     8,     9,    10,    -1,    -1,    -1,
      -1,    -1,    32,    33,    -1,    35,    -1,    37,    38,    -1,
      40,    -1,    42,    43,    44,    45,    46,    47,    32,    33,
      -1,    35,    -1,    37,    -1,    -1,    40,    -1,    42,    43,
      44,    45,    46,    47,     7,     8,     9,    10,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    32,
      33,    -1,    35,    -1,    -1,    -1,    -1,    40,    -1,    42,
      43,    44,    45,    46,    47
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     1,    11,    21,    22,    23,    49,    50,    51,    52,
      57,    58,    35,    32,     0,     1,    51,     1,    11,    54,
      55,    56,     1,    11,    12,    13,    14,    15,    17,    18,
      24,    25,    26,    27,    29,    31,    32,    39,    43,    46,
      65,    66,    67,    68,    69,    70,    71,    73,    75,    76,
      77,    78,    80,    82,    84,    85,    86,    87,    88,    89,
      90,     1,    57,    59,    60,    61,    28,    29,    30,    32,
      33,    32,    33,    28,    29,    30,     3,     4,     5,     6,
       7,     8,     9,    10,    29,    32,    33,    34,    35,    37,
      38,    40,    41,    42,    43,    44,    45,    46,    47,    74,
      79,    81,    83,    32,    33,    32,    32,    32,     1,    29,
      73,    29,     1,    72,     1,    73,     1,    77,    87,     1,
       1,    29,    38,    37,    79,    81,    83,     1,    84,     1,
       5,     6,    74,    29,    35,     1,    11,    62,    63,    35,
      29,     1,    11,    55,     1,    75,     1,    59,    13,     1,
      59,     1,    13,     1,    55,     1,    75,     1,    73,    91,
      92,    65,    66,     1,    77,     1,    76,     1,    73,     1,
      80,     1,    82,     1,    84,     1,    91,     1,    73,     1,
      75,     1,    75,     1,    11,    87,    35,    29,    64,    20,
      53,    57,    64,    35,     1,    76,     1,    77,     1,    80,
       1,    82,     1,    84,    73,     1,    73,    61,    65,    28,
      33,    33,    28,    65,    61,    35,    36,    35,    36,    28,
      35,    28,    16,    35,    36,    35,    35,    19,     1,    34,
      65,    57,     1,    54,    34,     1,    63,    13,     1,    36,
       1,    63,    65,    65,    73,    73,     1,    15,    17,    18,
      66,     1,    65,    66,    66,    67,    75,     1,    54,    29,
      29,    36,    35,    32,    32,    32,    16,    16,    35,    29,
      66,     1,    75,     1,    75,     1,    87,     1,    15,    17,
      18,    67,    66,    67,    66,    67,    35,    35,    19,    35,
      32,    32,    32,    66,    75,     1,    75,     1,    75,     1,
      87,    16,    35,    35,    35,    19,    66,    75,    16,    35
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
#line 106 "c-.y"
    { savedTree = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 3:

/* Line 1806 of yacc.c  */
#line 109 "c-.y"
    {
		   TreeNode* t = (yyvsp[(1) - (2)].nodeptr);
		   if ((yyvsp[(2) - (2)].nodeptr) == NULL)
		     (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr);
		   else {
		     if (t != NULL) {
		       if (t->sibling != NULL) 
			 t = t->sibling;
		       t->sibling = (yyvsp[(2) - (2)].nodeptr);
		       (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr);
		     } else
		       (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr); 
		   }
		 }
    break;

  case 4:

/* Line 1806 of yacc.c  */
#line 123 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 5:

/* Line 1806 of yacc.c  */
#line 124 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 6:

/* Line 1806 of yacc.c  */
#line 126 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 7:

/* Line 1806 of yacc.c  */
#line 127 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 8:

/* Line 1806 of yacc.c  */
#line 130 "c-.y"
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
		  yyerrok;
		}
    break;

  case 9:

/* Line 1806 of yacc.c  */
#line 142 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 10:

/* Line 1806 of yacc.c  */
#line 166 "c-.y"
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
			 yyerrok;
		       }
    break;

  case 11:

/* Line 1806 of yacc.c  */
#line 181 "c-.y"
    { 
			 TreeNode* t = (yyvsp[(2) - (3)].nodeptr);
			 if (t != NULL){
			   t->expType = (yyvsp[(1) - (3)].type);
			   t->isStatic = true;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = (yyvsp[(1) - (3)].type);
			     t->isStatic = true;
			   }
			 }
			 (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
			 yyerrok;
		       }
    break;

  case 12:

/* Line 1806 of yacc.c  */
#line 195 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 13:

/* Line 1806 of yacc.c  */
#line 199 "c-.y"
    {
		TreeNode* t = (yyvsp[(1) - (3)].nodeptr);
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = (yyvsp[(3) - (3)].nodeptr);
		  (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
		} else
		  (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
		yyerrok;
	      }
    break;

  case 14:

/* Line 1806 of yacc.c  */
#line 209 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 15:

/* Line 1806 of yacc.c  */
#line 210 "c-.y"
    {(yyval.nodeptr)=NULL;  yyerrok;}
    break;

  case 16:

/* Line 1806 of yacc.c  */
#line 211 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 17:

/* Line 1806 of yacc.c  */
#line 248 "c-.y"
    {(yyval.nodeptr)=(yyvsp[(1) - (1)].nodeptr);}
    break;

  case 18:

/* Line 1806 of yacc.c  */
#line 250 "c-.y"
    {
		      (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
		      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (3)].nodeptr);
		    }
    break;

  case 19:

/* Line 1806 of yacc.c  */
#line 254 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 20:

/* Line 1806 of yacc.c  */
#line 255 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 21:

/* Line 1806 of yacc.c  */
#line 258 "c-.y"
    {
	      (yyval.nodeptr) = newDeclNode(VarK);
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	      (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    }
    break;

  case 22:

/* Line 1806 of yacc.c  */
#line 264 "c-.y"
    {
	      (yyval.nodeptr) = newDeclNode(VarK);
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
	      (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
	      (yyval.nodeptr)->isArray = true;
	    }
    break;

  case 23:

/* Line 1806 of yacc.c  */
#line 270 "c-.y"
    {(yyval.nodeptr)=NULL; }
    break;

  case 24:

/* Line 1806 of yacc.c  */
#line 271 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 25:

/* Line 1806 of yacc.c  */
#line 273 "c-.y"
    { (yyval.type) = Boolean; }
    break;

  case 26:

/* Line 1806 of yacc.c  */
#line 274 "c-.y"
    { (yyval.type) = Character; }
    break;

  case 27:

/* Line 1806 of yacc.c  */
#line 275 "c-.y"
    { (yyval.type) = Integer; }
    break;

  case 28:

/* Line 1806 of yacc.c  */
#line 288 "c-.y"
    {
		  TreeNode* t = newDeclNode(FuncK); 
		  t->string = (yyvsp[(2) - (6)].tokenData)->tokenstr;
		  t->linnum = (yyvsp[(2) - (6)].tokenData)->linnum;
		  t->expType = (yyvsp[(1) - (6)].type);
		  (yyval.nodeptr) = t;
		  (yyval.nodeptr)->child[0] = (yyvsp[(4) - (6)].nodeptr);
		  (yyval.nodeptr)->child[1] = (yyvsp[(6) - (6)].nodeptr);
		  //yyerrok;
		}
    break;

  case 29:

/* Line 1806 of yacc.c  */
#line 299 "c-.y"
    {
		  TreeNode* t = newDeclNode(FuncK);
		  t->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
		  t->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
		  t->expType = Void;  // 0
		  (yyval.nodeptr) = t;
		  (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
		  (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
		}
    break;

  case 30:

/* Line 1806 of yacc.c  */
#line 308 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 31:

/* Line 1806 of yacc.c  */
#line 309 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 32:

/* Line 1806 of yacc.c  */
#line 310 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 33:

/* Line 1806 of yacc.c  */
#line 311 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 34:

/* Line 1806 of yacc.c  */
#line 353 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 35:

/* Line 1806 of yacc.c  */
#line 354 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 36:

/* Line 1806 of yacc.c  */
#line 357 "c-.y"
    {
	     TreeNode* t = (yyvsp[(1) - (3)].nodeptr);
	     if (t) {
	       if (t->sibling != NULL)   //segmentation fault here
		 t = t->sibling;
	       t->sibling = (yyvsp[(3) - (3)].nodeptr);
	       (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
	     } else 
	       (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
	     //yyerrok;  help help
	   }
    break;

  case 37:

/* Line 1806 of yacc.c  */
#line 368 "c-.y"
    {(yyval.nodeptr)=(yyvsp[(1) - (1)].nodeptr); yyerrok;}
    break;

  case 38:

/* Line 1806 of yacc.c  */
#line 370 "c-.y"
    {(yyval.nodeptr)=(yyvsp[(3) - (3)].nodeptr); yyerrok;}
    break;

  case 39:

/* Line 1806 of yacc.c  */
#line 373 "c-.y"
    {
		  TreeNode* v = (yyvsp[(2) - (2)].nodeptr);
		  if (v != NULL){
		    v->expType = (yyvsp[(1) - (2)].type);
		    while (v->sibling != NULL) {
		    //if (v->sibling != NULL) {
		      v = v->sibling;
		      v->expType = (yyvsp[(1) - (2)].type);
		    }
		    (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr); 
		  } 
		}
    break;

  case 40:

/* Line 1806 of yacc.c  */
#line 385 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 41:

/* Line 1806 of yacc.c  */
#line 388 "c-.y"
    {
		TreeNode* t = (yyvsp[(1) - (3)].nodeptr);
		//if ($3) {
		if (t){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = (yyvsp[(3) - (3)].nodeptr);
		  (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
		} else
		  (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
		//} else $$ = $1;
		yyerrok;
	      }
    break;

  case 42:

/* Line 1806 of yacc.c  */
#line 400 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 43:

/* Line 1806 of yacc.c  */
#line 401 "c-.y"
    {(yyval.nodeptr)=(yyvsp[(3) - (3)].nodeptr); yyerrok;}
    break;

  case 44:

/* Line 1806 of yacc.c  */
#line 402 "c-.y"
    {(yyval.nodeptr)=(yyvsp[(1) - (3)].nodeptr); yyerrok;}
    break;

  case 45:

/* Line 1806 of yacc.c  */
#line 405 "c-.y"
    {
	   (yyval.nodeptr) = newDeclNode(ParamK);
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	 }
    break;

  case 46:

/* Line 1806 of yacc.c  */
#line 411 "c-.y"
    {
	   (yyval.nodeptr) = newDeclNode(ParamK);
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (3)].tokenData)->tokenstr;
	   (yyval.nodeptr)->isArray = true;
	 }
    break;

  case 47:

/* Line 1806 of yacc.c  */
#line 417 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 48:

/* Line 1806 of yacc.c  */
#line 418 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 49:

/* Line 1806 of yacc.c  */
#line 426 "c-.y"
    {
		 TreeNode* t = (yyvsp[(1) - (2)].nodeptr);
		 if (t != NULL){
		   while (t->sibling != NULL) t = t->sibling;
		   t->sibling = (yyvsp[(2) - (2)].nodeptr);
		   (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr);
		 } else
		   (yyval.nodeptr) = (yyvsp[(2) - (2)].nodeptr);
		 //yyerrok;
	       }
    break;

  case 50:

/* Line 1806 of yacc.c  */
#line 436 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 51:

/* Line 1806 of yacc.c  */
#line 437 "c-.y"
    {(yyval.nodeptr) = NULL; }
    break;

  case 52:

/* Line 1806 of yacc.c  */
#line 439 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 53:

/* Line 1806 of yacc.c  */
#line 440 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 54:

/* Line 1806 of yacc.c  */
#line 441 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); }
    break;

  case 55:

/* Line 1806 of yacc.c  */
#line 442 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); }
    break;

  case 56:

/* Line 1806 of yacc.c  */
#line 445 "c-.y"
    { 
	    (yyval.nodeptr) = newStmtNode(IfK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	    (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	    (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	    (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	  }
    break;

  case 57:

/* Line 1806 of yacc.c  */
#line 453 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 58:

/* Line 1806 of yacc.c  */
#line 454 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 59:

/* Line 1806 of yacc.c  */
#line 457 "c-.y"
    { 
	    (yyval.nodeptr) = newStmtNode(WhileK);
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	    (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	    (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	    (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	  }
    break;

  case 60:

/* Line 1806 of yacc.c  */
#line 464 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 61:

/* Line 1806 of yacc.c  */
#line 467 "c-.y"
    { 
	    (yyval.nodeptr) = newStmtNode(ForEachK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	    (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	    (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	    (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	  }
    break;

  case 62:

/* Line 1806 of yacc.c  */
#line 475 "c-.y"
    {(yyval.nodeptr)=NULL; }
    break;

  case 63:

/* Line 1806 of yacc.c  */
#line 476 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 64:

/* Line 1806 of yacc.c  */
#line 479 "c-.y"
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

  case 65:

/* Line 1806 of yacc.c  */
#line 489 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(IfK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	    }
    break;

  case 66:

/* Line 1806 of yacc.c  */
#line 496 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 67:

/* Line 1806 of yacc.c  */
#line 497 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 68:

/* Line 1806 of yacc.c  */
#line 499 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 69:

/* Line 1806 of yacc.c  */
#line 502 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(WhileK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	    }
    break;

  case 70:

/* Line 1806 of yacc.c  */
#line 509 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 71:

/* Line 1806 of yacc.c  */
#line 512 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(ForEachK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (7)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (7)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (7)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (7)].nodeptr);
	      (yyval.nodeptr)->child[2] = (yyvsp[(7) - (7)].nodeptr);
	    }
    break;

  case 72:

/* Line 1806 of yacc.c  */
#line 520 "c-.y"
    {(yyval.nodeptr)=NULL; }
    break;

  case 73:

/* Line 1806 of yacc.c  */
#line 525 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 74:

/* Line 1806 of yacc.c  */
#line 526 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 75:

/* Line 1806 of yacc.c  */
#line 528 "c-.y"
    {
		 (yyval.nodeptr) = newStmtNode(BreakK);
		 (yyval.nodeptr)->string = (yyvsp[(1) - (2)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum;
	       }
    break;

  case 76:

/* Line 1806 of yacc.c  */
#line 533 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr);}
    break;

  case 77:

/* Line 1806 of yacc.c  */
#line 536 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(ReturnK);
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum;
		(yyval.nodeptr)->expType = Void;
		yyerrok;
	      }
    break;

  case 78:

/* Line 1806 of yacc.c  */
#line 543 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(ReturnK);
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
		(yyval.nodeptr)->child[0] = (yyvsp[(2) - (3)].nodeptr);
		(yyval.nodeptr)->expType = (yyvsp[(2) - (3)].nodeptr)->expType; 
		yyerrok;
	      }
    break;

  case 79:

/* Line 1806 of yacc.c  */
#line 550 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 80:

/* Line 1806 of yacc.c  */
#line 552 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); yyerrok;}
    break;

  case 81:

/* Line 1806 of yacc.c  */
#line 553 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok;}
    break;

  case 82:

/* Line 1806 of yacc.c  */
#line 554 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok;}
    break;

  case 83:

/* Line 1806 of yacc.c  */
#line 558 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(CompoundK);
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
		(yyval.nodeptr)->child[0] = (yyvsp[(2) - (4)].nodeptr);
		(yyval.nodeptr)->child[1] = (yyvsp[(3) - (4)].nodeptr);
		yyerrok;
	      }
    break;

  case 84:

/* Line 1806 of yacc.c  */
#line 565 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 85:

/* Line 1806 of yacc.c  */
#line 566 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 86:

/* Line 1806 of yacc.c  */
#line 569 "c-.y"
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

  case 87:

/* Line 1806 of yacc.c  */
#line 578 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 88:

/* Line 1806 of yacc.c  */
#line 580 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 89:

/* Line 1806 of yacc.c  */
#line 582 "c-.y"
    {
	     (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr); 
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
	     (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	   }
    break;

  case 90:

/* Line 1806 of yacc.c  */
#line 587 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 91:

/* Line 1806 of yacc.c  */
#line 588 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 92:

/* Line 1806 of yacc.c  */
#line 589 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 93:

/* Line 1806 of yacc.c  */
#line 591 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK); 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (2)].tokenData)->tokenClass;
	     (yyval.nodeptr)->string = (yyvsp[(2) - (2)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (2)].tokenData)->linnum; 
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (2)].nodeptr);
	   }
    break;

  case 94:

/* Line 1806 of yacc.c  */
#line 599 "c-.y"
    {
	     (yyval.nodeptr) = newExpNode(AssignK); 
	     (yyval.nodeptr)->attr.op = (yyvsp[(2) - (2)].tokenData)->tokenClass;
	     (yyval.nodeptr)->string = (yyvsp[(2) - (2)].tokenData)->tokenstr;
	     (yyval.nodeptr)->linnum = (yyvsp[(2) - (2)].tokenData)->linnum; 
	     (yyval.nodeptr)->child[0] = (yyvsp[(1) - (2)].nodeptr);
	   }
    break;

  case 95:

/* Line 1806 of yacc.c  */
#line 606 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 96:

/* Line 1806 of yacc.c  */
#line 607 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 97:

/* Line 1806 of yacc.c  */
#line 610 "c-.y"
    {
	   (yyval.nodeptr) = newExpNode(AssignK); 
	   (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	 }
    break;

  case 98:

/* Line 1806 of yacc.c  */
#line 617 "c-.y"
    {
	   (yyval.nodeptr) = newExpNode(AssignK); 
	   (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	 }
    break;

  case 99:

/* Line 1806 of yacc.c  */
#line 624 "c-.y"
    {
	   (yyval.nodeptr) = newExpNode(AssignK); 
	   (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	 }
    break;

  case 100:

/* Line 1806 of yacc.c  */
#line 632 "c-.y"
    {
		    (yyval.nodeptr) = newExpNode(OpK); 
		    (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		    (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		    (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		    (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		    (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
		  }
    break;

  case 101:

/* Line 1806 of yacc.c  */
#line 640 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 102:

/* Line 1806 of yacc.c  */
#line 641 "c-.y"
    { (yyval.nodeptr)=NULL; }
    break;

  case 103:

/* Line 1806 of yacc.c  */
#line 642 "c-.y"
    { (yyval.nodeptr)=NULL; yyerrok; }
    break;

  case 104:

/* Line 1806 of yacc.c  */
#line 645 "c-.y"
    {
		 (yyval.nodeptr) = newExpNode(OpK); 
		 (yyval.nodeptr)->attr.op = (yyvsp[(2) - (3)].tokenData)->tokenClass;
		 (yyval.nodeptr)->string = (yyvsp[(2) - (3)].tokenData)->tokenstr;
		 (yyval.nodeptr)->linnum = (yyvsp[(2) - (3)].tokenData)->linnum; 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 105:

/* Line 1806 of yacc.c  */
#line 653 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 106:

/* Line 1806 of yacc.c  */
#line 654 "c-.y"
    { (yyval.nodeptr)=NULL; yyerrok; }
    break;

  case 107:

/* Line 1806 of yacc.c  */
#line 655 "c-.y"
    { (yyval.nodeptr)=NULL; }
    break;

  case 108:

/* Line 1806 of yacc.c  */
#line 658 "c-.y"
    { 
		       (yyval.nodeptr) = newExpNode(OpK);
		       (yyval.nodeptr)->attr.op = (yyvsp[(1) - (2)].tokenData)->tokenClass;
		       (yyval.nodeptr)->string = (yyvsp[(1) - (2)].tokenData)->tokenstr;
		       (yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum; 
		       (yyval.nodeptr)->child[0] = (yyvsp[(2) - (2)].nodeptr);
		     }
    break;

  case 109:

/* Line 1806 of yacc.c  */
#line 665 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 110:

/* Line 1806 of yacc.c  */
#line 666 "c-.y"
    { (yyval.nodeptr)=NULL; }
    break;

  case 111:

/* Line 1806 of yacc.c  */
#line 669 "c-.y"
    {
		 (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 112:

/* Line 1806 of yacc.c  */
#line 674 "c-.y"
    {(yyval.nodeptr)=(yyvsp[(1) - (1)].nodeptr);}
    break;

  case 113:

/* Line 1806 of yacc.c  */
#line 675 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 114:

/* Line 1806 of yacc.c  */
#line 676 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 115:

/* Line 1806 of yacc.c  */
#line 679 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 116:

/* Line 1806 of yacc.c  */
#line 686 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 117:

/* Line 1806 of yacc.c  */
#line 693 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 118:

/* Line 1806 of yacc.c  */
#line 700 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 119:

/* Line 1806 of yacc.c  */
#line 707 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 120:

/* Line 1806 of yacc.c  */
#line 714 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 121:

/* Line 1806 of yacc.c  */
#line 722 "c-.y"
    {
		 (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr); 
		 (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
		 (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
	       }
    break;

  case 122:

/* Line 1806 of yacc.c  */
#line 727 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 123:

/* Line 1806 of yacc.c  */
#line 728 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 124:

/* Line 1806 of yacc.c  */
#line 729 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 125:

/* Line 1806 of yacc.c  */
#line 732 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
      }
    break;

  case 126:

/* Line 1806 of yacc.c  */
#line 739 "c-.y"
    {
	(yyval.nodeptr) = newExpNode(OpK);
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
      }
    break;

  case 127:

/* Line 1806 of yacc.c  */
#line 747 "c-.y"
    {
       (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
       (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
       (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
     }
    break;

  case 128:

/* Line 1806 of yacc.c  */
#line 752 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 129:

/* Line 1806 of yacc.c  */
#line 753 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 130:

/* Line 1806 of yacc.c  */
#line 754 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 131:

/* Line 1806 of yacc.c  */
#line 757 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 132:

/* Line 1806 of yacc.c  */
#line 764 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 133:

/* Line 1806 of yacc.c  */
#line 771 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 134:

/* Line 1806 of yacc.c  */
#line 779 "c-.y"
    {
		   (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); 
		   (yyval.nodeptr)->child[0] = (yyvsp[(2) - (2)].nodeptr);
		 }
    break;

  case 135:

/* Line 1806 of yacc.c  */
#line 783 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 136:

/* Line 1806 of yacc.c  */
#line 784 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 137:

/* Line 1806 of yacc.c  */
#line 787 "c-.y"
    { 
	  (yyval.nodeptr) = newExpNode(OpK); 
	  (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	}
    break;

  case 138:

/* Line 1806 of yacc.c  */
#line 794 "c-.y"
    { 
	  (yyval.nodeptr) = newExpNode(OpK); 
	  (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	}
    break;

  case 139:

/* Line 1806 of yacc.c  */
#line 801 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 140:

/* Line 1806 of yacc.c  */
#line 802 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 141:

/* Line 1806 of yacc.c  */
#line 805 "c-.y"
    {
	  (yyval.nodeptr) = newExpNode(IdK);
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	}
    break;

  case 142:

/* Line 1806 of yacc.c  */
#line 811 "c-.y"
    {
	  (yyval.nodeptr) = newExpNode(IdK);
	  (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
	  (yyval.nodeptr)->isArray = true; 
	  (yyval.nodeptr)->child[0] = (yyvsp[(3) - (4)].nodeptr);
	}
    break;

  case 143:

/* Line 1806 of yacc.c  */
#line 818 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 144:

/* Line 1806 of yacc.c  */
#line 819 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 145:

/* Line 1806 of yacc.c  */
#line 822 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 146:

/* Line 1806 of yacc.c  */
#line 823 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr); }
    break;

  case 147:

/* Line 1806 of yacc.c  */
#line 824 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 148:

/* Line 1806 of yacc.c  */
#line 825 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 149:

/* Line 1806 of yacc.c  */
#line 826 "c-.y"
    { (yyval.nodeptr) = NULL; yyerrok; }
    break;

  case 150:

/* Line 1806 of yacc.c  */
#line 829 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->attr.val = (yyvsp[(1) - (1)].tokenData)->iValue;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Integer;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 151:

/* Line 1806 of yacc.c  */
#line 837 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->expType = Character;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 152:

/* Line 1806 of yacc.c  */
#line 845 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Character;
	    (yyval.nodeptr)->isArray = true;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 153:

/* Line 1806 of yacc.c  */
#line 854 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Boolean;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 154:

/* Line 1806 of yacc.c  */
#line 862 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	    (yyval.nodeptr)->expType = Boolean;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 155:

/* Line 1806 of yacc.c  */
#line 871 "c-.y"
    {
       (yyval.nodeptr) = newExpNode(CallK);
       (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
       (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
       (yyval.nodeptr)->child[0] = (yyvsp[(3) - (4)].nodeptr);
     }
    break;

  case 156:

/* Line 1806 of yacc.c  */
#line 877 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;

  case 157:

/* Line 1806 of yacc.c  */
#line 878 "c-.y"
    {(yyval.nodeptr)=NULL;}
    break;

  case 158:

/* Line 1806 of yacc.c  */
#line 879 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 159:

/* Line 1806 of yacc.c  */
#line 880 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 160:

/* Line 1806 of yacc.c  */
#line 883 "c-.y"
    {
	   TreeNode * t = (yyvsp[(1) - (3)].nodeptr);
	   if (t != NULL){
	     while  (t->sibling != NULL) t = t->sibling;
	     t->sibling = (yyvsp[(3) - (3)].nodeptr);
	     (yyval.nodeptr) = (yyvsp[(1) - (3)].nodeptr);
	   } else
	     (yyval.nodeptr) = (yyvsp[(3) - (3)].nodeptr);
	   yyerrok;
	 }
    break;

  case 161:

/* Line 1806 of yacc.c  */
#line 893 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 162:

/* Line 1806 of yacc.c  */
#line 894 "c-.y"
    {(yyval.nodeptr)=NULL; yyerrok;}
    break;



/* Line 1806 of yacc.c  */
#line 3534 "c-.tab.c"
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
#line 897 "c-.y"


void nodePrint(void * p){
  //  TreeNode * t = (TreeNode*)p;
}

SymTab * st = new SymTab(nodePrint);
char nameCompoundStat[64];
char nameParam[32];
int depth = 1;

main(int argc, char* argv[]){
    int d_flag = 0;
    int s_flag = 0;
    char *d_value = NULL;
    int c;

    if (argc == 1) 
        yyin = stdin;
    else if (argc == 2) {
        yyin = fopen(argv[1], "r");
    } else if (argc > 2) {  
      while ((c = getopt (argc, argv, "ps")) != -1)
	switch (c) {      
	case 'p':   // yydebug
	  d_flag = 1;
	  break;
	case 's':  // debug_table
	  s_flag = 1;
	  break;
	default:
	  abort ();
	  break;
	}
      if (d_flag == 1)
	yydebug = 1;
      //printTree(savedTree);
      if (s_flag == 1)
	st->debug(0x2); 
      yyin = fopen(argv[2], "r");
    } else {
      printf("Usage:./c- TestFileName\nUsage:./c- < TestFileName\nUsage: cat TestFileName | ./c-\n");
        exit(-1);
    }
    if (yyin == NULL){
        printf("Can't open/read '%s'\n", argv[2]);
        exit(-1);
    }
    yyfilename = argv[1];
    linnum = 1;
    initYyerror();

    yyparse();
    savedTree = siblingNode(savedTree, Void, (char*)("outnl"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Character, (char*)("inputc"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Boolean, (char*)("inputb"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Integer, (char*)("input"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Void, (char*)("outputc"), Character, (char*)("xyz"));
    savedTree = siblingNode(savedTree, Void, (char*)("outputb"), Boolean, (char*)("xyz"));
    savedTree = siblingNode(savedTree, Void, (char*)("output"), Integer, (char*)("xyz"));
    //    insertCheckNode(savedTree);  

    printf("Number of warnings: %d\n", numWarnings);
    printf("Number of errors: %d\n", numError);

    if (argc != 1)
        fclose(yyin);
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
int depthcnt = 0;

static void insertCheckNode( TreeNode * t)  {

  switch (t->nodekind) {
  case DeclK:  
    switch(t->kind.decl){

    case VarK:
      if (t->child[0] != NULL) {
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

      if ((st->lookup(t->string) == NULL) || 
	  ( ((st->lookupSymTabEntry(t->string))->depth != st->depth()-1 ) //ParamK
	    && (st->lookupSymTabEntry(t->string))->depth != st->depth()) ) {
	st->insert(t->string, (void*)t ); 

	if (t->child[0] != NULL) {
	  if ( (t->isArray == false) && (t->child[0]->isArray == true) ) {
	    printf("ERROR(%d): Initializer for nonarray variable '%s' of type %s cannot be initialized with an array.\n",
		   t->child[0]->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	} // child[0] != NULL

      } else { // exist in symtab
	//      } else if ( (st->lookupSymTabEntry(t->string))->depth  ) { // scope
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", 
	       t->linnum, t->string, ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
      }

      if  (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case FuncK:
      if (st->lookup(t->string) == NULL) {   
	st->insert(t->string, (void*)t ); 
      } else { 
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", t->linnum, t->string, 
	       ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
      }

      st->enter(t->string);
      for (funci = 0; funci < 2; funci++) {
	if (t->child[funci] != NULL) {
	  insertCheckNode(t->child[funci]);
	}
      }

      if (t->child[1] != NULL){
	if ( (t->expType == 0) && (t->child[1]->expType != 0) ) {
	  printf("ERROR(%d): Function '%s' at line %d is expecting no return value, but return has return value.\n", 
		 t->child[1]->linnum, t->string, t->linnum);
	  ++numError;
	} else if ( (t->expType == 0) && (ReturnFlag == true) && (t->child[1]->expType != 0) ) {
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
	    printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement\n", 
		   t->linnum, getType(t->expType), t->string);
	    ++numWarnings;
	  }
	}
	ReturnFlag = false; // set back to default
      }
      st->leave();

      if ( (t->child[1] == NULL) && (t->expType != Void) 
	   && ((t->string != (char*)"input") && (t->string != (char*)"inputb") && (t->string != (char*)"inputc"))) {
	printf("WARNING(%d): Expecting to return type %s but function '%s' has no return statement.\n", 
	       t->linnum, getType(t->expType), t->string);
	++numWarnings;
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case ParamK:
      st->insert(t->string, (void*)t );
      if (t->sibling != NULL) {   
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
      }
      --depthcnt;
      LoopFlag = false;
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);
      break;

    case BreakK:
      //if ( (LoopFlag == false) && (depthcnt > 0) ) {   // potential problems with nested loops
      if ( LoopFlag == false ) {
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
      depth = st->depth() + 1;
      sprintf(nameCompoundStat, "Compound Statement:%d", depth);
      st->enter(nameCompoundStat);

      for (cmpi = 0; cmpi < MAXCHILDREN; cmpi++) { 
	if (t->child[cmpi] != NULL) 
	  insertCheckNode(t->child[cmpi]);
      }
      if (t->sibling != NULL) 
	insertCheckNode(t->sibling);

      sprintf(str, "Return:%d", st->depth());
      if (st->lookup(str) == NULL) {
	t->expType = Void;
	ReturnFlag = false;
      } else {
	ReturnFlag = true;
	t->expType = ((TreeNode*)(st->lookup(str)))->expType;
	t->linnum = ((TreeNode*)(st->lookup(str)))->linnum;
      }
      st->leave();
      --depth;
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

      if ( (t->attr.op == '=') && (t->child[0] != NULL) && (t->child[1] != NULL) ) {
	if ( (t->child[0]->isArray != t->child[1]->isArray)
	     && ((t->child[0]->expType != Undefined) && (t->child[1]->expType != Undefined)) ) {
	     //&& ((t->child[0]->expType != Character) && (t->child[1]->expType != Character)) ) {
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

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case CallK:
      if (st->lookup(t->string) == NULL) {
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	t->expType = Undefined; 
	if (t->child[0] != NULL)
	  insertCheckNode(t->child[0]);
      } else {
	if ( (((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK)
	     || (((TreeNode*)(st->lookup(t->string)))->kind.decl == ParamK) ) {
	  printf("ERROR(%d): '%s' is a simple variable and cannot be called.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = Undefined;
	  if ( t->child[0] )
	    insertCheckNode(t->child[0]);
	} else { //FuncK
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  if ( (t->child[0] == NULL) && (p->child[0] != NULL) ) {
	    printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		   t->linnum, t->string, p->linnum);
	    ++numError;
	  }
	  if (t->child[0] != NULL) {

	    TreeNode* tmpt = t->child[0];
	    int pcnt = 0;

	    while (tmpt) {
	      //if (tmpt) {
	      insertCheckNode(tmpt);

	      if (p->child[0] == NULL) {
		printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		       tmpt->linnum, t->string, p->linnum);
		++numError;
	      } else {
		TreeNode* tmpp = p->child[0];
		if ((tmpt->expType != tmpp->expType) && (tmpt->expType != Undefined) ) {
		  printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
			 tmpt->linnum, getType(tmpp->expType), pcnt+1, t->string, p->linnum, getType(tmpt->expType));
		  ++numError;
		}
		//if (tmpt->expType == tmpp->expType) 
		//t->expType = p->expType;
		if ( (tmpt->isArray == true) && (tmpp->isArray == false) ) {
		  printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		if ( (tmpt->isArray == false) && (tmpp->isArray == true) ) {
		  printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 t->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		tmpt->expType = tmpp->expType;
		tmpt->isArray = tmpp->isArray;

		if ( (tmpt->sibling != NULL) &&  (tmpp->sibling == NULL) ) {
		  printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
			 tmpt->linnum, t->string, p->linnum);
		  ++numError;
		  //tmpt = tmpt->sibling;
		  //while (tmpt)
		  //insertCheckNode(tmpt);
		}
		if ( (tmpt->sibling == NULL) &&  (tmpp->sibling != NULL) ) {
		  printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
			 tmpt->linnum, t->string, p->linnum);
		  ++numError;
		}
		
		//while ( (tmpt->sibling != NULL) &&  (tmpp->sibling != NULL) ) {
		if ( (tmpt->sibling != NULL) &&  (tmpp->sibling != NULL) ) 
		  pcnt++;
		//insertCheckNode(tmpt->sibling);
		tmpp = tmpp->sibling;
		tmpt = tmpt->sibling;
	      } // end p->child[0] != NULL
	      //while (tmpt) {
	      //insertCheckNode(tmpt);
	    } 
	  } //   end t->child[0] != NULL
	  t->expType = p->expType;

	} // FuncK
      } //symtab

      if (t->sibling != NULL)
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

	if (t->child[0] != NULL) 
	  t->isArray = true;  //double check

	if (t->child[0] != NULL) 
	  insertCheckNode(t->child[0]);
      } else {  // symtab != NULL

	if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK ) {
	  printf("ERROR(%d): Cannot use function '%s' as a simple variable.\n", t->linnum, t->string);
	  ++numError;
	  t->expType = ((TreeNode*)(st->lookup(t->string)))->expType; 
	} else { //if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK ) {

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
      if (t->sibling != NULL)
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
	t->expType = Boolean; 
	if ((t->child[0]->isArray == true) || (t->child[1]->isArray == true)) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
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
      else 
	t->isConstant = false;
    
      if ( ((t->child[0] != NULL) && (t->child[1] != NULL)) && 
	   ((t->child[0]->expType != Integer) || (t->child[1]->expType != Integer)) ) {  
	if ( (t->attr.op == '<') || (t->attr.op == '>') || (t->attr.op == AND) || (t->attr.op == OR) 
	     || (t->attr.op == EQ) || (t->attr.op == NEQ) || (t->attr.op == LEQ) || (t->attr.op == GEQ) )
	  t->expType = Boolean;   
	else   
	  t->expType = Integer;   
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;  // OpK
    }
    break;  // exp
  }
}

static void printSpaces(void){
  for ( int i = 0; i < indentno; i++){
    printf("|  ");
  }
}
/*
void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, linnum, yytext);
  //printf("ERROR linnum(%d):%s. I got: %s\n", linnum, s, yytext);
  exit(-1);
  }*/

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

void printTree( TreeNode * tree){
  int i; 
  int counter = 1; 

  while (tree != NULL){
    INDENT;
    //printSpaces();
    if (tree->nodekind == DeclK){  
      switch(tree->kind.decl){
      case VarK:
	printf("Var %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  break;
	default:
	  printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  break;
	}
	break;
      case FuncK:
	printf("Func %s returns type %s [line: %d]\n", tree->string, getType(tree->expType), tree->linnum);
	break;

      case ParamK:
	printf("Param %s ", tree->string);
	switch (tree->isArray){
	case true:
	  printf(" is array of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
	  break;
	default:
	  printf(" of type %s [line: %d]\n", getType(tree->expType), tree->linnum);
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
	printf("Child: %d\n", childcnt+1);
	childcnt++;
	printTree(tree->child[i]);
      } 
    } 

    if ( (tree->nodekind == DeclK) && (tree->kind.decl == FuncK) )
      counter = 0;
    tree = tree->sibling; 
    if (tree != NULL){
      if ( counter >= 1 ){
	printf("Sibling: %d\n", counter);
      }
      counter++;
    }
  }
  UNINDENT;
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

