%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. okt 2016 11:13
%%%-------------------------------------------------------------------
-module('simulator').
-author("Eigenaar").

%% API
-export([start/0,create/0,add/1]).

start() ->  PID = spawn(logboekje, create,[]),
  register(logboek,PID).

create() -> ets:new('Logboek', [named_table,public, ordered_set, {keypos, 1}]),
  loop().

add(Info) -> logboek ! {add,Info}.

loop() -> receive

            {add,Info} -> ets:insert_new('Logboek', {event_manager:getTime(), Info}),
              io:format("~p added ~n", [Info]),
              loop();

            {delete,Date} -> ets:delete('Logboek',Date),
              io:format("Task deleted ~n"),
              loop()

          end.