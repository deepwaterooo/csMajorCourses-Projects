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
#include "scanType.h"  
#include "c-.tab.h"
#include "symtab.h"
extern int yylex();
extern int yyparse();
extern FILE * yyin;
char *yyfilename;
extern char *yytext;
extern int linnum;
extern char tokenString[];
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
TreeNode * newStmtNode( StmtKind );
TreeNode * newDeclNode(DeclKind kind);
TreeNode * newExpNode( ExpKind );
//void FreeTree(Node *p);
static TokenData token; /* holds current token */
void yyerror(const char* s);
char* getType(int x);
char * copyString( char * s);

static int indentno = 0;
#define INDENT indentno += 3
#define UNINDENT indentno -= 3
void printTree( TreeNode * tree);
static void printSpaces(void);
static void insertCheckNode( TreeNode * t);
 TreeNode* siblingNode(TreeNode* t, ExpType expType, char* string, ExpType argType, char*);
char str[64];
//string mark[8] = {"+=", "-=", "++", "--", "==", "!=", "<=", ">="}



/* Line 268 of yacc.c  */
#line 142 "c-.tab.c"

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
#line 71 "c-.y"

  ExpType type;    
  int number;
  TokenData * tokenData;
  struct treeNode * nodeptr;



/* Line 293 of yacc.c  */
#line 217 "c-.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 343 of yacc.c  */
#line 229 "c-.tab.c"

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
#define YYFINAL  12
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   252

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  48
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  38
/* YYNRULES -- Number of rules.  */
#define YYNRULES  97
/* YYNRULES -- Number of states.  */
#define YYNSTATES  166

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
       0,     0,     3,     5,     8,    10,    12,    14,    18,    22,
      26,    28,    30,    35,    39,    46,    49,    51,    53,    55,
      57,    64,    70,    72,    73,    78,    81,    85,    87,    89,
      93,    95,    97,   105,   111,   119,   121,   129,   135,   141,
     149,   151,   154,   158,   161,   164,   166,   171,   174,   175,
     178,   179,   183,   187,   191,   194,   197,   199,   203,   205,
     209,   211,   214,   216,   220,   224,   228,   232,   236,   240,
     242,   246,   250,   252,   256,   258,   260,   262,   264,   267,
     269,   271,   273,   275,   277,   279,   284,   288,   290,   292,
     294,   296,   298,   300,   305,   307,   308,   312
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      49,     0,    -1,    50,    -1,    50,    51,    -1,    51,    -1,
      52,    -1,    58,    -1,    57,    54,    29,    -1,    56,    54,
      29,    -1,    54,    28,    55,    -1,    55,    -1,    11,    -1,
      11,    33,    13,    36,    -1,    11,    30,    71,    -1,    11,
      33,    13,    36,    30,    71,    -1,    20,    57,    -1,    57,
      -1,    21,    -1,    22,    -1,    23,    -1,    57,    11,    32,
      59,    35,    63,    -1,    11,    32,    59,    35,    63,    -1,
      60,    -1,    -1,    60,    29,    57,    61,    -1,    57,    61,
      -1,    61,    28,    62,    -1,    62,    -1,    11,    -1,    11,
      33,    36,    -1,    64,    -1,    65,    -1,    15,    32,    71,
      35,    64,    16,    64,    -1,    17,    32,    71,    35,    64,
      -1,    18,    32,    81,    19,    71,    35,    64,    -1,    66,
      -1,    15,    32,    71,    35,    64,    16,    65,    -1,    15,
      32,    71,    35,    63,    -1,    17,    32,    71,    35,    65,
      -1,    18,    32,    81,    19,    71,    35,    65,    -1,    67,
      -1,    26,    29,    -1,    26,    70,    29,    -1,    27,    29,
      -1,    70,    29,    -1,    29,    -1,    31,    68,    69,    34,
      -1,    68,    53,    -1,    -1,    69,    63,    -1,    -1,    81,
      41,    70,    -1,    81,     3,    70,    -1,    81,     4,    70,
      -1,    81,     5,    -1,    81,     6,    -1,    71,    -1,    71,
      38,    72,    -1,    72,    -1,    72,    37,    73,    -1,    73,
      -1,    39,    73,    -1,    74,    -1,    75,    40,    75,    -1,
      75,    42,    75,    -1,    75,     9,    75,    -1,    75,    10,
      75,    -1,    75,     7,    75,    -1,    75,     8,    75,    -1,
      75,    -1,    75,    47,    76,    -1,    75,    46,    76,    -1,
      76,    -1,    76,    77,    78,    -1,    78,    -1,    43,    -1,
      45,    -1,    44,    -1,    79,    78,    -1,    80,    -1,    46,
      -1,    43,    -1,    82,    -1,    81,    -1,    11,    -1,    11,
      33,    70,    36,    -1,    32,    70,    35,    -1,    83,    -1,
      13,    -1,    12,    -1,    14,    -1,    24,    -1,    25,    -1,
      11,    32,    84,    35,    -1,    85,    -1,    -1,    70,    28,
      85,    -1,    70,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    96,    96,    98,   108,   110,   111,   114,   131,   147,
     157,   159,   165,   173,   180,   189,   190,   192,   193,   194,
     197,   208,   220,   221,   224,   242,   255,   265,   267,   273,
     282,   283,   285,   295,   304,   313,   315,   325,   334,   343,
     353,   354,   360,   367,   373,   374,   380,   388,   398,   400,
     410,   412,   422,   431,   440,   448,   456,   458,   467,   469,
     478,   480,   488,   490,   499,   508,   517,   526,   535,   544,
     546,   555,   564,   566,   572,   574,   581,   588,   596,   601,
     603,   610,   618,   619,   621,   627,   636,   637,   638,   647,
     655,   664,   672,   681,   689,   690,   692,   702
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
  "scoped_type_specifier", "type_specifier", "fun_declaration", "params",
  "param_list", "param_id_list", "param_id", "statement", "ifmatched",
  "ifunmatched", "expression_stmt", "compound_stmt", "local_declarations",
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
     275,   276,   277,   278,   279,   280,   281,   282,    44,    59,
      58,   123,    40,    91,   125,    41,    93,   283,   284,   285,
      60,    61,    62,    42,    37,    47,    45,    43
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    48,    49,    50,    50,    51,    51,    52,    53,    54,
      54,    55,    55,    55,    55,    56,    56,    57,    57,    57,
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
       0,     2,     1,     2,     1,     1,     1,     3,     3,     3,
       1,     1,     4,     3,     6,     2,     1,     1,     1,     1,
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
       0,     0,    17,    18,    19,     0,     2,     4,     5,     0,
       6,    23,     1,     3,    11,     0,    10,     0,     0,    22,
       0,    23,     0,     0,     7,    28,    25,    27,     0,     0,
      84,    89,    88,    90,    91,    92,     0,     0,    81,    80,
      13,    58,    60,    62,    69,    72,    74,     0,    79,    83,
      82,    87,     0,     0,    11,     9,     0,     0,     0,     0,
       0,     0,     0,    45,    48,    21,    30,    31,    35,    40,
       0,    56,    83,     0,    95,     0,     0,    61,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    75,    77,
      76,     0,    78,     0,    12,    29,    26,     0,     0,     0,
      41,     0,    43,    50,    44,     0,     0,    54,    55,     0,
      24,    97,     0,    94,     0,    86,    57,    59,    67,    68,
      65,    66,    63,    64,    71,    70,    73,    20,     0,     0,
       0,    84,     0,    42,     0,    47,     0,    16,     0,    52,
      53,    51,     0,    93,    85,    14,     0,     0,     0,    15,
       0,    46,    49,    96,    37,    30,    33,    38,     0,     8,
       0,     0,    32,    36,    34,    39
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     5,     6,     7,     8,   135,    15,    16,   136,     9,
      10,    18,    19,    26,    27,    65,    66,    67,    68,    69,
     103,   138,    70,    71,    41,    42,    43,    44,    45,    91,
      46,    47,    48,    49,    50,    51,   112,   113
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -136
static const yytype_int16 yypact[] =
{
      16,   -27,  -136,  -136,  -136,    24,    16,  -136,  -136,    43,
    -136,    73,  -136,  -136,    36,   -19,  -136,    45,    23,    51,
     170,    73,    39,    72,  -136,    59,    77,  -136,   161,    73,
      -3,  -136,  -136,  -136,  -136,  -136,   170,   170,  -136,  -136,
      68,    70,  -136,  -136,    13,    -9,  -136,   206,  -136,  -136,
    -136,  -136,    76,    80,    15,  -136,    85,    45,    90,    91,
      93,    88,    79,  -136,  -136,  -136,  -136,  -136,  -136,  -136,
      97,    68,    10,    45,   170,   170,    94,  -136,   170,   170,
     206,   206,   206,   206,   206,   206,   206,   206,  -136,  -136,
    -136,   206,  -136,   161,    98,  -136,  -136,   170,   170,   119,
    -136,   112,  -136,    41,  -136,   170,   170,  -136,  -136,   170,
      77,   116,   110,  -136,   111,  -136,    70,  -136,    28,    28,
      28,    28,    28,    28,    -9,    -9,  -136,  -136,   170,     5,
      32,   113,   129,  -136,    73,  -136,    72,  -136,   125,  -136,
    -136,  -136,   170,  -136,  -136,    68,   161,   161,   170,  -136,
      69,  -136,  -136,  -136,  -136,   137,  -136,  -136,    44,  -136,
     161,   161,  -136,  -136,  -136,  -136
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -136,  -136,  -136,   149,  -136,  -136,    22,   138,  -136,   -10,
    -136,   139,  -136,    89,   106,   -89,  -129,  -135,  -136,  -136,
    -136,  -136,   -33,   -13,    87,   -35,  -136,     6,    17,  -136,
     -41,  -136,  -136,   -28,  -136,  -136,  -136,    25
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      72,    17,    77,    76,   127,    11,    92,    40,    72,    23,
      24,    17,   157,   105,   106,   107,   108,   155,   156,    73,
      80,    81,    82,    83,    12,   163,   165,     1,   101,    74,
      75,   162,   164,    72,    88,    89,    90,     2,     3,     4,
     146,   111,   114,    78,   117,    20,    72,    72,    22,   152,
     126,   109,    53,    84,    14,    85,    25,   154,    28,    86,
      87,   134,     2,     3,     4,    72,    20,   147,    21,    22,
      78,   132,   139,   140,    86,    87,   141,    72,    72,   161,
      29,    72,    78,    54,   129,   130,   118,   119,   120,   121,
     122,   123,    56,   137,     2,     3,     4,    23,   159,    30,
      31,    32,    33,   124,   125,    57,    78,    79,   102,   111,
      72,    93,    34,    35,    72,   145,    94,   100,    72,    72,
      36,    95,    97,    98,   149,    99,   104,    37,   128,   115,
     131,    38,    72,    72,    39,   158,    30,    31,    32,    33,
      58,   133,    59,    60,   142,   143,    75,   144,   148,    34,
      35,    61,    62,   160,    63,    13,    64,    36,   150,   151,
      52,    55,   110,    96,    37,   116,     0,   153,    38,     0,
       0,    39,    30,    31,    32,    33,    58,     0,    59,    60,
       0,    30,    31,    32,    33,    34,    35,    61,    62,     0,
      63,     0,    64,    36,    34,    35,     0,     0,     0,     0,
      37,     0,    36,     0,    38,     0,     0,    39,     0,    37,
       0,     0,     0,    38,     0,     0,    39,    30,    31,    32,
      33,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      34,    35,     0,     0,     0,     0,     0,     0,    36,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    38,
       0,     0,    39
};

