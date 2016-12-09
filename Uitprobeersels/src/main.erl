%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. dec 2016 13:36
%%%-------------------------------------------------------------------
-module(main).
-author("Eigenaar").

%% API
-export([isort/1,isort2/1,quicksort/1]).


isort([])  -> [];
isort([X|XS]) -> insert(X, isort(XS)).
insert(X, [ ]) -> [X];
insert(X, [Y|YS]) when X<Y -> [X,Y|YS];
insert(X, [Y|YS])  -> [Y | insert(X,YS) ].


isort2([])  -> [];
isort2([X|XS]) -> bubble(X, isort(XS)).
bubble(X, [ ]) -> [X];
bubble(X, [Y|YS]) when Y<X-> [Y,X|YS];
bubble(X, [Y|YS])  -> [Y | bubble(X,YS) ].


quicksort([])->[];                  Tqs(0) = c
quicksort([X|XS]) ->                Tqs(n) = c + O(n) + Tqs(eersteHelft) + Tqs(tweedeHelft)
  quicksort([Y|| Y <- XS,Y<X])
  ++ [X] ++
    quicksort([Y||Y<- XS,Y>=X]).


