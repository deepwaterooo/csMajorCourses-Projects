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
    s.insert((char *)"ga", (void *)1);
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    s.insert((char *)"gb", (void *)2);
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    s.insert((char *)"gc", (void *)2);
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    if (! s.insert((char *)"gd", (void *)3)) printf("** WARNING: gd already exists 3\n");
    printf("** print symbol table\n");
    s.print();
    if (! s.insert((char *)"gd", (void *)4)) printf("** OK: gd already exists 4\n");
    printf("** print symbol table\n");
    s.print();
    printf("** enter ant\n");
    s.enter((char *)"ant");
    printf("** leave A\n");
    s.leave();
    printf("** enter bull\n");
    s.enter((char *)"bull");
    printf("** print symbol table\n");
    s.print();
    s.insert((char *)"ba", (void *)5);
    printf("** print symbol table\n");
    s.print();
    s.insert((char *)"bb", (void *)6);
    s.insert((char *)"bc", (void *)7);
    printf("** enter civit\n");
    s.enter((char *)"civit");
    s.insert((char *)"ca", (void *)8);
    s.insert((char *)"cb", (void *)9);
    printf("** print symbol table\n");
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** leave B\n");
    s.leave();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());
    printf("** print symbol table\n");
    s.print();
    printf("** enter donkey\n");
    s.enter((char *)"donkey");
    printf("** enter elephant\n");
    s.enter((char *)"elephant");
    s.insert((char *)"ea", (void *)10);
    s.insert((char *)"cb", (void *)11);
    s.insert((char *)"ga", (void *)12);
    printf("** print symbol table\n");
    s.print();
    printf("** ea 0x%08x\n", s.lookup((char *)"ea"));
    printf("** cb 0x%08x\n", s.lookup((char *)"cb"));
    printf("** ca 0x%08x\n", s.lookup((char *)"ca"));
    printf("** bc 0x%08x\n", s.lookup((char *)"bc"));
    printf("** ga 0x%08x\n", s.lookup((char *)"ga"));
    printf("** gb 0x%08x\n", s.lookup((char *)"gb"));
    printf("** banana 0x%08x\n", s.lookup((char *)"banana"));
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


    s.insert((char *)"a", (void *)1);

    printf("** enter one\n");
    s.enter((char *)"one");

    s.insert((char *)"b", (void *)2);

    printf("** enter two\n");
    s.enter((char *)"two");

    s.insert((char *)"c", (void *)3);

    printf("** enter three\n");
    s.enter((char *)"three");

    s.insert((char *)"d", (void *)4);
    s.insertScope((char *)"D", 4, (void *)4);
    s.insertScope((char *)"C", 3, (void *)3);
    s.insertScope((char *)"B", 2, (void *)2);
    s.insertScope((char *)"A", 1, (void *)1);

    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    s.insertGlobal((char *)"G", (void *)5);

    if (s.insertScope((char *)"D", 4, (void *)4)) printf("** dup test D fail\n");
    else printf("** dup test D success\n");

    if (s.insertScope((char *)"C", 3, (void *)3)) printf("** dup test C fail\n");
    else printf("** dup test C success\n");

    if (s.insertScope((char *)"B", 2, (void *)2)) printf("** dup test B fail\n");
    else printf("** dup test B success\n");

    if (s.insertScope((char *)"A", 1, (void *)1)) printf("** dup test A fail\n");
    else printf("** dup test A success\n");

    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    s.debug(DEBUG_OFF);

    s.leave();
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    s.leave();
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    s.leave();
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    s.leave();
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    s.leave();
    s.print();
    printf("** numEntries: %d  depth: %d\n", s.numEntries(), s.depth());

    printf("Generate three errors\n");
    s.insert(NULL, NULL);
    s.insert((char *)"XXX", NULL);

    printf("** NULL 0x%08x\n", s.lookup(NULL));

    printf("Loop through table\n");
    for (SymTabEntry *ste = s.firstSymTabEntry() + 1;
         s.moreSymTab(ste);
         ste = s.nextSymTabEntry(ste)) {
        printf("process name %s\n", ste->name);
        fflush(stdout);
    }

    printf("Loop through scope\n");
    for (SymTabEntry *ste = s.firstSymTabEntry() + 1;
         s.moreScope(ste);
         ste = s.nextSymTabEntry(ste)) {
        printf("process name %s\n", ste->name);
        fflush(stdout);
    }

    printf("** enter meerkat\n");
    s.enter((char *)"meerkat");
    s.insert((char *)"flower", (void *)11);
    s.insert((char *)"rocket", (void *)12);

    printf("Loop through table\n");
    for (SymTabEntry *ste = s.firstSymTabEntry() + 1;
         s.moreSymTab(ste);
         ste = s.nextSymTabEntry(ste)) {
        if (ste->name) printf("process name %s\n", ste->name);
        else printf("new scope %s\n", ste->scope);
        fflush(stdout);
    }

    printf("Loop through global scope\n");
    for (SymTabEntry *ste = s.findScope((char *)"globals") + 1;
         s.moreScope(ste);
         ste = s.nextSymTabEntry(ste)) {
        printf("process name %s\n", ste->name);
        fflush(stdout);
    }

    printf("Loop through meerkat scope\n");
    for (SymTabEntry *ste = s.findScope((char *)"meerkat") + 1;
         s.moreScope(ste);
         ste = s.nextSymTabEntry(ste)) {
        printf("process name %s\n", ste->name);
        fflush(stdout);
    }

    return 0;
}
