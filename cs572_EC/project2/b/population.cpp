#include <cstdio>
#include <cstdlib>
#include <algorithm>
#include <cstring>

#include "node.h"
#include "individual.h"
#include "population.h"

using namespace std;

extern int genNum ;

Population::Population(int n, int maxdepth, Individual* indiptr, float mutrate):
    size(n), depth(maxdepth), mutRate(mutrate) {
    popu = new Individual[size];
}

Population::~Population() {
    // FOR loop delete individuals separately to make safe
    for (int i = 0; i < size; ++i) 
        popu[i].Individual::~Individual();
    indiPtr->~Individual();
    delete indiPtr;
    delete [] idxArray;
}

bool Population::reachBest() {
    float minF = minFitness();
    if (minF - 0.05 < 0.00001) {
        for (int i = 0; i < size; ++i) {
            popu[i].evaluate();
            if (popu[i].fitness - minFitness() < 0.00001) 
            {
                cout << endl << "popu[" << i << "]: " << " Size: " << popu[i].getSize() << " Fitness: " << popu[i].getFitness() << endl;
                popu[i].Individual::print(popu[i].getNodePtr(), 0);
            }
        }
        printf("\n\n");        
        return true;
    }
    return false;
}

void Population::newGen(int winIdx1, int winIdx2, int cnt) {
    twoIdx worIdx = maxFitness();
    int fst = worIdx.fst;
    int snd = worIdx.snd;

    int winfst, winsnd;
    if (popu[winIdx1].fitness - popu[winIdx2].fitness >= 0.00001) {    
        winfst = winIdx1;
        winsnd = winIdx2;
    } else {    
        winfst = winIdx2;
        winsnd = winIdx1;
    }
    /*
    cout << "winfst: " << winfst << endl;
    cout << "winsnd: " << winsnd << endl;
    */
    // copy elite parent to worst two
    popu[winfst].copy(popu[fst]);
    popu[winsnd].copy(popu[snd]);
    /*
    cout << "worst fst: " << fst << endl;
    cout << "worst snd: " << snd << endl;
    */
    /*
    cout << "best fst: " << winfst << endl;
    cout << "best snd: " << winsnd << endl;
    */
    /*
    cout << "best fst: " << endl;
    popu[winfst].Individual::print(popu[winfst].getNodePtr(), 0);
    cout << "best snd: " << endl;
    popu[winsnd].Individual::print(popu[winsnd].getNodePtr(), 0);
    */
    /*   
    cout << "best fst fit: " << popu[winfst].getFitness() << endl;
    cout << "best snd fit: " << popu[winsnd].getFitness() << endl;
    cout << "worst fst fit: " << popu[fst].getFitness() << endl;
    cout << "worst snd fit: " << popu[snd].getFitness() << endl;
    */
    // 2 point crossover two elite parent on place
    swapSubtree(winfst, winsnd, cnt);

    /*
    // instead of Subtree mutation, do Node Mutation instead for safety
    int mutNode = rand() % size;
    while (mutNode == fst || mutNode == snd
           || mutNode == winfst || mutNode == winsnd)
        mutNode = rand() % size;
    cout << "popu[" << mutNode << "] before mutate: " << endl;
    popu[mutNode].Individual::print(popu[mutNode].getNodePtr(), 0);
    popu[mutNode].mutate();
    cout << "popu[" << mutNode << "] after mutate: " << endl;
    popu[mutNode].Individual::print(popu[mutNode].getNodePtr(), 0);
    */
    // Node mutation on the Crossover offspring
    popu[winfst].mutate(popu[winfst].the_indiv, mutRate);
    /*
    cout << "winfst after Node Mutate: " << endl;
    cout << "winfst: " << endl;
    popu[winfst].Individual::print(popu[winfst].getNodePtr(), 0);

    cout << "winsnd after Node Mutate: " << endl;
    */
    popu[winsnd].mutate(popu[winsnd].the_indiv, mutRate);
    //cout << "winsnd: " << endl;
    //popu[winsnd].Individual::print(popu[winsnd].getNodePtr(), 0);

    /*
    // subtree mutate on 2 offsprings
    cout << endl << "for subtree mutation: " << endl;
    cout << "best first" << endl;
    popu[winfst].Individual::mutate();
    popu[winfst].Individual::print(popu[winfst].getNodePtr(), 0);
    cout << "for subtree mutation: " << endl;
    cout << "best snd: " << endl;
    popu[winsnd].Individual::mutate();
    popu[winsnd].Individual::print(popu[winsnd].getNodePtr(), 0);
    */
    /*
    // update fitness accordingly
    cout << "fitness before update: " << endl;
    cout << "fitness popu[winfst]: " << popu[winfst].fitness << endl;
    cout << "fitness popu[winsnd]: " << popu[winsnd].fitness << endl;
    */
    popu[winfst].evaluate();
    popu[winsnd].evaluate();
    /*
    cout << "fitness after update: " << endl;
    cout << "fitness popu[winfst]: " << popu[winfst].fitness << endl;
    cout << "fitness popu[winsnd]: " << popu[winsnd].fitness << endl;
    */

    int badIdx[100];
    if (cnt > 500000) 
    {
        memset(badIdx, 0, sizeof(badIdx));
        int p = 0, cnter = 0;
        for (int i = 0; i < size; ++i) 
        {
            popu[i].evaluate();
            popu[i].calc_size();
            //if ((popu[i].size > 40 || popu[i].fitness > 1000) && i != fst && i != snd)
            if ((popu[i].size > 60) && i != fst && i != snd)
                //if ((popu[i].fitness > 10000) && i != fst && i != snd)
            {
                badIdx[p++] = i;
                ++cnter;
            }
        }
        for (int i = 0; i < cnter; ++i) 
        {
            if (i % 2 == 0)
                popu[fst].copy(popu[badIdx[i]]);
            else 
                popu[snd].copy(popu[badIdx[i]]);
        }
        for (int j = 0; j < cnter/2; ++j) 
            swapSubtree(badIdx[2*j], badIdx[2*j+1], cnter);
        for (int i = 0; i < cnter/2; ++i) 
        {
            popu[badIdx[2*i]].mutate(popu[badIdx[2*i]].the_indiv, mutRate);
            popu[badIdx[2*i+1]].mutate(popu[badIdx[2*i+1]].the_indiv, mutRate);
            popu[badIdx[2*i]].evaluate();
            popu[badIdx[2*i+1]].evaluate();
        }
    }
}

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
    /*
    cout << "popu[fst].non_terms: " << popu[fst].non_terms << endl;
    cout << "popu[snd].non_terms: " << popu[fst].non_terms << endl;
    */
    if (rand() % 100 / 100.0 < 0.90 && popu[fst].non_terms) { // non-terminal swap
        //cout << "non_terms: " << popu[fst].non_terms << endl;
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
    /*
    cout << "one val: " << one << "\t one type: " << oneFlag << endl;
    cout << "two val: " << two << "\t two type: " << twoFlag << endl;
    */
    twoPtr p, q;
    int onecnt = 0, twocnt = 0;
        
    //cout << "the first one: " << endl;
    if (!oneFlag) {        
        popu[fst].getTermNodePtr(popu[fst].the_indiv, one, onecnt);
        p = popu[fst].term[0];
    } else {        
        popu[fst].getNonTermNodePtr(popu[fst].the_indiv, one, onecnt);
        p = popu[fst].nonterm[0];
    }
    
    //cout << "the second one: " << endl;
    
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

    /* // my old method, which is not working       
    twoPtr pone, ptwo;
    int onematch = -1, twomatch = -1;
    int p = 0, q = 0;
    //cout << "one: " << endl;
    pone = popu[fst].myTraverse(popu[fst].the_indiv, one, onematch, p);
    //cout << "two: " << endl;
    ptwo = popu[snd].myTraverse(popu[snd].the_indiv, two, twomatch, q);
    oneprv = pone.prt;
    onecur = pone.cld;
    twoprv = ptwo.prt;
    twocur = ptwo.cld;
    */
    
    oneprv = p.prt;
    onecur = p.cld;
    twoprv = q.prt;
    twocur = q.cld;
    /*
    cout << "oneprv: " << oneprv << endl;
    cout << "onecur: " << onecur << endl;
    cout << "twoprv: " << twoprv << endl;
    cout << "twocur: " << twocur << endl;
    */
    // swap two parts of subtrees from two individuals
    // special conditions still needs to be worked on
    if (!oneprv && !twoprv){;} // do nothing here
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
    /*
    cout << "best fst after swap: " << endl;
    popu[fst].Individual::print(popu[fst].getNodePtr(), 0);
    cout << "best snd after swap: " << endl;
    popu[snd].Individual::print(popu[snd].getNodePtr(), 0);
    */
}
/*
void Individual::mutate() 
{
    int mutNode = rand() % size;
    float dep = log2(size+1);
    float curDep;
    if (mutNode > size / 2)
        curDep = log2(mutNode-size/2);
    else
        curDep = log2(mutNode);
    int newDep = ceil(dep-curDep);
     
    Individual subs;
    subs.generate(newDep);
    cout << "new generated substitute tree" << endl;
    subs.print(i.getNodePtr(), 0);

    int onematch = -1;
    int p = 0;
    cout << "node mutNode: " << mutNode << endl;
    pone = subs.myTraverse(subs.the_indiv, mutNode, onematch, p);

    oneprv = pone.prt;
    onecur = pone.cld;
    cout << "oneprv: " << oneprv << endl;
    cout << "onecur: " << onecur << endl;

    for (int i = 0; i < MAX_ARITY; ++i) 
    {
        if (oneprv->branches[i] == onecur)
        {
            oneprv->branches[i] = subs.the_indiv;
            subs.the_indiv->parent = oneprv;
        }
    }
}
*/
int Population::TourSelection(int len) {
    int winIdx = idxArray[0];
    float winFitness = popu[winIdx].fitness;
    int temp;
    float tempFitness;
    for (int i = 1; i < len; ++i) {
        temp = idxArray[i];
        tempFitness = popu[temp].fitness;
        if (tempFitness < winFitness) {
            winFitness = tempFitness;
            winIdx = temp;
        }
    }
    return winIdx;
}