#define yypact_value_is_default(yystate) \
  ((yystate) == (-136))

#define yytable_value_is_error(yytable_value) \
  YYID (0)

static const yytype_int16 yycheck[] =
{
      28,    11,    37,    36,    93,    32,    47,    20,    36,    28,
      29,    21,   147,     3,     4,     5,     6,   146,   147,    29,
       7,     8,     9,    10,     0,   160,   161,    11,    61,    32,
      33,   160,   161,    61,    43,    44,    45,    21,    22,    23,
      35,    74,    75,    38,    79,    30,    74,    75,    33,   138,
      91,    41,    13,    40,    11,    42,    11,   146,    35,    46,
      47,    20,    21,    22,    23,    93,    30,    35,    32,    33,
      38,    99,   105,   106,    46,    47,   109,   105,   106,    35,
      29,   109,    38,    11,    97,    98,    80,    81,    82,    83,
      84,    85,    33,   103,    21,    22,    23,    28,    29,    11,
      12,    13,    14,    86,    87,    28,    38,    37,    29,   142,
     138,    35,    24,    25,   142,   128,    36,    29,   146,   147,
      32,    36,    32,    32,   134,    32,    29,    39,    30,    35,
      11,    43,   160,   161,    46,   148,    11,    12,    13,    14,
      15,    29,    17,    18,    28,    35,    33,    36,    19,    24,
      25,    26,    27,    16,    29,     6,    31,    32,   136,    34,
      21,    23,    73,    57,    39,    78,    -1,   142,    43,    -1,
      -1,    46,    11,    12,    13,    14,    15,    -1,    17,    18,
      -1,    11,    12,    13,    14,    24,    25,    26,    27,    -1,
      29,    -1,    31,    32,    24,    25,    -1,    -1,    -1,    -1,
      39,    -1,    32,    -1,    43,    -1,    -1,    46,    -1,    39,
      -1,    -1,    -1,    43,    -1,    -1,    46,    11,    12,    13,
      14,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      24,    25,    -1,    -1,    -1,    -1,    -1,    -1,    32,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    43,
      -1,    -1,    46
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    11,    21,    22,    23,    49,    50,    51,    52,    57,
      58,    32,     0,    51,    11,    54,    55,    57,    59,    60,
      30,    32,    33,    28,    29,    11,    61,    62,    35,    29,
      11,    12,    13,    14,    24,    25,    32,    39,    43,    46,
      71,    72,    73,    74,    75,    76,    78,    79,    80,    81,
      82,    83,    59,    13,    11,    55,    33,    28,    15,    17,
      18,    26,    27,    29,    31,    63,    64,    65,    66,    67,
      70,    71,    81,    57,    32,    33,    70,    73,    38,    37,
       7,     8,     9,    10,    40,    42,    46,    47,    43,    44,
      45,    77,    78,    35,    36,    36,    62,    32,    32,    32,
      29,    70,    29,    68,    29,     3,     4,     5,     6,    41,
      61,    70,    84,    85,    70,    35,    72,    73,    75,    75,
      75,    75,    75,    75,    76,    76,    78,    63,    30,    71,
      71,    11,    81,    29,    20,    53,    56,    57,    69,    70,
      70,    70,    28,    35,    36,    71,    35,    35,    19,    57,
      54,    34,    63,    85,    63,    64,    64,    65,    71,    29,
      16,    35,    64,    65,    64,    65
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
#line 96 "c-.y"
    { savedTree = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 3:

/* Line 1806 of yacc.c  */
#line 99 "c-.y"
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
#line 108 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 5:

/* Line 1806 of yacc.c  */
#line 110 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 6:

/* Line 1806 of yacc.c  */
#line 111 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 7:

/* Line 1806 of yacc.c  */
#line 115 "c-.y"
    {
		  // attach type in $1 to everybody in list $2
		  // $1 is of type TokenData*
		  // tagTypeInList($1, $2);
		  TreeNode* t = (yyvsp[(2) - (3)].nodeptr);
		  if (t != NULL){
		    t->expType = (yyvsp[(1) - (3)].type);
		    while (t->sibling != NULL) {
		      t = t->sibling;
		      t->expType = (yyvsp[(1) - (3)].type);
		    }
		    (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
		  }
		  //$$ = $2;
		}
    break;

  case 8:

/* Line 1806 of yacc.c  */
#line 132 "c-.y"
    { 
			 // attach type and scope in $1 to everybody in list $2  
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
		       }
    break;

  case 9:

/* Line 1806 of yacc.c  */
#line 148 "c-.y"
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

  case 10:

/* Line 1806 of yacc.c  */
#line 157 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 11:

/* Line 1806 of yacc.c  */
#line 160 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
		    }
    break;

  case 12:

/* Line 1806 of yacc.c  */
#line 166 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
		      //$$->child[0] = $3;
		      (yyval.nodeptr)->isArray = true;
		    }
    break;

  case 13:

/* Line 1806 of yacc.c  */
#line 174 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (3)].tokenData)->tokenstr;
		      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (3)].nodeptr);
		    }
    break;

  case 14:

