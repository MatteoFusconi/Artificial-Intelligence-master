% page 110
% ex. 1: last(L, E)
lastel([], _).
lastel([X], X):-!.
lastel([_|T],L):-lastel(T, L).

% ex. 2: sublist(L1,L2)
sublist([],[]).
sublist([E|L1], L2):-member(E, L2), sublist(L1,L2).
sublist(L1, [_|L2]):-sublist(L1, L2).

% ex. 3 palindrome(L).
palindrome([]).
palindrome([_]):-!.
palindrome([H|T]):-append(T1,[H],T), palindrome(T1).

% ex. 4 repeatedElements(L, R)
repeatedElements([],[]).
repeatedElements([_],[]).
repeatedElements([E|L],[E|R]):-deleteAllOccurrences(L,E,L1), repeatedElements(L1,R),!.
repeatedElements([_|L],R):-repeatedElements(L,R).

deleteAllOccurrences([],_,[]).
deleteAllOccurrences([El|T],El,Result):-deleteAllOccurrences(T,El,Result),!.
deleteAllOccurrences([H|T],El,[H|Result]):- deleteAllOccurrences(T,El,Result).

deleteFirstOccurrence([],_,[]).
deleteFirstOccurrence([El|T],El,T):-!.
deleteFirstOccurrence([H|T],El,[H|Result]):-deleteFirstOccurrence(T,El,Result). 

% ex. 5 count(El, L, N)
count(_,[],0):-!.
count(El,[El|L],N):-!, count(El,L,N1),N is N1+1.
count(El,[_|L], N):-count(El,L,N).

% ex.6 flatten(L, FL)
flatten([],[]).
flatten([L|T],FL):-is_list(L), !, append(L, T, L1), flatten(L1,FL).
flatten([H|T],[H|FL]):-flatten(T,FL).

% ex. 7 order(L, OL) in descending order
order([],[]):-!.
order([X],[X]):-!.
order([X,Y],[X,Y]):-X >= Y,!.
order([X,Y],[Y,X]):-!.
order([X|L], OL):- order(L, OL1), ins_el(X,OL1,OL).

ins_el(X,[],[X]):-!.
ins_el(X,[El|T], [X,El|T]):- X>=El, !.
ins_el(X,[Val|T],[Val|L]):-ins_el(X,T,L).

% exam 16/1/2023 ex.1
filter([],_,[]):-!.
filter([X|L1],L2,[X|L3]):-mymember(X,L2),!, filter(L1,L2,L3).
filter([_|L1],L2,L3):-filter(L1,L2,L3).

mymember(X,[X|_]):-!.
mymember(X,[_|L]):-mymember(X,L).

notmember(_,[]):-!.
notmember(X,[X|_]):-!, fail.
notmember(X,[_|L]):-notmember(X,L).

filter2(L1,L2,L3):-setof(X,(member(X,L1),member(X,L2)),L3).

filter3(L1,L2,L3):-intersection(L1,L2,Lint), removeDuplicates(Lint,L3).

intersection([],_,[]):-!.
intersection([X|L1],L2,[X|L3]):-mymember(X,L2),!, intersection(L1,L2,L3).
intersection([_|L1],L2,L3):-intersection(L1,L2,L3).

removeDuplicates([],[]):-!.
removeDuplicates([X|L],LR):-mymember(X,L), !, removeDuplicates(L,LR).
removeDuplicates([X|L],[X|LR]):-removeDuplicates(L,LR).