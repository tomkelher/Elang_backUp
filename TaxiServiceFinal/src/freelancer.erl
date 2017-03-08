%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 17:11
%%%-------------------------------------------------------------------
-module(freelancer).
-author("Tom Kelher").
%% API
-export([start/0,aantalAfspraken/1, workTime/3]).

start() ->
  List = ets:tab2list('freelancer1'),
  Afspraken = aantalAfspraken(List),
  io:format("Aantal afspraken: ~B", [Afspraken]),
  Tijd = workTime(List, Afspraken, 0),
  io:format(" tijd dat je moet werken: ~B", [Tijd]).

aantalAfspraken(List1) -> length(List1).


workTime(_,0, Werktijd) -> Werktijd;
workTime(List2,Afspraken, WerkTijd) ->
  {Key, BeginTijd, Eindtijd} = lists:nth(Afspraken, List2),
  Tijd = Eindtijd - BeginTijd,
  workTime(List2,Afspraken-1,WerkTijd+Tijd).


