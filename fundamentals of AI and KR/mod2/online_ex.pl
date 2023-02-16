% P01 (*) Find the last element of a list.
mylast([],emptylist).
mylast([X],X):-!.
mylast([_|L],X):-mylast(L,X).

% P02 (*) Find the last but one element of a list.
lastbone([],emptylist).
lastbone([_],oneelementlist):-!.
lastbone([X,_],X):-!.
lastbone([_|L],X):-lastbone(L,X).

% P03 (*) Find the K'th element of a list. element_at(K,L,X)
element_at(1,[X|_],X):-!.
element_at(K,[_|L],El):-K1 is K-1, element_at(K1,L,El).

% P04 (*) Find the number of elements of a list.
count_el([],0):-!.
count_el([_|L],N):-count_el(L,N1), N is N1+1.

% P05 (*) Reverse a list.
myreverse([],[]):-!.
myreverse([X],[X]):-!.
myreverse([X|L],LR):-myreverse(L,L1), myappend(L1,[X],LR).

myappend([],[],[]):-!.
myappend(L,[],L):-!.
myappend([],L,L):-!.
myappend([El|L1],L2,[El|LA]):-myappend(L1,L2,LA).

% P06 (*) Find out whether a list is a palindrome.
palindrome([]):-!.
palindrome([_]):-!.
palindrome([El|Rest]):-myappend(Reduced,[El],Rest), palindrome(Reduced).

% P07 (**) Flatten a nested list structure.
flatten([],[]):-!.
flatten([X|L], FL):-is_list(X), !, myappend(X, L, L1), flatten(L1, FL).
flatten([El|L], [El|FL]):-flatten(L, FL).

% P08 (**) Eliminate consecutive duplicates of list elements.
del_consec([],[]).
del_consec([X],[X]):-!.
del_consec([X,Y|L], LD):-X is Y, !, del_consec([X|L],LD).
del_consec([X|L], [X|LD]):-del_consec(L,LD).

% P09 (**) Pack consecutive duplicates of list elements into sublists.
pack([],[]):-!.
pack([X],[X]):-!.
pack([X,Y|L],LP):-X is Y, !, pack([[X,Y]|L],LP).
pack([X,Y|L],LP):-member(Y,X),!, pack([[Y|X]|L],LP).
pack([X|L],[X|LP]):-is_list(X),!, pack(L,LP).
pack([X|L],[[X]|LP]):-pack(L,LP).

% P10 (*) Run-length encoding of a list.
len_encode([],[]):-!.
len_encode([X|L],[[Len, Xel]|LE]):- is_list(X), !, length(X, Len), member(Xel, X), len_encode(L, LE).
len_encode([X|L],LE):- pack([X|L], LP), len_encode(LP, LE).

% P11 (*) Modified run-length encoding.
len_encode_mod([],[]):-!.
len_encode_mod([X|L],[Xel|LE]):- is_list(X), length(X, 1), !, member(Xel, X), len_encode_mod(L, LE).
len_encode_mod([X|L],[[Len, Xel]|LE]):- is_list(X), !, length(X, Len), member(Xel, X), len_encode_mod(L, LE).
len_encode_mod([X|L],LE):- pack([X|L], LP), len_encode_mod(LP, LE).

% P12 (**) Decode a run-length encoded list.
decode([],[]):-!.
decode([[0,_]|L],LD):-!, decode(L,LD).
decode([[N,X]|L],[X|LD]):-N1 is N-1, decode([[N1,X]|L],LD).

% P13 (**) Run-length encoding of a list (direct solution).
encode_direct([],[]):-!.
encode_direct([X],[X]):-!.
encode_direct([X,Y|L],[Xenc|LE]):-X is Y, !, encode_direct([[X,2]|L],[Xenc|LE]).
encode_direct([[X,N],Y|L], [Xenc|LE]):- Y is X, !, N1 is N+1, encode_direct([[X,N1]|L],[Xenc|LE]).
encode_direct([Xenc|L], [Xenc|LE]):-encode_direct(L,LE).

% P14 (*) Duplicate the elements of a list.
dupli([],[]).
dupli([X|L],[X,X|LD]):-dupli(L,LD).

