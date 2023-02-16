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

%-------------------------------------------------------------------------------------------------------%
father(matteoFusconi, gianlucaFusconi).
father(emanueleFusconi, gianlucaFusconi).
father(francescoFusconi, gianlucaFusconi).
father(giacomoGiardina, davideGiardina).
father(francescoGiardina, davideGiardina).
wife(gianlucaFusconi, danielaGiardina).
wife(davideGiardina,mariagraziaMirarchi).



brother(davideGiardina, danielaGiardina).
brother(X, Y):-or((male(Y), parent(X,Z), parent(Y,Z), X\= Y), (male(X), male(Y), brother(Y,X))).

sister(X, Y):-female(Y), father(X,Z), father(Y,Z), X\= Y.

%brother(X, Y):-mother(X,Z), mother(Y,Z), X\= Y.
husband(X, Y):-wife(Y,X).
parent(X, Y):- or(father(Y, X), mother(Y, X)).
sibling(X, Y):- or(brother(X,Y), sister(X,Y)).
son(X, Y):-male(Y), or(mother(Y, X), father(Y, X)).
daughter(X, Y):- female(Y), parent(Y,X).

mother(X,Y):-.

cousin(X, Y):-parent(X,PX), parent(Y,PY), sibling(PX, PY).

male(matteoFusconi).
male(emanueleFusconi).
male(francescoFusconi).
male(gianlucaFusconi).
male(davideGiardina).
male(ninoGiardina).
male(francescoGiardina).
male(giacomoGiardina).
female(danielaGiardina).
female(mariagraziaMirarchi).
female(elinaFalgares).

