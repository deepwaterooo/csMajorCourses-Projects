#include <iostream>
#include <stdlib.h>
#include <string>
#include <map>
#include <list>
#include "exp.h"

using namespace std;

  // the constructor for node links the node to its children,
  // and stores the character representation of the operator.
  operator_node::operator_node(exp_node *L, exp_node *R) {
    left    = L;
    right   = R;
  }

  
  number_node::number_node(float value) {
    num = value;
   }
  
void number_node:: print() {
  cout << num;
}

  float number_node::evaluate() { 
    cout << "number_node: operand = " << num << endl;
    return num; }

  id_node::id_node(string value) : id(value) {}

void id_node:: print() {
  cout << id;
}

  float id_node::evaluate() { 
    cout << "id_node: " << id << " = " << idTable[id] << endl;
    return idTable[id]; 
  }

// plus_node inherits the characteristics of node and adds its own evaluate function
  // plus_node's constructor just uses node's constructor
  plus_node::plus_node(exp_node *L, exp_node *R) : operator_node(L,R) {
  }

void plus_node:: print() {
  cout << "(";
  left->print();
  cout << " + ";
  right->print();
  cout << ")";
}

  float plus_node::evaluate() {
    float left_num, right_num;

    left_num  = left->evaluate();
    right_num = right->evaluate();

    num = left_num + right_num;
    cout << "plus_node: " << left_num << " + " << right_num << " = " << num << "\n";
    return (num);
  }


// minus_node inherits the characteristics of node and adds its own evaluate function
  minus_node::minus_node(exp_node *L, exp_node *R) : operator_node(L,R) {
  }

void minus_node:: print() {
  cout << "(";
  left->print();
  cout << " - ";
  right->print();
  cout << ")";
}

  float minus_node::evaluate() {
    float left_num, right_num;

    left_num  = left->evaluate();
    right_num = right->evaluate();

    num = left_num - right_num;
    cout << "minus_node: " << left_num << " - " << right_num << " = " << num << "\n";
    return (num);
  }


// times_node inherits the characteristics of node and adds its own evaluate function
  times_node::times_node(exp_node *L, exp_node *R) : operator_node(L,R) {
  }

void times_node:: print() {
  cout << "(";
  left->print();
  cout << " * ";
  right->print();
  cout << ")";
}

  float times_node::evaluate() {
    float left_num, right_num;

    left_num = left->evaluate();
    right_num = right->evaluate();

    num = left_num * right_num;
    cout << "times_node: " << left_num << " * " << right_num << " = " << num << "\n";
    return (num);
  }


// divide_node inherits the characteristics of node and adds its own evaluate function

  divide_node::divide_node(exp_node *L, exp_node *R) : operator_node(L,R) {
  }

void divide_node:: print() {
  cout << "(";
  left->print();
  cout << " / ";
  right->print();
  cout << ")";
}

  float divide_node::evaluate() {
    float left_num, right_num;

    left_num = left->evaluate();
    right_num = right->evaluate();

    if(right_num)
      {
        num = (float)left_num / (float)right_num;
        cout << "divide_node: " << left_num << " / " << right_num << " = " << num << "\n";
        return (num);
      }
    else
      {
	cout << "divide_node: division by zero -> " << left_num << " / " << 0 << endl;
	// you have to include stdlib.h for exit
	exit(1);
      }
  }

// unary_minus_node inherits the characteristics of node and adds its own evaluate function
unary_minus_node::unary_minus_node(exp_node *L) : exp(L) {}

void unary_minus_node:: print() {
  cout << "-";
  exp->print();
}

float unary_minus_node::evaluate() {
  int expValue = exp->evaluate();
  num = -expValue;

  cout << "unary_minus_node: " << "-\t" << expValue << " = " << num << "\n";
    return num;
}

assignment_stmt::assignment_stmt(string name, exp_node *expression)
  : id(name), exp(expression) {}

void assignment_stmt::print() {
  cout << id << " = ";
  exp->print();
  cout << endl;
}

void assignment_stmt::evaluate() {
  float result = exp->evaluate();
  cout << "assignment_node: " << id << " = " << result << endl << endl;
  idTable[id] = result;
}

print_stmt::print_stmt (string name) : id(name) {}

void print_stmt::evaluate() {
  cout << "print_node: " << id << " = " << idTable[id] << endl << endl;
}

pgm::pgm(list<statement *> *stmtList) : stmts(stmtList) {}

void pgm::evaluate() {
  list<statement *>::iterator stmtIter;
  for (stmtIter = stmts->begin(); stmtIter != stmts->end();
       stmtIter++) {
    (*stmtIter)->print();
    (*stmtIter)->evaluate();
  }
}

map<string, float> idTable;
