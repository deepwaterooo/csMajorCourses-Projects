#include<iostream>
#include<cmath>
#include<cstdlib>
#include "node.h"
#include "individual.h"
using namespace std;

const double CONST_LIMIT = 10.0;
/*
const int NUM_POINTS = 5;
float inputs[NUM_POINTS] = {1,2,3,4,5};
float outputs[NUM_POINTS] = {1,4,9,16,25};
*/

const int NUM_POINTS = 81;
float inputs[NUM_POINTS] = {-40,-39,-38,-37,-36,-35,-34,-33,-32,-31,-30,-29,-28,-27,-26,-25,-24,-23,-22,-21,-20,-19,-18,-17,-16,-15,-14,-13,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40};
float outputs[NUM_POINTS] = {52,30.2,23.2,12,0.6,-8,-20.8,-21.8,-27,-33.4,-41,-53.8,-52.8,-61,-55.4,-56,-63.8,-65.8,-60,-55.4,-57,-57.8,-49.8,-42,-42.4,-29,-28.8,-13.8,-13,-1.4,15,-7.5,-5,1.5,1,0.5,-7,2.5,-1,2.5,1,-0.5,5,3.5,-1,1.5,7,-0.5,2,-0.5,10.20537863,12.47229837,12.60292251,14.07559994,12.28493299,19.68999988,20.94679123,19.99243556,21.06059243,22.6242444,18.27989445,14.6015212,12.00004897,22.62273913,20.31713541,24.66839051,28.10083518,31.01892213,27.95303678,28.67447528,35.2514392,31.03233741,29.56048342,34.44107329,31.19301254,35.12186997,36.24506377,31.28759691,34.74938605,44.02769935,43.56472625};

static float avgTgt;
float evoOut[NUM_POINTS];

float genNum = 10.0;

Individual& Individual::operator=(Individual &rhs) {
    return *this;
}

bool Individual::condition(int cnt, int& ori)
{
    if (ori < cnt)
        return true;
    else
        return false;
}

twoPtr Individual::myTraverse(node* src, int cnt, int& match, int& p) 
{
    node* tmp = src;
    node* dst = src;
    if (tmp && condition(cnt, match)) 
    {
        switch(src->type) {
        case add:
        case subtract:
        case multiply:   
        case divide:
            for (int i = 0; condition(cnt, match) && i < 2; ++i) {
                if (i > 0)
                    --match;
                ++match;
                tmp = src->branches[i]; dst = src;
                //cout << "i: " << i << "\tmatch: " << match << endl;
                //cout << "src->type: " << src->type << endl;
                //cout << "\t src: " << src << endl;
                //cout << "\t tmp: " << tmp << endl;
                myTraverse(src->branches[i], cnt, match, p);
            }
            break;
        case mypow:
            if (condition(cnt, match)) 
            {
                ++match;
                //cout << "match: " << match << endl;
                tmp = src->branches[0]; dst = src;
                //cout << "src->type: " << src->type << endl;
                //cout << "\t src: " << src << endl;
                //cout << "\t tmp: " << tmp << endl;
                myTraverse(src->branches[0], cnt, match, p);
            }
            break;
        case myif:
            for (int i = 0; condition(cnt, match) && i < MAX_ARITY; ++i) {            
                if (i > 0)
                    --match;
                ++match;
                tmp = src->branches[i]; dst = src;
                //cout << "i: " << i << "\tmatch: " << match << endl;
                //cout << "src->type: " << src->type << endl;
                //cout << "\t src: " << src << endl;
                //cout << "\t tmp: " << tmp << endl;
                myTraverse(src->branches[i], cnt, match, p);
            }
            break;
        case inputX:
        case constt:
            ++match;
            //cout << "match: " << match << endl;
            //cout << "src->type: " << src->type << endl;
            tmp = src; dst = src;
            //cout << "src: " << src << endl;
            //cout << "tmp: " << tmp << endl;
            break;
        default:
            //cout << "something is wrong here: " << endl;
            break;
        }
    }
    
    //cout << "match: " << match << endl;
    if (match == cnt) 
    {
        doneFlag = true;
        pair[p].prt = dst->parent;
        pair[p].cld = dst;
        //cout << "Individual prt: " << pair[p].prt << endl;
        //cout << "Individual cld: " << pair[p].cld << endl;
        p++;
        return pair[0];
    } 
}

