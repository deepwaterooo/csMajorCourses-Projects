program : declaration_list { savedTree = $1; }
        ;                
declaration_list : declaration_list declaration 
                 {
		   TreeNode* t = $1;
		   if (t != NULL){
		     while (t->sibling != NULL) t = t->sibling;
		     t->sibling = $2;
		     $$ = $1;
		   } else
		     $$ = $2;
		 }
                 | declaration { $$ = $1; }
                 ;
declaration : var_declaration { $$ = $1; }
            | fun_declaration { $$ = $1; }
            ;

var_declaration : type_specifier var_decl_list ';' 
                {
		  // attach type in $1 to everybody in list $2
		  // $1 is of type TokenData*
		  // tagTypeInList($1, $2);
		  TreeNode* t = $2;

		  if (t != NULL){
		    t->expType = $1;
		    while (t->sibling != NULL) {
		      t = t->sibling;
		      t->expType = $1;
		    }
		  }
		  $$ = $2;
		}
                ;
scoped_var_declaration : scoped_type_specifier var_decl_list ';' 
                       { 
			 // attach type and scope in $1 to everybody in list $2  
			 TreeNode* t = $2;
			 if (t != NULL){
			   t->expType = $1;
			   t->isStatic = true;
			   while (t->sibling != NULL) {
			     t = t->sibling;
			     t->expType = $1;
			     t->isStatic = true;
			   }
			 }
			 $$ = $2;
		       }
                       ;
var_decl_list : var_decl_list ',' var_decl_initialize 
              {
		TreeNode* t = $1;
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = $3;
		  $$ = $1;
		} else
		  $$ = $3;
	      }
              | var_decl_initialize { $$ = $1; }
              ;
var_decl_initialize : ID 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		    }
                    | ID '[' NUMCONST ']' 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      //$$->child[0] = $3;
		      $$->isArray = true;
		    }
                    | ID ':' simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->child[0] = $3;
		    }
                    | ID '[' NUMCONST ']' ':' simple_expression 
                    {
		      $$ = newDeclNode(VarK);
		      $$->linnum = $1->linnum;
		      $$->string = $1->tokenstr;
		      $$->child[0] = $6;
		      $$->isArray = true;
		    }
                    ;
scoped_type_specifier : STATIC type_specifier { $$ = $2; }
                      | type_specifier { $$ = $1; }
                      ;
type_specifier : INT  { $$ = Integer; }
               | BOOL { $$ = Boolean; }
               | CHAR { $$ = Character; }
               ;

fun_declaration : type_specifier ID '(' params ')' statement 
                {
		  TreeNode* t = newDeclNode(FuncK); 
		  t->string = $2->tokenstr;
		  t->linnum = $2->linnum;
		  t->expType = $1;
		  $$ = t;
		  $$->child[0] = $4;
		  $$->child[1] = $6;
		}
                | ID '(' params ')' statement 
		{
		  TreeNode* t = newDeclNode(FuncK);
		  t->string = $1->tokenstr;
		  t->linnum = $1->linnum;
		  $$ = t;
		  $$->child[0] = $3;
		  $$->child[1] = $5;
		}
		;
params : param_list { $$ = $1; }
       | /* empty*/ { $$ = NULL; }
       ;

param_list : param_list ';' type_specifier param_id_list 
           {
	     TreeNode* t = $1;
	     TreeNode* v = $4;
	     if (v != NULL){
	       v->expType = $3;
	       while (v->sibling != NULL) {
		 v = v->sibling;
		 v->expType = $3;
	       }
	     }
	     if (t != NULL){
	       while (t->sibling != NULL) t = t->sibling;
	       t->sibling = $4;
	       $$ = $1;
	     } else
	       $$ = $4;
	   }
	   | type_specifier param_id_list 
	   {
	     TreeNode* v = $2;
	     if (v != NULL){
	       v->expType = $1;
	       while (v->sibling != NULL) {
		 v = v->sibling;
		 v->expType = $1;
	       }
	     } 
	     $$ = $2;
	   }
	   ;
param_id_list : param_id_list ',' param_id 
              {
		TreeNode* t = $1;
		if (t != NULL){
		  while (t->sibling != NULL) t = t->sibling;
		  t->sibling = $3;
		  $$ = $1;
		} else
		  $$ = $3;
	      }
              | param_id  { $$ = $1; }
              ;
