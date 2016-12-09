%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. nov 2016 14:19
%%%-------------------------------------------------------------------
-module(main).
-author("Eigenaar").

%% API
-export([start/0,testCode/0,testCodePrev/0]).
start() ->  observer:start().

testCodePrev() ->
  klant:start(),
  klant:addEvent(event,{{2021,9,7},{12,32,22}},{{2022,9,7},{12,32,22}}),
  klant:addEvent(event,{{2025,9,7},{12,32,22}},{{2031,9,7},{12,32,22}}).

testCode() -> 'nothing yet'.
