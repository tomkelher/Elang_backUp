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
-export([start/0,addEvent/3,serial/1,getEventMessage/0]).

start() ->
  ets:new('logboek', [ordered_set, {keypos, 1}, public,named_table]),
  ets:new('messages', [ordered_set, {keypos, 1}, public,named_table]),
  Pid = spawn(klant, serial, [0]),
  register('Proces', Pid).

getEventMessage()->
  CurrentTime = calendar:local_time(),
  EndTime = ets:lookup_element(logboek,0,3),
  BeginTime = ets:lookup_element(logboek,0,2),
  if ( BeginTime < CurrentTime)->
      if ( EndTime > CurrentTime)->
        ets:insert_new('messages', {"we got a match"})
      end
  end.


%tijd: {{2009,9,7},{12,32,22}},{{2009,9,7},{12,32,22}}
%tijd: {{yyyy,m,d},{hh,mm,ss}}
addEvent(Event,BeginTime,EndTime) ->
  Pid = whereis('Proces'),
  Pid ! {get, self()},
  Serial = receive
      C -> C
  end,
  ets:insert_new('logboek', {Serial,BeginTime,EndTime,Event}),
  Pid ! inc.

serial(C) -> receive
            stop -> stopped;
            reset -> serial(0);
            inc -> serial(C+1);
            {get,P} -> P!C, serial(C)
          end.

Bepaaltijden(TabelNaam) -> ets:lookup_element(logboek,0,3).
Bepaaltijden(X,)