twoIdx Population::tourSelection(int len) {
    twoIdx idx;
    int winIdx = TourSelection(len);
    cout << "winIdx: " << winIdx << endl;
    
    int newArray[len-1];
    int p = 0;
    for (int i = 0; i < len; ++i) 
    {
        if (idxArray[i] == winIdx);
        else
            newArray[p++] = idxArray[i];
    }
    for (int i = 0; i < len-1; ++i)
        cout << newArray[i] << "\t";
    cout << endl;

    int sndIdx = newArray[0];
    float winFitness = popu[sndIdx].fitness;
    int temp;
    float tempFitness;
    for (int i = 1; i < len-1; ++i) {
        temp = newArray[i];
        tempFitness = popu[temp].fitness;
        if (tempFitness < winFitness) {
            winFitness = tempFitness;
            sndIdx = temp;
        }
    }
    
    idx.fst = winIdx;
    idx.snd = sndIdx;
    cout << "tour fst: " << winIdx << endl;
    cout << "tour snd: " << sndIdx << endl;
    
    return idx;
}
/*
twoIdx Population::tourSelection(int len) {
    twoIdx idx;
    int winIdx = idxArray[0], sndIdx = winIdx;
    float winFitness = popu[winIdx].fitness, sndFitness = winFitness;
    
    int temp = idxArray[0], snd;
    float tempFitness = popu[temp].fitness, sndfit;

    for (int i = 1; i < len; ++i) {
        snd = temp;
        sndfit = tempFitness;
        temp = idxArray[i];
        tempFitness = popu[temp].fitness;
        
        if (tempFitness-winFitness < 0.000001) {        
            sndFitness = winFitness;
            sndIdx = winIdx;
            winFitness = tempFitness;
            winIdx = temp;
        }
        
        if ( (tempFitness-winFitness>0.000001) && (sndFitness-tempFitness>0.000001) ) {
            sndFitness = tempFitness;
            sndIdx = temp;
        }
    }
    
    idx.fst = winIdx;
    idx.snd = sndIdx;
    cout << "tour fst: " << winIdx << endl;
    cout << "tour snd: " << sndIdx << endl;
    
    return idx;
}
*/
void Population::print() {  // print population
    for (int i = 0; i < size; ++i) 
    {
        popu[i].evaluate();
        //cout << endl << "popu[" << i << "]: " << " Size: " << popu[i].getSize() << " Fitness: " << popu[i].getFitness();
        if (popu[i].fitness - minFitness() < 0.00001) 
        {
            cout << endl << "popu[" << i << "]: " << " Size: " << popu[i].getSize() << " Fitness: " << popu[i].getFitness() << endl;
            popu[i].Individual::print(popu[i].getNodePtr(), 0);
        }
    }
    printf("\n\n");
}

