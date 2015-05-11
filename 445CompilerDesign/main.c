  1 /****************************************************/
  2 /* File: main.c                                     */
  3 /* Main program for TINY compiler                   */
  4 /* Compiler Construction: Principles and Practice   */
  5 /* Kenneth C. Louden                                */
  6 /****************************************************/
  7 
  8 #include "globals.h"
  9 
 10 /* allocate global variables */
 11 int lineno = 0;
 12 FILE *source;
 13 FILE *listing;
 14 FILE *code;
 15 
 16 /* allocate and set tracing flags */
 17 int EchoSource = FALSE;
 18 int TraceScan = FALSE;
 19 int TraceParse = FALSE;
 20 int TraceAnalyze = FALSE;
 21 int TraceCode = FALSE;
 22 
 23 int Error = FALSE;
 24 
 25 
 26 main(int argc, char *argv[])
 27 {
 28     TreeNode *syntaxTree;
 29     char pgm[120];              /* source code file name */
 30 //RH
 31 //RH use getopt here and not this ad hoc sort of way.  Best to
 32 //RH learn to use it now since we will be adding options in each
 33 //RH assignment.  See getopt handout on the class web page
 34 //RH
 35     if (argc != 2) {
 36         fprintf(stderr, "usage: %s <filename>\n", argv[0]);
 37         exit(1);
 38     }
 39     strcpy(pgm, argv[1]);
 40     if (strchr(pgm, '.') == NULL)
 41         strcat(pgm, ".tny");
 42     source = fopen(pgm, "r");
 43     if (source == NULL) {
 44         fprintf(stderr, "File %s not found\n", pgm);
 45         exit(1);
 46     }
 47     listing = stdout;           /* send listing to screen */
 48 
 49 //RH Don't print out anything I don't ask for.
 50 
 51     fprintf(listing, "\nTINY COMPILATION: %s\n", pgm);
 52 #if NO_PARSE
 53     while (getToken() != ENDFILE);
 54 #else
 55 
 56 
 57 //RH parse the input and create a tree.
 58     syntaxTree = parse();
 59     if (TraceParse) {
 60         fprintf(listing, "\nSyntax tree:\n");
 61         printTree(syntaxTree);
 62     }
 63 //RH this is where assignment 2 ends!
 64 
 65 #if !NO_ANALYZE
 66     if (!Error) {
 67         if (TraceAnalyze)
 68             fprintf(listing, "\nBuilding Symbol Table...\n");
 69 
 70 //RH build symbol table
 71         buildSymtab(syntaxTree);
 72         if (TraceAnalyze)
 73             fprintf(listing, "\nChecking Types...\n");
 74 
 75 //RH do type checking
 76         typeCheck(syntaxTree);
 77         if (TraceAnalyze)
 78             fprintf(listing, "\nType Checking Finished\n");
 79     }
 80 #if !NO_CODE
 81     if (!Error) {
 82         char *codefile;
 83 
 84 //RH create output file
 85         int fnlen = strcspn(pgm, ".");
 86         codefile = (char *) calloc(fnlen + 4, sizeof(char));
 87         strncpy(codefile, pgm, fnlen);
 88         strcat(codefile, ".tm");
 89         code = fopen(codefile, "w");
 90         if (code == NULL) {
 91             printf("Unable to open %s\n", codefile);
 92             exit(1);
 93         }
 94 
 95 //RH generate code
 96         codeGen(syntaxTree, codefile);
 97         fclose(code);
 98     }
 99 #endif
100 #endif
101 #endif
102     fclose(source);
103     return 0;
104 }
105 
106 
107 
108 
109 /****************************************************/
110 /* File: globals.h                                  */
111 /* Global types and vars for TINY compiler          */
112 /* must come before other include files             */
113 /* Compiler Construction: Principles and Practice   */
114 /* Kenneth C. Louden                                */
115 /****************************************************/
116 
117 #ifndef _GLOBALS_H_
118 #define _GLOBALS_H_
119 
120 #include <stdio.h>
121 #include <stdlib.h>
122 #include <ctype.h>
123 #include <string.h>
124 
125 #ifndef FALSE
126 #define FALSE 0
127 #endif
128 
129 #ifndef TRUE
130 #define TRUE 1
131 #endif
132 
133 /* MAXRESERVED = the number of reserved words */
134 #define MAXRESERVED 8
135 
136 typedef enum
137     /* bookkeeping tokens */
138 { ENDFILE, ERROR,
139     /* reserved words */
140     IF, THEN, ELSE, END, REPEAT, UNTIL, READ, WRITE,
141     /* multicharacter tokens */
142     ID, NUM,
143     /* special symbols */
144     ASSIGN, EQ, LT, PLUS, MINUS, TIMES, OVER, LPAREN, RPAREN, SEMI
145 } TokenType;
146 
147 extern FILE *source;            /* source code text file */
148 extern FILE *listing;           /* listing output text file */
149 extern FILE *code;              /* code text file for TM simulator */
150 
151 extern int lineno;              /* source line number for listing */
152 
153 /**************************************************/
154 /***********   Syntax tree for parsing ************/
155 /**************************************************/
156 
157 
158 //RH type of nodes
159 typedef enum
160 { StmtK, ExpK } NodeKind;
161 
162 //RH type of statements
163 typedef enum
164 { IfK, RepeatK, AssignK, ReadK, WriteK } StmtKind;
165 
166 //RH kind of expression
167 typedef enum
168 { OpK, ConstK, IdK } ExpKind;
169 
170 /* ExpType is used for type checking */
171 typedef enum
172 { Void, Integer, Boolean } ExpType;
173 
174 //RH at most 3 children for what we will do
175 #define MAXCHILDREN 3
176 
177 //RH this is the tree node for Tiny
178 typedef struct treeNode
179 {
180     struct treeNode *child[MAXCHILDREN];
181     struct treeNode *sibling;
182     int lineno;
183     NodeKind nodekind;
184     union
185     {
186         StmtKind stmt;
187         ExpKind exp;
188     } kind;
189     union
190     {
191         TokenType op;
192         int val;
193         char *name;
194     } attr;
195     ExpType type;               /* for type checking of exps */
196 } TreeNode;
197 
198 #endif
199 
200 
201 
202 //RH functions to build a syntax tree
203 /****************************************************/
204 /* File: util.c                                     */
205 /* Utility function implementation                  */
206 /* for the TINY compiler                            */
207 /* Compiler Construction: Principles and Practice   */
208 /* Kenneth C. Louden                                */
209 /****************************************************/
210 #include "globals.h"
211 #include "util.h"
212 
213 /* Function newStmtNode creates a new statement
214  *node for syntax tree construction
215  */
216 TreeNode *newStmtNode(StmtKind kind)
217 {
218     TreeNode *t = (TreeNode *) malloc(sizeof(TreeNode));
219     int i;
220     if (t == NULL)
221         fprintf(listing, "Out of memory error at line %d\n", lineno);
222     else {
223         for (i = 0; i<MAXCHILDREN; i++)
224             t->child[i] = NULL;
225         t->sibling = NULL;
226         t->nodekind = StmtK;  //RH it is a statement
227         t->kind.stmt = kind;
228         t->lineno = lineno;
229     }
230     return t;
231 }
232 
233 /* Function newExpNode creates a new expression
234 *node for syntax tree construction
235  */
236 TreeNode *newExpNode(ExpKind kind)
237 {
238     TreeNode *t = (TreeNode *) malloc(sizeof(TreeNode));
239     int i;
240     if (t == NULL)
241         fprintf(listing, "Out of memory error at line %d\n", lineno);
242     else {
243         for (i = 0; i<MAXCHILDREN; i++)
244             t->child[i] = NULL;
245         t->sibling = NULL;
246         t->nodekind = ExpK;
247         t->kind.exp = kind;
248         t->lineno = lineno;
249         t->type = Void;
250     }
251     return t;
252 }
253 
254 /* Function copyString allocates and makes a new
255 *copy of an existing string
256  */
257 //RH
258 //RH use strdup
259 //RH
260 char *copyString(char *s);
261 
262 /* Variable indentno is used by printTree to
263 *store current number of spaces to indent
264  */
265 static indentno = 0;
266 
267 /* macros to increase/decrease indentation */
268 #define INDENT indentno+=2
269 #define UNINDENT indentno-=2
270 
271 /* printSpaces indents by printing spaces */
272 static void printSpaces(void)
273 {
274     int i;
275     for (i = 0; i<indentno; i++)
276         fprintf(listing, " ");
277 }
278 
279 /* procedure printTree prints a syntax tree to the
280 *listing file using indentation to indicate subtrees
281  */
282 void printTree(TreeNode*tree)
283 {
284     int i;
285     INDENT;
286     while (tree != NULL) {
287         printSpaces();
288         if (tree->nodekind == StmtK) {
289             switch (tree->kind.stmt) {
290             case IfK:
291                 fprintf(listing, "If\n");
292                 break;
293             case RepeatK:
294                 fprintf(listing, "Repeat\n");
295                 break;
296             case AssignK:
297                 fprintf(listing, "Assign to: %s\n", tree->attr.name);
298                 break;
299             case ReadK:
300                 fprintf(listing, "Read: %s\n", tree->attr.name);
301                 break;
302             case WriteK:
303                 fprintf(listing, "Write\n");
304                 break;
305             default:
306                 fprintf(listing, "Unknown ExpNode kind\n");
307                 break;
308             }
309         }
310         else if (tree->nodekind == ExpK) {
311             switch (tree->kind.exp) {
312             case OpK:
313                 fprintf(listing, "Op: ");
314                 printToken(tree->attr.op, "\0");
315                 break;
316             case ConstK:
317                 fprintf(listing, "Const: %d\n", tree->attr.val);
318                 break;
319             case IdK:
320                 fprintf(listing, "Id: %s\n", tree->attr.name);
321                 break;
322             default:
323                 fprintf(listing, "Unknown ExpNode kind\n");
324                 break;
325             }
326         }
327         else
328             fprintf(listing, "Unknown node kind\n");
329         for (i = 0; i<MAXCHILDREN; i++)  //RH check all the children
330             printTree(tree->child[i]);
331         tree = tree->sibling;     //RH try the next sibling
332     }
333     UNINDENT;
334 }
335 
336 
337 
338 /****************************************************/
339 /* File: tiny.y                                     */
340 /* The TINY Yacc/Bison specification file           */
341 /* Compiler Construction: Principles and Practice   */
342 /* Kenneth C. Louden                                */
343 /****************************************************/
344 %{
345 #define YYPARSER /* distinguishes Yacc output from other code files */
346 
347 #include "globals.h"
348 #include "util.h"
349 #include "scan.h"
350 #include "parse.h"
351 
352 //RH
353 //RH DON'T SET YYSTYPE as he does!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
354 //RH Use the typing mechanism of bison to check your types.
355 //RH
356 #define YYSTYPE TreeNode *
357 //RH
358 
359 
360 static char * savedName; /* for use in assignments */
361 static int savedLineNo;  /* ditto */
362 static TreeNode * savedTree; /* stores syntax tree for later return */
363 
364 %}
365 
366 %token IF THEN ELSE END REPEAT UNTIL READ WRITE
367 %token ID NUM
368 %token ASSIGN EQ LT PLUS MINUS TIMES OVER LPAREN RPAREN SEMI
369 %token ERROR
370 
371 //RH
372 //RH what are the types of the nonterminals?
373 //RH
374 
375 %% /* Grammar for TINY */
376 
377 program     : stmt_seq
378                  { savedTree = $1;}
379             ;
380 stmt_seq    : stmt_seq SEMI stmt
381                  { YYSTYPE t = $1;
382                    if (t != NULL)
383                    { while (t->sibling != NULL)
384                         t = t->sibling;
385                      t->sibling = $3;
386                      $$ = $1; }
387                      else $$ = $3;
388                  }
389             | stmt  { $$ = $1; }
390             ;
391 stmt        : if_stmt { $$ = $1; }
392             | repeat_stmt { $$ = $1; }
393             | assign_stmt { $$ = $1; }
394             | read_stmt { $$ = $1; }
395             | write_stmt { $$ = $1; }
396             | error  { $$ = NULL; }
397             ;
398 if_stmt     : IF exp THEN stmt_seq END
399                  { $$ = newStmtNode(IfK);
400                    $$->child[0] = $2;
401                    $$->child[1] = $4;
402                  }
403             | IF exp THEN stmt_seq ELSE stmt_seq END
404                  { $$ = newStmtNode(IfK);
405                    $$->child[0] = $2;
406                    $$->child[1] = $4;
407                    $$->child[2] = $6;
408                  }
409             ;
410 repeat_stmt : REPEAT stmt_seq UNTIL exp
411                  { $$ = newStmtNode(RepeatK);
412                    $$->child[0] = $2;
413                    $$->child[1] = $4;
414                  }
415             ;
416 assign_stmt : ID { savedName = copyString(tokenString);
417                    savedLineNo = lineno; }
418               ASSIGN exp                 //RH production w/multiple actions
419                  { $$ = newStmtNode(AssignK);
420                    $$->child[0] = $4;
421                    $$->attr.name = savedName;
422                    $$->lineno = savedLineNo;
423                  }
424             ;
425 read_stmt   : READ ID
426                  { $$ = newStmtNode(ReadK);
427                    $$->attr.name =
428                      copyString(tokenString);
429                  }
430             ;
431 write_stmt  : WRITE exp
432                  { $$ = newStmtNode(WriteK);
433                    $$->child[0] = $2;
434                  }
435             ;
436 
437 //RH
438 //RH this is ambiguous!  You may use associativity declarations such
439 //RH as %right, %left, %nonassoc. See the bison primer handout.
440 //RH
441 exp         : simple_exp LT simple_exp
442                  { $$ = newExpNode(OpK);
443                    $$->child[0] = $1;
444                    $$->child[1] = $3;
445                    $$->attr.op = LT;
446                  }
447             | simple_exp EQ simple_exp
448                  { $$ = newExpNode(OpK);
449                    $$->child[0] = $1;
450                    $$->child[1] = $3;
451                    $$->attr.op = EQ;
452                  }
453             | simple_exp { $$ = $1; }
454             ;
455 simple_exp  : simple_exp PLUS term
456                  { $$ = newExpNode(OpK);
457                    $$->child[0] = $1;
458                    $$->child[1] = $3;
459                    $$->attr.op = PLUS;
460                  }
461             | simple_exp MINUS term
462                  { $$ = newExpNode(OpK);
463                    $$->child[0] = $1;
464                    $$->child[1] = $3;
465                    $$->attr.op = MINUS;
466                  }
467             | term { $$ = $1; }
468             ;
469 term        : term TIMES factor
470                  { $$ = newExpNode(OpK);
471                    $$->child[0] = $1;
472                    $$->child[1] = $3;
473                    $$->attr.op = TIMES;
474                  }
475             | term OVER factor
476                  { $$ = newExpNode(OpK);
477                    $$->child[0] = $1;
478                    $$->child[1] = $3;
479                    $$->attr.op = OVER;
480                  }
481             | factor { $$ = $1; }
482             ;
483 factor      : LPAREN exp RPAREN
484                  { $$ = $2; }
485             | NUM
486                  { $$ = newExpNode(ConstK);
487                    $$->attr.val = atoi(tokenString);
488                  }
489             | ID { $$ = newExpNode(IdK);
490                    $$->attr.name =
491                          copyString(tokenString);
492                  }
493             | error { $$ = NULL; }
494             ;
495 
496 %%
497 
498 int yyerror(char * message)
499 { fprintf(listing,"Syntax error at line %d: %s\n",lineno,message);
500   fprintf(listing,"Current token: ");
501   printToken(yychar,tokenString);
502   Error = TRUE;
503   return 0;
504 }
505 
506 //RH Just let bison call the flex code don't wrap
507 //RH redefine yylex!  This is OK of you built the
508 //RH scanner by hand, but that is not us.
509 
510 /* yylex calls getToken to make Yacc/Bison output
511  * compatible with ealier versions of the TINY scanner
512  */
513 static int yylex(void)
514 { return getToken(); }
515 
516 TreeNode * parse(void)
517 { yyparse();
518   return savedTree;
519 }
