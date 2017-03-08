%%%-------------------------------------------------------------------
%%% @author u0002531
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. sep 2016 13:55
%%%-------------------------------------------------------------------
-module(main).
-author("u0002531").

%% API
-export([plus1/1, plus1/2, som/1, isIn/2, isort/1, halveer/1, kleinste/1,
         somEvenPos/1,somEvenPos2/1,somEvenPos3/1, somEvenPos4/1,
         aantalVoorkomens/2, meesteVoorkomens/1,
  verdubbel/1,verdubbelAlles/1,verdubbelAlles2/1,
  enkelPositief/1, aantalDelers/1, filterPriem/1, test/1,
  diagonalVector/1,sizeVector/1,sizeVector2/1,
  buizen/1, allesGeslaagd/1, allesGeslaagd2/1,
  percentage/1,
  testSuite/0]).

plus1(X) -> X+1.				T(n) = 1
plus1(X,Y) -> X + Y +1.		T(n,m) = 1

som([]) -> 0;				Tsom(0) = C
som ( [X|XS]) -> X + som(XS).	Tsom(n+1) = c + Tsom(n) => O(n)

isIn(_, []) -> false;			Tisin(0) = c
isIn(X, [Y|_] ) when X == Y -> true;// telt niet mee
isIn(X, [_|YS] ) -> isIn(X, YS).Tisin(n+1) = c + Tisin(n) => O(n)

halveer([]) -> [];			Th(0) = c
halveer([X]) -> [X];			Th(1) = c
halveer([X,Y|YS])->[X|halveer(YS)].Th(n+2)=c+Th(n) => O(n/2)=O(n)
						  Th(n+1) =c+Th(n) => O(n)

		

ontdubbel([]) -> [];		Tont(0) = c
ontdubbel([X]) -> [X];	Tont(1) = c
ontdubbel([X|XS]) ->		Tont(n+1) =c+ TisIn(n) + Tont(n)
  case isIn(X,XS) of		Tont(n+1) =c+ O(n) + Tont(n) => O(n²)
    true -> ontdubbel(XS);
    false -> [X | ontdubbel(XS)]
  end.


isort ([ ])    ->  [ ];			  T(0) = c
isort ([X|XS]) -> insert (X, isort(XS)).T(n+1)=c+Tis(n)+Tins(n)
							   ---> O(n)+Tis(n)=O(n²)
insert (X, [ ]) -> [X];				T(0) = c
insert (X, [Y|YS]) when X<Y -> [X,Y|YS];	T(1) = c
insert (X, [Y|YS])          -> [Y | insert(X,YS) ].T(n)+T(0)=O(n)

kleinste([]) -> 0;
kleinste([X|XS]) -> kleinste(X,XS).

kleinste(X,[]) -> X;		
kleinste(X, [Y|YS]) ->			O(n)
  if X < Y -> kleinste(X, YS);
     true  -> kleinste(Y, YS)
  end.

somEvenPos([]) -> 0;
somEvenPos([_]) -> 0;
somEvenPos([_,Y|YS]) -> Y + somEvenPos(YS).

somEvenPos2(XS) -> somEvenPos2(0,XS).
somEvenPos2(N,[]) -> N;
somEvenPos2(N, [_]) -> N;
somEvenPos2(N, [_,Y|YS]) -> somEvenPos2(N+Y,YS).

somEvenPos3(XS) -> somEvenPos3(0,oneven,XS).
somEvenPos3(N,_,[]) -> N;
somEvenPos3(N,oneven,[_|XS]) -> somEvenPos3(N,even,XS);
somEvenPos3(N,even,[X|XS]) -> somEvenPos3(N+X,oneven,XS).

somEvenPos4(XS) -> somOnevenPos4(0,XS).

somOnevenPos4(N,[]) -> N;
somOnevenPos4(N, [_|XS]) -> somEvenPos4(N, XS).

somEvenPos4(N,[]) -> N;
somEvenPos4(N, [X|XS]) -> somOnevenPos4(N+X, XS).

aantalVoorkomens(_, []) -> 0;
aantalVoorkomens(X, [Y|YS]) when X == Y ->
                                    aantalVoorkomens(X, YS) +1;
aantalVoorkomens(X, [_|YS]) -> aantalVoorkomens(X, YS).