/* Line 1806 of yacc.c  */
#line 181 "c-.y"
    {
		      (yyval.nodeptr) = newDeclNode(VarK);
		      (yyval.nodeptr)->linnum = (yyvsp[(1) - (6)].tokenData)->linnum;
		      (yyval.nodeptr)->string = (yyvsp[(1) - (6)].tokenData)->tokenstr;
		      (yyval.nodeptr)->child[0] = (yyvsp[(6) - (6)].nodeptr);
		      (yyval.nodeptr)->isArray = true;
		    }
    break;

  case 15:

/* Line 1806 of yacc.c  */
#line 189 "c-.y"
    { (yyval.type) = (yyvsp[(2) - (2)].type); }
    break;

  case 16:

/* Line 1806 of yacc.c  */
#line 190 "c-.y"
    { (yyval.type) = (yyvsp[(1) - (1)].type); }
    break;

  case 17:

/* Line 1806 of yacc.c  */
#line 192 "c-.y"
    { (yyval.type) = Integer; }
    break;

  case 18:

/* Line 1806 of yacc.c  */
#line 193 "c-.y"
    { (yyval.type) = Boolean; }
    break;

  case 19:

/* Line 1806 of yacc.c  */
#line 194 "c-.y"
    { (yyval.type) = Character; }
    break;

  case 20:

