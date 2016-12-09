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
-export([start/0,test/0,loop/1,refnr/1,addEvent/3,add/0,delete/0,testTimer/0,lookupTime/0]).
%100 ms = timer interval
-define(INTERVAL, 100).
start() ->
  ets:new('agenda', [ordered_set, {keypos, 1}, public,named_table]),
  PID = spawn(simulator, loop, [0]),
  Pid = spawn(simulator, refnr, [0]),
  register('LoopProcess', PID),
  register('refNumber', Pid),
  observer:start().

add() -> ets:new('agenda', [ordered_set, {keypos, 1}, public,named_table]).

delete() -> ets:delete(agenda).

loop(C) -> receive
               stop -> stopped;
               reset -> loop(0);
               inc -> loop(C+1);
               {get,P} -> P!C, loop(C);
               {set,P,X} -> P!C,loop(X)
             end.

test() -> io:fwrite('het lukt, blijkbaar').
lookupTime() -> {Datum, RefNr} = ets:first('agenda'),
  io:fwrite('Date: ~w, refnr: ~B ', [Datum, RefNr]).
testTimer() -> {Ack, {Test,Tref}} = timer:apply_interval(1000, simulator, test, []),
  timer:apply_after(5000, simulator, testCancel, [Tref]).
testCancel(TimerRef) -> timer:cancel(TimerRef).

addEvent(Event,BeginTime,EndTime) ->
  Pid = whereis('refNumber'),
  Pid ! {get, self()},
  RefNr = receive
             C -> C
           end,
  Pid ! inc,
  Serial = BeginTime,
  ets:insert_new('agenda', {{Serial,RefNr},BeginTime,EndTime,Event}).

refnr(C) -> receive
             stop -> stopped;
             reset -> loop(0);
             inc -> loop(C+1);
             {get,P} -> P!C, loop(C);
             {set,P,X} -> P!C,loop(X)
           end.