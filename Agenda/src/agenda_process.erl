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
-export([start/0,loop/1,add/2]).

start() ->
  Test = ets:new('Logboek', [ordered_set, {keypos, 1}, public,named_table]),
  PID = spawn(agenda_process, loop, [0]),
  add(PID,Test).


add(PID,Test) ->
  PID ! {get, self()},
  Value = receive
            C -> C
         end,
  ets:insert_new(Test, {Value, calendar:now_to_universal_time(os:timestamp())}),
  PID ! inc,
  timer:apply_after(1000, agenda_process,add,[PID, Test]).


loop(C) -> receive
             stop -> stopped;
             reset -> loop(0);
             inc -> loop(C+1);
             {get,P} -> P!C, loop(C)
           end.