/* Line 1806 of yacc.c  */
#line 198 "c-.y"
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
#line 209 "c-.y"
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
#line 220 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 23:

/* Line 1806 of yacc.c  */
#line 221 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 24:

/* Line 1806 of yacc.c  */
#line 225 "c-.y"
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
#line 243 "c-.y"
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
#line 256 "c-.y"
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
#line 265 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 28:

/* Line 1806 of yacc.c  */
#line 268 "c-.y"
    {
	   (yyval.nodeptr) = newDeclNode(ParamK);
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	 }
    break;

  case 29:

/* Line 1806 of yacc.c  */
#line 274 "c-.y"
    {
	   (yyval.nodeptr) = newDeclNode(ParamK);
	   (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
	   (yyval.nodeptr)->string = (yyvsp[(1) - (3)].tokenData)->tokenstr;
	   (yyval.nodeptr)->isArray = true;
	 }
    break;

  case 30:

/* Line 1806 of yacc.c  */
#line 282 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 31:

/* Line 1806 of yacc.c  */
#line 283 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 32:

/* Line 1806 of yacc.c  */
#line 286 "c-.y"
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
#line 296 "c-.y"
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
#line 305 "c-.y"
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
#line 313 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 36:

/* Line 1806 of yacc.c  */
#line 316 "c-.y"
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
#line 326 "c-.y"
    { 
	      (yyval.nodeptr) = newStmtNode(IfK);
	      (yyval.nodeptr)->string = (yyvsp[(1) - (5)].tokenData)->tokenstr;
	      (yyval.nodeptr)->linnum = (yyvsp[(1) - (5)].tokenData)->linnum;
	      (yyval.nodeptr)->child[0] = (yyvsp[(3) - (5)].nodeptr);
	      (yyval.nodeptr)->child[1] = (yyvsp[(5) - (5)].nodeptr);
	      (yyval.nodeptr)->child[1]->expType = Boolean;
	    }
    break;

  case 38:

/* Line 1806 of yacc.c  */
#line 335 "c-.y"
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
#line 344 "c-.y"
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
#line 353 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 41:

/* Line 1806 of yacc.c  */
#line 355 "c-.y"
    {
		 (yyval.nodeptr) = newStmtNode(ReturnK);
		 (yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum;
		 (yyval.nodeptr)->expType = Void;
	       }
    break;

  case 42:

/* Line 1806 of yacc.c  */
#line 361 "c-.y"
    {
		 (yyval.nodeptr) = newStmtNode(ReturnK);
		 (yyval.nodeptr)->linnum = (yyvsp[(1) - (3)].tokenData)->linnum;
		 (yyval.nodeptr)->child[0] = (yyvsp[(2) - (3)].nodeptr);
		 (yyval.nodeptr)->expType = (yyvsp[(2) - (3)].nodeptr)->expType; 
	       }
    break;

  case 43:

/* Line 1806 of yacc.c  */
#line 368 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(BreakK);
		(yyval.nodeptr)->string = (yyvsp[(1) - (2)].tokenData)->tokenstr;
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (2)].tokenData)->linnum;
	      }
    break;

  case 44:

