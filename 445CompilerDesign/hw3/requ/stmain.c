#include "symtab.h"
// 
// Test main below
// 


// a simple default print routine 
void ePrint(void *p)
{
    printf("[0x%08x]", p);
}


int main()
{
    // init symbol table object
    SymTab s(ePrint);
    s.debug(DEBUG_ALL);

    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    // begins in global scope
    s.insert("ga", (void *)1);
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    s.insert("gb", (void *)2);
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    s.insert("gc", (void *)2);
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    if (! s.insert("gd", (void *)3)) printf("** WARNING: gd already exists 3\n");
    printf("** print symbol table\n");
    s.print();
    if (! s.insert("gd", (void *)4)) printf("** OK: gd already exists 4\n");
    printf("** print symbol table\n");
    s.print();
    printf("** enter ant\n");
    s.enter("ant");
    printf("** leave A\n");
    s.leave();
    printf("** enter bull\n");
    s.enter("bull");
    printf("** print symbol table\n");
    s.print();
    s.insert("ba", (void *)5);
    printf("** print symbol table\n");
    s.print();
    s.insert("bb", (void *)6);
    s.insert("bc", (void *)7);
    printf("** enter civit\n");
    s.enter("civit");
    s.insert("ca", (void *)8);
    s.insert("cb", (void *)9);
    printf("** print symbol table\n");
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** leave B\n");
    s.leave();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** print symbol table\n");
    s.print();
    printf("** enter donkey\n");
    s.enter("donkey");
    printf("** enter elephant\n");
    s.enter("elephant");
    s.insert("ea", (void *)10);
    s.insert("cb", (void *)11);
    s.insert("ga", (void *)12);
    printf("** print symbol table\n");
    s.print();
    printf("** ea 0x%08x\n", s.lookup("ea"));
    printf("** cb 0x%08x\n", s.lookup("cb"));
    printf("** ca 0x%08x\n", s.lookup("ca"));
    printf("** bc 0x%08x\n", s.lookup("bc"));
    printf("** ga 0x%08x\n", s.lookup("ga"));
    printf("** gb 0x%08x\n", s.lookup("gb"));
    printf("** banana 0x%08x\n", s.lookup("banana"));
    printf("** print symbol table\n");
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** leave C\n");
    s.leave();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** leave D\n");
    s.leave();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** leave E\n");
    s.leave();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** leave F\n");
    s.leave();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    return 0;
}