void Population::generate() { // generate population
    int dep;
    for (int i = 0; i < size; ++i)
    {
        dep = rand() % depth + 1;
        //cout << "popu[" << i << "] " << "dep: " << dep << endl;
        popu[i].Individual::generate(dep);
        popu[i].fitness = popu[i].getFitness();
    }
}

void Population::printRanIndi(int len) {
    for (int i = 0; i < len; ++i)
	printf("%d ", idxArray[i]);
    printf("\n");
}

void Population::genRanIndi(int n) {
    idxArray = new int[n];
    idxArray[0] = rand() % size;
    for (int i = 1; i < n; ++i) 
        idxArray[i] = rand() % size;
    sort(idxArray, idxArray+n);
    int cnt = 0;

    for (int i = 1; i < n; ++i) 
    {
        if (idxArray[i] == idxArray[i-1]) 
        {
            ++cnt;
            for (int j = i; j < n-1; ++j)
                idxArray[j] == idxArray[j+1];
        }
    }
    int p = cnt;
    for (int i = 0; i < cnt; ++i) 
    {
        idxArray[n-p] = rand() % size;
        for (int j = 0; j < n-cnt; ++j)
            while (idxArray[j] == idxArray[n-p])
                idxArray[n-p] = rand() % size;
        --p;
    }
}

