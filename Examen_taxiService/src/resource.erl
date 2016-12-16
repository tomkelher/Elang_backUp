%%%-------------------------------------------------------------------
%%% @author Eigenaar
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. okt 2016 11:15
%%%-------------------------------------------------------------------
-module('resource').
-author("Eigenaar").

%% API
-export([updateEvents/4,deleteEvents/1,checkTimeLeft/0]).

updateEvents(Serial,Event,BeginTime,EndTime) ->
  ets:update_element(logboek, Serial,[{Event, BeginTime,EndTime}]).

deleteEvents(Serial)->
  ets:delete(logboek, Serial).

%The Time left
  %Delete the invalid ones that are passed and check when the next date will begintill the next event starts
  checkTimeLeft()->
  LocalTime = calendar:local_time(),
  Waarde = clearUp(ets:last(agenda)),
  if (Waarde == 'No Event booked') -> 'An event has yet to be booked';
  true -> {Dagen,{Uren,Minuten,Seconden}} = calendar:time_difference(LocalTime,ets:lookup_element(agenda,0,2)),
  io:fwrite('days left: ~B, Hours: ~B, Minutes: ~B, Seconden: ~B, EndLine: ', [Dagen, Uren,Minuten,Seconden])
  end.

clearUp(X) when X < 0 -> 'done';
clearUp(X) when X == '$end_of_table' -> 'No Event booked';
clearUp(X) when X >= 0 ->
  PlannedEndTime = ets:lookup_element(agenda,X,3),
  LocalTime = calendar:local_time(),
  if ( PlannedEndTime < LocalTime)-> ets:delete(agenda,X),clearUp(X-1);
  true -> clearUp(X-1)
  end.