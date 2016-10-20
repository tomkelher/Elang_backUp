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
  enkelPositief/1, aantalDelers/1, filterPriem/1]).
%  enkelPositief/1, aantalDelers/1, filterPriem/1]).

plus1(X) -> X+1.
plus1(X,Y) -> X + Y +1.

som([]) -> 0;
som ( [X|XS]) -> X + som(XS).

isIn(_, []) -> false;
isIn(X, [Y|_] ) when X == Y -> true;
isIn(X, [_|YS] ) -> isIn(X, YS).

halveer([]) -> [];
halveer([X]) -> [X];
halveer([X,Y|YS]) -> [X | halveer(YS)].

ontdubbel([]) -> [];
ontdubbel([X]) -> [X];
ontdubbel([X|XS]) ->
  case isIn(X,XS) of
    true -> ontdubbel(XS);
    false -> [X | ontdubbel(XS)]
  end.


isort ([ ])    ->  [ ];
isort ([X|XS]) -> insert (X, isort(XS)).

insert (X, [ ]) -> [X];
insert (X, [Y|YS]) when X<Y -> [X,Y|YS];
insert (X, [Y|YS])          -> [Y | insert(X,YS) ].

kleinste([]) -> 0;
kleinste([X|XS]) -> kleinste(X,XS).

kleinste(X,[]) -> X;
kleinste(X, [Y|YS]) ->
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