float Population::minFitness() {
    float minFitness = popu[0].fitness;
    float tempFitness;
    for (int i = 1; i < size; ++i) {
	tempFitness = popu[i].fitness;
	if (tempFitness - minFitness < 0.000001)
	    minFitness = tempFitness;
    }
    return minFitness;
}

twoIdx Population::maxFitness() {
    twoIdx idx;
    float maxFitness = popu[0].fitness, sndFitness;
    int worIdx = 0, sndIdx, temp = 0, snd;
    float tempFitness = popu[temp].fitness, sndfit;

    for (int i = 1; i < size; ++i) {
        snd = temp;
        sndfit = tempFitness;        
        temp = i;
        tempFitness = popu[i].fitness;
        
        if (tempFitness - maxFitness > 0.00001) {
            sndFitness = maxFitness;
            sndIdx = worIdx;
            maxFitness = tempFitness;
            worIdx = temp;
        } else if ( (tempFitness - maxFitness <= 0.00001) && (tempFitness - sndFitness > 0.00001) ) {
            sndFitness = tempFitness;
            sndIdx = i;
        }
    }
    idx.fst = worIdx;
    idx.snd = sndIdx;
    return idx;
}

float Population::avgFitness() {
    float avgFitness = 0.0;
    for (int i = 0; i < size; ++i) {
        avgFitness += popu[i].fitness;
    }
    avgFitness = (float) (avgFitness / size);
    return avgFitness;
}
/*
float Population::avgIndiSize() {
    int res = 0;
    for (int i = 0; i < size; ++i) 
        res += popu[i].getSize();
    float avgSize = (float)res/size;
    return avgSize;
}
*/
void Population::evaluate_print() {
    for (int i = 0; i < size; ++i)
        popu[i].evaluate_print();
}

float Population::avgIndiSize() 
{
    int sumSize = 0;
    for (int i = 0; i < size; ++i) 
    {
        popu[i].calc_size();
        popu[i].evaluate();
        sumSize += popu[i].Individual::getSize();
    }
    return (float)sumSize/size;
}
