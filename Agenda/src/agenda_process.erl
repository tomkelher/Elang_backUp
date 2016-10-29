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
-export([start/0,addAgenda/3,serial/1]).

start() ->
  ets:new('logboek', [ordered_set, {keypos, 1}, public,named_table]),
  ets:new('agenda', [ordered_set, {keypos, 1}, public,named_table]),
  Pid = spawn(agenda_process, serial, [0]),
  register('Proces', Pid).



%tijd: {{2009,9,7},{12,32,22}},{{2009,9,7},{12,32,22}}
%tijd: {{yyyy,m,d},{hh,mm,ss}}
addAgenda(Event,BeginTime,EndTime) ->
  Pid = whereis('Proces'),
  Pid ! {get, self()},
  Serial = receive
             C -> C
           end,
  ets:insert_new('agenda', {Serial,BeginTime,EndTime,Event}),
  addLogboek(Serial,Event),
  Pid ! inc.

addLogboek(Serial,Title) ->
  ets:insert_new('logboek', {Serial,  calendar:local_time(),Title}).

serial(C) -> receive
               stop -> stopped;
               reset -> serial(0);
               inc -> serial(C+1);
               {get,P} -> P!C, serial(C)
             end.