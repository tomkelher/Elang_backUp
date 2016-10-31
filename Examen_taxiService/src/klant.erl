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
-export([start/0,addEvent/3,serial/1,getEventMessage/0,serialMes/1]).

start() ->
  ets:new('logboek', [ordered_set, {keypos, 1}, public,named_table]),
  ets:new('messages', [ordered_set, {keypos, 1}, public,named_table]),
  Pid = spawn(klant, serial, [0]),
  PID = spawn(klant, serialMes, [0]),
  register('Message', PID),
  register('Proces', Pid).

getEventMessage()->
  Pid = whereis('Proces'),
  clearUpAndMatch(ets:last(logboek)),
  ToSend = ets:last(logboek),
  if ToSend == '$end_of_table' -> Pid ! reset;
    true -> Pid ! {set, self(),ets:last(logboek) }
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
            {get,P} -> P!C, serial(C);
            {set,P,X} -> P!C,serial(X)
          end.

serialMes(C) -> receive
               stop -> stopped;
               reset -> serialMes(0);
               inc -> serialMes(C+1);
               {get,P} -> P!C, serialMes(C);
               {set,P,X} -> P!C,serialMes(X)
             end.

clearUpAndMatch(X) when X < 0 -> ets:tab2list(logboek);
clearUpAndMatch(X) when X == '$end_of_table' -> empty;
clearUpAndMatch(X) when X >= 0 ->
       PlannedBeginTime = ets:lookup_element(logboek,X,3),
       PlannedEndTime = ets:lookup_element(logboek,X,3),
       LocalTime = calendar:local_time(),
        if ( PlannedEndTime < LocalTime)-> ets:delete(logboek,X),clearUpAndMatch(X-1);
        true ->
          if (PlannedBeginTime < LocalTime) ->
            Pid = whereis('Message'),
            Pid ! {get, self()},
            Serial = receive
                       C -> C
                     end,
            ets:insert_new('messages', {Serial,LocalTime,PlannedBeginTime,PlannedEndTime,"this place is booked"}),
            Pid ! inc;
            true -> clearUpAndMatch(X-1)
          end
        end.