param_id : ID 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->string = $1->tokenstr;
	 }
	 | ID '[' ']' 
         {
	   $$ = newDeclNode(ParamK);
	   $$->linnum = $1->linnum;
	   $$->string = $1->tokenstr;
	   $$->isArray = true;
	 }
	 ;

statement : ifmatched { $$ = $1; }
          | ifunmatched { $$ = $1; }
          ;
ifmatched : IF '(' simple_expression ')' ifmatched ELSE ifmatched 
          { 
	    $$ = newStmtNode(IfK);
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
          | WHILE '(' simple_expression ')' ifmatched
          { 
	    $$ = newStmtNode(WhileK);
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	  }
          | FOREACH '(' mutable IN simple_expression ')' ifmatched 
          { 
	    $$ = newStmtNode(ForEachK);
	    $$->linnum = $1->linnum;
	    $$->child[0] = $3;
	    $$->child[1] = $5;
	    $$->child[2] = $7;
	  }
          | expression_stmt { $$ = $1; }
    	  ;
ifunmatched : IF '(' simple_expression ')' ifmatched ELSE ifunmatched
            { 
	      $$ = newStmtNode(IfK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[2] = $7;
	    }
            | IF '(' simple_expression ')' statement
            { 
	      $$ = newStmtNode(IfK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	    }
            | WHILE '(' simple_expression ')' ifunmatched
            { 
	      $$ = newStmtNode(WhileK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	    }
            | FOREACH '(' mutable IN simple_expression ')' ifunmatched 
            { 
	      $$ = newStmtNode(ForEachK);
	      $$->linnum = $1->linnum;
	      $$->child[0] = $3;
	      $$->child[1] = $5;
	      $$->child[2] = $7;
	    }
            ;

expression_stmt: compound_stmt { $$ = $1; }
          | RETURN ';' 
          {
	    $$ = newStmtNode(ReturnK);
	  }
          | RETURN expression ';'  
          {
	    $$ = newStmtNode(ReturnK);
	    $$->child[0] = $2;
	  }
          | BREAK ';'  
          {
	    $$ = newStmtNode(BreakK);
	  }
          ;
compound_stmt : '{' local_declarations statement_list '}' 
              {
		$$ = newStmtNode(CompoundK);
		$$->linnum = $1->linnum;
		$$->child[0] = $2;
		$$->child[1] = $3;
	      }
	      ;
local_declarations : local_declarations scoped_var_declaration 
                   {
		     TreeNode* t = $1;
		     if (t != NULL){
		       while (t->sibling != NULL) t = t->sibling;
		       t->sibling = $2;
		       $$ = $1;
		     } else
		       $$ = $2;
		   }
                   | { $$ = NULL; } 
                   ;
statement_list : statement_list statement 
               {
		 TreeNode* t = $1;
		 if (t != NULL){
		   while (t->sibling != NULL) t = t->sibling;
		   t->sibling = $2;
		   $$ = $1;
		 } else
		   $$ = $2;
	       }
               |  { $$ = NULL; } 
               ;
expression_stmt : expression ';' { $$ = $1; }
                | ';' { $$ = NULL; }
                ;
expression : mutable '=' expression // this grammar may have problems
           {
	     $$ = newExpNode(AssignK); 
	     $$->attr.op = $2->tokenClass;
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable PASSIGN expression 
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable MASSIGN expression 
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	     $$->child[1] = $3;
	   }
           | mutable INC
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	   }
           | mutable DEC
           {
	     $$ = newExpNode(AssignK);
	     $$->string = $2->tokenstr;
	     $$->linnum = $2->linnum; 
	     $$->child[0] = $1;
	   }
           | simple_expression { $$ = $1; }
           ;
simple_expression : simple_expression OR and_expression  
                  {
		    $$ = newExpNode(OpK); 
		    $$->attr.op = $2->tokenClass;
		    $$->string = $2->tokenstr;
		    $$->linnum = $2->linnum; 
		    $$->child[0] = $1;
		    $$->child[1] = $3;
		  }
                  | and_expression { $$ = $1; }
                  ;
and_expression : and_expression AND unary_rel_expression  
               {
		 $$ = newExpNode(OpK); 
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | unary_rel_expression { $$ = $1; }
               ;
unary_rel_expression : NOT unary_rel_expression
                     { 
		       $$ = newExpNode(OpK);
		       $$->attr.op = $1->tokenClass;
		       $$->string = $1->tokenstr;
		       $$->linnum = $1->linnum; 
		       $$->child[0] = $2;
		     }
                     | rel_expression { $$ = $1; }
                     ;
rel_expression : sum_expression '<' sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression '>' sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression LEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression GEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression EQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression NEQ sum_expression
               {
		 $$ = newExpNode(OpK);
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum; 
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression { $$ = $1; }
               ;
sum_expression : sum_expression '+' term  
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum;
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | sum_expression '-' term  
               {
		 $$ = newExpNode(OpK);
		 $$->attr.op = $2->tokenClass;
		 $$->string = $2->tokenstr;
		 $$->linnum = $2->linnum;
		 $$->child[0] = $1;
		 $$->child[1] = $3;
	       }
               | term { $$ = $1; }
               ;
term : term mulop unary_expression 
     {
       $$ = $2;
       $$->child[0] = $1;
       $$->child[1] = $3;
     }
     | unary_expression { $$ = $1; }
     ;
mulop : '*' 
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | '/'
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      | '%'
      { 
	$$ = newExpNode(OpK); 
	$$->attr.op = $1->tokenClass;
	$$->string = $1->tokenstr;
	$$->linnum = $1->linnum; 
      }
      ;
unary_expression : unaryop unary_expression  
                 {
		   $$ = $1; 
		   $$->child[0] = $2;
		 }
                 | factor { $$ = $1; }
                 ;
unaryop : '-' 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.op = $1->tokenClass;
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        | '*' 
        { 
	  $$ = newExpNode(OpK); 
	  $$->attr.op = $1->tokenClass;
	  $$->string = $1->tokenstr;
	  $$->linnum = $1->linnum; 
	}
        ;
factor : immutable { $$ = $1; }
       | mutable { $$ = $1; }
       ;
mutable : ID 
        {
	  $$ = newExpNode(IdK);
	  $$->attr.name = $1->tokenstr;
	  $$->linnum = $1->linnum;
	}
        | ID '[' expression ']' 
        {
	  $$ = newExpNode(IdK);
	  $$->attr.name = $1->tokenstr;
	  $$->linnum = $1->linnum;
	  $$->isArray = true;
	  $$->child[0] = $3;
	}
        ;
immutable : '(' expression ')' { $$ = $2; }
          | call  { $$ = $1; }
          | NUMCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->attr.val = $1->iValue;
	    $$->linnum = $1->linnum; 
	    $$->expType = Integer;
	    $$->isConstant = true;
	  }
          | CHARCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->linnum = $1->linnum; 
	    $$->string = $1->tokenstr;
	    $$->expType = Character;
	    $$->isConstant = true;
	  }
          | STRINGCONST
	  {
	    $$ = newExpNode(ConstantK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum; 
	    $$->expType = Character;
	    $$->isConstant = true;
	  }
          | TRUE  
	  {
	    $$ = newExpNode(ConstantK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum; 
	    $$->expType = Boolean;
	    $$->isConstant = true;
	  }
          | FALSE
	  {
	    $$ = newExpNode(ConstantK);
	    $$->string = $1->tokenstr;
	    $$->linnum = $1->linnum;
	    $$->expType = Boolean;
	    $$->isConstant = true;
	  }
          ;
call : ID '(' args ')' 
     {
       $$ = newExpNode(CallK);
       $$->string = $1->tokenstr;
       $$->linnum = $1->linnum;
       $$->child[0] = $3;
     }
     ;
args : arg_list { $$ = $1; }
     | { $$ = NULL; }
     ;
arg_list : expression ',' arg_list   
         {
	   /*TreeNode* t = $3;
	   if (t != NULL){
	     while (t->sibling != NULL) t = t->sibling;
	     t->sibling = $1;
	     $$ = $3;
	   } else
	   $$ = $1; */
	   TreeNode * t = $1;
	   if (t != NULL){
	     while  (t->sibling != NULL) t = t->sibling;
	     t->sibling = $3;
	     $$ = $1;
	   } else
	     $$ = $3;
	 }
         | expression { $$ = $1; }
         ;
