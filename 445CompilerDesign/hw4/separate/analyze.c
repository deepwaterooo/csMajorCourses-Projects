#include "scanType.h"
#include "analyze.h"
#include "symtab.h"

void nodePrint(void * p){
  //  TreeNode * t = (TreeNode*)p;
}

SymTab * st = new SymTab(nodePrint);
int numError = 0; 
int numWarnings = 0;
char nameCompoundStat[64];
char nameParam[32];
int depth = 1;

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
