% ANDREA GALASSI.
% -----------------------------------------------------------------
% Exercise 1 : lastel(L, E)
% last element E in list 
lastel([E], E):- !.
lastel([_|T], E):- lastel(T, E).
% -----------------------------------------------------------------

% -----------------------------------------------------------------
% Exercise 2 : max(L,E)
% maximum element in a list
max([], write("empty list")).
max([X], X):- !.
max([M|T], M):- max(T, N), M>N, !.
max([_|T], M):- max(T, M).
% -----------------------------------------------------------------

% -----------------------------------------------------------------
% Exercise 3 : question1(L1, N, L2)
%L2 must be the list of elements in L1 that are list with 2 positive value between 1 and 9 which sum is N.
question1([], _, []).
question1([[A, B]|T], N, [[A,B]|R]):- A>=1, A=<9, B>=1, B=<9, N is A + B, question1(T, N, R).
question1([_|T], N, R):- question1(T, N, R).

% -----------------------------------------------------------------
% Exercise 4 : consec(L,E,F)
% F is the consecutive element of E in list L
consec([X,Y|_], X, Y):- !.
consec([_|T], X, Y):- consec(T, X, Y).

% -----------------------------------------------------------------
% Exercise 5: listPos(L, E, P)
% the element E is in position P in list L
listPos([X|_], X, 0):-!.
listPos([_|T], X, P):-  listPos(T, X, Q), P is Q+1.

% -----------------------------------------------------------------
% Exercise 6 : family
parent(emily, frank).
parent(frank, paolo).
parent(paolo, tommy).
parent(paolo, mary).

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

descendant(X, Y) :- parent(Y, X).
descendant(X, Y) :- parent(Z, X), descendant(Z, Y).

directly_related(X, L) :- findall(A, descendant(A, X), L1),
                            findall(B, ancestor(B, X), L2),
                            append(L2, L1, L).