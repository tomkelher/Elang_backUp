%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 17:11
%%%-------------------------------------------------------------------
-module(logboek).
-author("Tom Kelher").

%% API
-export([start/0,create/0,add/1]).

start() ->  PID = spawn(logboek, create,[]),
  register(logboek,PID).

create() -> ets:new('Logboek', [named_table,public, ordered_set, {keypos, 1}]),
  loop().

add(Info) -> logboek ! {add,Info}.

loop() -> receive

            {add,Info} -> ets:insert_new('Logboek', {eventManager:getTime(), Info}),
              io:format("~p added ~n", [Info]),
              loop();

            {delete,Date} -> ets:delete('Logboek',Date),
              io:format("Task deleted ~n"),
              loop()

          end.