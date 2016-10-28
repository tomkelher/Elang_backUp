%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. okt 2016 11:14
%%%-------------------------------------------------------------------
-module('klant').
-author("Eigenaar").

%% API
-export([start/0,addEvent/2,serial/1]).

start() ->
  Table = ets:new('Logboek', [ordered_set, {keypos, 1}, public,named_table]),
  Var = ets:new('Logboek', [ordered_set, {keypos, 1}, public]),
  Pid = spawn(klant, serial, [0]),
  ets:insert_new(Var, {Pid}),
  addEvent(Pid,"").
%getEventMessage(Pid)-> _ .

addEvent(Pid, Event) ->
  Pid ! {get, self()},
  Serial = receive
      C -> C
  end,
  ets:insert_new('Logboek', {Serial, calendar:now_to_universal_time(os:timestamp()),Event}),
  Pid ! inc.

serial(C) -> receive
            stop -> stopped;
            reset -> serial(0);
            inc -> serial(C+1);
            {get,P} -> P!C, serial(C)
          end.


