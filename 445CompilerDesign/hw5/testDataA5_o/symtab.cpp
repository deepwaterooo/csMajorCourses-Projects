#include "symtab.h"
int SymTab::initMaxTable_=100;

void xPrint(void *p)
{
    printf("0x%08lx", (unsigned long int)p);
}


// constructor
SymTab::SymTab(void (* elemPrint)(void *))
{
    maxTable_ = initMaxTable_;
    table_ = new SymTabEntry[initMaxTable_];
    for (int i=0; i<initMaxTable_; i++) table_[i].name=NULL;
    top_ = table_;
    elemPrint_ = elemPrint;
    scopeDepth_ = 0;
    debug_ = 0x0;
    enter((char *)"globals");
};


// destructor
SymTab::~SymTab()
{
    maxTable_ = 0;
    delete table_;
};

// set the debug flags defined in symtab.h
void SymTab::debug(int newDebugValue)
{
    debug_ = newDebugValue;
}


void SymTab::increaseTable() {
    int offset;
    SymTabEntry *newt;

    newt = new SymTabEntry[2*maxTable_];
    memcpy(newt, table_, sizeof(SymTabEntry)*maxTable_);
    delete table_;

    maxTable_= 2*maxTable_;
    printf("SYMTAB: size fault.  Increase to %d elements\n", maxTable_);
    fflush(stdout);
    offset = top_-table_;
    table_ = newt;
    top_ = newt+offset;
}


// push the sym and ptr on the stack
void SymTab::push(char *sym, int scopeDepth, void *ptr)
{
    // if you run out of memory then add some
    if (top_>=table_+maxTable_) increaseTable();
    top_->name = sym;          // record the symbol
    top_->scope = scopeName_;  // record the scopename
    top_->depth = scopeDepth;  // record the depth that is passed in
    top_->ptr = ptr;           // record the data
    top_++;
};

// zzz
// insert the sym and ptr on the stack
bool SymTab::insertScope(char *sym, int scopeDepth, void *ptr)
{
    SymTabEntry *p, *pp;
    char *newScopeName;

    // if you run out of memory then add some
    if (top_>=table_+maxTable_) increaseTable();
    
    // find where it goes
    p = findScope(scopeDepth);
    newScopeName = (p-1)->scope;

    // is it already there?  Then do nothing.
    for (pp=p-1; pp->name; pp--) {
	if (strcmp(pp->name, sym)==0) return false;
    }

    // make room
    for (pp=top_-1; pp>=p; pp--) {
        *(pp+1) = *pp;
    }

    // insert it
    p->name = sym;            // record the symbol
    p->scope = newScopeName;  // record the scopename
    p->depth = scopeDepth;    // record the depth that is passed in
    p->ptr = ptr;             // record the data
    top_++;
};


// insert into the global space
bool SymTab::insertGlobal(char *sym, void *ptr) {
    return insertScope(sym, 1, ptr);
}


// prints the symbol table with each element printed using
// the print routine supplied in the constuctor.  New line is supplied
// by this print routine.
void SymTab::print()
{
    SymTabEntry *p;

    printf("\nSymbol Stack:\n");
    for (p=table_; p<top_; p++) {
	// print a regular entry
	if (p->name) {
//debug	    printf("%10s %10s %d 0x%08x ", p->name, p->scope, p->depth, p);
	    printf("%10s %10s %d ", p->name, p->scope, p->depth);
	    elemPrint_(p->ptr);
	    printf("\n");
	}
	// print the scope divider
	else {
	    printf("%10s %10s ---- \n", "", p->scope);
	}
    }
    fflush(stdout);
};



// inserts an element into the symbol table.
// if successful it will return true
bool SymTab::insert(char *sym, void *ptr)
{
    SymTabEntry *p;

    if (sym==NULL) {
        printf("ERROR(symbol table): Attempting to insert a NULL symbol.\n");
        return false;
    }
    if (ptr==NULL) {
        printf("ERROR(symbol table): Attempting to insert a NULL pointer for symbol \"%s\".\n", sym);
        return false;
    }

    // search this scope
    for (p=top_-1; p->name; p--) {
	if (strcmp(p->name, sym)==0) return false;
    }

    if (debug_ & DEBUG_PUSH) {
	printf("SymTab: Pushing this node: ");
	elemPrint_(ptr);
	printf("\n");
	fflush(stdout);
    }

    push(sym, scopeDepth_, ptr);
    return true;
};