twoPtr Individual::getPtrs(int x) 
{
    node* tmp;
    node* cur = the_indiv;
    int cnt = -1; int j = 0; int y = 0;
    while (cur && cnt < x-1)
    {
        ++cnt;
        switch(cur->type) 
        {
        case add:
        case subtract:	
        case multiply:
        case divide:
            cur = cur->parent->branches[0];
            cur = cur->parent->branches[1];
            break;
        case mypow:
            cur = cur->parent->branches[0];
            break;
        case myif: // less than or equal to
            cur = cur->parent->branches[0];
            cur = cur->parent->branches[1];
            cur = cur->parent->branches[2];
            cur = cur->parent->branches[3];
        }
        cur = cur->branches[j++];
        while (!cur && j < 4) 
            cur = (cur->parent)->branches[y++];
    }
    twoPtr pair;
    pair.cld = cur;
    pair.prt = cur->parent;
    return pair;
}
    
void getAvgTarget() {
    float sum = 0;
    for (int i = 0; i < NUM_POINTS; ++i)
        sum += outputs[i];
    avgTgt = sum / NUM_POINTS;
}

void Individual::evaluate(void){  
	fitness = 0;
	float output;
	for(int j=0; j < NUM_POINTS; j++){
		output = the_indiv-> evaluate(inputs[j]);
		fitness += (pow((output-outputs[j]),2));
	}
    fitness += 0.09*pow((getSize()-12), 2);
	fitness = sqrt(fitness);
}

/*
void Individual::evaluate(void){  
	fitness = 0;
    getAvgTarget();
	float output, avgEvo;
    float sumevo = 0, sumpdt = 0, sumsqrt = 0;

	for(int j=0; j < NUM_POINTS; j++){
        // need to panelize for individual tree size  81 times  810
		output = the_indiv->evaluate(inputs[j]) + pow((getSize()-14), 2);
        evoOut[j] = output;
        sumevo += output;
	}
    avgEvo = (float)sumevo / NUM_POINTS;
    //cout << "avgEvo: " << avgEvo << endl;
    
	for(int j=0; j < NUM_POINTS; j++) 
    {
        sumpdt += (outputs[j]-avgTgt)*(evoOut[j]-avgEvo);
        sumsqrt += pow((evoOut[j]-avgEvo), 2);
    }
    float bcons = sumpdt / sumsqrt;
    float acons = avgTgt - bcons*avgEvo;
	for(int j=0; j < NUM_POINTS; j++) 
        fitness += pow( (outputs[j]-(acons+bcons*evoOut[j])), 2);
	fitness = fitness/NUM_POINTS;
    //cout << "fitness: " << fitness << endl;
}
*/

void Individual::evaluate_print(void){
	fitness = 0;
	float output;
	for(int j=0; j < NUM_POINTS; j++){
		output = the_indiv-> evaluate(inputs[j]);
		fitness += (pow((outputs[j]-output),2));
		//cout << inputs[j] << "," << output << "," << outputs[j] << " , " ;
	}
	fitness = sqrt(fitness);
	//cout << endl << "Fitness = " << fitness << "\t size: " << getSize() << endl;
}

// subtree mutation
void Individual::mutate() 
{
    calc_size();
    evaluate();
    //int mutNode = rand() % size;
    int mutNode = 0;
    
    /*
    float dep = log2(size+1);
    float curDep;
    if (mutNode > size / 2)
        curDep = log2(mutNode-size/2);
    else
        curDep = log2(mutNode);
    int newDep = floor(dep-curDep);
    */
    Individual subs;
    //subs.generate(newDep);
    subs.generate(3);
    cout << "new generated substitute tree" << endl;
    subs.print(subs.the_indiv, 0);

    bool mutNodeFlag = false;
    if (rand() % 100 / 100.0 < 0.90 && non_terms) { // non-terminal swap
        mutNode = rand() % non_terms;
        mutNodeFlag = true;  
    } else {    
        mutNodeFlag = false;
        mutNode = rand() % terms;
    }
    cout << "mutNode: " << mutNode << "\t type: " << mutNodeFlag << endl;
        
    twoPtr pone;
    int onecnt = 0;
    if (!mutNodeFlag) {        
        getTermNodePtr(the_indiv, mutNode, onecnt);
        pone = term[0];
    } else {        
        getNonTermNodePtr(the_indiv, mutNode, onecnt);
        pone = nonterm[0];
    }
    /*
    int onematch = -1;
    int p = 0;
    cout << "node to be mutated mutNode: " << mutNode << endl;
    twoPtr pone = myTraverse(the_indiv, mutNode, onematch, p);
    */
    node* oneprv = pone.prt;
    node* onecur = pone.cld;
    cout << "oneprv: " << oneprv << endl;
    cout << "onecur: " << onecur << endl;
    /*
    int cnt = 0;
    getNodePtr(the_indiv, mutNode, cnt);
    pone = together[0];
    oneprv = pone.prt;
    onecur = pone.cld;
    cout << endl << "another set: " << endl;
    cout << "oneprv: " << oneprv << endl;
    cout << "onecur: " << onecur << endl;
    */
    
    if (mutNodeFlag && !oneprv) // non-term root
    {
        the_indiv->erase();
        the_indiv = NULL;
        copy(subs.the_indiv);
    } else 
    {
        for (int i = 0; i < MAX_ARITY; ++i) 
        {

            if (oneprv && oneprv->branches[i] == onecur) // parent exist
            {
                onecur->parent->branches[i] = subs.the_indiv;
                subs.the_indiv->parent = oneprv;
                onecur->node::erase();
                break;
            } 
        }
    }
    subs.the_indiv->erase();
    subs.the_indiv= NULL;
}