% P15 (**) Duplicate the elements of a list a given number of times.
duplin([],_,[]).
duplin([X|L],N,LD):-ntimes(X,N,Xntimes), append(Xntimes, LD1, LD), duplin(L,N,LD1).

ntimes(_,0,[]).
ntimes(X,N,[X|L]):-N1 is N-1, ntimes(X,N1,L).

% P16 (**) Drop every N'th element from a list. drop(L,N,LD)
drop([_|L],1,L):-!.
drop([X|L],N,[X|LD]):- N1 is N-1, drop(L,N1,LD).

% P17 (*) Split a list into two parts; the length of the first part is given.
split(L,0,[],L):-!.
split([X|L],N,[X|L1],L2):-N1 is N-1, split(L,N1,L1,L2).

% P18 (**) Extract a slice from a list. slice(L,I,F,S)
slice(_,1,1,[]):-!.
slice([X|L],1,F,[X|S]):-!, F1 is F-1, slice(L,1,F1,S).
slice([_|L],I,F,S):-!, I1 is I-1, slice(L,I1,F,S).

% P19 (**) Rotate a list N places to the left.
rotate(_,0,_):-!.
rotate(L,N,LR):- split(L,N,L1,L2), append(L2,L1,LR).

% P20 (*) Remove the K'th element from a list. removeKel(L,K,LR)
removeKel(L,0,L):-!.
removeKel([_|L],1,L):-!.
removeKel([X|L],N,[X|LR]):-N1 is N-1, removeKel(L, N1, LR).

kel([X|_],1,X):-!.
kel([_|L],N,X):-N1 is N-1, kel(L,N1,X).

% P21 (*) Insert an element at a given position into a list.
insert(El,1,L,[El|L]):-!.
insert(El,N,[H|L],[H|LI]):-N1 is N-1, insert(El,N1,L,LI).

% P22 (*) Create a list containing all integers within a given range.
range(X,X,[X]):-!.
range(I,F,[I|L]):-I1 is I+1, range(I1,F,L).

pyrange(X,X,_,[]):-!.
pyrange(X,Y,_,[]):-Y < X,!.
pyrange(I,F,Step,[I|L]):-I1 is I+Step, pyrange(I1,F,Step,L).

% P23(**) Extract a given number of randomly selected elements from a list.
rnd_select(_,0,[]):-!.
rnd_select(L,N,[X|LR]):-N1 is N-1, random_member(X,L), rnd_select(L,N1,LR).

rnd_select_norep(_,0,[]):-!.
% rnd_select_norep([X],1,[X]):-!.
rnd_select_norep(L,N,[X|LR]):-N1 is N-1, length(L,Len), Len1 is Len+1, random(1, Len1, R), kel(L,R,X), removeKel(L,R,Lremoved), rnd_select_norep(Lremoved,N1,LR).

% P24 (*) Lotto: Draw N different random numbers from the set 1..M.
drawN(0,_,[]):-!.
drawN(N,M,[X|L]):-Limit is M+1, random(1,Limit,X), N1 is N-1, drawN(N1,M,L).

% P25 (*) Generate a random permutation of the elements of a list.
rnd_permu(L,LP):-length(L,Len), rnd_select_norep(L,Len,LP).

% P26 (**) Generate the combinations of K distinct objects chosen from the N elements of a list
combinations(0,_,[]):-!.
combinations(N,[X|L],[X|C]):-N1 is N-1, combinations(N1,L,C),length(C,N1).
combinations(N,[_|L],C):-combinations(N,L,C),length(C,N).

% P27 (**) Group the elements of a set into disjoint subsets.
% a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? 
%    Write a predicate that generates all the possibilities via backtracking.
% group3(L,G1,G2,G3)
% group3([],G1,G2,G3):-length(G1,2),length(G2,3),length(G3,4),!.
group3([],[],[],[]):-!.
group3([H|L],[H|G1],G2,G3):-group3(L,G1,G2,G3), length(G1,Len), Len < 2.
group3([H|L],G1,[H|G2],G3):-group3(L,G1,G2,G3), length(G2,Len), Len < 3.
group3([H|L],G1,G2,[H|G3]):-group3(L,G1,G2,G3), length(G3,Len), Len < 4.