meesteVoorkomens([]) -> {niks, 0};
meesteVoorkomens([X|XS]) ->
  N = aantalVoorkomens(X, XS),
  {Y, M} = meesteVoorkomens(XS),
  if N >= M -> {X, N+1};
     true   -> {Y, M}
  end.


verdubbelAlles(List) -> lists:map(fun(A) -> 2*A end, List).

verdubbel(A) -> A*2.
verdubbelAlles2(List) -> lists:map(fun verdubbel/1, List).

enkelPositief(L) -> lists:filter(fun(N) -> N > 0 end, L).

aantalDelers(N) -> aantalDelers(N, 1, 2).
aantalDelers(N, Teller, Deler)
    when N == Deler -> Teller + 1;
aantalDelers(N, Teller, Deler)
    when (N rem Deler) == 0 -> aantalDelers(N, Teller+1, Deler+1);
aantalDelers(N, Teller, Deler) -> aantalDelers(N, Teller, Deler+1).

filterPriem(L) -> lists:filter(fun(N) -> aantalDelers(N)==2 end, L).

-record(vector, {x=0, y=0}).

test(X) ->  #vector{x=X, y=0}.

diagonalVector(X) -> #vector{x=X,y=X}.
sizeVector(V) ->
   X = V#vector.x,
   Y = V#vector.y,
   math:sqrt(X*X+Y*Y).


sizeVector2(#vector{x=X,y=Y}) -> math:sqrt(X*X+Y*Y);
sizeVector2(W) -> "iets anders".

som2({X,Y}) -> X+Y.
som2bis(X) -> element(1,X) + element(2,X).


-record(examen, {vak,punt}).
isGebuisd(#examen{vak=_,punt=P}) -> P<10.
alleBuizen(Examens) -> lists:filter(fun isGebuisd/1, Examens).

buizen(L) -> lists:filter(fun(#examen{vak=_,punt=P}) -> P<10 end, L).

minstens3Buizen(Examens) -> length(buizen(Examens))>=3.

-record(student, {naam,examens}).
minderGoedeStudenten(Studs) ->
  lists:filter(
    fun(#student{naam=_,examens = Exs}) -> minstens3Buizen(Exs) end,
    Studs).

allesGeslaagd(Studs) ->
    lists:filter(
      fun(#student{naam=_,examens = Exs}) ->
        GeslaagdeVakken = lists:filter(
          fun(#examen{vak=_,punt=P}) -> P >= 10 end,
          Exs),
        AantalGeslaagd = length(GeslaagdeVakken),
        TotaalAantal = length(Exs),
        AantalGeslaagd == TotaalAantal end,
      Studs
    ).
allesGeslaagd2(Studs) ->
  lists:filter(
    fun(#student{naam=_,examens = Exs}) ->
      length(lists:filter(fun isGebuisd/1, Exs))==0 end,
    Studs
  ).

percentage(Exs)
  -> lists:foldl(fun(#examen{vak=_,punt=P},Som) -> Som+P end, 0, Exs)
     /length(Exs).

isRandGeval(#student{naam = _, examens = Exs}) ->
  (length(isGebuisd(Exs))==1 andalso percentage(Exs)<0.54*20)
  orelse
  (length(isGebuisd(Exs))==2 andalso percentage(Exs)<0.58*20).

alleRandgevallen(Studs) -> lists:filter(fun isRandGeval/1, Studs).



testSuite() ->
  Examens = [#examen{vak="A", punt=11},
    #examen{vak="B", punt=11},
    #examen{vak="C", punt=8},
    #examen{vak="D", punt=11},
    #examen{vak="E", punt=12}
  ],
  percentage(Examens).





quicksort([])->[];                  
quicksort([X|XS]) ->                  
 		Tqs(0) = c
        	Tqs(n) = c + O(n) + Tqs(eersteHelft) + Tqs(tweedeHelft)
		Tqs(n) = c + O(n) + Tqs(n/2) + Tqs (n/2)
		Tqs(n) = c + O(n) + Tqs(0) + Tqs(n-1)    -> O(n²)
quicksort([Y|| Y <- XS,Y<X])
  ++ [X] ++
    quicksort([Y||Y<- XS,Y>=X]).