void Individual::mutate(node* tmp, float mutRate) 
{
    int type;
    if (tmp && rand()% 100/100.0 < mutRate) 
    {
        if (tmp->type < NUM_NON_TERMS && tmp->type < 4) 
        {
            type = rand() % 4;
            while (type == tmp->type)               
                type = rand() % 4; // get rid of pow and if
            tmp->type = type;
            for (int i = 0; i < 2; ++i)
                mutate(tmp->branches[i], mutRate);
        } else if (tmp->type >= 4 && tmp->type < 8) {        
            tmp->type = 4 + rand() % 4;
            mutate(tmp->branches[0], mutRate);
        } else if (tmp->type == 9) 
        {
            if (rand() % 100 / 100.0 < 0.5) 
            {
                tmp->type = 10;
                tmp->const_value = double(drand48() * 2.0 * CONST_LIMIT) - (CONST_LIMIT/2.0);
            }
        } else if (tmp->type == 10) {
            /*
              if (rand() % 1000 / 1000 < 0.5)
              tmp->const_value = tmp->const_value + 0.05;
              else
              tmp->const_value = tmp->const_value - 0.05;
            */
            tmp->const_value = double(drand48() * 2.0 * CONST_LIMIT) - (CONST_LIMIT/2.0);    
        }
        else if (tmp->type == 8) 
            for (int i = 0; i < MAX_ARITY; ++i)
                mutate(tmp->branches[i], mutRate);
        else;
    } else {    
        switch(tmp->type)
        {
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

void Individual::mutate(float mutRate, int cnt) {
/*
  float delta, temp, random;
    if (cnt % 100 == 0)  
        genNum *= 10.0;
        
    for (int i = 0; i < p; ++i) {
        if (rand()%1000/1000 < mutRate) 
        {
            delta = (float)(((*funPtr).high - (*funPtr).low) / genNum );
            random = rand() % 1000 / 1000.0;
            //if ( (rand()%100/100.0) < 0.5)   // pos
            if ( random < 0.5)   // pos
                temp = point[i] + delta;
            else                  // neg
                temp = point[i] - delta;
            while (temp < (*funPtr).low || temp > (*funPtr).high) {
                delta = (float)((*funPtr).high - (*funPtr).low) / genNum;
                random = rand() % 1000 / 1000.0;
                //if ( (rand()%100/100.0) < 0.5)   // pos
                if ( random < 0.5)   // pos
                    temp = point[i] + delta;
                else                  // neg
                    temp = point[i] - delta;
            } // while
        }
        point[i] = temp;
    }
    fitness = getFitness();
*/
}

void Individual::erase(void){
	the_indiv -> erase();
}

void Individual::copy(node* src) 
{
    the_indiv = new node;
    the_indiv->parent = NULL;
    node* newPtr = the_indiv;
    node * tmp = src;
    node::copy(newPtr, tmp);
}

void Individual::copy(Individual& dst) 
{
    if (this != &dst) 
    {
        dst.fitness = fitness;
        dst.size = size;
        dst.terms = terms;
        dst.non_terms = non_terms;

        dst.the_indiv = new node;
        (dst.the_indiv)->parent = NULL;
        node* newPtr = dst.the_indiv;
        node * tmp = the_indiv;
        node::copy(newPtr, tmp);
    }
}

Individual Individual::copy() 
{
    Individual newtree;
    newtree.fitness = fitness;
    newtree.size = size;
    newtree.terms = terms;
    newtree.non_terms = non_terms;

    newtree.the_indiv = new node;
    node* newPtr = newtree.the_indiv;
    node * tmp = the_indiv;
    node::copy(newPtr, tmp);
    return newtree;
}

void Individual::generate(int max_depth){
    /*
    the_indiv->erase();
    the_indiv= NULL;
    */
	the_indiv = new node;
    the_indiv->parent = NULL;
	the_indiv->full(0, max_depth,NULL);
}

string genTab(int cnt) 
{
    string s = "";
    for (int i = 0; i < cnt; ++i)
        s.append("\t");
    return s;
}

void Individual::print(node* p, int depth) 
{
    string s;
    if (p != NULL)  {    
        s = genTab(depth);
        /*
          switch(p->type) {        
          case add:
          cout << s << "+" << p->type << "  " << endl;
          break;
          case subtract:
          cout << s << "-" << p->type << "  " << endl;
          break;
          case multiply:
          cout << s << "*" << p->type << "  " << endl;
          break;
          case divide:
          cout << s << "/" << p->type << "  " << endl;
          break;
          case mypow:
          cout << s << "P" << p->type << "  " << endl;
          break;
          case myif:
          cout << s << "F" << p->type << "  " << endl;
          break;            
          case inputX:
          cout << s << "X" << p->type << "  " << endl;
          break;
          case constt:
          cout << s << p->getVal() << "  " << endl;
          break;
          }
        */
          switch(p->type) {        
          case add:
          cout << s << "+" << "  " << endl;
          break;
          case subtract:
          cout << s << "-" << "  " << endl;
          break;
          case multiply:
          cout << s << "*" << "  " << endl;
          break;
          case divide:
          cout << s << "/" << "  " << endl;
          break;
          case mypow:
          cout << s << "P" << "  " << endl;
          break;
          case myif:
          cout << s << "F" << "  " << endl;
          break;            
          case inputX:
          cout << s << "X" << "  " << endl;
          break;
          case constt:
          cout << s << p->getVal() << "  " << endl;
          break;
          }

          /*
        switch(p->type) {        
        case add:
            cout << s << "+" << p->type << "  " << p << endl;
            break;
        case subtract:
            cout << s << "-" << p->type << "  " << p << endl;
            break;
        case multiply:
            cout << s << "*" << p->type << "  " << p << endl;
            break;
        case divide:
            cout << s << "/" << p->type << "  " << p << endl;
            break;
        case mypow:
            cout << s << "P" << p->type << "  " << p << endl;
            break;
        case myif:
            cout << s << "F" << p->type << "  " << p << endl;
            break;            
        case inputX:
            cout << s << "X" << p->type << "  " << p << endl;
            break;
        case constt:
            cout << s << p->getVal() << "  " << p << endl;
            break;
        }
        */
        for (int i = 0; i < MAX_ARITY; ++i)
            print(p->branches[i], depth+1);
    }
}

void Individual::calc_size(void){
	terms = 0;
	non_terms = 0;
	size = 0;
    node* tmp = the_indiv;
    tmp->calc_size(terms,non_terms);
	size += (terms + non_terms);
    //cout << "Individual Calc_size: " << size << endl;
}

void Individual::getTermNodePtr(node* tmp, int &myterm, int& cnt) 
{
    twoPtr pair;
	if(tmp->type >= NUM_NON_TERMS){	// count size
        if (myterm == 0) 
        {
            /*
            cout << "term tmp: " << tmp << endl;
            cout << "term tmp->parent: " << tmp->parent << endl;
            */
            pair.cld = tmp;
            pair.prt = tmp->parent;
            term[cnt] = pair;
            cnt++;
            //return tmp;
        }
		--myterm;
		//return;
	} else {
		for(int i=0;i<MAX_ARITY;++i){
			if(tmp->branches[i] != NULL)
				getTermNodePtr(tmp->branches[i], myterm, cnt);
		}
	}
}

void Individual::getNonTermNodePtr(node* tmp, int &mynonterm, int& cnt) 
{
    twoPtr pair;
	if(tmp->type >= NUM_NON_TERMS){	// count size
		;
	} else {
        if (mynonterm == 0) 
        {
            /*
            cout << "non-term tmp: " << tmp << endl;
            cout << "non-term tmp->parent: " << tmp->parent << endl;
            */
            pair.cld = tmp;
            pair.prt = tmp->parent;
            nonterm[cnt] = pair;
            cnt++;
            //return tmp;
        }
        --mynonterm;
		for(int i=0;i<MAX_ARITY;++i){
			if(tmp->branches[i] != NULL)
				getNonTermNodePtr(tmp->branches[i], mynonterm, cnt);
		}
	}
}

void Individual::getNodePtr(node* tmp, int &myterm, int& cnt)
{
    twoPtr pair;
	if(tmp->type >= NUM_NON_TERMS){	// count size
        if (myterm == 0) 
        {
            //cout << "term tmp: " << tmp << endl;
            pair.cld = tmp;
            pair.prt = tmp->parent;
            together[cnt] = pair;
            cnt++;
            //return tmp;
        }
		--myterm;
	} else {
        if (myterm == 0) 
        {
            //cout << "non-term tmp: " << tmp << endl;
            pair.cld = tmp;
            pair.prt = tmp->parent;
            together[cnt] = pair;
            cnt++;
            //return tmp;
        }
        --myterm;
		for(int i=0;i<MAX_ARITY;++i){
			if(tmp->branches[i] != NULL)
				getNonTermNodePtr(tmp->branches[i], myterm, cnt);
		}
	}
}

