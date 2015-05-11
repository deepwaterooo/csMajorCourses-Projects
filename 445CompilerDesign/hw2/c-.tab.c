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


  // definitions section

#include <iostream>
#include <cstring>
#include <cctype>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "scanType.h"  
#include "c-.tab.h"

extern int yylex();
extern int yyparse();
extern FILE * yyin;
char *yyfilename;

/*
#define MAXCHILDREN 3
typedef struct treeNode {
  // connectivity in the tree
  struct treeNode *child[MAXCHILDREN];   // children of the node
  struct treeNode *sibling;              // siblings for the node

  // what kind of node
  int lineno;                            // linenum relevant to this node
  NodeKind nodekind;                     // type of node
  union {                                // subtype of type 
    DeclKind decl;                     // used when DeclK
    StmtKind stmt;                     // used when StmtK
    ExpKind exp;                       // used when ExpK
  } kind;
    
  // extra properties about the node depending on type of the node
  union {                                  // relevant data to type -> attr
    OpKind op;                         // type of token (same as in bison)
    int val;                           // used when an integer constant
    char *name;                        // used when IdK
    char *string;                      // used when a string constant
  } attr;                                 
  ExpType expType;		           // used when ExpK for type checking
  bool isStatic;                         // is staticly allocated?
  bool isArray;                          // is this an array
  bool isConstant;                       // can this expression be precomputed?

  // even more semantic stuff will go here in later assignments.
} TreeNode;

// the root of the abstract syntax tree
TreeNode *root;
*/
extern char *yytext;
extern int linnum;

using namespace std;
#define YY_DECL extern "C" int yylex()
//#define YYERROR_VERBOSE
#define YYDEBUG 1
/*
// Prints a token and its lexeme to the listing file
void printToken( TokenType, const char *);
// creates a new statement node for syntax tree construction
TreeNode * newStmtNode( StmtKind );
// creates a new expression node for syntax tree construction
TreeNode * newExpNode( ExpKind );
// allocates and makes a new copy of an existing string
char * copyString( char * );
// prints a syntax tree to the listing file using indentation to indicate subtrees 
void printTree( TreeNode * );
*/
//void printTree(FILE *, TreeNode *); 
// void FreeTree(Node *p);
// void PrintTree(Node *p, int depth);
void yyerror(const char* s);


/* Line 268 of yacc.c  */
#line 149 "c-.tab.c"

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
     ID = 258,
     QUIT = 259,
     CHARCONST = 260,
     NUMCONST = 261,
     STRINGCONST = 262,
     IF = 263,
     ELSE = 264,
     WHILE = 265,
     FOREACH = 266,
     IN = 267,
     STATIC = 268,
     INT = 269,
     BOOL = 270,
     CHAR = 271,
     E = 272,
     TRUE = 273,
     FALSE = 274,
     RETURN = 275,
     BREAK = 276,
     OR = 277,
     NOT = 278,
     INC = 279,
     DEC = 280,
     LEQ = 281,
     GEQ = 282,
     EQ = 283,
     NEQ = 284,
     PASSIGN = 285,
     MASSIGN = 286,
     lt = 287,
     gt = 288,
     equal = 289,
     plus = 290,
     minus = 291,
     multiply = 292,
     divide = 293,
     mod = 294,
     comma = 295,
     semicolon = 296,
     colon = 297,
     leftp2 = 298,
     leftp = 299,
     leftp3 = 300,
     rightp2 = 301,
     rightp = 302,
     rightp3 = 303,
     AND = 304
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 293 of yacc.c  */
#line 78 "c-.y"

  Token * token;