// lookup the name in the SymTabEntry
// returning the pointer to the thing stored with the symbol
// or NULL if it could not be found
void *SymTab::lookup(char *sym)
{
    SymTabEntry *p;

    if (sym==NULL) {
        printf("ERROR(symbol table): Attempting to look up a NULL pointer.\n");
        return NULL;
    }

    for (p=top_-1; p>=table_; p--) {
	if (p->name && strcmp(p->name, sym)==0) {
	    if (debug_ & DEBUG_LOOKUP) {
		printf("SymTab: looking up: %s and found data: ", sym);
		elemPrint_(p->ptr);
		printf("\n");
		fflush(stdout);
	    }
		
	    return p->ptr;
	}
    }
    if (debug_ & DEBUG_LOOKUP) {
	printf("SymTab: looking up: %s and did not find it.\n", sym);
	fflush(stdout);
    }
    return NULL;
};


// lookup the entry in the symbol table.
// this returns the entire entry in the table.
SymTabEntry *SymTab::lookupSymTabEntry(char *sym)
{
    SymTabEntry *p;

    for (p=top_-1; p>=table_; p--) {
	if (p->name && strcmp(p->name, sym)==0) {
	    return p;
	}
    }
    return NULL;
};



// returns the first SymTabEntry pointer that has scope scopeName
// this gives you the *bottom* of a given scope
SymTabEntry *SymTab::findScope(char *scopeName)
{
    for (SymTabEntry *p=table_; p<top_; p++) {
	if (strcmp(scopeName, p->scope)==0) {
	    return p;
	}
    }

    return NULL;
}


// find the *top* of the given scope number.
// this is the next slot after the last entry (new top)
// if scopeNum<1 then set to 1 (the global scope)
SymTabEntry *SymTab::findScope(int scopeNum)
{
    SymTabEntry *p;
    if (scopeNum<1) scopeNum=1;

    for (p=top_-1; p>=table_; p--) {
	if (p->depth == scopeNum) break;
    }
    return p+1;  // move the pointer to the space between scopes
}


// returns the beginning of the symbol table
// note that this is a scope separator
SymTabEntry *SymTab::firstSymTabEntry()
{
    return table_;
}


//gives you the next entry in the symbol table
SymTabEntry *SymTab::nextSymTabEntry(SymTabEntry *last)
{
    if (last<top_) return last+1;

    return NULL;
}

bool SymTab::moreSymTab(SymTabEntry *last)
{
    return last!=top_;
}


bool SymTab::moreScope(SymTabEntry *last)
{
    if (last==top_) return false;   // catch the special case
    return last->name!=NULL;
}

// create a new scope on the stack
void SymTab::enter(char *funcname)
{
    if (funcname==NULL) scopeName_ = (char *)"(null)";
    else scopeName_ = strdup(funcname);
    if (debug_ & DEBUG_TABLE) printf("SymTab: Entering scope %s\n", scopeName_);
    scopeDepth_++;
    push(NULL, scopeDepth_, scopeName_);   // push a scope divider
};


// leave a scope 
bool SymTab::leave()
{
    SymTabEntry *newTop;

    if (debug_ & DEBUG_TABLE) {
	print();
	printf("SymTab: Leaving scope %s ", scopeName_);
	fflush(stdout);
    }

    newTop = findScope(scopeDepth_-1);
//zzz
//    newTop = lookupSymTabEntry((char *)"");
    if (newTop>table_) {
	top_ = newTop;
	scopeName_ = (top_-1)->scope;
	if (debug_ & DEBUG_TABLE) {
	    printf("and entering scope %s\n", scopeName_);
	    fflush(stdout);
	}
	if (scopeDepth_>1) scopeDepth_--;
	return true;
    }
    if (debug_ & DEBUG_TABLE) printf("\n");

//debug    printf("ERROR(symbol table): You cannot leave global scope.\n");
    return false;
};


// the depth of the scope stack with the first real scope (probably
// globals) numbered 1
int SymTab::depth()
{
    return scopeDepth_;
}

// number of real entries in the whole table
int SymTab::numEntries()
{
    return (top_-table_)-scopeDepth_;
}
