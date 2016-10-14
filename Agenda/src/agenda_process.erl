%%%-------------------------------------------------------------------
%%% @author
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. okt 2016 16:41
%%%-------------------------------------------------------------------
-module(agenda_process).
-author("Tom").

%% API
-export([start/0,loop/1]).

start() ->
  create(),
  PID = spawn(agenda_process, loop, [0]),
  add(PID).

create() -> ets:new('Logboek', [ordered_set, {keypos, 1}]).
add(PID) ->
  Value = receive
            C -> C
          end,
  ets:insert_new({Value, "test"}),
  PID ! inc,
  timer:apply_after(5000, main,add,[PID]).


loop(C) -> receive
             stop -> stopped;
             reset -> loop(0);
             inc -> loop(C+1);
             {get,P} -> P!C, loop(C)
           end.

