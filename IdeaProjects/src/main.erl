%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. sep 2016 13:56
%%%-------------------------------------------------------------------
-module(main).
-author("Eigenaar").

%% API
%% de /1 geeft aan dat er maar 1 parameter nodig is ctr+spatie/tab = aanvullen
%% de /2 geeft aan dat er maar 2 parameters nodig zijn ctr+spatie/tab = aanvullen
-export([plus1/1, plus2/2, som/1, isIn/2, isort/1,verdubbel/1,vermenigvuldig/2,halveer/1,clone/1,unclone/1,
        fac/1,herm/1, evenoneven/1, aantalDelers/1,isPrime/1]).

plus1(X) -> X+1.
plus2(X,Y) -> X+Y+1.

%%main:isIn([1,2,3]).
som([]) -> 0;
som([X|XS]) -> X + som(XS).

%%main:isIn(1,[1,2,3]).
%%main:isIn(1,[]).
isIn(X,[]) -> false;
isIn(X,[Y|YS]) when X == Y -> true;
isIn(X,[_|YS]) -> isIn(X, YS).

%%main: isort([5,2,3,1]).
isort([]) -> [];
isort([X|XS])-> insert(X,isort(XS)).
%%behoort bij bovenstaande functie = hulpfunctie
insert(X,[]) -> [X];
%%Indien kleiner moet die voor het cijfer Y staan
insert(X,[Y|YS]) when X<Y -> [X,Y|YS];
%%Indien groter erna
insert(X,[Y|YS]) -> [Y|insert(X,YS)].


%%%-------------------------------------------------------------------
%%%Zelfgemaakte oefeningen
%%%-------------------------------------------------------------------

%%verdubbelen van elke cijfer in een lijst
verdubbel([]) -> [];
verdubbel([X|XS]) -> insert2(X*2,verdubbel(XS)).



insert2(X,[]) -> [X];
insert2(X,[Y|YS]) -> [X|insert2(Y,YS)].

%%vermenigvuldigen van elke cijfer in een lijst
vermenigvuldig([],Y) -> [];
vermenigvuldig([X|XS],Y) -> insert2(X*Y,vermenigvuldig(XS,Y)).

%%halveren van de lijst om de beurt een cijfer weg laten [1,2,3,4] wordt [1,3]
halveer([]) -> [];
halveer([X]) -> [X];
halveer([X,Y|YS]) ->  [X|halveer(YS)].

%%Lijst clonen [1,2,3,4] -> [1,1,2,2,3,3,4,4]
clone([]) -> [];
clone([X|XS]) -> [X,X|clone(XS)].

%%dubbele getallen weghalen.
unclone([]) -> [];
unclone([X]) -> [X];
%%in de lijst zit op zijn minst een x en andere getallen
unclone([X|XS]) ->
  case isIn(X,XS) of
    true -> unclone(XS);
    false -> [X|unclone(XS)]
  end.


%%het faculteit bepalen
fac(0) -> 1;
fac(X) -> X*fac(X-1).

herm(0) -> 1;
herm(X) -> 1/X + herm(X-1).

evenoneven(X) -> if (X rem 2>0) -> 3*X+1;
                   true -> X/2
                 end.

aantalDelers(N) -> aantalDelers(N,N,[]).
aantalDelers(N,0,D) -> length(D);
aantalDelers(N,X,[]) when N rem X == 0 -> aantalDelers(N,X-1,[X]);
aantalDelers(N,X,[]) when N rem X /= 0 -> aantalDelers(N,X-1,[]);
aantalDelers(N,X,D) when N rem X == 0 -> aantalDelers(N,X-1,[X|D]);
aantalDelers(N,X,D) when N rem X /= 0 -> aantalDelers(N,X-1,D).

isPrime(N) -> isPrime(N,N,[]).
isPrime(N,0,D) when length(D) /= 0 -> false;
isPrime(N,0,D) when length(D) == 0 -> true;
isPrime(N,1,D)-> isPrime(N,0,D);
isPrime(N,1,[]) -> isPrime(N,0,[]);
isPrime(N,X,[])  when N == X -> isPrime(N,X-1,[]);
isPrime(N,X,[])  when N rem X /= 0 -> isPrime(N,X-1,[]);
isPrime(N,X,[])  when N rem X == 0 -> isPrime(N,X-1,[X]);
isPrime(N,X,D)  when N == X -> isPrime(N,X-1,D);
isPrime(N,X,D)  when N rem X /= 0 -> isPrime(N,X-1,D);
isPrime(N,X,D)  when N rem X == 0 -> isPrime(N,X-1,[X|D]).