% b) Generalize the above predicate in a way that we can specify a list of group sizes 
%    and the predicate will return a list of groups.
% group(List,Numberlist,Groupslist)
group([],[],[]):-!.
group(L,[0|NL], [[]|GL]):-group(L,NL,GL), !.
group([X|L],[N|NL], [[X|G]|GL]):-N1 is N-1, group(L,[N1|NL],[G|GL]).
group([X|L],NL,GL):-length(L,Len), Len > 0, append(L, [X], L1), group(L1,NL,GL).
% to be debugged

% P28 (**) Sorting a list of lists according to length of sublists
lsort([],[]):-!.
lsort([X],[X]):-!.
lsort([X,Y],[X,Y]):-length(X,Lx), length(Y,Ly), Lx =< Ly, !.
lsort([X,Y],[Y,X]):-!.
lsort([X|L],LS):-lsort(L,LS1), putList(X,LS1,LS).

putList(X,[],[X]):-!.
putList(X,[El|T], [X,El|T]):- length(X,Lx), length(El,LEl), Lx=<LEl, !.
putList(X,[Val|T],[Val|L]):-putList(X,T,L).
% part b missing

% P31 (**) Determine whether a given integer number is prime.
divisor(X,Y):-0 is X mod Y.

isPrimeChecker(_,1):-!.
isPrimeChecker(X,N):-divisor(X,N),!,fail.
isPrimeChecker(X,N):-N1 is N-1, isPrimeChecker(X,N1).

isPrime(1):-!.
isPrime(X):-X < 1, !, fail.
isPrime(X):-N is X-1, isPrimeChecker(X,N).

% P32 (**) Determine the greatest common divisor of two positive integer numbers.
gcd(A,0,A):-!.
gcd(_,0,1):-!,fail.
gcd(A,B,GCD):-C is A mod B, gcd(B,C,GCD).
gcd(A,B):-gcd(A,B,_).

% P33 (*) Determine whether two positive integer numbers are coprime.
coprime(X,Y):-gcd(X,Y,1).

% P34 (**) Calculate Euler's totient function phi(m).
totient_counter(_,1,1):-!.
totient_counter(X,N,Phi):-coprime(X,N), !, N1 is N - 1, totient_counter(X,N1,Phi1), Phi is Phi1 + 1.
totient_counter(X,N,Phi):-N1 is N - 1, totient_counter(X,N1,Phi).
totient_phi(X,Phi):-totient_counter(X,X,Phi).

% P35 (**) Determine the prime factors of a given positive integer.
prevPrime(N,P):-N1 is N-1, isPrime(N1),!, P is N1.
prevPrime(N,P):-N1 is N-1, prevPrime(N1,P).
nextPrime(N,1):-var(N),!.
nextPrime(N,P):-N1 is N+1, isPrime(N1),!, P is N1.
nextPrime(N,P):-N1 is N+1, nextPrime(N1,P).

nextPrimeDivisor(X,D,S):-nextPrime(S,D), 0 is X mod D, !.
nextPrimeDivisor(X,D,S):-nextPrime(S,P), nextPrimeDivisor(X,D,P).

prime_factors(1,[]):-!.
prime_factors(X,[N|L]):-nextPrimeDivisor(X,N,1), X1 is X div N, prime_factors(X1,L).

% P36 (**) Determine the prime factors of a given positive integer (2).
prime_factors_multi(X,L):-prime_factors(X, L1), encode_direct(L1,L).

% P46 (**) Truth tables for logical expressions.
and(A,B):-call(A),call(B).
or(A,_):-call(A),!.
or(_,B):-call(B).
nand(A,B):-not(and(A,B)).
xor(A,B):-call(A),call(B),!,fail.
xor(A,B):-or(A,B).
impl(A,B):-or(not(A),B).
equ(A,B):-call(A),call(B),!.
equ(A,B):-not(A),not(B).

eval(A,true):-call(A),!.
eval(_,false).

bool(true).
bool(false).

table(A,B,P):-bool(A), bool(B), write(A),write("\t"), write(B), write("\t"), eval(P,V), write(V),nl,fail.

op(400,xfx,and).
op(400,xfx,nand).
op(500,xfx,or).
op(500,xfx,xor).
op(600,xfx,impl).
op(600,xfx,equ).


