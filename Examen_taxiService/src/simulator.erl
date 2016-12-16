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
-export([start/0,test/0,loop/1,refnr/1,addEvent/3,add/0,delete/0,testTimer/0,lookupTime/0,testCancel/1,checkProc/0]).
%100 ms = timer interval
-define(INTERVAL, 100).
start() ->
  ets:new('agenda', [ordered_set, {keypos, 1}, public,named_table]),
  ets:new('refLookUp', [ordered_set, {keypos, 1}, public,named_table]),
  PID = spawn(simulator, loop, [0]),
  Pid = spawn(simulator, refnr, [0]),
  register('LoopProcess', PID),
  register('refNumber', Pid),
  observer:start().

add() -> ets:new('agenda', [ordered_set, {keypos, 1}, public,named_table]),
  Pid = whereis('refNumber'),
  Pid ! reset.

delete() -> ets:delete(agenda),
  Pid = whereis('refNumber'),
  Pid ! reset.

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
testTimer() -> {Ack, {Test,Tref}} = timer:apply_interval(5000, simulator, test, []),
  timer:apply_after(5000, simulator, testCancel, [Tref]).
testCancel(TimerRef) -> timer:cancel(TimerRef).

addEvent(Event,BeginTime,EndTime) ->
  Pid = whereis('refNumber'),
  TempIndex = ets:last(agenda),
  if(TempIndex /= '$end_of_table') ->
    {DatePrev,TimePrev} = ets:lookup_element(agenda,TempIndex,2),
    {Date,Time} = BeginTime,
    if(DatePrev  < Date) ->
      Pid ! {get, self()},
      RefNrM = receive
        K -> K
        end,
      ets:insert_new('refLookUp', {DatePrev,RefNrM}),Pid ! reset;
    true ->
      if(DatePrev  > Date) ->
        SetRef = ets:lookup_element('refLookUp',Date,2),
        io:fwrite('ref nummer: ~B, EndLine: ', [SetRef]),
        Pid ! {set, self(),SetRef};
      true -> ok
      end
    end;
    true -> ok
  end,
  Pid ! {get, self()},
  RefNr = receive
            C -> C
          end,
  Pid ! inc,
  io:fwrite('ref nummer: ~B, EndLine: ', [RefNr]),
  ets:insert_new('agenda', {{BeginTime,make_ref()},BeginTime,EndTime,Event}).


refnr(C) -> receive
             stop -> stopped;
             reset -> loop(0);
             inc -> loop(C+1);
             {get,P} -> P!C, loop(C);
             {set,P,X} -> P!C,loop(X)
           end.

checkProc() ->
  Pid = whereis('refNumber'),
  Pid ! {get, self()},
  RefNr = receive
            C -> C
          end,
  io:fwrite('the current ref nummer: ~B, EndLine: ', [RefNr]).