% A thief is stealing sculptures in an art gallery. Each sculpture has a specific value and
% a weight. The thief wants to steal sculptures for more than 600$ of total value, but can only have
% 11 kilos of sculptures in the sack. The thief must therefore decide what to take and what to leave.
% Write a CLP or minizinc program to compute which choices thief has, and for each choice, what is
% the final value of the stolen sculptures. The sculptures are 4 (A, B, C, D): A weights 10kg and it
% is worth 500$, B weights 4kg and it is worth 600$, C weights 2kg and it is worth 100$, D weights
% 2kg and it is worth 200$.

:- use_module(library(clpfd)).
steal(VARIABLES):- length(VARIABLES, 6), VARIABLES = [A, B, C, D, V, W], [A, B, C, D] ins 0..1, 
                    V #= A*500+B*600+C*100+D*200,
                    W #= A*10+B*4+C*2+D*2, 
                    V #> 600, W #< 11.

bag( VARIABLES ) :-
length( VARIABLES , 6),
VARIABLES = [A,B,C,D,W,V],
[A,B,C,D] ins 0..1 ,
% all_distinct ( VARIABLES ),
Aw #= A * 10 ,
Bw #= B * 4,
Cw #= C * 2,
Dw #= D * 2,
Av #= A * 500 ,
Bv #= B * 600 ,
Cv #= C * 100 ,
Dv #= D * 200 ,
W #= Aw + Bw + Cw + Dw ,
V #= Av + Bv + Cv + Dv ,
W #< 12 ,
V #> 600.

% selectdiscard
selectdiscard([],[],[],0).
selectdiscard(_,[],[],0).
selectdiscard([],_,[],0).
selectdiscard([H1|T1],[H2|T2],[H3|R],S):- H3 is min(H1,H2),
    										selectdiscard(T1,T2,R,S1), 
    										S is S1+max(H1,H2).

% selectgreater(L1,L2,R,S) : R is the greater of elements of L1,L2 pairwise, 
selectgreater([],[],[],0).
selectgreater([X],[],[X],X).
selectgreater([],[X],[X],X).
selectgreater([H1|T1], [H2|T2], [HR|R], S):-HR is max(H1,H2),
                                            selectgreater(T1,T2,R,S1),
                                            S is S1 + HR.

% sum_and_prod(L,S,P)
sum_and_prod([],0,0).
sum_and_prod([X],X,X):-!.
sum_and_prod([X|T],S,P):-sum_and_prod(T,S1,P1), S is S1+X, P is P1*X .

% count_leaves(T,N). The tree T has N leaves
count_leaves(nil,0).
count_leaves(t(_,nil,nil),1).
count_leaves(t(_,LT,RT),N):- count_leaves(LT,NL), count_leaves(RT,NR), N is NR+NL.

% count_nodes(T,N) count the number of nodes that are not leaves
count_nodes(nil,0).
count_nodes(t(_,nil,nil),0):-!.
count_nodes(t(_,LT,RT),N):- count_nodes(LT,NL), count_nodes(RT,NR), N is 1+NR+NL.

% sum_nodes(T,N). T is a tree with the nodes labeled with numbers. Return S, the sum of all the nodes.
sum_nodes(nil,0).
sum_nodes(t(X,LT,RT),S):-sum_nodes(LT,SL), sum_nodes(RT,SR), S is X+SL+SR.

% (5 points) A binary tree is either empty or it is composed of a root element and two successors,
% which are binary trees themselves. In Prolog we represent the empty tree by the atom nil and
% the non-empty tree by the term t(X,L,R) where X denotes the root node and L and R denote the
% left and right subtree, respectively. A leaf is a node with no successors. Two nodes are siblings
% if they have the same parent. For example, the tree in the Figure is represented by the term
% t(a,t(b,nil,nil),t(c,nil,nil)) and b and c are leaves.

% Write a Prolog program which defines a predicate count_leaves_without_sib(T,N) which counts the number of leafs which have no siblings
% count leaves with sib(T,N) :- the binary tree T has N leafs with no siblings.
count_leaves_without_sib(nil,0).
count_leaves_without_sib(t(_,t(_,nil,nil),nil),1):-!.
count_leaves_without_sib(t(_,nil,t(_,nil,nil)),1):-!.
count_leaves_without_sib(t(_,LT,RT),N):-   count_leaves_without_sib(LT,N1), 
                                            count_leaves_without_sib(RT,N2),
                                            N is N1+N2.

% give a program P and a goal G such that, inverting the order of the atoms in a clause, the program first terminates with a success, then it doesn't terminate.
% G : p(X)
% P :
p(X):-q(X),r(X).
q(a).
r(b):-r(b).
r(a).