/* Line 1806 of yacc.c  */
#line 373 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); }
    break;

  case 45:

/* Line 1806 of yacc.c  */
#line 374 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 46:

/* Line 1806 of yacc.c  */
#line 381 "c-.y"
    {
		(yyval.nodeptr) = newStmtNode(CompoundK);
		(yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
		(yyval.nodeptr)->child[0] = (yyvsp[(2) - (4)].nodeptr);
		(yyval.nodeptr)->child[1] = (yyvsp[(3) - (4)].nodeptr);
	      }
    break;

  case 47:

/* Line 1806 of yacc.c  */
#line 389 "c-.y"
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
#line 398 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 49:

/* Line 1806 of yacc.c  */
#line 401 "c-.y"
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
#line 410 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 51:

/* Line 1806 of yacc.c  */
#line 413 "c-.y"
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
#line 423 "c-.y"
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
#line 432 "c-.y"
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
#line 441 "c-.y"
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
#line 449 "c-.y"
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
#line 456 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 57:

/* Line 1806 of yacc.c  */
#line 459 "c-.y"
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
#line 467 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 59:

/* Line 1806 of yacc.c  */
#line 470 "c-.y"
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
#line 478 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 61:

/* Line 1806 of yacc.c  */
#line 481 "c-.y"
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
#line 488 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 63:

/* Line 1806 of yacc.c  */
#line 491 "c-.y"
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
#line 500 "c-.y"
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
#line 509 "c-.y"
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
#line 518 "c-.y"
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
#line 527 "c-.y"
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
#line 536 "c-.y"
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
#line 544 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 70:

/* Line 1806 of yacc.c  */
#line 547 "c-.y"
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
#line 556 "c-.y"
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
#line 564 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 73:

/* Line 1806 of yacc.c  */
#line 567 "c-.y"
    {
       (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr);
       (yyval.nodeptr)->child[0] = (yyvsp[(1) - (3)].nodeptr);
       (yyval.nodeptr)->child[1] = (yyvsp[(3) - (3)].nodeptr);
     }
    break;

  case 74:

/* Line 1806 of yacc.c  */
#line 572 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 75:

/* Line 1806 of yacc.c  */
#line 575 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 76:

/* Line 1806 of yacc.c  */
#line 582 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 77:

/* Line 1806 of yacc.c  */
#line 589 "c-.y"
    { 
	(yyval.nodeptr) = newExpNode(OpK); 
	(yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	(yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	(yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
      }
    break;

  case 78:

/* Line 1806 of yacc.c  */
#line 597 "c-.y"
    {
		   (yyval.nodeptr) = (yyvsp[(1) - (2)].nodeptr); 
		   (yyval.nodeptr)->child[0] = (yyvsp[(2) - (2)].nodeptr);
		 }
    break;

  case 79:

/* Line 1806 of yacc.c  */
#line 601 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 80:

/* Line 1806 of yacc.c  */
#line 604 "c-.y"
    { 
	  (yyval.nodeptr) = newExpNode(OpK); 
	  (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	}
    break;

  case 81:

/* Line 1806 of yacc.c  */
#line 611 "c-.y"
    { 
	  (yyval.nodeptr) = newExpNode(OpK); 
	  (yyval.nodeptr)->attr.op = (yyvsp[(1) - (1)].tokenData)->tokenClass;
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	}
    break;

  case 82:

/* Line 1806 of yacc.c  */
#line 618 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 83:

/* Line 1806 of yacc.c  */
#line 619 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 84:

/* Line 1806 of yacc.c  */
#line 622 "c-.y"
    {
	  (yyval.nodeptr) = newExpNode(IdK);
	  (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	}
    break;

  case 85:

/* Line 1806 of yacc.c  */
#line 628 "c-.y"
    {
	  (yyval.nodeptr) = newExpNode(IdK);
	  (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
	  (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
	  (yyval.nodeptr)->isArray = true; // or false???
	  (yyval.nodeptr)->child[0] = (yyvsp[(3) - (4)].nodeptr);
	}
    break;

  case 86:

/* Line 1806 of yacc.c  */
#line 636 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(2) - (3)].nodeptr); }
    break;

  case 87:

/* Line 1806 of yacc.c  */
#line 637 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 88:

/* Line 1806 of yacc.c  */
#line 639 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    //sprintf($$->string, "%d", $1->iValue);
	    (yyval.nodeptr)->attr.val = (yyvsp[(1) - (1)].tokenData)->iValue;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Integer;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 89:

/* Line 1806 of yacc.c  */
#line 648 "c-.y"
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
#line 656 "c-.y"
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
#line 665 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum; 
	    (yyval.nodeptr)->expType = Boolean;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 92:

/* Line 1806 of yacc.c  */
#line 673 "c-.y"
    {
	    (yyval.nodeptr) = newExpNode(ConstantK);
	    (yyval.nodeptr)->string = (yyvsp[(1) - (1)].tokenData)->tokenstr;
	    (yyval.nodeptr)->linnum = (yyvsp[(1) - (1)].tokenData)->linnum;
	    (yyval.nodeptr)->expType = Boolean;
	    (yyval.nodeptr)->isConstant = true;
	  }
    break;

  case 93:

/* Line 1806 of yacc.c  */
#line 682 "c-.y"
    {
       (yyval.nodeptr) = newExpNode(CallK);
       (yyval.nodeptr)->string = (yyvsp[(1) - (4)].tokenData)->tokenstr;
       (yyval.nodeptr)->linnum = (yyvsp[(1) - (4)].tokenData)->linnum;
       (yyval.nodeptr)->child[0] = (yyvsp[(3) - (4)].nodeptr);
     }
    break;

  case 94:

/* Line 1806 of yacc.c  */
#line 689 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;

  case 95:

/* Line 1806 of yacc.c  */
#line 690 "c-.y"
    { (yyval.nodeptr) = NULL; }
    break;

  case 96:

/* Line 1806 of yacc.c  */
#line 693 "c-.y"
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
#line 702 "c-.y"
    { (yyval.nodeptr) = (yyvsp[(1) - (1)].nodeptr); }
    break;



/* Line 1806 of yacc.c  */
#line 2708 "c-.tab.c"
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
#line 705 "c-.y"


void nodePrint(void * p){
  //  TreeNode * t = (TreeNode*)p;
}

SymTab * st = new SymTab(nodePrint);
int numError = 0; 
int numWarnings = 0;
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

    yyparse();
    savedTree = siblingNode(savedTree, Void, (char*)("outnl"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Character, (char*)("inputc"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Boolean, (char*)("inputb"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Integer, (char*)("input"), Void, (char*)(" "));
    savedTree = siblingNode(savedTree, Void, (char*)("outputc"), Character, (char*)("xyz"));
    savedTree = siblingNode(savedTree, Void, (char*)("outputb"), Boolean, (char*)("xyz"));
    savedTree = siblingNode(savedTree, Void, (char*)("output"), Integer, (char*)("xyz"));
    insertCheckNode(savedTree);  

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
int pcnt = 0;
bool WhileFlag = false;
bool ForEachFlag = false;
int depthcnt = 0;

static void insertCheckNode( TreeNode * t)  {

  switch (t->nodekind) {
  case DeclK:  
    switch(t->kind.decl){

    case VarK:
      if ((st->lookup(t->string) == NULL) || 
	  ( (st->lookupSymTabEntry(t->string))->depth != st->depth() ) ) {
	//|| (((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK) ){
	//&& ((st->lookupSymTabEntry(t->string))->depth != 1) ) )  {    
	//((st->lookupSymTabEntry(t->string))->depth != 1) )  { 
	st->insert(t->string, (void*)t ); 

	if (t->child[0] != NULL) {
	  insertCheckNode(t->child[0]);

	  if (t->child[0]->isConstant == false) {
	    printf("ERROR(%d): Initializer for variable '%s' is not a constant expression.\n", 
		   t->child[0]->linnum, t->string);
	    ++numError;
	  }

	  // initialize array variable
	  if ( (t->isArray == true) && (t->child[0] != NULL) ) {
	    if (t->expType != 3) {
	      printf("ERROR(%d): Array '%s' must be of type char to be initialized, but is of type %s.\n",
		     t->linnum, t->string, getType(t->expType));
	      ++numError;
	    }
	    if ( t->child[0]->isArray == false ) {
	      printf("ERROR(%d): Initializer for array variable '%s' must be a string, but is of nonarray type %s.\n",
		     t->child[0]->linnum, t->string, getType(t->child[0]->expType));
	      ++numError;
	    }
	  }

	  //if (t->expType != t->child[0]->expType){
	  if ( (t->isArray == false) && (t->expType != t->child[0]->expType) ) {
	    printf("ERROR(%d): Variable '%s' is of type %s but is being initialized with an expression of type %s.\n", 
		   t->linnum, t->string, getType(t->expType), getType(t->child[0]->expType));
	    ++numError;
	  }
	  if ( (t->isArray == false) && (t->child[0]->isArray == true) ) {
	    printf("ERROR(%d): Initializer for nonarray variable '%s' of type %s cannot be initialized with an array.\n",
		   t->child[0]->linnum, t->string, getType(t->expType));
	    ++numError;
	  }
	} // child[0] != NULL
      } else { // exist in symtab
	//	if ( (st->lookupSymTabEntry(t->string))->depth == st->depth() ) {
	if (((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK) {
	//if (((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK) {
	printf("ERROR(%d): Symbol '%s' is already defined at line %d.\n", 
	       t->linnum, t->string, ((TreeNode*)(st->lookup(t->string)))->linnum);
	++numError;
	}
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
      st->insert(t->string, (void*)t ); // potential duplicate here
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
	if ( (t->child[0]->kind.exp == IdK) &&
	     ( ((TreeNode*)(st->lookup(t->child[0]->string)))->isArray == true) ) {
	  printf("ERROR(%d): Cannot return an array.\n", t->linnum);  
	  ++numError;
	} 
	insertCheckNode(t->child[0]);
	t->expType = t->child[0]->expType;
      }
      sprintf(str, "Return:%d", st->depth());
      st->insert(str, (void*)t );
      if (t->sibling != NULL)  // just added
	insertCheckNode(t->sibling);
      break;

    case CompoundK:  
      depth = st->depth() + 1;
      sprintf(nameCompoundStat, "Compound Statement:%d", depth);
      //printf("\n****** enter %s ******\n", nameCompoundStat);
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
	  if (t->child[0]->expType != 1) {
	    printf("ERROR(%d): '%s' requires operands of type int but lhs is of type %s.\n", 
		   t->linnum, t->string, getType(t->child[0]->expType));
	    ++numError;
	  } else {
	    printf("ERROR(%d): '%s' requires operands of type int but rhs is of type %s.\n", 
		   t->linnum, t->string, getType(t->child[1]->expType));
	    ++numError;
	  }
	} else if ( (t->attr.op == '=') && (t->child[0] != NULL) && (t->child[1] != NULL) ) {
	  if ( t->child[0]->isArray != t->child[1]->isArray ){
	    printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		   t->linnum, t->string);
	    ++numError;
	  }
	  if (t->child[0]->expType != t->child[1]->expType) {
	    printf("ERROR(%d): '%s' requires operands of the same type but lhs is type %s and rhs is type %s.\n", 
		   t->linnum, t->string, getType(t->child[0]->expType), getType(t->child[1]->expType));
	    ++numError;
	  }
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
	  t->child[0]->expType = Integer; 
	}
	if (t->child[0]->isArray == true) {
	  printf("ERROR(%d): The operation '%s' does not work with arrays.\n", t->linnum, t->string);
	  ++numError;
	}
      }

      if ( (t->attr.op == '=') && (t->child[0] != NULL) && (t->child[1] != NULL) ) {
	if ( t->child[0]->isArray != t->child[1]->isArray ){
	  printf("ERROR(%d): '%s' requires that if one operand is an array so must the other operand.\n", 
		 t->linnum, t->string);
	  ++numError;
	}
      }

      if (t->sibling != NULL)
	insertCheckNode(t->sibling);
      break;

    case CallK:
      if (st->lookup(t->string) == NULL) {
	printf("ERROR(%d): Symbol '%s' is not defined.\n", t->linnum, t->string);
	++numError;
	t->expType = Void; 
	st->insert(t->string, (void*)t );
	if (t->child[0] != NULL)
	  insertCheckNode(t->child[0]);
      } else {
	if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK ) {
	  printf("ERROR(%d): '%s' is a simple variable and cannot be called.\n", t->linnum, t->string);
	  ++numError;
	} else { //FuncK
	  TreeNode* p = (TreeNode*)(st->lookup(t->string));
	  // differentiate between VarK and FuncK ????

	  if ( (t->child[0] == NULL) && (p->child[0] != NULL) ) {
	    printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		   t->linnum, t->string, p->linnum);
	    ++numError;
	  }
	  if (t->child[0] != NULL) {
	    insertCheckNode(t->child[0]);
	    pcnt = 0;

	    if (p->child[0] == NULL) {
	      printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		     t->child[0]->linnum, t->string, p->linnum);
	      ++numError;
	    } else {
	      if ((t->child[0]->expType != p->child[0]->expType) && (t->child[0]->expType != 4) ) {
		printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
		       t->child[0]->linnum, getType(p->child[0]->expType), pcnt+1, t->string, p->linnum, getType(t->child[0]->expType));
		++numError;
		t->child[0]->expType != p->child[0]->expType;
	      }
	      if (t->child[0]->expType == p->child[0]->expType) 
		t->expType = p->expType;

	      if ( (t->child[0]->isArray == true) && (p->child[0]->isArray == false) ) {
		printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
		       t->child[0]->linnum, pcnt+1, t->string, p->linnum);
		++numError;
	      }
	      if ( (t->child[0]->isArray == false) && (p->child[0]->isArray == true) ) {
		printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
		       t->child[0]->linnum, pcnt+1, t->string, p->linnum);
		++numError;
	      }

	      TreeNode* tmpt = t->child[0];
	      TreeNode* tmpp = p->child[0];
	      while ( (tmpt->sibling != NULL) &&  (tmpp->sibling != NULL) ) {
		++pcnt;

		if ( (tmpt->sibling->expType != tmpp->sibling->expType) && (tmpt->sibling->expType != 4) ) {
		  printf("ERROR(%d): Expecting type %s in parameter %i of call to '%s' defined on line %d but got type %s.\n", 
			 tmpt->sibling->linnum, getType(tmpp->sibling->expType), pcnt+1, t->string, 
			 p->linnum, getType(tmpt->sibling->expType));
		  ++numError;
		}
		if ( (tmpt->sibling->isArray == true) && (tmpp->sibling->isArray == false) ) {
		  printf("ERROR(%d): Not expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 tmpt->sibling->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		if ( (tmpt->sibling->isArray == false) && (tmpp->sibling->isArray == true) ) {
		  printf("ERROR(%d): Expecting array in parameter %i of call to '%s' defined on line %d.\n", 
			 tmpt->sibling->linnum, pcnt+1, t->string, p->linnum);
		  ++numError;
		}
		tmpt = tmpt->sibling;
		tmpp = tmpp->sibling;
	      }

	      if ( (tmpt->sibling != NULL) &&  (tmpp->sibling == NULL) ) {
		printf("ERROR(%d): Too many parameters passed for function '%s' defined on line %d.\n", 
		       tmpt->sibling->linnum, t->string, p->linnum);
		++numError;
	      }
	      if ( (tmpt->sibling == NULL) &&  (tmpp->sibling != NULL) ) {
		printf("ERROR(%d): Too few parameters passed for function '%s' defined on line %d.\n", 
		       tmpt->sibling->linnum, t->string, p->linnum);
		++numError;
	      }
	    } // end p->child[0] != NULL
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
	st->insert(t->string, (void*)t );

	if (t->child[0] != NULL) 
	  insertCheckNode(t->child[0]);
      } else {  // symtab != NULL

	if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == FuncK ) {
	  printf("ERROR(%d): Cannot use function '%s' as a simple variable.\n", t->linnum, t->string);
	  ++numError;
	} else {//if ( ((TreeNode*)(st->lookup(t->string)))->kind.decl == VarK ) {

	  // Dealing Array or Not
	  if (((TreeNode*)(st->lookup(t->string)))->isArray == false) {
	    t->isArray = false;
	    t->expType = ((TreeNode*)(st->lookup(t->string)))->expType;
	    if (t->child[0] != NULL) {
	      printf("ERROR(%d): Cannot index nonarray '%s'.\n", t->linnum, t->string);
	      ++numError;
	    } 
	  } else { //isArray == true
	    t->isArray = true; 

	    if (t->child[0] != NULL) {
	      insertCheckNode(t->child[0]);

	      // isArray
	      if (t->child[0]->isArray == true) {
		printf("ERROR(%d): Array index is the unindexed array '%s'.\n", 
		       t->child[0]->linnum, t->child[0]->string);
		++numError;
	      } else {
		if ( (t->child[0]->expType == Integer) || (t->child[0]->expType == Undefined) ) //t->child[0]->expType: int
		  t->isArray = false;
		else {
		  printf("ERROR(%d): Array '%s' should be indexed by type int but got type %s.\n", 
			 t->linnum, t->string, getType(t->child[0]->expType));
		  ++numError;
		}
	      } //t->child[0]->isArray == false
	    } // child[0] != NULL
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
	if ( (t->child[0] != NULL) && (t->child[0]->expType != Integer) ) {
	  printf("ERROR(%d): '%s' requires operands of type %s but lhs is of type %s.\n", t->linnum, t->string, 
		 getType(1), getType(t->child[0]->expType));
	  ++numError;
	  t->child[0]->expType = Integer; 
	} 
	if ( (t->child[1] != NULL) && (t->child[1]->expType != Integer) ) {
	  printf("ERROR(%d): '%s' requires operands of type %s but rhs is of type %s.\n", t->linnum, t->string, 
		 getType(1), getType(t->child[1]->expType));
	  ++numError;
	  t->child[1]->expType = Integer; 
	} 
	t->expType = Integer; 
      }  

      if ((t->attr.op == '-') && (t->child[0] != NULL) && (t->child[1] == NULL)) {
	if (t->child[0]->expType != Integer) {
	  printf("ERROR(%d): Unary '%s' requires an operand of type int but was given type %s.\n", 
		 t->linnum, t->string, getType(t->child[0]->expType));	       
	  ++numError;
	  t->child[0]->expType = Integer; 
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

      if ( (t->attr.op == '*') && (t->child[0] != NULL) && 
	   (t->child[1] == NULL) && (t->child[0]->isArray == false) ){
	printf("ERROR(%d): The operation '%s' only works with arrays.\n", t->linnum, t->string);
	++numError;
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

      if ( (t->attr.op == AND) && t->child[0] && t->child[1] ) {
	//cout << "t->child[0]->expType: " << t->child[0]->expType << endl;

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
	   ((t->child[0]->isConstant == 1) && (t->child[1]->isConstant == 1)) ) 
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


