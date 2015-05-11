// 9-18-2013

proc first( vector p )
    foreach A elemof TERMS
        first ( A ) = {A}
    foreach A elemof NUM
        first ( A ) = {}
    while stillchangingaAy first ( A ) do {
    	  foreach pi = Ai = x1x2...xn {
	  	  first ( A ) = first ( A ) U fistlist( x1x2...xn )
        }
    }
end

proc firstlist( x1x2...xn )
     firstset = {}
     k = o
     do {
     	k++
	firstset = firstset U ( first( xk ) - e )
     } while K < n & belong element First( xk )

// if x1x2...xk is nullable
   if K = n & belong element First( xn ) {
      firstset = firstset U { e }
   }
   return firstset
}

// first and follow sets webpage -- check !!!
09-19-2013 Thursday

1 <exp> ::= <exp> <addop>l <term>
2 <exp> ::= <term> 
3 <addop> ::= + | -
4 <term> ::= <term> <mulop> <factor>
5 <term> ::= <factor>
6 <mulop> ::= *
7 <factor> ::= ( <exp> )
8 <factor> ::= num

<exp> ::= first(exp), first(term)
<addop> ::= first(+), first(-)
<term> ::= first(term), first(factor)
<mulop> ::= first(*)
<factor> ::= first( ( ), first(num) 

// first set for non-terminals: 
Non-term : First : FollowSetProd1&5 FollowSetProd2&7 FollowSetProd4
<exp> : ( , num    First(addop)     First(")")
<addop> : + , -    First(term)
<term> : ( , num   follow(exp), first(mulop) first(factor) follow(term)
<mulop> : *        first(factor)
<factor> : ( , num follow(exp)
	     
Non-term : First : FollowSetProd1&5 FollowSetProd2&7 FollowSetProd4
<exp> : ( , num    +,- )
<addop> : + , -    (, num
<term> : ( , num   +,-,) * (,num
<mulop> : *        
<factor> : ( , num +,-,),*
$ // end of input, in a legal program, pay attention to this mark

top-down bottom-up
non-terminal mark table
M( N, tokeninput ) --> Pk

N\token:    $ + - *  || ( ) num
------------------------------------------------------------
<exp> :    STOP      || 12  12
<addop> :     3 3    ||
<term> :             || 45  45
------------------------------------------------------------
<mulop> :          6 ||
<factor> :           || 7   8
rework on grammar so that each token belongs to only one grammars

			    //conditioning grammars
 // example 2
<exp>   ::= <term> <expx>
<expx>  ::= <addop> <term> <expx> | \epsilon 
<addop> ::= + | - 
<term>  ::= <factor> <termx>
<termx> ::= <mulop> <factor> <termx> | \epsilon
<mulop> ::= *
<factor>::= ( <exp> ) | num 















