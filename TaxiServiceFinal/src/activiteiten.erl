%%%-------------------------------------------------------------------
%%% @author Tom Kelher
%%% @copyright (C) 2017, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. jan 2017 21:12
%%%-------------------------------------------------------------------
-module(activiteiten).
-author("Tom Kelher").

%% API
-export([create/5, init/5,start_activity/1,stop_activity/1]).

create(Start, Eind, Bestemming, Personen, Auto) ->
  spawn(?MODULE, init,[Start, Eind, Bestemming, Personen, Auto]).

init(Start, Eind, Bestemming, Personen, Auto) ->
  boek_resources(Auto,Personen,Start,Eind,Bestemming),
  eventManager:add_event(Start,?MODULE,start_activity,self()),
  eventManager:add_event(Eind,?MODULE,stop_activity,self()),
  loop().

loop() -> receive

            {start_activity}  -> io:format("Activity has started ~n"),loop();
            {stop_activity} ->  io:format("Activity has ended ~n"),
              loop();
            stop -> ok
          end.

boek_auto(Bestemming,Start,Eind,Auto,PidActiviteit) ->

  Auto ! {boek,PidActiviteit,Start,Eind,Bestemming}.

boek_personen(Personen,Start,Eind,PidActiviteit) ->

  lists:foreach(fun (P) -> boek_persoon(P, Start, Eind, PidActiviteit) end, Personen).

boek_persoon(PidPersoon,Start,Eind,PidActiviteit) ->

  PidPersoon ! {boek,PidActiviteit,Start,Eind}.

boek_resources(Auto,Personen,Start,Eind,Bestemming) ->
  boek_auto(Bestemming,Start,Eind,Auto,self()),
  boek_personen(Personen,Start,Eind,self()).

start_activity(PID) -> PID ! {start_activity}.

stop_activity(PID) -> PID ! {stop_activity}.