/* Line 293 of yacc.c  */
#line 240 "c-.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 343 of yacc.c  */
#line 252 "c-.tab.c"

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
#define YYLAST   224

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  50
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  54
/* YYNRULES -- Number of rules.  */
#define YYNRULES  117
/* YYNRULES -- Number of states.  */
#define YYNSTATES  177

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   304

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
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
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     5,     8,    10,    12,    14,    18,    22,
      26,    28,    30,    34,    37,    38,    42,    45,    47,    49,
      51,    53,    60,    66,    68,    69,    73,    75,    78,    82,
      84,    86,    91,    93,    94,    96,    98,   100,   102,   104,
     106,   111,   114,   115,   118,   119,   122,   124,   126,   128,
     136,   138,   140,   142,   144,   146,   152,   154,   156,   159,
     160,   163,   169,   177,   180,   184,   187,   191,   195,   199,
     202,   205,   207,   211,   213,   217,   219,   222,   224,   227,
     228,   231,   233,   235,   237,   239,   241,   243,   247,   249,
     251,   253,   257,   259,   261,   263,   265,   268,   270,   272,
     274,   276,   278,   281,   282,   286,   290,   292,   294,   299,
     301,   302,   306,   308,   310,   312,   314,   316
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      51,     0,    -1,    52,    -1,    52,    53,    -1,    53,    -1,
      54,    -1,    62,    -1,    61,    56,    41,    -1,    60,    56,
      41,    -1,    56,    40,    57,    -1,    57,    -1,    58,    -1,
      58,    42,    84,    -1,     3,    59,    -1,    -1,    45,     6,
      48,    -1,    13,    61,    -1,    61,    -1,    14,    -1,    15,
      -1,    16,    -1,    61,     3,    44,    63,    47,    69,    -1,
       3,    44,    63,    47,    69,    -1,    64,    -1,    -1,    64,
      41,    65,    -1,    65,    -1,    61,    66,    -1,    66,    40,
      67,    -1,    67,    -1,     3,    -1,     3,    45,    68,    48,
      -1,     6,    -1,    -1,    73,    -1,    70,    -1,    74,    -1,
      80,    -1,    81,    -1,    82,    -1,    43,    71,    72,    46,
      -1,    71,    55,    -1,    -1,    72,    69,    -1,    -1,    83,
      41,    -1,    41,    -1,    75,    -1,    76,    -1,     8,    44,
      84,    47,    75,     9,    75,    -1,    73,    -1,    70,    -1,
      80,    -1,    81,    -1,    82,    -1,     8,    44,    84,    47,
      77,    -1,    78,    -1,    76,    -1,    75,    79,    -1,    -1,
       9,    76,    -1,    10,    44,    84,    47,    69,    -1,    11,
      44,    97,    12,    84,    47,    69,    -1,    20,    41,    -1,
      20,    83,    41,    -1,    21,    41,    -1,    97,    34,    83,
      -1,    97,    30,    83,    -1,    97,    31,    83,    -1,    97,
      24,    -1,    97,    25,    -1,    84,    -1,    84,    22,    85,
      -1,    85,    -1,    85,    49,    86,    -1,    86,    -1,    23,
      86,    -1,    87,    -1,    90,    88,    -1,    -1,    89,    90,
      -1,    32,    -1,    33,    -1,    26,    -1,    27,    -1,    28,
      -1,    29,    -1,    90,    91,    92,    -1,    92,    -1,    35,
      -1,    36,    -1,    92,    93,    94,    -1,    94,    -1,    37,
      -1,    38,    -1,    39,    -1,    95,    94,    -1,    96,    -1,
      36,    -1,    37,    -1,    99,    -1,    97,    -1,     3,    98,
      -1,    -1,    45,    83,    48,    -1,    44,    83,    47,    -1,
     100,    -1,   103,    -1,     3,    44,   101,    47,    -1,   102,
      -1,    -1,    83,    40,   102,    -1,    83,    -1,     6,    -1,
       5,    -1,     7,    -1,    18,    -1,    19,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    96,    96,    98,    99,   101,   102,   106,   109,   112,
     113,   117,   118,   122,   123,   124,   128,   129,   131,   132,
     133,   137,   138,   142,   143,   146,   147,   150,   153,   154,
     158,   159,   161,   162,   166,   167,   168,   169,   170,   171,
     174,   177,   178,   181,   182,   185,   186,   190,   191,   193,
     194,   195,   196,   197,   198,   200,   202,   203,   205,   207,
     208,   219,   220,   223,   224,   227,   231,   232,   233,   234,
     235,   236,   238,   239,   241,   242,   246,   247,   251,   252,
     253,   256,   257,   258,   259,   260,   261,   265,   266,   268,
     269,   271,   272,   274,   275,   276,   278,   279,   281,   282,
     286,   287,   291,   293,   294,   297,   298,   299,   302,   306,
     307,   310,   311,   313,   314,   315,   316,   317
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "QUIT", "CHARCONST", "NUMCONST",
  "STRINGCONST", "IF", "ELSE", "WHILE", "FOREACH", "IN", "STATIC", "INT",
  "BOOL", "CHAR", "E", "TRUE", "FALSE", "RETURN", "BREAK", "OR", "NOT",
  "INC", "DEC", "LEQ", "GEQ", "EQ", "NEQ", "PASSIGN", "MASSIGN", "lt",
  "gt", "equal", "plus", "minus", "multiply", "divide", "mod", "comma",
  "semicolon", "colon", "leftp2", "leftp", "leftp3", "rightp2", "rightp",
  "rightp3", "AND", "$accept", "program", "declaration_list",
  "declaration", "var_declaration", "scoped_var_declaration",
  "var_decl_list", "var_decl_initialize", "var_decl_id", "id_exp0",
  "scoped_type_specifier", "type_specifier", "fun_declaration", "params",
  "param_list", "param_type_list", "param_id_list", "param_id", "mid_exp",
  "statement", "compound_stmt", "local_declarations", "statement_list",
  "expression_stmt", "selection_stmt", "matched", "unmatched",
  "unmatched_exp", "matched_exp", "matched_else_exp", "iteration_stmt",
  "return_stmt", "break_stmt", "expression", "simple_expression",
  "and_expression", "unary_rel_expression", "rel_expression",
  "sum_expression_rest", "relop", "sum_expression", "sumop", "term",
  "mulop", "unary_expression", "unaryop", "factor", "mutable", "id_exp39",
  "immutable", "call", "args", "arg_list", "constant", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    50,    51,    52,    52,    53,    53,    54,    55,    56,
      56,    57,    57,    58,    59,    59,    60,    60,    61,    61,
      61,    62,    62,    63,    63,    64,    64,    65,    66,    66,
      67,    67,    68,    68,    69,    69,    69,    69,    69,    69,
      70,    71,    71,    72,    72,    73,    73,    74,    74,    75,
      75,    75,    75,    75,    75,    76,    77,    77,    78,    79,
      79,    80,    80,    81,    81,    82,    83,    83,    83,    83,
      83,    83,    84,    84,    85,    85,    86,    86,    87,    88,
      88,    89,    89,    89,    89,    89,    89,    90,    90,    91,
      91,    92,    92,    93,    93,    93,    94,    94,    95,    95,
      96,    96,    97,    98,    98,    99,    99,    99,   100,   101,
     101,   102,   102,   103,   103,   103,   103,   103
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     3,     3,     3,
       1,     1,     3,     2,     0,     3,     2,     1,     1,     1,
       1,     6,     5,     1,     0,     3,     1,     2,     3,     1,
       1,     4,     1,     0,     1,     1,     1,     1,     1,     1,
       4,     2,     0,     2,     0,     2,     1,     1,     1,     7,
       1,     1,     1,     1,     1,     5,     1,     1,     2,     0,
       2,     5,     7,     2,     3,     2,     3,     3,     3,     2,
       2,     1,     3,     1,     3,     1,     2,     1,     2,     0,
       2,     1,     1,     1,     1,     1,     1,     3,     1,     1,
       1,     3,     1,     1,     1,     1,     2,     1,     1,     1,
       1,     1,     2,     0,     3,     3,     1,     1,     4,     1,
       0,     3,     1,     1,     1,     1,     1,     1
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,    18,    19,    20,     0,     2,     4,     5,     0,
       6,    24,     1,     3,    14,     0,    10,    11,     0,     0,
      23,    26,    24,     0,    13,     0,     7,     0,    30,    27,
      29,     0,     0,     0,     0,    14,     9,   103,   114,   113,
     115,   116,   117,     0,    98,    99,     0,    12,    73,    75,
      77,    79,    88,    92,     0,    97,   101,   100,   106,   107,
      33,     0,     0,     0,     0,     0,     0,    46,    42,    22,
      35,    34,    36,    47,    48,    37,    38,    39,     0,    71,
     101,    25,     0,    15,   110,     0,   102,    76,     0,     0,
       0,    83,    84,    85,    86,    81,    82,    89,    90,    78,
       0,     0,    93,    94,    95,     0,    96,    32,     0,    28,
       0,     0,     0,    63,     0,    65,    44,    45,    69,    70,
       0,     0,     0,    21,   112,     0,   109,     0,   105,    72,
      74,    80,    87,    91,    31,     0,     0,   103,     0,    64,
       0,    41,     0,    17,     0,    67,    68,    66,     0,   108,
     104,     0,     0,     0,    16,     0,    40,    43,   111,    51,
      50,    59,    57,    55,    56,    52,    53,    54,    61,     0,
       8,     0,    58,     0,    49,    60,    62
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     5,     6,     7,     8,   141,    15,    16,    17,    24,
     142,    18,    10,    19,    20,    21,    29,    30,   108,    69,
      70,   116,   144,    71,    72,    73,    74,   163,   164,   172,
      75,    76,    77,    78,    79,    48,    49,    50,    99,   100,
      51,   101,    52,   105,    53,    54,    55,    80,    86,    57,
      58,   125,   126,    59
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -136
static const yytype_int16 yypact[] =
{
      46,   -29,  -136,  -136,  -136,    27,    46,  -136,  -136,    31,
    -136,    66,  -136,  -136,   -25,   -18,  -136,    11,    80,   -17,
      51,  -136,    66,    49,  -136,    90,  -136,   145,    60,    61,
    -136,   136,    66,    59,    48,    62,  -136,    14,  -136,  -136,
    -136,  -136,  -136,   145,  -136,  -136,   145,    86,    65,  -136,
    -136,   168,    52,  -136,   180,  -136,  -136,  -136,  -136,  -136,
     103,    80,    73,    74,    75,     6,    79,  -136,  -136,  -136,
    -136,  -136,  -136,  -136,  -136,  -136,  -136,  -136,    81,    86,
     181,  -136,   136,  -136,   145,   145,  -136,  -136,    76,   145,
     145,  -136,  -136,  -136,  -136,  -136,  -136,  -136,  -136,  -136,
     180,   180,  -136,  -136,  -136,   180,  -136,  -136,    77,  -136,
     145,   145,   118,  -136,    83,  -136,    56,  -136,  -136,  -136,
     145,   145,   145,  -136,    91,    85,  -136,    78,  -136,    65,
    -136,     9,    52,  -136,  -136,   -14,   -12,    89,   125,  -136,
      66,  -136,    90,  -136,    92,  -136,  -136,  -136,   145,  -136,
    -136,   136,   136,   145,  -136,    26,  -136,  -136,  -136,  -136,
    -136,   140,  -136,  -136,  -136,  -136,  -136,  -136,  -136,    -8,
    -136,   136,  -136,   136,  -136,  -136,  -136
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -136,  -136,  -136,   139,  -136,  -136,    16,   128,  -136,  -136,
    -136,     0,  -136,   138,  -136,   129,  -136,   101,  -136,   -79,
    -135,  -136,  -136,  -133,  -136,  -125,  -120,  -136,  -136,  -136,
    -119,  -114,  -103,   -44,   -23,    82,   -36,  -136,  -136,  -136,
      67,  -136,    64,  -136,   -49,  -136,  -136,   -26,  -136,  -136,
    -136,  -136,    18,  -136
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
       9,    56,    88,   123,    47,   106,     9,    87,    89,    37,
      89,    38,    39,    40,    89,    11,   159,    56,   160,    22,
      23,   114,    25,    26,    41,    42,   161,    12,    56,    43,
      31,   162,   165,   151,    14,   152,   159,   166,   160,   173,
     124,   127,    44,    45,    97,    98,   174,   113,   167,     1,
      46,   175,   165,    27,   130,    34,   133,   166,    84,    85,
       2,     3,     4,    56,    56,   157,    25,   170,   167,   140,
       2,     3,     4,   168,    56,    56,   145,   146,   147,    56,
       2,     3,     4,    28,    56,    56,   138,   135,   136,   102,
     103,   104,    32,    35,   176,    37,    83,    38,    39,    40,
      62,    61,    63,    64,   124,    60,    82,    23,    89,   107,
      41,    42,    65,    66,    90,    43,   143,   110,   111,   112,
     115,   137,   117,   128,   139,   134,   150,    56,    44,    45,
     169,   148,   149,    67,    85,    68,    46,   153,   156,    37,
     154,    38,    39,    40,    62,    13,    63,    64,    37,   171,
      38,    39,    40,    36,    41,    42,    65,    66,   155,    43,
      33,    81,   109,    41,    42,   132,   158,   131,    43,     0,
       0,   129,    44,    45,     0,     0,     0,    67,     0,    68,
      46,    44,    45,    37,     0,    38,    39,    40,     0,    46,
       0,     0,     0,     0,    91,    92,    93,    94,    41,    42,
      95,    96,     0,    97,    98,   118,   119,     0,     0,     0,
       0,   120,   121,     0,     0,   122,    44,    45,     0,     0,
       0,     0,     0,     0,    46
};

