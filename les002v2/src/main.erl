%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. okt 2016 10:53
%%%-------------------------------------------------------------------
-module(main).
-author("Eigenaar").

%% API
-export([smallestNumber/1, somEvenPosities/1,keepPos/1]).

%geef de kleinste nummer van een lijst weer
%main:smallestNumber([2,3,5,2,1]).
smallestNumber([]) -> 0;
smallestNumber([X]) -> X;
smallestNumber([X|XS]) -> smallestNumber(X,[X|XS]).
smallestNumber(X,[]) -> X;
smallestNumber(X,[Y|YS]) -> if(X<Y) -> smallestNumber(X,YS);
                              true-> smallestNumber(Y,YS)
                            end.

%tel de getallen op de even posities bij elkaar op
%main:somEvenPosities([5,2,3,1]).

somEvenPosities([]) -> 0;
somEvenPosities([_]) -> 0;
somEvenPosities([_,Y|YS]) -> somEvenPosities(Y,YS).
somEvenPosities(N,[]) -> N;
somEvenPosities(N,[_,Y|YS]) -> somEvenPosities(N+Y,YS).




%Hou enkel de positieve getallen in een lijst over


%posKeep([]) -> [];
%posKeep([X|XS]) -> posKeep([X|XS],[X|XS]).
%posKeep([],YS) -> YS;
%posKeep([X|XS],YS) when X>0 ->posKeep(XS,YS);
%posKeep([X|XS],YS) when X<0 -> posKeep(XS,YS -- [X]).

posKeep(X) -> if X>0 -> false;
                true -> true
              end.

keepPos(List) -> lists:dropwhile(fun posKeep/1, List).

