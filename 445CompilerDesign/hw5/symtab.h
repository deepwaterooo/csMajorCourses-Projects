#ifndef SYMTAB_H
#define SYMTAB_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define DEBUG_OFF 0x0
#define DEBUG_PUSH 0x1
#define DEBUG_TABLE 0x2
#define DEBUG_LOOKUP 0x4
#define DEBUG_ALL 0xffffffff

typedef struct {
    char *name;     // NULL if first entry in scope
    char *scope;    // name of scope and must be nonNull
    int depth;      // depth in scope stack (global scope == 1)
    void *ptr;      // the "data"
} SymTabEntry;
    

// 
// Class SymTab
// 
// A general simple stack of symbol tables that maps 
// a char * to a void *.  Provides a user definable
// print routine for the objects stored in the symbol table.
// The print rouinte is defined when the constructor is called.
// 
// debug flags setable by the debug method:
//   DEBUG_TABLE - announce entry to a scope and prints the symbol
//       table on exit from a scope.
//   DEBUG_PUSH - print everything that is pushed on the stack (uses
//       the print routine for printing the ptr value (treeNode *?)
// these flags are bit masks and so can be ored together to turn
// on multiple affects.  For example debug(DEBUG_TABLE | DEBUG_PUSH) would
// turn on both the DEBUG_PUSH and DEBUG_TABLE flags.
//
//  The four most important operations are insert, lookup, enter, leave.
//

class SymTab 
{
    // static data
    private:
    static int initMaxTable_;   // this is the initial size of the symbol table

    // data
    private:
        int maxTable_;          // this is how big the table is now since it can grow
        SymTabEntry *table_;    // the table is simply a fancy stack of SymTabEntries
        SymTabEntry *top_;      // this is where the next new data will be added
        char *scopeName_;       // this is the current scope name
        int scopeDepth_;        // this is the currect depth of the scopes
        void (* elemPrint_)(void *);  // this is a print routine to print your TreeNode *
	int debug_;             // this holds debug flags defined above
	
    // methods
    private:
        void increaseTable();
	void push(char *sym, int scopeDepth, void *ptr);

    public:
	// symbol table constructor/destructor debug         
        SymTab(void (* elemPrint)(void *));  // the constructor creates and sets the print routine
	~SymTab();                           // destructor
	void debug(int newDebugValue);       // sets the debug flags
	void print();                        // prints the entire stack

	// basic symbol operations
	bool insert(char *sym, void *ptr);   // inserts a new ptr associated with symbol sym 
                                             // returns false if already defined
	bool insertGlobal(char *sym, void *ptr);   // inserts a new ptr associated with symbol sym in globals
                                             // returns false if already defined
	bool insertScope(char *sym, int scope, void *ptr);   // inserts a new ptr associated with symbol sym in scope
                                             // returns false if already defined
	void *lookup(char *sym);             // returns the ptr associated with sym
                                             // returns NULL if symbol not found

        // basic scope functions
	void enter(char *funcname);          // enter a function named funcname
	bool leave();                        // leave that function
        int numEntries();                    // number of entries (more for debugging)
        int depth();                         // depth of scopes on stack (useful in later assignment)

        // symtab entry functions
	SymTabEntry *lookupSymTabEntry(char *sym);  // returns pointer to SymTabEntry associated with sym
                                                    // returns NULL if symbol not found
        SymTabEntry *findScope(char *scopeName);         // return the first SymTabEntry in the named scope
        SymTabEntry *findScope(int scopeNum);            // return the just past the last SymTabEntry in the scope
                                                         // NULL when it runs out

        // looping in the symbol table
        SymTabEntry *firstSymTabEntry();                 // return the first SymTabEntry in the table
        SymTabEntry *nextSymTabEntry(SymTabEntry *last); // return the next SymTabEntry given the last
        bool moreSymTab(SymTabEntry *last);              // not at end of table yet (use in for loop)
        bool moreScope(SymTabEntry *last);               // not at end of scope yet (use in for loop)
};

#endif
