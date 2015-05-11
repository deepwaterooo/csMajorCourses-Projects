void Population::swapSubtree(int winIdx1, int winIdx2, int cnt) 
{
    int fst = winIdx1;
    int snd = winIdx2;
    int one;
    int two;
    bool oneFlag = true, twoFlag = true; // flag for non-terminal
    popu[fst].calc_size();
    popu[fst].evaluate();
    popu[snd].calc_size();
    popu[snd].evaluate();

    // generate node number for expression tree 1
    if (rand() % 100 / 100.0 < 0.90 && popu[fst].non_terms) { // non-terminal swap
        one = rand() % popu[fst].non_terms;
        oneFlag = true;  
    } else {    
        oneFlag = false;
        one = rand() % popu[fst].terms;
    }

    // generate node number for expression tree 2
    if (rand() % 100 / 100.0 < 0.90 && popu[snd].non_terms) { // non-terminal swap
        two = rand() % popu[snd].non_terms;
        twoFlag = true;
    } else {    
        twoFlag = false;
        two = rand() % popu[snd].terms;
    }
    
    while ( (one == two && (one == 0 || two == 0))
            || (oneFlag != twoFlag) )
    {
        if (rand() % 100 / 100.0 < 0.90 && popu[fst].non_terms) { // non-terminal swap
            one = rand() % popu[fst].non_terms;
            oneFlag = true;
        } else {    
            oneFlag = false;
            one = rand() % popu[fst].terms;
        }
    
        if (rand() % 100 / 100.0 < 0.90 && popu[snd].non_terms) { // non-terminal swap
            two = rand() % popu[snd].non_terms;
            twoFlag = true;
        } else {    
            twoFlag = false;
            two = rand() % popu[snd].terms;
        }
    }

    twoPtr p, q;
    int onecnt = 0, twocnt = 0;

    // get node pointers for current node and current node's parent
    if (!oneFlag) {        
        popu[fst].getTermNodePtr(popu[fst].the_indiv, one, onecnt);
        p = popu[fst].term[0];
    } else {        
        popu[fst].getNonTermNodePtr(popu[fst].the_indiv, one, onecnt);
        p = popu[fst].nonterm[0];
    }

    // get node pointers for current node and current node's parent
    if (!twoFlag) {        
        popu[snd].getTermNodePtr(popu[snd].the_indiv, two, twocnt);
        q = popu[snd].term[0];
    } else {        
        popu[snd].getNonTermNodePtr(popu[snd].the_indiv, two, twocnt);
        q = popu[snd].nonterm[0];
    }

    node* oneprv;
    node* onecur;
    node* twoprv;
    node* twocur;
    
    oneprv = p.prt;
    onecur = p.cld;
    twoprv = q.prt;
    twocur = q.cld;

    // swap two parts of subtrees from two individuals
    // special conditions still needs to be worked on
    if (!oneprv && !twoprv){;}  // do nothing here
    else if (!oneprv && onecur && twoprv) {    
        for (int i = 0; i < MAX_ARITY; ++i) {        
            if (twoprv->branches[i] == twocur) {            
                twoprv->branches[i] = onecur;
                onecur->parent = twoprv;
            }
        }
        popu[fst].the_indiv = NULL;
        popu[fst].copy(twocur);
        (popu[fst].the_indiv)->parent = NULL;
    } else if (!twoprv && twocur && oneprv) {
        for (int i = 0; i < MAX_ARITY; ++i) {        
            if (oneprv->branches[i] == onecur) 
            {
                oneprv->branches[i] = twocur;
                twocur->parent = oneprv;
            }
        }
        popu[snd].the_indiv = NULL;
        popu[snd].copy(onecur);
        (popu[snd].the_indiv)->parent = NULL;
    } else {    
        for (int i = 0; i < MAX_ARITY; ++i) 
        {
            if (oneprv && oneprv->branches[i] == onecur) 
            {
                oneprv->branches[i] = twocur;
                twocur->parent = oneprv;
            }
        
            if (twoprv && twoprv->branches[i] == twocur)
            {
                twoprv->branches[i] = onecur;
                onecur->parent = twoprv;
            }
        }
    }
}
