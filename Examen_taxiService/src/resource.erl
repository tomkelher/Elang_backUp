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

%The Time left untill the next event starts
checkTimeLeft()->
  %Delete the invalid ones that are passed and check when the next date will begin
  LocalTime = calendar:local_time(),
  Waarde = clearUp(ets:last(logboek)),
  if (Waarde == 'No Event booked') -> 'An event has yet to be booked';
  true -> ets:lookup_element(logboek,0,2) - LocalTime
  end.

clearUp(X) when X < 0 -> 'done';
clearUp(X) when X == '$end_of_table' -> 'No Event booked';
clearUp(X) when X >= 0 ->
  PlannedEndTime = ets:lookup_element(logboek,X,3),
  LocalTime = calendar:local_time(),
  if ( PlannedEndTime < LocalTime)-> ets:delete(logboek,X),clearUp(X-1);
  true -> clearUp(X-1)
  end.

