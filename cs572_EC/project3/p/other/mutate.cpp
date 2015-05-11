void Individual::mutate(node* tmp, float mutRate)  {
    int type;
    if (tmp && rand()% 100/100.0 < mutRate)  {    
        if (tmp->type < NUM_NON_TERMS && tmp->type < 4) {        
            type = rand() % 4;
            while (type == tmp->type)               
                type = rand() % 4;  // get rid of pow and if
            tmp->type = type;
            for (int i = 0; i < 2; ++i)
                mutate(tmp->branches[i], mutRate);
        } else if (tmp->type >= 4 && tmp->type < 8) {        
            tmp->type = 4 + rand() % 4;
            mutate(tmp->branches[0], mutRate);
        } else if (tmp->type == 9) {        
            if (rand() % 100 / 100.0 < 0.5) {            
                tmp->type = 10;
                tmp->const_value = double(drand48() * 2.0 * CONST_LIMIT) - (CONST_LIMIT/2.0);
            }
        } else if (tmp->type == 10) {
            tmp->const_value = double(drand48() * 2.0 * CONST_LIMIT) - (CONST_LIMIT/2.0);    
        }
        else if (tmp->type == 8) 
            for (int i = 0; i < MAX_ARITY; ++i)
                mutate(tmp->branches[i], mutRate);
        else;
    } else {    
        switch(tmp->type) {        
        case add:
        case subtract:
        case multiply:
        case divide:
            for (int i = 0; i < 2; ++i)
                mutate(tmp->branches[i], mutRate);
            break;
        case mypow:
            mutate(tmp->branches[0], mutRate);
            break;
        case myif:
            for (int i = 0; i < MAX_ARITY; ++i)
                mutate(tmp->branches[i], mutRate);
            break;
        }
    }
}
