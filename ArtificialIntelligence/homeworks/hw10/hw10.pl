/* member(A,B) := A is B's member */
member(X,[X|Y]).
member(X,[Y|Z]):-member(X,Z).

member(X,[1,2,3,4,5]),write(X),nl,fail.


(94 ms) yes
| ?- member(X,[1,2,3,4,5]),write(X),nl,fail.
1
2
3
4
5

/* subset(A,B) := A is B's subset */
subset([],[]).
subset([X|Y],[X|Z]):-subset(Y,Z).
subset(X,[Y|Z]):-subset(X,Z).

subset(X,[1,2,3,4,5]),write(X),nl,fail.

(47 ms) yes
| ?- subset(X,[1,2,3,4,5]),write(X),nl,fail.
[1,2,3,4,5]
[1,2,3,4]
[1,2,3,5]
[1,2,3]
[1,2,4,5]
[1,2,4]
[1,2,5]
[1,2]
[1,3,4,5]
[1,3,4]
[1,3,5]
[1,3]
[1,4,5]
[1,4]
[1,5]
[1]
[2,3,4,5]
[2,3,4]
[2,3,5]
[2,3]
[2,4,5]
[2,4]
[2,5]
[2]
[3,4,5]
[3,4]
[3,5]
[3]
[4,5]
[4]
[5]
[]

/* grandfather */

male(di).
male(jianbo).
female(xin).
female(yuan).
female(yuqing).
father(jianbo,di).
father(di,yuqing).
mother(xin,di).
mother(yuan,yuqing).
grandfather(X,Y):-father(X,Z),father(Z,Y).
grandmother(X,Y):-mother(X,Z),father(Z,Y).
daughter(X,Y):-father(X,Y),female(Y).

grandfather(X,yuqing).

| ?- grandfather(X,yuqing).

X = jianbo ? 

yes
| ?- 
