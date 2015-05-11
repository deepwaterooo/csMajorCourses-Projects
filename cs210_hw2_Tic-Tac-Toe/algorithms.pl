:- module(algorithms,
        [ minimax/5            % The minimax algorithm
        ]).

:- use_module(board,
        [ moves/2,
          opponent/1,
          me/1
        ]).

:- use_module(heuristics,
        [ value/3
        ]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%%%     Minimax
%%%
%%%
%%%     This is a minimax algorithm using alpha-beta pruning
%%%
%%%         minimax(+Board, -BestMove, )
%%%
%%%         where Board is the current board state
%%%               BestMove is the best selected move
%%%               BestValue is the heuristic value of this move
%%%               Branches is the number of branches used
%%%               Depth is the lookahead of the algorithm
%%%
%%%         if there is no more moves available, it fails

:- dynamic bounds/1.

:- asserta(bounds(0/10000000)).

minimax(Board, BestMove, BestValue, Branches, Depth) :-
  Depth > 0,
  bounds(Bounds),
  nb_setval(branches, 0),
  alphabeta(Board, Bounds, BestMove, BestValue, Depth, min),
  nb_getval(branches, Branches), !.

alphabeta(Board, _, _, Val, 0, ToMove) :-
  player(ToMove, X),
  heuristics:value(Board, X, Val), !.

alphabeta(Board, Bounds, GoodMove, GoodVal, Depth, ToMove) :-
  nb_getval(branches,N),NC is N+1,nb_setval(branches,NC),
  board:moves(Board, Moves),
  min_or_max(ToMove, NextToMove),
  OneDeeper is Depth - 1,
  boundedbest(Board, Moves, Bounds, GoodMove, GoodVal, OneDeeper, NextToMove), !.

boundedbest(Board, [Move|TailMoves], Bounds, GoodMove, GoodVal, Depth, ToMove) :-
  player(ToMove, X),
  board:put(Board, Move, X, NewBoard),
  alphabeta(NewBoard, Bounds, _, Val, Depth, ToMove),
  goodenough(Board, TailMoves, Bounds, Move, Val, GoodMove, GoodVal, Depth, ToMove), !.

goodenough(_, [], _, Move, Val, Move, Val, _, _) :- !.

goodenough(_, _, Alpha/Beta, Move, Val, Move, Val, _, ToMove) :-
  ToMove = min, Val > Beta, !
  ;
  ToMove = max, Val < Alpha, !.

goodenough(Board, TailMoves, Bounds, Move, Val, GoodMove, GoodVal, Depth, ToMove)  :-
  newbounds(Bounds, Val, NewBounds, ToMove),
  boundedbest(Board, TailMoves, NewBounds, NewMove, NewVal, Depth, ToMove),
  betterof(NewMove, NewVal, Move, Val, GoodMove, GoodVal, ToMove), !.

newbounds(Alpha/Beta, Val, Val/Beta, ToMove) :-
  ToMove = min, Val > Alpha, !.

newbounds(Alpha/Beta, Val, Alpha/Val, ToMove) :-
  ToMove = max, Val < Beta, !.

newbounds(Alpha/Beta, _, Alpha/Beta, _) :- !.

betterof(Move1, Val1, _, Val2, Move1, Val1, ToMove) :-
  ToMove = min, Val1 > Val2, !
  ;
  ToMove = max, Val1 < Val2, !.

betterof(_, _, Move2, Val2, Move2, Val2, _) :- !.

min_or_max(max, min) :- !.
min_or_max(min, max) :- !.

player(max, X) :- % max = it's me!
  board:me(X), !.  

player(_, X) :-   % min = my opponent!
  board:opponent(X), !.
