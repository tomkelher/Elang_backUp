%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 21:13
%%%-------------------------------------------------------------------
-module(autoManager).
-author("Tom Kelher").

%% API
-export([start/0, loop/1,add/1,init/0]).


start() -> PID = spawn(?MODULE,init,[]),
  register(autoManager,PID).

init() -> Tabel = ets:new(carList, [named_table,public, ordered_set]),
  loop(Tabel).

add(PID) -> autoManager ! {add_auto, PID}.

loop(Tabel) -> receive
                 {add_auto, Auto} ->
                   ets:insert_new(carList, {Auto}),
                   io:format("Car ~p has been added ~n",[Auto]),
                   loop(Tabel);

                 {delete_auto, Auto} ->
                   ets:delete(carList,Auto),
                   io:format("Car has been deleted~n"),
                   ok

               end.