#define yypact_value_is_default(yystate) \
  ((yystate) == (-136))

#define yytable_value_is_error(yytable_value) \
  YYID (0)

static const yytype_int16 yycheck[] =
{
       0,    27,    46,    82,    27,    54,     6,    43,    22,     3,
      22,     5,     6,     7,    22,    44,   151,    43,   151,    44,
      45,    65,    40,    41,    18,    19,   151,     0,    54,    23,
      47,   151,   151,    47,     3,    47,   171,   151,   171,    47,
      84,    85,    36,    37,    35,    36,   171,    41,   151,     3,
      44,   171,   171,    42,    90,     6,   105,   171,    44,    45,
      14,    15,    16,    89,    90,   144,    40,    41,   171,    13,
      14,    15,    16,   152,   100,   101,   120,   121,   122,   105,
      14,    15,    16,     3,   110,   111,   112,   110,   111,    37,
      38,    39,    41,     3,   173,     3,    48,     5,     6,     7,
       8,    40,    10,    11,   148,    45,    47,    45,    22,     6,
      18,    19,    20,    21,    49,    23,   116,    44,    44,    44,
      41,     3,    41,    47,    41,    48,    48,   153,    36,    37,
     153,    40,    47,    41,    45,    43,    44,    12,    46,     3,
     140,     5,     6,     7,     8,     6,    10,    11,     3,     9,
       5,     6,     7,    25,    18,    19,    20,    21,   142,    23,
      22,    32,    61,    18,    19,   101,   148,   100,    23,    -1,
      -1,    89,    36,    37,    -1,    -1,    -1,    41,    -1,    43,
      44,    36,    37,     3,    -1,     5,     6,     7,    -1,    44,
      -1,    -1,    -1,    -1,    26,    27,    28,    29,    18,    19,
      32,    33,    -1,    35,    36,    24,    25,    -1,    -1,    -1,
      -1,    30,    31,    -1,    -1,    34,    36,    37,    -1,    -1,
      -1,    -1,    -1,    -1,    44
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    14,    15,    16,    51,    52,    53,    54,    61,
      62,    44,     0,    53,     3,    56,    57,    58,    61,    63,
      64,    65,    44,    45,    59,    40,    41,    42,     3,    66,
      67,    47,    41,    63,     6,     3,    57,     3,     5,     6,
       7,    18,    19,    23,    36,    37,    44,    84,    85,    86,
      87,    90,    92,    94,    95,    96,    97,    99,   100,   103,
      45,    40,     8,    10,    11,    20,    21,    41,    43,    69,
      70,    73,    74,    75,    76,    80,    81,    82,    83,    84,
      97,    65,    47,    48,    44,    45,    98,    86,    83,    22,
      49,    26,    27,    28,    29,    32,    33,    35,    36,    88,
      89,    91,    37,    38,    39,    93,    94,     6,    68,    67,
      44,    44,    44,    41,    83,    41,    71,    41,    24,    25,
      30,    31,    34,    69,    83,   101,   102,    83,    47,    85,
      86,    90,    92,    94,    48,    84,    84,     3,    97,    41,
      13,    55,    60,    61,    72,    83,    83,    83,    40,    47,
      48,    47,    47,    12,    61,    56,    46,    69,   102,    70,
      73,    75,    76,    77,    78,    80,    81,    82,    69,    84,
      41,     9,    79,    47,    75,    76,    69
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
      

/* Line 1806 of yacc.c  */
#line 1667 "c-.tab.c"
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
#line 320 "c-.y"


main(int argc, char* argv[]){

  int d_flag = 0;
  char * d_value = NULL;
  int c;

  if (argc == 1) 
    yyin = stdin;
  else if (argc == 2) {
      yyin = fopen(argv[1], "r");
  } else if (argc > 2) {  
      while ((c = getopt (argc, argv, "d")) != -1)
	switch (c) {      
	case 'd':
	  d_flag = 1;
	  break;
	default:
	  abort ();
	}
      if (d_flag == 1)
	yydebug = 1;
      yyin = fopen(argv[2], "r");
  } else {
    printf("Usage: ./c- TestFileName\nUsage: ./c- < TestFileName\nUsage: cat TestFileName | ./c-\n");
    exit(-1);
  }

  if (yyin == NULL){
    printf("Can't open/read '%s'\n", argv[2]);
    exit(-1);
  }

  yyfilename = argv[1];
  linnum = 1;

  do {
    yyparse();
    //    printTree(stdout, syntaxTree);
  }   while ( !feof(yyin)) ;

  if (argc != 1)
    fclose(yyin);
}

/*
// Prints a token and its lexeme to the listing file
void printToken( TokenType token, const char * tokenString){
  switch (token){
  case IF: 
  case THEN: 
  case ELSE: 
  case END:
  case REPEAT:
  case UNTIL:
  case READ:
  case WRITE:
    fprintf(listing, "reserved word: %s\n", tokenString);
    break;
  case ASSIGN: fprintf(listing, ":=\n"); break;
  case LT: fprintf(listing, "<\n"); break;
  case EQ: fprintf(listing, "=\n"); break;
  case LPAREN: fprintf(listing, "(\n"); break;
  case RPAREN: fprintf(listing, ")\n"); break;
  case SEMI: fprintf(listing, ";\n"); break;
  case PLUS: fprintf(listing, "+\n"); break;
  case MINUS: fprintf(listing, "-\n"); break;
  case TIMES: fprintf(listing, "*\n"); break;
  case OVER: fprintf(listing, "/n"); break;
  case ENDFILE: fprintf(listing, "EOF\n"); break;
  case NUM:
        fprintf(listing, "NUM, val= %s\n", tokenString);
	break;
  case ID:
        fprintf(listing, "ID, name= %s\n", tokenString);
	break;
  case ERROR:
        fprintf(listing, "ERROR: %s\n", tokenString);
	break;
  default: 
        fprintf(listing, "Unknow token: %s\n", tokenString);
	break;
  }
}

// creates a new statement node for syntax tree construction
TreeNode * newStmtNode( StmtKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    fprintf(listing, "Out of memory error at line %d\n", lineno);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind.stmt = kind; 
  }
  return t;
}

// creates a new expression node for syntax tree construction
TreeNode * newExpNode( ExpKind kind){
  TreeNode * t = (TreeNode*) malloc(sizeof(TreeNode));
  int i; 
  if (t==NULL)
    fprintf(listing, "Out of memory error at line %d\n", lineno);
  else {
    for (i = 0; i < MAXCHILDREN; i++)
      t->child[i] = NULL; 
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind.stmt = kind; 
    t->type = void;
  }
  return t;
}

// allocates and makes a new copy of an existing string
char * copyString( char * s){
  int n; 
  if (s==NULL) return NULL;
  n = strlen(s) + 1;
  t = malloc(n);
  if (t==NULL)
    fprintf(listing, "Out of memory error at line %d\n", lineno);
  else strcpy(t, s);
  return t;
}

// Variable indentno is used by printTree to store current number of spaces to indetn
static indentno = 0;

// macros to increase/decrease indentation
#define INDENT indentno += 2
#define UNINDENT indentno -= 2

// indents by printing spaces
static void printSpaces(void){
  int i;
  for (i = 0; i < indentno; i++){
    fprintf(listing, "  ");
  }
}

// prints a syntax tree to the listing file using indentation to indicate subtrees 
void printTree( TreeNode * tree){
  int i; 
  INDENT;
  while (tree != NULL){
    printSpaces();
    if (tree->nodekind == StmtK){
      switch (tree->kind.stmt){
      case IfK:
	fprintf(listing, "If\n");
	break;
      case RepeatK:
	fprintf(listing, "Repeat\n");
	break;
      case AssignK:
	fprintf(listing, "Assign to: %s\n", tree->attr.name);
	break;
      case ReadK:
	fprintf(listing, "Read: %s\n", tree->attr.name);
	break;
      case WriteK:
	fprintf(listing, "Write\n");
	break;
      default:
	fprintf(listing, "Unknown ExpNode kind\n");
	break;
      }
    }
    else if (tree->nodekind == ExpK){
      switch (tree->kind.exp){
      case OpK:
	fprintf(listing, "Op: ");
	printToken(tree->attr.op, "\0");
	break;
      case ConstK:
	fprintf(listing, "const: %d\n", tree->attr.val);
	break;
      case IdK:
	fprintf(listing, "Id: %s\n", tree->attr.name);
	break;
      default:
	fprintf(listing, "Unknown ExpNode kind\n");
	printToken(tree->attr.op, "\0");
	break;
      }
    }
    else fprintf(listing, "Unknown node kind\n");
    for (i = 0; i < MAXCHILDREN; i++)
      printTree(tree->child[i]);
    tree = tree->sibling; 
  }
  UNINDENT;
}
*/

/*
void PrintTree(Node *p, int depth){  
  for (int i = 0; i < depth; i++) cout << '\t';        
  if(!p->arrived_value.empty()){  
    cout<<p->arrived_value<<endl;  
    for (int i = 0; i < depth+1; i++) cout << '\t';   
  }  
  cout<<p->attribute;  
  //cout<<p->attribute<< "\t cnt:" << p->cnt << endl; 
  if ( (!p->attribute.compare(yes)) || (!p->attribute.compare(no)) )
		cout << "\t cnt:" << p->cnt << endl;
  else
		cout << endl;
  for (vector<Node*>::iterator it = p->childs.begin(); it != p->childs.end(); it++){  
    PrintTree(*it, depth + 1);  
  }  
}  

void FreeTree(Node *p){  
  if (p == NULL)  
    return;  
  //rootcnt = p->cnt;
  for (vector<Node*>::iterator it = p->childs.begin(); it != p->childs.end(); it++){  
	totalcnt += (*it)->cnt ;
    FreeTree(*it);  
  }  
  delete p;  
  tree_size++;  
}  
*/

void yyerror(const char* s){
  fprintf(stderr, "%s in line %d in token %s\n", s, linnum, yytext);
  //printf("ERROR lineno(%d):%s. I got: %s\n", linnum, s, yytext);
  exit(-1);
}


