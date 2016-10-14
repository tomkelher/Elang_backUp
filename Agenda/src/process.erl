%%%-------------------------------------------------------------------
%%% @author
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. sep 2016 12:16
%%%-------------------------------------------------------------------
-module(process).
-author().

%% API
-export([loop/1, start/0]).

start() -> spawn(process,loop,[0]).

loop(C) -> receive
             stop -> ok;
             reset -> loop(0);
             inc -> loop(C+1);
             {get,P} -> P!C, loop(C)
           end.
